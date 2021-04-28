package com.mySpring.springEx.course.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.course.vo.CourseVO;




public interface CourseService {

	public List listCourses() throws DataAccessException;
	public int addCourse(CourseVO courseVO) throws DataAccessException;
	public int removeCourse(int id) throws DataAccessException;
	public CourseVO selectCourse(int id) throws DataAccessException;
	public int updateCourse(CourseVO courseVO) throws DataAccessException;
	
	List listBySearchCourses(String searchType, String searchText) throws DataAccessException;
	
	

	
	
	
//	public int countBoard() throws DataAccessException; 
//	public List<CourseVO> selectBoard(PagingVO pagingVO) throws DataAccessException;
}
