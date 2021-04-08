package com.mySpring.springEx.enrollment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface EnrollmentController {

	ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	ModelAndView updateEnrollment(int[] arr, HttpServletRequest request, HttpServletResponse response) throws Exception;

	ModelAndView updateEnrollmentComplete(int[] arr, HttpServletRequest request, HttpServletResponse response)
			throws Exception;

	ModelAndView updateEnrollmentCancel(int[] arr, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
}
