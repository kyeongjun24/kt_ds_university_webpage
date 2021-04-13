package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.enrollment.vo.EnrollmentVO;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public int updateEnrollments(int id) throws DataAccessException;

	public EnrollmentVO selectEnrollment(int id) throws DataAccessException;

	public int modEnrollment(EnrollmentVO enrollment) throws DataAccessException;

	public int insertEnrollment(EnrollmentVO enrollmentVO) throws DataAccessException;

	public List selectSylCrsList() throws DataAccessException;

}
