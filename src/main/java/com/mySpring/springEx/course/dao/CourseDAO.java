package com.mySpring.springEx.course.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.course.vo.CourseVO;




public interface CourseDAO {
	
	public List selectAllCourseList() throws DataAccessException;
	public int insertCourse(CourseVO course) throws DataAccessException;
	public int deleteCourse(int id) throws DataAccessException;
	public CourseVO selectCourse(int id) throws DataAccessException;
	public int updateCourse(CourseVO courseVO) throws DataAccessException;
	public List selectBySearchCourseList(String searchType, String searchText);
	
	
	
	
	
//	public List<CourseVO> selectBoard(PagingVO pagingVO) throws DataAccessException;
//	public int countBoard();
}
