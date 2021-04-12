package com.mySpring.springEx.enrollment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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

	
	
	
	//수강신청내역 리스트로 이동 
	@Override
	@RequestMapping(value="/enrollment/listEnrollments.do" ,method = RequestMethod.GET)
	public ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		List enrollmentsList = enrollmentService.listEnrollments();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("enrollmentsList", enrollmentsList);
		return mav;
	}
	
	//상세 접수내역 페이지로 이동
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
	@RequestMapping(value="/enrollment/modEnrollment.do" ,method = RequestMethod.POST)
	public ModelAndView modEnrollment(@ModelAttribute("enrollment") EnrollmentVO enrollment,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = enrollmentService.modEnrollment(enrollment);
		ModelAndView mav = new ModelAndView("redirect:/enrollment/informationEnrollment.do");
		return mav;
	}
	
	
	// 여러개 상태 수정
	@Override
	@ResponseBody
	@RequestMapping(value="/enrollment/modEnrollments.do", method = RequestMethod.POST)
	public int updateEnrollments(int [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateEnrollments(arr[i]);
		 } 
		return result;
	}

	//폼
	@RequestMapping(value = "/enrollment/*Form.do", method = RequestMethod.GET)
	private ModelAndView form(@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		System.out.println(viewName);
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	
}
