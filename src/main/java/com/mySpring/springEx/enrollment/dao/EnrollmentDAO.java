package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;


public interface EnrollmentDAO {

	public List selectAllEnrollmentList() throws DataAccessException;

	public EnrollmentVO enrollmentMember(int id) throws DataAccessException;

	public int insertEnrollment(EnrollmentVO enrollmentVO) throws DataAccessException;

	public List selectSylCrsList() throws DataAccessException;

	public int modEnrollmentCompany(EnrollmentVO enrollmentVO) throws DataAccessException;

	public int modEnrollmentStat(EnrollmentVO enrollmentVO) throws DataAccessException;
	
	public int checkEnrollment(EnrollmentVO enrollment);

	public List selectEnrollmentCriteriaBySearch(Criteria criteria) throws DataAccessException;

	public List<EnrollmentVO> listEnrollmentCriteria(Criteria criteria) throws DataAccessException;

	public List selectBySearchEnrollmentList(String searchType, String searchText) throws DataAccessException;

	public List<EnrollmentVO> listEnrollmentPaging(int page) throws DataAccessException;

	public int updateDeleteEnrollments(int id) throws DataAccessException;
	
	public int updateApproveEnrollments(int id) throws DataAccessException;

	public int updateCompleteEnrollments(int id) throws DataAccessException;

	public List excelEnrollmentList() throws DataAccessException;

	public List enrollmentCourse(int id) throws DataAccessException;

	public EnrollmentVO selectCompletion(int id) throws DataAccessException;

	public List selectBySearchCompletion(String searchType, String searchText) throws DataAccessException;

	public List<MemberVO> listCompletionPaging(int page) throws DataAccessException;

	public List<EnrollmentVO> listCompletionCriteria(Criteria criteria) throws DataAccessException;

	public List selectCompletionCriteriaBySearch(Criteria criteria) throws DataAccessException;

	public List selectAllCompletionList() throws DataAccessException;
	public int selectNumberOfApplicants() throws DataAccessException;

	public int selectNumberOfWaitingCompletion() throws DataAccessException;

}
