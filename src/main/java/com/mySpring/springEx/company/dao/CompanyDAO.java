package com.mySpring.springEx.company.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyDAO {

	public List selectAllCompanyList() throws DataAccessException;

	public List selectBySearchMemberList(CompanyVO companyVO) throws DataAccessException;

	public CompanyVO selectCompany(String id) throws DataAccessException;

	// 협력회사 리스트 출력 메소드
	public List selectAllPartnersList() throws DataAccessException;
	
	// 회사 삭제 메소드
	public int deleteCompany(String id) throws DataAccessException;
}
