package com.mySpring.springEx.company.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyService {

	public List listCompanies() throws DataAccessException;
	public List listBySearchCompanies(CompanyVO companyVO) throws DataAccessException;
	public CompanyVO selectCompany(String comId) throws DataAccessException;

}
