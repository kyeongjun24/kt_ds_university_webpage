package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.dao.DataAccessException;


public interface EnrollmentService {

	public List listEnrollments() throws DataAccessException;

}
