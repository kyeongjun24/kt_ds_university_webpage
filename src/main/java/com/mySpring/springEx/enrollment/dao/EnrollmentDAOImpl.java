package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Repository("enrollmentDAO")
public class EnrollmentDAOImpl implements EnrollmentDAO{

	@Autowired
	private SqlSession sqlSession;

	//수강신청내역 리스트로 이동
	@Override
	public List selectAllEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.selectAllEnrollmentList");
		return enrollmentsList;
	}
	
	//상세 접수내역 페이지로 이동
	@Override
	public EnrollmentVO selectEnrollment(int id) throws DataAccessException {
		EnrollmentVO vo = sqlSession.selectOne("mapper.enrollment.selectEnrollment", id);
		return vo;
	}
	
	// 상태 '승인' 으로 수정
	@Override
	public int updateEnrollment(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollment", id);
		return result;
	}
	
}
