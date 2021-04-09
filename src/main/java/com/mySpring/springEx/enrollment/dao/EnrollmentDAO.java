package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.enrollment.vo.EnrollmentVO;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public int updateEnrollment(int id) throws DataAccessException;

	public EnrollmentVO selectEnrollment(int id) throws DataAccessException;

}
