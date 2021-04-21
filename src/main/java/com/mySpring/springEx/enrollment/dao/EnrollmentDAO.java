package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public List selectAllCompletionList() throws DataAccessException;

}
