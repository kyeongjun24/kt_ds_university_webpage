package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;


public interface EnrollmentService {

	public List listEnrollments() throws DataAccessException;

	public List listCompletion() throws DataAccessException;

	public EnrollmentVO selectCompletion(int id) throws DataAccessException;

	public List listCriteria(Criteria criteria) throws DataAccessException;

	public List listBySearchCompletion(String searchType, String searchText) throws DataAccessException;

	public List listCriteriaBySearch(Criteria criteria) throws DataAccessException;

}
