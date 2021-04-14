package com.mySpring.springEx.enrollment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.enrollment.dao.EnrollmentDAO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;

@Service("enrollmentService")
@Transactional(propagation = Propagation.REQUIRED)
public class EnrollmentServiceImpl implements EnrollmentService{
	
	@Autowired
	private EnrollmentDAO enrollmentDAO;

	@Override
	public List listEnrollments() throws DataAccessException {
		List enrollmentsList = null;
		enrollmentsList = enrollmentDAO.selectAllEnrollmentList();
		return enrollmentsList;
	}
	
	@Override
	public List listCompletion() throws DataAccessException {
		List completionList = null;
		completionList = enrollmentDAO.selectAllCompletionList();
		return completionList;
	}
	
	@Override
	public EnrollmentVO selectCompletion(int id) throws DataAccessException {
		return enrollmentDAO.selectCompletion(id);
	}
	
	//기준 나누는 메서드 
		@Override
		public List listCriteria(Criteria criteria) throws DataAccessException {
			return enrollmentDAO.listCriteria(criteria);
		}
		
		//검색에 의해 나눠지는 메서드
		@Override
		public List listBySearchCompletion(String searchType, String searchText) throws DataAccessException {
			List membersBySearchList = null;
			membersBySearchList = enrollmentDAO.selectBySearchCompletion(searchType, searchText);
			return membersBySearchList;
		}
		
		//검색과 기준에 의해 리스트 나눠지는 메서드
		@Override
		public List listCriteriaBySearch(Criteria criteria) throws DataAccessException {
			List membersCriteriaBySearch = null;
			membersCriteriaBySearch = enrollmentDAO.selectCriteriaBySearch(criteria);
			return membersCriteriaBySearch;
		}
	
	
}
