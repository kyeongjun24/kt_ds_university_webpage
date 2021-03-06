package com.mySpring.springEx.company.controller;

import java.io.File;
import java.net.URI;
import java.net.URLEncoder;
import java.text.Normalizer.Form;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.common.paging.PageMaker;
import com.mySpring.springEx.company.service.CompanyService;
import com.mySpring.springEx.company.vo.CompanyVO;

@Controller("companyController")
public class CompanyControllerImpl implements CompanyController {

	@Autowired
	CompanyService companyService;

	// 전체회사 리스트 출력 메소드
	@Override
	@RequestMapping(value = "/company/listCompanies.do", method = RequestMethod.GET)
	public ModelAndView listCompanies(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");

		int page = 0;

		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		} else {
			page = 1; 
		}

		int perPage = 0;

		
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt(request.getParameter("perPage")); 
		} else {
			perPage = 10;
		}

		List companiesList = null;
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); 
		pageMaker.setCriteria(criteria); 

		if (searchType != null && searchText != null) { 
			companiesList = companyService.listBySearchCompanies(searchType, searchText);
			criteria.setPage(page); 
			criteria.setSearchText(searchText); 
			criteria.setSearchType(searchType); 
			pageMaker.setTotalCount(companiesList.size());
			companiesList = companyService.listCriteriaBySearch(criteria); 
			mav.addObject("searchText", searchText);
			mav.addObject("searchType", searchType);
		} else {
			companiesList = companyService.listCompanies();
			criteria.setPage(page);
			pageMaker.setTotalCount(companiesList.size()); 
			companiesList = companyService.listCriteria(criteria);
		}
		mav.addObject("page", page);
		mav.addObject("criteria", criteria);
		mav.addObject("perPage", perPage);
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("companiesList", companiesList); 
		return mav;
	}

	// 회사관리에서 검색된 회사 출력
	@Override
	@ResponseBody
	@RequestMapping(value = "/company/listBySearch.do", method = RequestMethod.POST)
	public ModelAndView listBySearchCompanies(@RequestParam("searchType") String searchType,
			@RequestParam("searchText") String searchText, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List companiesList = companyService.listBySearchCompanies(searchType, searchText);
		ModelAndView mav = new ModelAndView("/company/listCompanies");
		mav.addObject("companiesList", companiesList);
		return mav;
	}

	// 협력회사 리스트 불러오는 메소드
	@Override
	@RequestMapping(value = "/partner/listPartners.do", method = RequestMethod.GET)
	public ModelAndView listPartners(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = request.getParameter("searchType");
		String searchText = request.getParameter("searchText");

		
		int page = 0;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page")); 
		} else {
			page = 1; 
		}

		int perPage = 0; 

		
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt((String) request.getParameter("perPage")); 
		} else {
			perPage = 10;
		}

		List partnersList = null;
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); 
		pageMaker.setCriteria(criteria); 

		if (searchType != null && searchText != null) {
			partnersList = companyService.listBySearchPartners(searchType, searchText);
			criteria.setPage(page); 
			criteria.setSearchText(searchText); 
			criteria.setSearchType(searchType); 
			pageMaker.setTotalCount(partnersList.size());
			partnersList = companyService.partnerListCriteriaBySearch(criteria);
			mav.addObject("searchText", searchText); 
			mav.addObject("searchType", searchType); 
		} else { 
			partnersList = companyService.listPartners();
			criteria.setPage(page);
			pageMaker.setTotalCount(partnersList.size()); 
			partnersList = companyService.partnerListCriteria(criteria);
		}
		mav.addObject("criteria", criteria);
		mav.addObject("perPage", perPage); 
		mav.addObject("pageMaker", pageMaker); 
		mav.addObject("partnersList", partnersList);
		return mav;
	}

	// 협력회사 검색 할 수 있는 메소드
	@Override
	@RequestMapping(value = "/partner/listBySearchPartners.do", method = RequestMethod.POST)
	public ModelAndView listBySearchPartners(@RequestParam("searchType") String searchType,
			@RequestParam("searchText") String searchText, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List partnersList = companyService.listBySearchPartners(searchType, searchText);
		ModelAndView mav = new ModelAndView("/partner/listPartners");
		mav.addObject("partnersList", partnersList);
		return mav;
	}

	// 회사 등록할 수 있는 메소드
	@Override
	@RequestMapping(value = "/company/addCompany.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView addCompany(@ModelAttribute("company") CompanyVO companyVO, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String searchType = (String) request.getParameter("searchType");
		String searchText = URLEncoder.encode((String) request.getParameter("searchText"),"utf-8");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		// 아이디랑 주소는 add.jsp에서 안넘어와서 컨트롤러에서 값을 합쳐줬다.
		companyVO.setid(
				request.getParameter("id1") + "-" + request.getParameter("id2") + "-" + request.getParameter("id3"));
		companyVO.setAddress(
				request.getParameter("address1") + "," + request.getParameter("address2"));
		int result = 0;
		result = companyService.addCompany(companyVO);
		rttr.addAttribute("page", criteria.getPage());
		rttr.addAttribute("perPageNum", criteria.getPerPageNum());
		rttr.addAttribute("searchType", criteria.getSearchType());
		rttr.addAttribute("searchText", criteria.getSearchText());
		ModelAndView mav = new ModelAndView("redirect:/company/listCompanies.do?&page="+page+"&searchType="+searchType+"&searchText="+searchText+"&perPage="+perPage);
		return mav;
	}

	// 협력회사, 회사관리 리스트의 회사명을 클릭하면 그 회사의 정보가 띄어지는 메소드
	@Override
	@RequestMapping(value = "/company/companyForm.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView selectCompany(@RequestParam("id") String id, @RequestParam("type") String type, @ModelAttribute("criteria") Criteria criteria, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		CompanyVO companyVO = new CompanyVO();
		mav.setViewName(viewName);
		companyVO = companyService.selectCompany(id);
		model.addAttribute("type", type);
		model.addAttribute("criteria", criteria);
		model.addAttribute("companyVO", companyVO);
		mav.addObject("companyVO", companyVO);
		return mav;
	}

	// 회사 수정할 수 있는 메소드
	@Override
	@RequestMapping(value = "/company/modCompany.do", method = RequestMethod.POST)
	public ModelAndView modCompany(@ModelAttribute("company") CompanyVO companyVO, @RequestParam("type") String type, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr,  HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		companyVO.setid(
				request.getParameter("id1") + "-" + request.getParameter("id2") + "-" + request.getParameter("id3"));
		companyVO.setAddress(
				request.getParameter("address1") + "," + request.getParameter("address2"));
		
		int result = 0;
		result = companyService.modCompany(companyVO);
		
		rttr.addAttribute("page", criteria.getPage());
		rttr.addAttribute("perPageNum", criteria.getPerPageNum());
		rttr.addAttribute("searchType", criteria.getSearchType());
		rttr.addAttribute("searchText", criteria.getSearchText());
		ModelAndView mav = new ModelAndView();
		
		if (type.equals("partner")) {
			mav.setViewName("redirect:/partner/listPartners.do");
		} else {
			mav.setViewName("redirect:/company/listCompanies.do");
		}
		return mav;
	}

	// 회사명을 선택하면 회사 상세창에서 회사를 삭제할 수 있는 메소드
	@Override
	@RequestMapping(value = "/company/removeCompany.do", method = RequestMethod.GET)
	public ModelAndView removeCompany(@RequestParam("id") String id, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		companyService.removeCompany(id);
		
		rttr.addAttribute("page", criteria.getPage());
		rttr.addAttribute("perPageNum", criteria.getPerPageNum());
		rttr.addAttribute("searchType", criteria.getSearchType());
		rttr.addAttribute("searchText", criteria.getSearchText());
		ModelAndView mav = new ModelAndView("redirect:/company/listCompanies.do");
		return mav;
	}

	// 회사 리스트 창에서 체크해서 회사를 삭제할 수 있는 메소드
	@Override
	@ResponseBody
	@RequestMapping(value = "/company/removeCheckedCompanies.do", method = RequestMethod.POST)
	public int removeCheckedCompanies(String[] arr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		for (int i = 0; i < arr.length; i++) {
			result = companyService.removeCompany(arr[i]);
		}
		return result;
	}

	// 전체 회사 엑셀 다운로드
	@Override
	@RequestMapping(value = "/company/excelDownload.do", method = RequestMethod.POST)
	@ResponseBody
	public void companyExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		companyService.companyExcelDownload(response);
	}

	// 협력 회사 엑셀 다운로드
	@Override
	@RequestMapping(value = "/partner/partnersExcelDownload.do", method = RequestMethod.POST)
	@ResponseBody
	public void partnersExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		companyService.partnersExcelDownload(response);
	}

	// 학생관리의 수정창 안에 회사수정 팝업창
	@RequestMapping(value = "/company/popUp.do", method = { RequestMethod.GET, RequestMethod.POST })
	private ModelAndView popUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");

		
		int page = 0;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page")); 
		} else {
			page = 1; 
		}

		int perPage = 0; 
		
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt(request.getParameter("perPage")); 
		} else {
			perPage = 10; 
		}
		List companiesList = companyService.listCompanies();
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); 
		pageMaker.setCriteria(criteria); 

		if (searchType != null && searchText != null) { 
			companiesList = companyService.searchFromPopUp(searchType, searchText);
			criteria.setPage(page); 
			criteria.setSearchText(searchText); 
			criteria.setSearchType(searchType); 
			pageMaker.setTotalCount(companiesList.size()); 
			companiesList = companyService.listCriteriaBySearchFromPopUp(criteria); 
			mav.addObject("searchText", searchText); 
			mav.addObject("searchType", searchType); 
		} else {
			companiesList = companyService.listCompanies(); 
			criteria.setPage(page); 
			pageMaker.setTotalCount(companiesList.size()); 
			companiesList = companyService.listCriteria(criteria);
		}
		mav.addObject("perPage", perPage);
		mav.addObject("pageMaker", pageMaker); 
		mav.addObject("companiesList", companiesList);
		return mav;
	}

	// 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/company/idCheck.do", method = RequestMethod.POST)
	public int idCheck(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		CompanyVO vo = new CompanyVO();
		vo.setid(id);
		int result = companyService.idCheck(vo);
		return result;
	}

	@RequestMapping(value = "/company/*Form.do", method = RequestMethod.GET)
	private ModelAndView Form(@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page")); 
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		mav.addObject("page", page);
		mav.addObject("perPage", perPage); 
		mav.addObject("searchText", searchText);
		mav.addObject("searchType", searchType);
		return mav;
	}

	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}
}
