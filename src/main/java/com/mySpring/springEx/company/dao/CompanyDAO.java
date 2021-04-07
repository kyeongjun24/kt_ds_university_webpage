package com.mySpring.springEx.company.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyDAO {

	public List selectAllCompanyList() throws DataAccessException;
	public List selectBySearchMemberList(CompanyVO companyVO) throws DataAccessException;
	public CompanyVO selectCompany(String comId) throws DataAccessException;

}
