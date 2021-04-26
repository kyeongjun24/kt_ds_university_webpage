package com.mySpring.springEx.enrollment.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Repository("enrollmentDAO")
public class EnrollmentDAOImpl implements EnrollmentDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// 검색에 의해 나눠지는 메서드
	@Override
	public List selectBySearchEnrollmentList(String searchType, String searchText) throws DataAccessException {
		List<EnrollmentVO> enrollmentsBySearchList = null;
		Map<String, String> mapSearch = new HashMap<String, String>();
		mapSearch.put("searchType", searchType);
		mapSearch.put("searchText", searchText);
		enrollmentsBySearchList = sqlSession.selectList("mapper.enrollment.selectBySearchEnrollmentList", mapSearch);
		return enrollmentsBySearchList;
	}
	
	// 페이지 기준 설정 메서드
	@Override
	public List<EnrollmentVO> listCriteria(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.enrollment.listCriteria", criteria);
	}
	
	// criteria에 의해 리스트 나누는 메서드
	@Override
	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.enrollment.selectCriteriaBySearchEnrollmentList", criteria);
	}
	
	// 페이징 리스트 뽑아오기 메서드
	@Override
	public List<EnrollmentVO> listPaging(int page) throws DataAccessException {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		return sqlSession.selectList("mapper.enrollment.selectEnrollmentListByPaging", page);
	}
	
	//등록 페이지 리스트 출력
	@Override
	public List selectSylCrsList() throws DataAccessException {
		List<EnrollmentVO> sylCrsList = null;
		sylCrsList = sqlSession.selectList("mapper.enrollment.syllabusCourseEnrollment");
		return sylCrsList;
	}
	
	// 리스트 페이지
	@Override
	public List selectAllEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.selectAllEnrollmentList");
		return enrollmentsList;
	}

	// 상세 페이지 (사람)
	@Override
	public EnrollmentVO enrollmentMember(int id) throws DataAccessException {
		EnrollmentVO vo = sqlSession.selectOne("mapper.enrollment.enrollmentMember", id);
		return vo;
	}

	// 상세 페이지 (강의)
	@Override
	public List enrollmentCourse(int id) throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.enrollmentCourse", id);
		return enrollmentsList;
	}
	
	// 엑셀 다운로드
	@Override
	public List excelEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.excelEnrollmentList");
		return enrollmentsList;
	}

	//수강신청 등록
	@Override
	public int insertEnrollment(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.insert("mapper.enrollment.addEnrollment", enrollmentVO);
		return result;
	}
	
	// 상세페이지 (회사) 수정
	@Override
	public int modEnrollmentCompany(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentCompany", enrollmentVO);
		return result;
	}
	
	// 상세페이지 (상태) 수정
	@Override
	public int modEnrollmentStat(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentStat", enrollmentVO);
		return result;
	}
	
	// 상태 '삭제' 로 수정
	@Override
	public int updateDeleteEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateDeleteEnrollments", id);
		return result;
	}

	// 상태 '승인' 으로 수정
	@Override
	public int updateApproveEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateApproveEnrollments", id);
		return result;
	}
		
	// 상태 '수료' 로 수정
	@Override
	public int updateCompleteEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateCompleteEnrollments", id);
		return result;
	}

	//(등록관련) 수강신청 되어있는지 체크
	public int checkEnrollment(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.insert("mapper.enrollment.checkEnrollment", enrollmentVO);
		return result;
	}
}
