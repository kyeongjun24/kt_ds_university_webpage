package com.mySpring.springEx.course.controller;

import java.sql.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.course.vo.CourseVO;
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
	
	@Override
	@RequestMapping(value="/course/listCourses.do" ,method = RequestMethod.GET)
	public ModelAndView listCourses(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		System.out.println(viewName);
		List coursesList = courseService.listCourses();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("coursesList", coursesList);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/course/addCourse.do" ,method = RequestMethod.POST)
	public ModelAndView addCourse(@ModelAttribute("course") CourseVO courseVO,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = courseService.addCourse(courseVO);
		ModelAndView mav = new ModelAndView("redirect:/course/listCourses.do");
		return mav;
	}
	
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
