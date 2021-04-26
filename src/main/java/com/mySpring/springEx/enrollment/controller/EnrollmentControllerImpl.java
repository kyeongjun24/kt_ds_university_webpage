				package com.mySpring.springEx.enrollment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.common.paging.PageMaker;
import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.service.EnrollmentService;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.service.MemberService;
import com.mySpring.springEx.member.vo.MemberVO;

@Controller("enrollmentController")
public class EnrollmentControllerImpl implements EnrollmentController{

	@Autowired
	private EnrollmentService enrollmentService;
	
	@Autowired
	CourseService courseService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MemberVO memberVO;
	
	@Autowired
	CourseVO courseVO;
	
	//엑셀 다운로드
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/excelDownload.do", method = RequestMethod.POST)
	public void excelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		enrollmentService.excelDownload(response);
	}
	
	// excel download - course
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/excelCourseDownload.do", method = {RequestMethod.POST, RequestMethod.GET})
	public void excelCourseDownload(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@@@@@@@@@" + id);
		enrollmentService.excelCourseDownload(Integer.parseInt(id), response);
	}
	
	// 여러개 상태 수정 (승인)
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/modApproveEnrollments.do", method = RequestMethod.POST)
	public int updateApproveEnrollments(String [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateApproveEnrollments(Integer.parseInt(arr[i]));
		 } 
		return result;
	}
	
	// Into detail page --> course
	@Override
	@RequestMapping(value="/enrollment/enrollmentCourse.do" ,method = RequestMethod.GET)
	public ModelAndView enrollmentCourse(@RequestParam int id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		List enrollmentsList = null;
		enrollmentsList = enrollmentService.enrollmentCourse(id);	
		 
		ModelAndView mav = new ModelAndView();
		mav.addObject("enrollmentsList", enrollmentsList);
		return mav;
	}
	
	// 리스트 페이지
	@Override
	@RequestMapping(value="/enrollment/listEnrollments.do", method =  RequestMethod.GET)
	public ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//EnrollmentList에서 보낸 name 받는다. (searchType : 검색 유형, searchText : 검색 텍스트)
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
	
		int page = 0;		// page 기본 변수 생성
		if(request.getParameter("page") != null) { // 받은 페이지 값이 있다면
			page = Integer.parseInt((String)request.getParameter("page")); //page 변수에 값을 저장
		} else {
			page = 1; //아니면 page 1로 기본 지정
		}
		
		int perPage = 0; //리스트 개수 값 저장할 변수 생성
		if(request.getParameter("perPage") != null) {	// perPage 값이 있다면
			perPage = Integer.parseInt((String)request.getParameter("perPage")); // perPage 변수에 리스트 띄울 개수 저장
		} else {
			perPage = 10; // 기본 10개로 지정
		}
		
		List enrollmentsList = null; 
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();
		
		criteria.setPerPageNum(perPage); // 리스트 개수 설정
		pageMaker.setCriteria(criteria); // 전달 받은 페이지 번호 page 
		
		if (searchType != null && searchText != null) { // 검색 유형이랑 값을 받았다면
			enrollmentsList = enrollmentService.listBySearchEnrollments(searchType, searchText);
			criteria.setPage(page); // page 설정
			criteria.setSearchText(searchText); // 검색 값 설정
			criteria.setSearchType(searchType); // 검색 유형 설정
			pageMaker.setTotalCount(enrollmentsList.size()); // 페이지 개수를 전체 리스트 크기로 설정
			enrollmentsList = enrollmentService.listCriteriaBySearch(criteria); // 기준 설정에 의해 새로 받는 리스트
			mav.addObject("searchText", searchText); // 검색 값 다시 페이지로 보내기
			mav.addObject("searchType", searchType); // 검색 유형 다시 페이지로 보내기
		} else { // 검색 유형이랑 값을 받지 않았다면
			enrollmentsList = enrollmentService.listEnrollments(); //전체 리스트 저장
			criteria.setPage(page); //페이지 설정
			pageMaker.setTotalCount(enrollmentsList.size()); //페이지 개수 설정
			enrollmentsList = enrollmentService.listCriteria(criteria); //기준에 의해 나눠진 리스트 설정
		}
		mav.addObject("perPage", perPage); // 리스트 기준 값 보내기
		mav.addObject("pageMaker", pageMaker); // 페이지 만들어진 값 보내기
		mav.addObject("enrollmentsList", enrollmentsList); //설정된 리스트 보내기
		return mav; //리스트 페이지로
	}

	//수강신청 등록 
	@Override
	@RequestMapping(value="/enrollment/addEnrollment" ,method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView addEnrollment(@ModelAttribute("enrollment") EnrollmentVO enrollmentVO,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = enrollmentService.addEnrollment(enrollmentVO);
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}
	
	// 상세페이지 상태 수정
	@Override
	@RequestMapping(value="/enrollment/modEnrollment.do" ,method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView modEnrollment(@ModelAttribute("enrollment") EnrollmentVO enrollment,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = enrollmentService.modEnrollment(enrollment);
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}

	// 상세페이지 상태 수정
	@Override
	@RequestMapping(value = "/enrollment/enrollmentForm.do", method = RequestMethod.GET)
	public ModelAndView enrollmentForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		List syllabusesCoursesList = enrollmentService.listSylCrs();
		mav.addObject("syllabusesCoursesList", syllabusesCoursesList);
		return mav;
	}
	
	//수강 등록 - 강의 리스트 출력
	@Override
	@RequestMapping(value = "/enrollment/exceptEnrollmentForm.do", method = RequestMethod.GET)
	public ModelAndView exceptEnrollmentForm(@RequestParam String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		List exceptList = enrollmentService.exceptListSylCrs(id);
		mav.addObject("exceptList", exceptList);
		return mav;
	}
		
	// Into detail page --> member
	@Override
	@RequestMapping(value="/enrollment/informationEnrollment.do" ,method = RequestMethod.GET)
	public ModelAndView informationEnrollment(@RequestParam int id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		EnrollmentVO enrollmentVO = enrollmentService.selectEnrollment(id);	
		mv.addObject("enrollmentVO", enrollmentVO);
		return mv;
	}
	
	// 여러개 상태 수정 (수료)
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/modCompleteEnrollments.do", method = RequestMethod.POST)
	public int updateCompleteEnrollments(String [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateCompleteEnrollments(Integer.parseInt(arr[i]));
		 } 
		return result;
	}

	// 여러개 상태 수정 (삭제)
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/modDeleteEnrollments.do", method = RequestMethod.POST)
	public int updateDeleteEnrollments(String [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateDeleteEnrollments(Integer.parseInt(arr[i]));
		 } 
		return result;
	}
	
	// 한개 삭제
	@Override
	@RequestMapping(value="/enrollment/deleteEnrollment.do" ,method = RequestMethod.GET)
	public ModelAndView deleteEnrollment(@RequestParam String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = enrollmentService.updateDeleteEnrollments(Integer.parseInt(id));	
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}
	

//아이디 중복신청 체크
//	@Override
//	@RequestMapping(value="/enrollment/checkEnrollment.do", method = RequestMethod.POST)
//	public int checkEnrollment(@ModelAttribute("enrollment") EnrollmentVO enrollmentVO, 
//							HttpServletRequest request, HttpServletResponse response) throws Exception{
//		request.setCharacterEncoding("utf-8");
//		String viewName = (String)request.getAttribute("viewName");
//		int result = enrollmentService.checkEnrollment(enrollmentVO);
//		System.out.println("�씪硫쒕씪@@@@@@ :   " + result);
//		return result;
//	}
	
	
//폼
//	@RequestMapping(value = "/enrollment/enrollmentForm.do", method = RequestMethod.GET)
//	private ModelAndView enrollmentForm(@RequestParam(value = "result", required = false) String result,
//			@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//
//		String viewName = (String) request.getAttribute("viewName");
//		HttpSession session = request.getSession();
//		session.setAttribute("action", action);
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result", result);
//		mav.setViewName(viewName);
//		return mav;
//	}
	
//수강신청내역 리스트로 이동 (백업)
//	@Override
//	@RequestMapping(value="/enrollment/listEnrollments.do" ,method = RequestMethod.GET)
//	public ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String viewName = (String)request.getAttribute("viewName");
//		List enrollmentsList = enrollmentService.listEnrollments();
//		ModelAndView mav = new ModelAndView(viewName);
//		
//		mav.addObject("enrollmentsList", enrollmentsList);
//		return mav;
//	}
	
	
}
