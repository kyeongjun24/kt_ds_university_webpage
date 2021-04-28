package com.mySpring.springEx.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.board.service.BoardService;
import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;
import com.mySpring.springEx.manager.vo.ManagerVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Controller("boardController")
public class BoardControllerImpl implements BoardController {
	private static final String ARTICLE_FILE_REPO = "C:\\uploadtest"; 
	@Autowired
	private BoardService boardService;
	@Autowired
	private ArticleVO articleVO;

	// 怨듭��궗�빆 由ъ뒪�듃
	@Override
	@RequestMapping(value = "/board/listArticles.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		List articlesList1 = boardService.listImptArticles();
		List articlesList2 = boardService.listArticles();
		ModelAndView mav = new ModelAndView(viewName);
		if (searchType != null && searchText != null) {
			articlesList2 = boardService.listBySearchArticles(searchType, searchText);
			mav.addObject("searchText", searchText);
			mav.addObject("searchType", searchType);
		} else {
			articlesList2 = boardService.listArticles();
		}
		mav.addObject("articlesList1", articlesList1);
		mav.addObject("articlesList2", articlesList2);
		return mav;
	}

	// 怨듭��궗�빆 �젣紐� �꽑�깮�븯硫� �궡�슜 �굹�삤湲�
	@Override
	@RequestMapping(value = "/board/selectArticle.do", method = RequestMethod.GET)
	public ModelAndView selectArticle(@RequestParam("id") int id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		ArticleVO vo = boardService.selectArticle(id);
		ArticleFileVO filevo = boardService.selectArticleFile(id);
		System.out.println(filevo);
		mv.addObject("vo", vo);
		mv.addObject("filevo",filevo);
		return mv;
	}
	
	// 怨듭��궗�빆 �뙆�씪 �꽑�깮
	@Override
	@RequestMapping(value = "/board/selectArticleFile.do", method = RequestMethod.GET)
	public ModelAndView selectArticleFile(@RequestParam("id") int id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		ArticleFileVO filevo = boardService.selectArticleFile(id);
		System.out.println(filevo);
		mv.addObject("filevo", filevo);
		return mv;
	}

	// 怨듭��궗�빆 湲� 異붽� , �븳 媛� �뙆�씪
	@Override
	@RequestMapping(value = "/board/addNewArticle.do", method = RequestMethod.POST) //
	public ModelAndView addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames(); // �뤌�뿉 �쟾�넚�븳 �뙆�씪誘명꽣�뱾�쓽 �씠由꾩쓣 Enumeration ���엯�쑝濡� 諛섑솚, �뤌�뿉 �엳�뒗 input �깭洹�
																// 以� file �냽�꽦�씠 �븘�땶 紐⑤뱺 �뙆�씪誘명꽣�뱾�쓽 �씠由꾩쓣 諛섑솚
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}
		
		String name = upload(multipartRequest);
		/*
		 * HttpSession session = multipartRequest.getSession(); ManagerVO managerVO =
		 * (ManagerVO) session.getAttribute("manager"); String memId =
		 * managerVO.getId(); articleMap.put("id", memId);
		 */
		articleMap.put("name", name);
		
		// article file移쇰읆 T or F 援ы쁽
		 if(articleMap.get("name") != null && ( ((String)articleMap.get("name")).length() ) != 0) { 
			 articleMap.put("file",'T'); 
			 } else {
				 articleMap.put("file",'F'); 
				 }
		 System.out.println(articleMap);	
		 
		try {
			int id = boardService.addNewArticle(articleMap);
			int file = boardService.addNewArticleFile(articleMap);
			System.out.println(id);
			System.out.println(ARTICLE_FILE_REPO); 
			if (name != null && name.length() != 0) {
				File srcFile = new File(ARTICLE_FILE_REPO + "\\" + "temp" + "\\" + name);
				File destDir = new File(ARTICLE_FILE_REPO + "\\" +id);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}
		} catch (Exception e) {
			File srcFile = new File(ARTICLE_FILE_REPO +  "\\" + "temp" + "\\" + name);
			srcFile.delete();
		}
		ModelAndView mav = new ModelAndView("redirect:/board/listArticles.do");
		return mav;
	}
	
	// 怨듭��궗�빆 湲� �젣嫄�
	 @Override
	 @RequestMapping(value = "/board/removeArticle.do", method = RequestMethod.GET)
	 public ModelAndView removeArticle(@RequestParam("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 request.setCharacterEncoding("utf-8");
		 try { 
			 boardService.removeArticle(id);
			File destDir = new File(ARTICLE_FILE_REPO+"\\"+id);
			FileUtils.deleteDirectory(destDir);
		} catch (Exception e) { 
			e.printStackTrace(); 
			System.out.println("*");
		} 
	ModelAndView mav = new ModelAndView("redirect:/board/listArticles.do");
	return mav; 
	}
	 
	 // 怨듭��궗�빆湲� 泥댄겕諛뺤뒪濡� �젣嫄�
	@Override
	@ResponseBody
	@RequestMapping(value="/board/removeCheckedArticles.do", method = RequestMethod.POST)
		public int removeCheckedArticles(String [] arr, HttpServletRequest request, HttpServletResponse response) throws Exception{
			request.setCharacterEncoding("utf-8");
			System.out.println(arr.length);
			int result = 0;
			for(int i = 0; i < arr.length; i++) {
				try { 
				result = boardService.removeArticle(Integer.parseInt(arr[i]));
				File destDir = new File(ARTICLE_FILE_REPO+"\\"+Integer.parseInt(arr[i]));
				FileUtils.deleteDirectory(destDir);
				} catch (Exception e) { 
					e.printStackTrace(); 
					System.out.println("*");
				} 
			}
			return result;
		}	
	
	// 怨듭��궗�빆 湲� �닔�젙
	 @Override
	 @RequestMapping(value = "/board/modArticle.do", method = RequestMethod.POST)
	 public ModelAndView modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		 multipartRequest.setCharacterEncoding("utf-8"); 
		 Map<String, Object> articleMap = new HashMap<String, Object>(); 
		 Enumeration enu = multipartRequest.getParameterNames(); 
		 while (enu.hasMoreElements()) { 
			 String name = (String) enu.nextElement(); 
			 String value = multipartRequest.getParameter(name); 
			 articleMap.put(name, value); 
		 }
		 String name= upload(multipartRequest); 
		 articleMap.put("name", name);
		 String id=(String)articleMap.get("id");
		 try {
			 boardService.modArticle(articleMap);
			 boardService.modArticleFile(articleMap);
			 // article file移쇰읆 T or F 援ы쁽
			 if(articleMap.get("name") != null && ( ((String)articleMap.get("name")).length() ) != 0) 
			 	{ 
				 articleMap.put("file",'T'); 
				 } else {
					 articleMap.put("file",'F'); 
				}
			 
			 if(name != null && name.length()!=0) { 
				 System.out.println(name +"//"+ id);
				 File srcFile = new File(ARTICLE_FILE_REPO+"\\"+"temp"+"\\"+name); 
				 System.out.println("*");
				 File destDir = new File(ARTICLE_FILE_REPO+"\\"+id); 
				 System.out.println("**");
				 FileUtils.moveFileToDirectory(srcFile, destDir, true);
				 System.out.println("***");
				 String originalFileName = (String)articleMap.get("originalFileName"); 
				 System.out.println("****");
				 File oldFile = new File(ARTICLE_FILE_REPO+"\\"+id+"\\"+originalFileName);
				 System.out.println("*****");
				 oldFile.delete(); 
				 System.out.println("******");
			 	} 
		 	} catch (Exception e) {
			 if(articleMap.get("name") != null && ( ((String)articleMap.get("name")).length() ) != 0) 
			 	{ 
				 articleMap.put("file",'T'); 
				 } else {
					 articleMap.put("file",'F'); 
				}
			 File srcFile = new File(ARTICLE_FILE_REPO+"\\"+"temp"+"\\"+name);
			 srcFile.delete();
			 System.out.println("exeption");
		 	} 
		 ModelAndView mav = new ModelAndView("redirect:/board/listArticles.do");
		 return mav; 
	 	}
	 
		@Override
		@RequestMapping(value="/board/modArticleForm.do", method = RequestMethod.GET)
		public ModelAndView updateArticleForm(@RequestParam int id, HttpServletRequest request, HttpServletResponse response) throws Exception {
			request.setCharacterEncoding("utf-8");
			String viewName = (String)request.getAttribute("viewName");
			ModelAndView mv = new ModelAndView();
			mv.setViewName(viewName);
			ArticleVO vo = boardService.selectArticle(id);
			mv.addObject("vo", vo);
			return mv;
		}
		
		// 寃��깋湲곕뒫 (�젣紐�)
		@Override
		@RequestMapping(value="/board/listBySearch.do" ,method = RequestMethod.POST)
		public ModelAndView listBySearchArticles(@RequestParam("searchType") String searchType, @RequestParam("searchText") String searchText,  
				HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String viewName = (String)request.getAttribute("viewName");
			System.out.println(viewName);
			System.out.println(searchType);
			System.out.println(searchText);
			List articlesList1 = boardService.listBySearchArticles(searchType, searchText);
			List articlesList2 = boardService.listBySearchArticles(searchType, searchText);
			ModelAndView mav = new ModelAndView("/board/listArticles");
			mav.addObject("articlesList1", articlesList1);
			mav.addObject("articlesList2", articlesList2);
			return mav;
		}
	 
	 
	// upload 硫붿냼�뱶
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		String name = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			name = mFile.getOriginalFilename();
			File file = new File(ARTICLE_FILE_REPO + "\\" + fileName);
			if (mFile.getSize() != 0) { // File Null Check
				if (! file.exists()) { // 寃쎈줈�긽�뿉 �뙆�씪�씠 議댁옱�븯吏� �븡�쓣 寃쎌슦
					if (file.getParentFile().mkdirs()) { // 寃쎈줈�뿉 �빐�떦�븯�뒗 �뵒�젆�넗由щ뱾�쓣 �깮�꽦
						file.createNewFile(); // �씠�썑 �뙆�씪 �깮�꽦
					}
				}
				mFile.transferTo(new File(ARTICLE_FILE_REPO + "\\" + "temp"+ "\\"+ name)); // �엫�떆濡� ���옣�맂
																									// multipartFile�쓣 �떎�젣 �뙆�씪濡� �쟾�넚
			}
		}
		return name;
	}

	@RequestMapping(value = "/board/*Form.do", method = RequestMethod.GET)
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}

}