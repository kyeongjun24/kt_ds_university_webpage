package com.mySpring.springEx.company.controller;

import java.lang.reflect.Member;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.company.vo.CompanyVO;

public interface CompanyController {
	
	// �쟾泥댄쉶�궗 異쒕젰
	ModelAndView listCompanies(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 寃��깋�맂 �쉶�궗 異쒕젰
	ModelAndView listBySearchCompanies(@RequestParam("searchType") String searchType, @RequestParam("searchText") String searchText, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �삊�젰�쉶�궗 異쒕젰
	ModelAndView listPartners(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �삊�젰�쉶�궗 寃��깋由ъ뒪�듃 異쒕젰
	ModelAndView listBySearchPartners(@RequestParam("searchType") String searchType, @RequestParam("searchText") String searchText, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �쉶�궗 �벑濡앺븷 �닔 �엳�뒗 硫붿냼�뱶
	ModelAndView addCompany(@ModelAttribute("company")CompanyVO companyVO, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response)throws Exception;
	
	// �쉶�궗紐� �겢由��뻽�쓣 �븣
	ModelAndView selectCompany(@RequestParam String comId, @RequestParam String type, @ModelAttribute("criteria") Criteria criteria, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �쉶�궗 �닔�젙�븷 �닔 �엳�뒗 硫붿냼�뱶
	ModelAndView modCompany(@ModelAttribute("company")CompanyVO companyVO, @RequestParam("type") String type, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response)throws Exception;
	
	// �쉶�궗愿�由� �긽�꽭李쎌뿉�꽌 �꽑�깮�맂 �쉶�궗瑜� �궘�젣�븷 �닔 �엳�뒗 硫붿냼�뱶
	ModelAndView removeCompany(@RequestParam("id") String id, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response) throws Exception;
		
	// �쉶�궗愿�由� 由ъ뒪�듃�뿉 �엳�뒗 �궘�젣 踰꾪듉�쑝濡� �쉶�썝�쓣 泥댄겕�빐�꽌 �궘�젣�븷 �닔 �엳�뒗 硫붿냼�뱶
	int removeCheckedCompanies(String [] arr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �쟾泥댄쉶�궗 �뿊�� �떎�슫濡쒕뱶
	void companyExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// �삊�젰�쉶�궗 �뿊�� �떎�슫濡쒕뱶
	void partnersExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
