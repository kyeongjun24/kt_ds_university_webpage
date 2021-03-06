package com.mySpring.springEx.survey.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.survey.vo.SurveyVO;




public interface SurveyDAO {
	
	public List selectAllSurveysList() throws DataAccessException;
	public List selectBySearchSurveyList(String searchType, String searchText) throws DataAccessException;
	public int insertSurvey(SurveyVO surveyVO) throws DataAccessException;
	public int deleteSurvey(int id) throws DataAccessException;
	public SurveyVO selectSurvey(int id) throws DataAccessException;
	public int updateSurvey(SurveyVO surveyVO) throws DataAccessException;
	
	public List<SurveyVO> listPaging(int page) throws DataAccessException;
	public List<SurveyVO> listCriteria(Criteria criteria) throws DataAccessException;
	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException;
	public int selectCheckSurvey(int id) throws DataAccessException;
	
	

}
