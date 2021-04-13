package com.mySpring.springEx.company.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.company.vo.CompanyVO;

@Repository("companyDAO")
public class CompanyDAOImpl implements CompanyDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List selectAllCompanyList() throws DataAccessException {
		List<CompanyVO> companiesList = null;
		companiesList = sqlSession.selectList("mapper.company.selectAllCompaniesList");
		return companiesList;
	}

	@Override
	public List selectBySearchCompanyList(String searchType, String searchText) throws DataAccessException {
		List<CompanyVO> companiesBySearchList = null;
		Map<String, String> mapSearch = new HashMap<String, String>();
		mapSearch.put("searchType", searchType);
		mapSearch.put("searchText", searchText);
		companiesBySearchList = sqlSession.selectList("mapper.company.selectBySearchCompaniesList", mapSearch);
		return companiesBySearchList;
	}

	@Override
	public CompanyVO selectCompany(String id) throws DataAccessException {
		CompanyVO vo = sqlSession.selectOne("mapper.company.selectCompany", id);
		return vo;
	}
	
	@Override
	public List selectAllPartnersList() throws DataAccessException {
		List<CompanyVO> partnersList = null;
		partnersList = sqlSession.selectList("mapper.company.selectAllPartnersList");
		return partnersList;
	}
	
	// 회사 삭제 메소드
	@Override
	public int deleteCompany(String id) throws DataAccessException {
		int result = sqlSession.delete("mapper.company.deleteCompany",id);
		return result;
	}
	
	// 회사 등록 메소드
	@Override
	public int insertCompany(CompanyVO company) throws DataAccessException {
		int result = sqlSession.insert("mapper.company.insertCompany", company);
		return result;
	}
	
	// 회사 수정 메소드
	@Override
	public int modCompany(CompanyVO company) throws DataAccessException {
		int result = sqlSession.update("mapper.company.updateCompany", company);
		return result;
	}
}
