package com.mySpring.springEx.enrollment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.service.EnrollmentService;
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

	@Override
	@RequestMapping(value="/enrollment/listEnrollments.do" ,method = RequestMethod.GET)
	public ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		List enrollmentsList = enrollmentService.listEnrollments();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("enrollmentsList", enrollmentsList);
		return mav;
	}
	
	// 상태 '승인' 으로 수정
	@Override
	@RequestMapping(value="/enrollment/modEnrollment.do", method = RequestMethod.POST)
	public ModelAndView updateEnrollment(int [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateEnrollment(arr[i]);
		 } 
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}
	
	// 상태 '수료' 로 수정
	@Override
	@RequestMapping(value="/enrollment/modEnrollmentComplete.do", method = RequestMethod.POST)
	public ModelAndView updateEnrollmentComplete(int [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateEnrollmentComplete(arr[i]);
		 } 
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}
	
	// 상태 '취소' 로 수정
	@Override
	@RequestMapping(value="/enrollment/modEnrollmentCancel.do", method = RequestMethod.POST)
	public ModelAndView updateEnrollmentCancel(int [] arr, 
					  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for(int i = 0; i < arr.length; i++) { 
			result = enrollmentService.updateEnrollmentCancel(arr[i]);
		 } 
		ModelAndView mav = new ModelAndView("redirect:/enrollment/listEnrollments.do");
		return mav;
	}
}
