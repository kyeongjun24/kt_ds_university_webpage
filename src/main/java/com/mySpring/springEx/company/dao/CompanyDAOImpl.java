package com.mySpring.springEx.company.dao;

import java.util.List;

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
		List<CompanyVO> companyList = null;
		companyList = sqlSession.selectList("mapper.company.selectAllCompaniesList");
		return companyList;
	}

	@Override
	public List selectBySearchMemberList(CompanyVO companyVO) throws DataAccessException {
		List<CompanyVO> companiesBySearchList = null;
		companiesBySearchList = sqlSession.selectList("mapper.company.selectBySearchCompaniesList", companyVO);
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
}
