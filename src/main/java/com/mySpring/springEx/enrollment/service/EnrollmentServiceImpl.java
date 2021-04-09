package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.enrollment.dao.EnrollmentDAO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;

@Service("enrollmentService")
@Transactional(propagation = Propagation.REQUIRED)
public class EnrollmentServiceImpl implements EnrollmentService{
	
	@Autowired
	private EnrollmentDAO enrollmentDAO;

	//수강신청내역 리스트로 이동
	@Override
	public List listEnrollments() throws DataAccessException {
		List enrollmentsList = null;
		enrollmentsList = enrollmentDAO.selectAllEnrollmentList();
		return enrollmentsList;
	}
	
	//상세 접수내역 페이지로 이동
	@Override
	public EnrollmentVO selectEnrollment(int id) throws DataAccessException {
		return enrollmentDAO.selectEnrollment(id);
	}
	
	// 상태 '승인' 으로 수정
	@Override 
	public int updateEnrollment(int id) throws DataAccessException {
		return enrollmentDAO.updateEnrollment(id);
	}
	
}
