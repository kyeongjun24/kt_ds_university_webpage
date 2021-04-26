package com.mySpring.springEx.courseCategory.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.courseCategory.vo.CourseCategoryVO;

public interface CourseCategoryDAO {

	List selectAllCourseCategory() throws DataAccessException;
	int addCourseCategoryVO(CourseCategoryVO courseCategoryVO) throws DataAccessException;
	CourseCategoryVO selectCourseCategory(int id) throws DataAccessException;
	int updateCourseCategory(CourseCategoryVO courseCategoryVO) throws DataAccessException;
	int deleteCourseCategory(int id) throws DataAccessException;

}
