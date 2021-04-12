package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.enrollment.vo.EnrollmentVO;


public interface EnrollmentService {

	public List listEnrollments() throws DataAccessException;
	
	public int updateEnrollments(int id) throws DataAccessException;

	public EnrollmentVO selectEnrollment(int id) throws DataAccessException;

	public int modEnrollment(EnrollmentVO enrollment) throws DataAccessException;

	public int addEnrollment(EnrollmentVO enrollment) throws DataAccessException;

}
