package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public int updateEnrollment(int id) throws DataAccessException;

	public int updateEnrollmentComplete(int id) throws DataAccessException;

	public int updateEnrollmentCancel(int id) throws DataAccessException;

}
