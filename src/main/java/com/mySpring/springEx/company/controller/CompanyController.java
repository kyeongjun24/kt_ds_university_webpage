package com.mySpring.springEx.company.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyController {

	ModelAndView listCompanies(HttpServletRequest request, HttpServletResponse response) throws Exception;
	List listBySearchCompanies(CompanyVO companyVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	ModelAndView selectCompany(@RequestParam String comId, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 협력회사 출력
	ModelAndView listSuppliers(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
