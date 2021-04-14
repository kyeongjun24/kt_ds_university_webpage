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
	
	//수료관리 리스트 출력 메소드
	@Override
	@RequestMapping(value="/enrollment/listCompletion.do" ,method = RequestMethod.GET)
	public ModelAndView listCompletion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		List completionList = enrollmentService.listCompletion();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("completionList", completionList);
		return mav;
	}
}
