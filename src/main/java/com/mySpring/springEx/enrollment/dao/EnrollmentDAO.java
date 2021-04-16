package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public int updateEnrollments(int id) throws DataAccessException;

	public EnrollmentVO selectEnrollment(int id) throws DataAccessException;

	public int insertEnrollment(EnrollmentVO enrollmentVO) throws DataAccessException;

	public List selectSylCrsList() throws DataAccessException;

	public int modEnrollmentCompany(EnrollmentVO enrollmentVO) throws DataAccessException;

	public int modEnrollmentStat(EnrollmentVO enrollmentVO) throws DataAccessException;
	
	public int checkEnrollment(EnrollmentVO enrollment);

	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException;

	public List<EnrollmentVO> listCriteria(Criteria criteria) throws DataAccessException;

	public List selectBySearchEnrollmentList(String searchType, String searchText) throws DataAccessException;

	public List<EnrollmentVO> listPaging(int page) throws DataAccessException;


}
