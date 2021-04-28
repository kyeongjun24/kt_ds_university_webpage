package com.mySpring.springEx.course.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.course.vo.CourseVO;

public interface CourseController {
	
	public ModelAndView listCourses(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addCourse(@ModelAttribute("course")CourseVO courseVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView removeCourse(@RequestParam("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateCourseForm(@RequestParam("id") int id, @RequestParam("slbId") int slbId, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateCourse(@ModelAttribute("course")CourseVO courseVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView selectCourse(@ModelAttribute("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView courseForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int removeCheckedCourses(int[] arr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listBySearchCourses(String searchType, String searchText, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	
	public String upload(MultipartHttpServletRequest multipartRequest) throws Exception;
	
	
}
