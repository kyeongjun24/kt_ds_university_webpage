package com.mySpring.springEx.course.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.sql.Date;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.course.vo.PagingVO;
import com.mySpring.springEx.member.vo.MemberVO;
import com.mySpring.springEx.syllabus.service.SyllabusService;
import com.mySpring.springEx.syllabus.vo.SyllabusVO;

@Controller("courseController")
public class CourseControllerImpl implements CourseController{
		
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private SyllabusService syllabusService;
	
	@Autowired
	CourseVO courseVO;
	
	@Autowired
	SyllabusVO cyllabusVO;
	//-------------------파일첨부----------------------
	private static final String COURSE_IMAGE_REPO="D:\\board\\article_image\\temp";
	
	@RequestMapping("/download.do")
	protected void download(@RequestParam("bannerImg") String bannerImg,	//?占쏙옙誘몌옙? ?占쏙옙?占쏙옙?占쏙옙占�? ?占쏙옙?占쏙옙
							@RequestParam("id") int id,
			                 HttpServletResponse response)throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile = COURSE_IMAGE_REPO + "\\" +id+"\\"+ bannerImg;	//?占쏙옙?占쏙옙 寃쎈줈 ?占쏙옙?占쏙옙
		File file = new File(downFile);

		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + bannerImg);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer); 
			if (count == -1) 
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	//-------------------------------------------------------
	
	
	@Override
	@RequestMapping(value="/course/listCourses.do" ,method = RequestMethod.GET)
	public ModelAndView listCourses(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		List coursesList = null;
//		System.out.println(viewName);
//		System.out.println(searchType);
//		System.out.println(searchText);
		ModelAndView mav = new ModelAndView(viewName);
		if (searchType != null && searchText != null) {
			coursesList = courseService.listBySearchCourses(searchType, searchText);
			mav.addObject("searchText", searchText);
			mav.addObject("searchType", searchType);
		} else {
			coursesList = courseService.listCourses();
		}
		mav.addObject("coursesList", coursesList);
		return mav;
	}
//		System.out.println(viewName);
//		List coursesList = courseService.listCourses();
//		ModelAndView mav = new ModelAndView(viewName);
//		mav.addObject("coursesList", coursesList);
//		return mav;
	
	
	@Override
	@RequestMapping(value="/course/listBySearch.do" ,method = RequestMethod.POST)
	public ModelAndView listBySearchCourses(@RequestParam("searchType") String searchType, @RequestParam("searchText") String searchText,  
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		System.out.println(viewName);
		System.out.println(searchType);
		System.out.println(searchText);
		List coursesList = courseService.listBySearchCourses(searchType, searchText);
		ModelAndView mav = new ModelAndView("/course/listCourses");
		mav.addObject("coursesList", coursesList);
		return mav;
	}
	
//-----------------------------업로드-----------------------------
	
	@Override
	@RequestMapping(value="/course/addCourse.do" ,method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addCourse(MultipartHttpServletRequest multipartRequest, 
	HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String,Object> courseMap = new HashMap<String, Object>();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			courseMap.put(name,value);
		}
		
		String bannerImg= upload(multipartRequest);
		HttpSession session = multipartRequest.getSession();
		CourseVO courseVO = (CourseVO) session.getAttribute("course");
		int id = CourseVO.getId();
		courseMap.put("parentNO", 0);
		courseMap.put("id", id);
		courseMap.put("bannerImg", bannerImg);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int id = courseService.addCourse(courseMap);
			if(bannerImg!=null && bannerImg.length()!=0) {
				File srcFile = new 
				File(COURSE_IMAGE_REPO+"\\"+"temp"+"\\"+bannerImg);
				File destDir = new File(COURSE_IMAGE_REPO+"\\"+id);
				FileUtils.moveFileToDirectory(srcFile, destDir,true);
			}
	
			message = "<script>";
			message += " alert('�깉湲��쓣 異붽��뻽�뒿�땲�떎.');";
			message += " location.href='"+multipartRequest.getContextPath()+"/course/listCourses.do'; ";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {
			File srcFile = new File(COURSE_IMAGE_REPO+"\\"+"temp"+"\\"+COURSE_IMAGE_REPO);
			srcFile.delete();
			
			message = " <script>";
			message +=" alert('�삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎. �떎�떆 �떆�룄�빐 二쇱꽭�슂');');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/course/courseForm.do'; ";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		String bannerImg= null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			bannerImg=mFile.getOriginalFilename();
			File file = new File(COURSE_IMAGE_REPO +"\\"+ fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(! file.exists()){ //寃쎈줈�긽�뿉 �뙆�씪�씠 議댁옱�븯吏� �븡�쓣 寃쎌슦
					if(file.getParentFile().mkdirs()){ //寃쎈줈�뿉 �빐�떦�븯�뒗 �뵒�젆�넗由щ뱾�쓣 �깮�꽦
							file.createNewFile(); //�씠�썑 �뙆�씪 �깮�꽦
					}
				}
				mFile.transferTo(new File(COURSE_IMAGE_REPO +"\\"+"temp"+ "\\"+bannerImg)); //�엫�떆濡� ���옣�맂 multipartFile�쓣 �떎�젣 �뙆�씪濡� �쟾�넚
			}
		}
		return bannerImg;
	}
	
	//----------------------------------------------------------------------------
	
//	@Override
//	@RequestMapping(value="/course/addCourse.do" ,method = RequestMethod.POST)
//	public ModelAndView addCourse(@ModelAttribute("course") CourseVO courseVO,
//			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
//		request.setCharacterEncoding("utf-8");
//		int result = 0;
//		result = courseService.addCourse(courseVO);
//		ModelAndView mav = new ModelAndView("redirect:/course/listCourses.do");
//		return mav;
//	}
	
	
	@Override
	@RequestMapping(value="/course/removeCourse.do" ,method = RequestMethod.GET)
	public ModelAndView removeCourse(@RequestParam("id") int id, 
			           HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		courseService.removeCourse(id);
		ModelAndView mav = new ModelAndView("redirect:/course/listCourses.do");
		return mav;
	}


	
	@Override
	@ResponseBody
	@RequestMapping(value="/course/removeCheckedCourses.do", method = RequestMethod.POST)
	public int removeCheckedCourses(int [] arr, HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		System.out.println(arr.length);
		int result = 0;
		for(int i = 0; i < arr.length; i++) {
			result = courseService.removeCourse(arr[i]);
		}
		return result;
	}

	
	@Override
	@RequestMapping(value="/course/courseForm.do", method = RequestMethod.GET)
	public ModelAndView courseForm(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		List syllabusesList = syllabusService.listSyllabuses();
		mv.addObject("syllabusesList", syllabusesList);
//		CourseVO courseVO = courseService.selectCourse(id);
//		SyllabusVO syllabusVO = syllabusService.selectSyllabus(slbId);
//		mv.addObject("courseVO", courseVO);
//		mv.addObject("syllabusVO", syllabusVO);
		return mv;
	}
	
	@Override
	@RequestMapping(value="/course/updateCourseForm.do", method = RequestMethod.GET)
	public ModelAndView updateCourseForm(@RequestParam("id") int id, @RequestParam("slbId") int slbId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		CourseVO courseVO = courseService.selectCourse(id);
		SyllabusVO syllabusVO = syllabusService.selectSyllabus(slbId);
		mv.addObject("courseVO", courseVO);
		mv.addObject("syllabusVO", syllabusVO);
		return mv;
	}
	
	@Override
	@RequestMapping(value="/course/updateCourse.do", method = RequestMethod.POST)
	public ModelAndView updateCourse(@ModelAttribute("course") CourseVO courseVO,
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = courseService.updateCourse(courseVO);
		ModelAndView mav = new ModelAndView("redirect:/course/listCourses.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/course/selectCourse.do", method = RequestMethod.GET)
	public ModelAndView selectCourse(@RequestParam("id") int id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		CourseVO vo = courseService.selectCourse(id);
		mv.addObject("vo", vo);
		return mv;
	}
	
	
	
	
//	@RequestMapping("boardList")
//	public String boardList(PagingVO pagingVO, Model model
//			, @RequestParam(value="nowPage", required=false)String nowPage
//			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
//		
//		int total = CourseService.countBoard();
//		if (nowPage == null && cntPerPage == null) {
//			nowPage = "1";
//			cntPerPage = "5";
//		} else if (nowPage == null) {
//			nowPage = "1";
//		} else if (cntPerPage == null) { 
//			cntPerPage = "5";
//		}
//		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
//		model.addAttribute("paging", pagingVO);
//		model.addAttribute("viewAll", courseService.selectBoard(pagingVO));
//		return "course/boardPaging";
//	}
	
	
	
	
//	@RequestMapping(value = "/course/*Form.do", method =  RequestMethod.GET)
//	private ModelAndView form(@RequestParam(value= "result", required=false) String result,
//							  @RequestParam(value= "action", required=false) String action,
//						       HttpServletRequest request, 
//						       HttpServletResponse response) throws Exception {
//		
//		String viewName = (String)request.getAttribute("viewName");
//		HttpSession session = request.getSession();
//		session.setAttribute("action", action);  
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result);
//		mav.setViewName(viewName);
//		return mav;
//	}
	
	
	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}
}
