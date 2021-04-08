package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.enrollment.vo.EnrollmentVO;

@Repository("enrollmentDAO")
public class EnrollmentDAOImpl implements EnrollmentDAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.selectAllEnrollmentList");
		return enrollmentsList;
	}
	
	// 상태 '승인' 으로 수정
	@Override
	public int updateEnrollment(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollment", id);
		return result;
	}
	
	// 상태 '수료' 로 수정
	@Override
	public int updateEnrollmentComplete(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollmentComplete", id);
		return result;
	}
	
	// 상태 '취소' 로 수정
	@Override
	public int updateEnrollmentCancel(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollmentCancel", id);
		return result;
	}
}
