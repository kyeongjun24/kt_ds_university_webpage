package com.mySpring.springEx.enrollment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface EnrollmentController {

	ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception;

	ModelAndView listCompletion(HttpServletRequest request, HttpServletResponse response) throws Exception;

	ModelAndView completionDoc(int id, HttpServletRequest request, HttpServletResponse response) throws Exception;

	/*
	 * ModelAndView printCompletion(HttpServletRequest request, HttpServletResponse
	 * response) throws Exception;
	 */

}
