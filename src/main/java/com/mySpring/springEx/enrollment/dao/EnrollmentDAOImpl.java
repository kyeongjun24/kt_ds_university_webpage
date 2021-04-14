package com.mySpring.springEx.enrollment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Repository("enrollmentDAO")
public class EnrollmentDAOImpl implements EnrollmentDAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectSylCrsList() throws DataAccessException {
		List<EnrollmentVO> sylCrsList = null;
		sylCrsList = sqlSession.selectList("mapper.enrollment.syllabusCourseEnrollment");
		return sylCrsList;
	}
	
	
	//수강신청내역 리스트로 이동
	@Override
	public List selectAllEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.selectAllEnrollmentList");
		return enrollmentsList;
	}
	
	//수강신청 등록
	@Override
	public int insertEnrollment(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.insert("mapper.enrollment.addEnrollment", enrollmentVO);
		return result;
	}
	
	//상세 접수내역 페이지로 이동
	@Override
	public EnrollmentVO selectEnrollment(int id) throws DataAccessException {
		EnrollmentVO vo = sqlSession.selectOne("mapper.enrollment.selectEnrollment", id);
		return vo;
	}
	
	// 상세페이지 (회사) 수정
	@Override
	public int modEnrollmentCompany(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentCompany", enrollmentVO);
		
		System.out.println(result);
		System.out.println(enrollmentVO.getId());
		return result;
	}
	
	// 상세페이지 (상태) 수정
	@Override
	public int modEnrollmentStat(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentStat", enrollmentVO);
		return result;
	}
	
	// 상태 '승인' 으로 수정
	@Override
	public int updateEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateEnrollments", id);
		return result;
	}
	
}
