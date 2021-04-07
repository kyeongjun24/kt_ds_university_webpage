package com.mySpring.springEx.course.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.course.vo.CourseVO;



public interface CourseService {

	public List listCourses() throws DataAccessException;
	public int addCourse(CourseVO course) throws DataAccessException;
	public int removeCourse(int id) throws DataAccessException;
	public CourseVO selectCourse(int id) throws DataAccessException;
	public int updateCourse(CourseVO courseVO) throws DataAccessException;
}
