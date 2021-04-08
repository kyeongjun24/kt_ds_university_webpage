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
	
	// ªÛ≈¬ "Ω¬¿Œ" ¿∏∑Œ πŸ≤„¡‹
	@Override
	public int updateEnrollment(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollment", id);
		return result;
	}
	
	// ªÛ≈¬ "ºˆ∑·" ∑Œ πŸ≤„¡‹
	@Override
	public int updateEnrollmentComplete(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollmentComplete", id);
		return result;
	}
	
	// ªÛ≈¬ "√Îº“" ∑Œ πŸ≤„¡‹
	@Override
	public int updateEnrollmentCancel(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollmentCancel", id);
		return result;
	}
}
