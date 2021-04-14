package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public List selectAllCompletionList() throws DataAccessException;

	public EnrollmentVO selectCompletion(int id) throws DataAccessException;

	public List selectBySearchCompletion(String searchType, String searchText) throws DataAccessException;

	public List<MemberVO> listPaging(int page) throws DataAccessException;

	public List<EnrollmentVO> listCriteria(Criteria criteria) throws DataAccessException;

	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException;

}
