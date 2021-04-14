package com.mySpring.springEx.company.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyService {

	public List listCompanies() throws DataAccessException;
	
	// 회사 검색 메소드
	public List listBySearchCompanies(String searchType, String searchText) throws DataAccessException;

	public CompanyVO selectCompany(String id) throws DataAccessException;

	// 협력회사 리스트 출력 메소드
	public List listPartners() throws DataAccessException;
	
	// 회사 삭제 메소드
	public int removeCompany(String id) throws DataAccessException;
	
	// 회사 추가 메소드
	public int addCompany(CompanyVO companyVO) throws DataAccessException;

	// 회사 수정 메소드
	public int modCompany(CompanyVO companyVO) throws DataAccessException;
	
	// 협력회사 검색 메소드
	public List listBySearchPartners(String searchType, String searchText) throws DataAccessException;

	

}
