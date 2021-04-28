package com.mySpring.springEx.event_security_log.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.event_security_log.vo.Event_security_logVO;
import com.mySpring.springEx.survey.vo.SurveyVO;




public interface Event_security_logDAO {
	
	

	public List selectAllLogsList() throws DataAccessException;
	
	public List<Event_security_logVO> listCriteria(Criteria criteria) throws DataAccessException;
	
	public List selectCriteriaBySearchLogList(Criteria criteria) throws DataAccessException;

	public List selectBySearchLogList(String searchType, String searchText) throws DataAccessException;
	
	public List<Event_security_logVO> listPaging(int page) throws DataAccessException;

	


}
