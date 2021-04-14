package com.mySpring.springEx.company.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyDAO {

	public List selectAllCompanyList() throws DataAccessException;
	
	// 회사 검색 메소드
	public List selectBySearchCompanyList(String searchType, String searchText) throws DataAccessException;
	
	// 협력회사 검색 메소드
	public List selectBySearchPartnerList(String searchType, String searchText) throws DataAccessException;

	public CompanyVO selectCompany(String id) throws DataAccessException;

	// 협력회사 리스트 출력 메소드
	public List selectAllPartnersList() throws DataAccessException;
	
	// 회사 삭제 메소드
	public int deleteCompany(String id) throws DataAccessException;

	// 회사 추가 메소드
	public int insertCompany(CompanyVO company) throws DataAccessException;
	
	// 회사 수정 메소드
	public int modCompany(CompanyVO company) throws DataAccessException;
}
