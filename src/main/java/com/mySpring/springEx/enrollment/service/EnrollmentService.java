package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.dao.DataAccessException;


public interface EnrollmentService {

	public List listEnrollments() throws DataAccessException;
	
	public int updateEnrollment(int id) throws DataAccessException;

	public int updateEnrollmentComplete(int id) throws DataAccessException;

	public int updateEnrollmentCancel(int id) throws DataAccessException;

}
