package com.mySpring.springEx.enrollment.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;

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
	
	@Override
	public List selectAllCompletionList() throws DataAccessException {
		List<EnrollmentVO> completionList = null;
		completionList = sqlSession.selectList("mapper.enrollment.selectAllCompletionList");
		return completionList;
	}
	
	@Override
	public EnrollmentVO selectCompletion(int id) throws DataAccessException {
		EnrollmentVO vo = sqlSession.selectOne("mapper.enrollment.selectCompletion", id);
		return vo;
	}
	
	@Override
	public List selectBySearchCompletion(String searchType, String searchText) throws DataAccessException {
		List<MemberVO> completionBySearchList = null;
		Map<String, String> mapSearch = new HashMap<String, String>();
		mapSearch.put("searchType", searchType);
		mapSearch.put("searchText", searchText);
		completionBySearchList = sqlSession.selectList("mapper.member.selectBySearchCompletion", mapSearch);
		return completionBySearchList;
	}
	
	//페이징 리스트 뽑아오기 메서드
	@Override
	public List<MemberVO> listPaging(int page) throws DataAccessException {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		return sqlSession.selectList("mapper.member.selectCompletionByPaging", page);
	}
	
	// 페이지 기준 설정 메서드
	@Override
	public List<EnrollmentVO> listCriteria(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.member.listCriteria", criteria);
	}
	
	//criteria에 의해 리스트 나누는 메서드
	@Override
	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.member.selectCriteriaBySearchCompletion", criteria);
	}
	
}
