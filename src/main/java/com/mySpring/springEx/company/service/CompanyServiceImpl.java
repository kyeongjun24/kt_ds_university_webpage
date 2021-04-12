package com.mySpring.springEx.company.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.company.dao.CompanyDAO;
import com.mySpring.springEx.company.vo.CompanyVO;
import com.mySpring.springEx.course.dao.CourseDAO;

@Service("companyService")
@Transactional(propagation = Propagation.REQUIRED)
public class CompanyServiceImpl implements CompanyService{

	@Autowired
	CompanyDAO companyDAO;
	
	@Override
	public List listCompanies() throws DataAccessException {
		List companiesList = null;
		companiesList = companyDAO.selectAllCompanyList();
		return companiesList;
	}

	@Override
	public List listBySearchCompanies(String searchType, String searchText) throws DataAccessException {
		List companiesBySearchList = null;
		companiesBySearchList = companyDAO.selectBySearchCompanyList(searchType, searchText);
		return companiesBySearchList;
	}

	@Override
	public CompanyVO selectCompany(String id) throws DataAccessException {
		return companyDAO.selectCompany(id);
	}
	
	@Override
	public List listPartners() throws DataAccessException {
		List partnersList = null;
		partnersList = companyDAO.selectAllPartnersList();
		return partnersList;
	}
	
	// 회사 삭제 메소드
	@Override
	public int removeCompany(String id) throws DataAccessException {
		return companyDAO.deleteCompany(id);
	}
	
	// 회사 추가 메소드
	@Override
	public int addCompany(CompanyVO company) throws DataAccessException {
		
		return companyDAO.insertCompany(company);
	}
	
	// 회사 수정 메소드
	@Override
	public int modCompany(CompanyVO company) throws DataAccessException {
		return companyDAO.modCompany(company);
	}
}
