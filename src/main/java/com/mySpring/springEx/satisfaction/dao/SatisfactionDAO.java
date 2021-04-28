package com.mySpring.springEx.satisfaction.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.satisfaction.vo.SatisfactionVO;





public interface SatisfactionDAO {

	public List selectAllSatisfactionsList() throws DataAccessException;

	public List selectBySearchSatisfactionList(String searchType, String searchText) throws DataAccessException;

	public int insertSatisfaction(SatisfactionVO satisfactionVO) throws DataAccessException;

	public List<SatisfactionVO> listPaging(int page) throws DataAccessException;

	public List<SatisfactionVO> listCriteria(Criteria criteria) throws DataAccessException;

	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException;

	public SatisfactionVO selectSatisfaction(int id) throws DataAccessException;

	public int selectCheckSatisfaction(int id) throws DataAccessException;

	public int updateSatisfaction(SatisfactionVO satisfactionVO) throws DataAccessException;

	public int deleteSatisfaction(int id) throws DataAccessException;

	
	
	

}
