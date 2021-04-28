package com.mySpring.springEx.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.common.paging.PageMaker;
import com.mySpring.springEx.company.service.CompanyService;
import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.enrollment.service.EnrollmentService;
import com.mySpring.springEx.manager.vo.ManagerVO;
import com.mySpring.springEx.member.service.MemberService;
import com.mySpring.springEx.member.vo.MemberVO;

@Controller("memberController")
//@EnableAspectJAutoProxy
public class MemberControllerImpl implements MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	CourseService courseService;
	
	@Autowired
	EnrollmentService enrollmentService;
	
	@Autowired
	CompanyService companyService;
	
	@Autowired
	MemberVO memberVO ;
	
	
	@Override
	@RequestMapping(value="/member/adminMain.do" ,method = RequestMethod.GET)
	public ModelAndView adminMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		int courseCount = courseService.numberOfCourses();
		int numberOfApplicants = enrollmentService.numberOfApplicants();
		int numberOfCompanies = companyService.numberOfCompanies();
		mav.addObject("numberOfCourses", courseCount );
		mav.addObject("numberOfApplicants", numberOfApplicants);
		mav.addObject("numberOfCompanies", numberOfCompanies);
		return mav;
	}

	
	//�븘�씠�뵒 寃��깋 �뙘�뾽 (�썝蹂�)
//	@RequestMapping(value = "/member/memberSearchPopUp.do", method = {RequestMethod.GET, RequestMethod.POST})
//	private ModelAndView memberSearchPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String viewName = (String)request.getAttribute("viewName");
//		List membersList = memberService.listMembers();
//		ModelAndView mv = new ModelAndView(viewName);
//		mv.addObject("membersList", membersList);
//		return mv;
//	}
	
	//�븘�씠�뵒 寃��깋 �뙘�뾽 (寃��깋, �럹�씠吏� 湲곕뒫 �옉�뾽以�)
	@RequestMapping(value = "/member/memberSearchPopUp.do", method = {RequestMethod.GET, RequestMethod.POST})
	private ModelAndView memberSearchPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = 1;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt((String)request.getParameter("page")); //page 蹂��닔�뿉 媛믪쓣 ���옣
		} else {
			page = 1; //�븘�땲硫� page 1濡� 湲곕낯 吏��젙
		}
		
		int perPage = 10;
		
		List membersList = null; 
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();
		
		criteria.setPerPageNum(perPage); // 由ъ뒪�듃 媛쒖닔 �꽕�젙
		pageMaker.setCriteria(criteria); // 湲곗� 媛� �꽕�젙
		//�뿬湲곌퉴吏� 吏꾪뻾 @@
		if (searchType != null && searchText != null) { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆븯�떎硫�
			membersList = memberService.listBySearchMembersPopup(searchType, searchText);
			criteria.setPage(page); // page �꽕�젙
			criteria.setSearchText(searchText); // 寃��깋 媛� �꽕�젙
			criteria.setSearchType(searchType); // 寃��깋 �쑀�삎 �꽕�젙
			pageMaker.setTotalCount(membersList.size()); // �럹�씠吏� 媛쒖닔瑜� �쟾泥� 由ъ뒪�듃 �겕湲곕줈 �꽕�젙
			membersList = memberService.listCriteriaBySearchPopup(criteria); // 湲곗� �꽕�젙�뿉 �쓽�빐 �깉濡� 諛쏅뒗 由ъ뒪�듃
			
			mav.addObject("searchText", searchText); // 寃��깋 媛� �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
			mav.addObject("searchType", searchType); // 寃��깋 �쑀�삎 �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
		} else { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆� �븡�븯�떎硫�
			membersList = memberService.listMembers(); //�쟾泥� 由ъ뒪�듃 ���옣
			criteria.setPage(page); //�럹�씠吏� �꽕�젙
			pageMaker.setTotalCount(membersList.size()); //�럹�씠吏� 媛쒖닔 �꽕�젙
			membersList = memberService.listCriteria(criteria); //湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �꽕�젙
		}
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲�
		mav.addObject("pageMaker", pageMaker); // �럹�씠吏� 留뚮뱾�뼱吏� 媛� 蹂대궡湲�		
		mav.addObject("membersList", membersList); //�꽕�젙�맂 由ъ뒪�듃 蹂대궡湲�
	
		
		return mav;
	}

	@Override
	@RequestMapping(value="/member/listMembers.do", method =  RequestMethod.GET)
	public ModelAndView listMembers(HttpServletRequest request, HttpServletResponse response
			) throws Exception {
		
		//mebmerList�뿉�꽌 蹂대궦 name 諛쏅뒗�떎. (searchType : 寃��깋 �쑀�삎, searchText : 寃��깋 �뀓�뒪�듃)
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		
		// page 湲곕낯 蹂��닔 �깮�꽦
		int page = 0;
		
		// 諛쏆� �럹�씠吏� 媛믪씠 �엳�떎硫�
		if(request.getParameter("page") != null) {
			page = Integer.parseInt((String)request.getParameter("page")); //page 蹂��닔�뿉 媛믪쓣 ���옣
		} else {
			page = 1; //�븘�땲硫� page 1濡� 湲곕낯 吏��젙
		}
		
		int perPage = 0; //由ъ뒪�듃 媛쒖닔 媛� ���옣�븷 蹂��닔 �깮�꽦
		
		// perPage 媛믪씠 �엳�떎硫�
		if(request.getParameter("perPage") != null) {
			perPage = Integer.parseInt((String)request.getParameter("perPage")); // perPage 蹂��닔�뿉 由ъ뒪�듃 �쓣�슱 媛쒖닔 ���옣
		} else {
			perPage = 10; // 湲곕낯 10媛쒕줈 吏��젙
		}

		List membersList = null; 
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();
		
		criteria.setPerPageNum(perPage); // 由ъ뒪�듃 媛쒖닔 �꽕�젙
		pageMaker.setCriteria(criteria); // 湲곗� 媛� �꽕�젙
		
		if (searchType != null && searchText != null) { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆븯�떎硫�
			membersList = memberService.listBySearchMembers(searchType, searchText);
			
			criteria.setPage(page); // page �꽕�젙
			criteria.setSearchText(searchText); // 寃��깋 媛� �꽕�젙
			criteria.setSearchType(searchType); // 寃��깋 �쑀�삎 �꽕�젙
			pageMaker.setTotalCount(membersList.size()); // �럹�씠吏� 媛쒖닔瑜� �쟾泥� 由ъ뒪�듃 �겕湲곕줈 �꽕�젙
			membersList = memberService.listCriteriaBySearch(criteria); // 湲곗� �꽕�젙�뿉 �쓽�빐 �깉濡� 諛쏅뒗 由ъ뒪�듃
			
			
			mav.addObject("searchText", searchText); // 寃��깋 媛� �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
			mav.addObject("searchType", searchType); // 寃��깋 �쑀�삎 �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
		} else { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆� �븡�븯�떎硫�
			membersList = memberService.listMembers(); //�쟾泥� 由ъ뒪�듃 ���옣
//			membersList = memberService.listCriteria(criteria);
			criteria.setPage(page); //�럹�씠吏� �꽕�젙
			pageMaker.setTotalCount(membersList.size()); //�럹�씠吏� 媛쒖닔 �꽕�젙
			membersList = memberService.listCriteria(criteria); //湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �꽕�젙
		}
		mav.addObject("page", page);
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲�
		mav.addObject("pageMaker", pageMaker); // �럹�씠吏� 留뚮뱾�뼱吏� 媛� 蹂대궡湲�
		mav.addObject("membersList", membersList); //�꽕�젙�맂 由ъ뒪�듃 蹂대궡湲�
		mav.addObject("viewName", viewName);
		return mav; //由ъ뒪�듃 �럹�씠吏�濡�
	}
	
	//湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �솗�씤�빐蹂대ŉ �뿰�뒿�븷 �럹�씠吏�濡� -> �떎�젣 援ы쁽�븷 �븣�뒗 �븘�슂�뾾�쓣 �삁�젙
	@RequestMapping(value = "/member/listCriteria.do", method = RequestMethod.GET)
	public String listCriteria(Model model, Criteria criteria) throws Exception {
		model.addAttribute("members", memberService.listCriteria(criteria));
		return "/member/list_criteria";
		
	}

	//�럹�씠吏� 媛쒖닔媛� �뼱�뼸寃� �굹�닠吏��뒗吏� �솗�씤�빐蹂대ŉ �뿰�뒿�븷 �럹�씠吏�濡� -> �떎�젣 援ы쁽�븷 �븣�뒗 �븘�슂�뾾�쓣 �삁�젙
	@RequestMapping(value = "/member/listPaging.do", method = RequestMethod.GET)
	public String listPaging(Model model, Criteria criteria) throws Exception {
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(1000);
		
		model.addAttribute("members", memberService.listCriteria(criteria));
		model.addAttribute("pageMaker", pageMaker);
		return "/member/list_paging";
	}

	@Override
	@RequestMapping(value="/member/addMember.do" ,method = RequestMethod.POST)
	public ModelAndView addMember(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		int result = 0;
		result = memberService.addMember(member);
		if (result > 0) {
			HttpSession session = request.getSession();
			ManagerVO managerVO = (ManagerVO)session.getAttribute("manager");
			String managerId = managerVO.getId();
			Map<String, String> map = new HashMap();
			map.put("manager", managerId);
			map.put("id", member.getId());
			memberService.addMemberLog(map);
		}
		ModelAndView mav = new ModelAndView("redirect:/member/listMembers.do?page="+page+"&searchText="+searchText+"&searchType="+searchType+"&perPage="+perPage);
		return mav;
	}

	@Override
	@ResponseBody
	@RequestMapping(value = "/member/idCheckMember.do", method = RequestMethod.POST)
	public int idCheckMember(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		int result = memberService.idCheckMember(id);
		return result;
	}

	@Override
	@RequestMapping(value = "/member/removeMember.do", method = RequestMethod.GET)
	public ModelAndView removeMember(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = memberService.updateMemberDelYN(id);
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		if (result > 0) {
			HttpSession session = request.getSession();
			ManagerVO managerVO = (ManagerVO)session.getAttribute("manager");
			String managerId = managerVO.getId();
			Map<String, String> map = new HashMap();
			map.put("manager", managerId);
			map.put("id", id);
			memberService.removeMemberLog(map);
		}
		
		ModelAndView mav = new ModelAndView("redirect:/member/listMembers.do?page="+page+"&searchText="+searchText+"&searchType="+searchType+"&perPage="+perPage);
		return mav;
	}

	@Override
	@ResponseBody
	@RequestMapping(value = "/member/removeCheckedMembers.do", method = RequestMethod.POST)
	public int removeCheckedMembers(String[] arr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) {
			result = memberService.updateMemberDelYN(arr[i]);
			if(result > 0) {
				HttpSession session = request.getSession();
				ManagerVO managerVO = (ManagerVO)session.getAttribute("manager");
				String managerId = managerVO.getId();
				Map<String, String> map = new HashMap();
				map.put("manager", managerId);
				map.put("id", arr[i]);
				memberService.removeMemberLog(map);
			}
		}
		return result;
	}

	@Override
	@RequestMapping(value = "/member/modMember.do", method = RequestMethod.POST)
	public ModelAndView updateMember(@ModelAttribute("member") MemberVO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		int result = 0;
		result = memberService.updateMember(member);
		if (result > 0) {
			HttpSession session = request.getSession();
			ManagerVO managerVO = (ManagerVO)session.getAttribute("manager");;
			String managerId = managerVO.getId();
			Map<String, String> map = new HashMap();
			map.put("manager", managerId);
			map.put("id", member.getId());
			memberService.updateMemberLog(map);
		}
		ModelAndView mav = new ModelAndView("redirect:/member/listMembers.do?page="+page+"&searchText="+searchText+"&searchType="+searchType+"&perPage="+perPage);
		return mav;
	}

	@Override
	@RequestMapping(value = "/member/modMemberForm.do", method = RequestMethod.GET)
	public ModelAndView updateMemberForm(@RequestParam String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		MemberVO vo = memberService.selectMember(id);
		mv.addObject("searchType", searchType);
		mv.addObject("searchText", searchText);
		mv.addObject("page", page);
		mv.addObject("perPage", perPage);
		mv.addObject("vo", vo);
		return mv;
	}

	@Override
	@RequestMapping(value = "/member/informationMemberForm.do", method = RequestMethod.GET)
	public ModelAndView informationMemberForm(@RequestParam String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		ModelAndView mv = new ModelAndView();
		MemberVO vo = memberService.selectMember(id);
		mv.setViewName(viewName);
		mv.addObject("searchType", searchType);
		mv.addObject("searchText", searchText);
		mv.addObject("page", page);
		mv.addObject("perPage", perPage);
		mv.addObject("vo", vo);
		return mv;
	}
	
	@Override
	@ResponseBody
	@RequestMapping(value="/member/insertLogByInformationInquiry.do", method = RequestMethod.POST)
	public int insertLogByInformationInquiry(String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		HttpSession session = request.getSession();
		ManagerVO managerVO = (ManagerVO)session.getAttribute("manager");
		String managerId = managerVO.getId();
		Map<String, String> map = new HashMap();
		map.put("manager", managerId);
		map.put("id", id);
		int result = 0;
		result = memberService.insertLogByInformationInquiry(map);
		return result;
	}
						

	/*
	 * @RequestMapping(value = { "/member/loginForm.do", "/member/memberForm.do" },
	 * method = RequestMethod.GET)
	 * 
	 * @RequestMapping(value = "/member/*Form.do", method = RequestMethod.GET)
	 * public ModelAndView form(HttpServletRequest request, HttpServletResponse
	 * response) throws Exception { String viewName = getViewName(request);
	 * ModelAndView mav = new ModelAndView(); mav.setViewName(viewName); return mav;
	 * }
	 */

	@Override
	@RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberVO member, RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.login(member);
		if (memberVO != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", memberVO);
			session.setAttribute("isLogOn", true);
			// mav.setViewName("redirect:/member/listMembers.do");
			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");
			if (action != null) {
				mav.setViewName("redirect:" + action);
			} else {
				mav.setViewName("redirect:/main.do");
			}

		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/member/loginForm.do");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("isLogOn");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main.do");
		return mav;
	}

	@RequestMapping(value = "/member/*Form.do", method =  RequestMethod.GET)
	private ModelAndView form(@RequestParam(value= "result", required=false) String result,
							  @RequestParam(value= "action", required=false) String action,
						       HttpServletRequest request, 
						       HttpServletResponse response) throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("searchType", searchType);
		mav.addObject("searchText", searchText);
		mav.addObject("page", page);
		mav.addObject("perPage", perPage);
		mav.addObject("result",result);
		mav.setViewName(viewName);
		return mav;
	}

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
