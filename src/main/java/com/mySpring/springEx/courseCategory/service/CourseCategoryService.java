package com.mySpring.springEx.courseCategory.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.courseCategory.vo.CourseCategoryVO;

public interface CourseCategoryService {

	List listAllCourseCategories() throws DataAccessException;
	int addCourseCategory(CourseCategoryVO courseCategoryVO);
	CourseCategoryVO selectCourseCategory(int id);
	int updateCourseCategory(CourseCategoryVO courseCategoryVO);
	int removeCourseCategory(int id);

}
