package com.mySpring.springEx.company.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyService {

	public List listCompanies() throws DataAccessException;

	public List listBySearchCompanies(CompanyVO companyVO) throws DataAccessException;

	public CompanyVO selectCompany(String id) throws DataAccessException;

	// 협력회사 리스트 출력 메소드
	public List listPartners() throws DataAccessException;
	
	// 회사 삭제 메소드
	public int removeCompany(String id) throws DataAccessException;

}
