package com.mySpring.springEx.company.controller;

import java.io.File;
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

	// �쟾泥댄쉶�궗 由ъ뒪�듃 異쒕젰 硫붿냼�뱶
	@Override
	@RequestMapping(value = "/company/listCompanies.do", method = RequestMethod.GET)
	public ModelAndView listCompanies(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");

		// �럹�씠吏� 蹂��닔 �꽑�뼵
		int page = 0;

		// �럹�씠吏� 媛믪씠 �엳�쑝硫�
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page")); // �럹�씠吏� 媛� ���옣
		} else {
			page = 1; // �뾾�쑝硫� 1 ���옣
		}

		int perPage = 0; // 由ъ뒪�듃 媛쒖닔 媛� ���옣�븷 蹂��닔 �깮�꽦

		// perPage 媛� �엳�쑝硫�
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt(request.getParameter("perPage")); // �럹�씠吏� 媛� ���옣
		} else {
			perPage = 10; // �뾾�쑝硫� 10 ���옣
		}

		List companiesList = null;
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); // 由ъ뒪�듃 媛쒖닔 �꽕�젙
		pageMaker.setCriteria(criteria); // 湲곗� 媛� �꽕�젙

		if (searchType != null && searchText != null) { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆븯�쑝硫�
			companiesList = companyService.listBySearchCompanies(searchType, searchText);
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			criteria.setSearchText(searchText); // 寃��깋 媛� �꽕�젙
			criteria.setSearchType(searchType); // 寃��깋 �쑀�삎 �꽕�젙
			pageMaker.setTotalCount(companiesList.size()); // �럹�씠吏� 媛쒖닔瑜� �쟾泥� 由ъ뒪�듃 �겕湲곕줈 �꽕�젙
			companiesList = companyService.listCriteriaBySearch(criteria); // 湲곗� �꽕�젙�뿉 �쓽�빐 �깉濡� 諛쏅뒗 由ъ뒪�듃
			mav.addObject("searchText", searchText); // 寃��깋 媛� �떎�떆 �럹�씠吏�濡� 蹂대궡怨�
			mav.addObject("searchType", searchType); // 寃��깋 �쑀�삎 �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
		} else { // type, text瑜� 諛쏆� �븡�쑝硫�
			companiesList = companyService.listCompanies(); // �쟾泥� 由ъ뒪�듃瑜� ���옣�븯怨�
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			pageMaker.setTotalCount(companiesList.size()); // �럹�씠吏� 媛쒖닔 �꽕�젙
			companiesList = companyService.listCriteria(criteria); // 湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �꽕�젙
		}
		mav.addObject("page", page);
		mav.addObject("criteria", criteria);
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲�
		mav.addObject("pageMaker", pageMaker); // �럹�씠吏� 留뚮뱾�뼱吏� 媛� 蹂대궡湲�
		mav.addObject("companiesList", companiesList); // �꽕�젙�맂 由ъ뒪�듃 蹂대궡湲�
		return mav;
	}

	// �쉶�궗愿�由ъ뿉�꽌 寃��깋�맂 �쉶�궗 異쒕젰
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

	// �삊�젰�쉶�궗 由ъ뒪�듃 遺덈윭�삤�뒗 硫붿냼�뱶
	@Override
	@RequestMapping(value = "/partner/listPartners.do", method = RequestMethod.GET)
	public ModelAndView listPartners(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = request.getParameter("searchType");
		String searchText = request.getParameter("searchText");

		// �럹�씠吏� 蹂��닔 �꽑�뼵
		int page = 0;
		// �럹�씠吏� 媛믪씠 �엳�쑝硫�
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page")); // �럹�씠吏� 媛� ���옣
		} else {
			page = 1; // �뾾�쑝硫� 1 ���옣
		}

		int perPage = 0; // 由ъ뒪�듃 媛쒖닔 媛� ���옣�븷 蹂��닔 �깮�꽦

		// perPage 媛� �엳�쑝硫�
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt((String) request.getParameter("perPage")); // �럹�씠吏� 媛� ���옣
		} else {
			perPage = 10; // �뾾�쑝硫� 10 ���옣
		}

		List partnersList = null;
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); // 由ъ뒪�듃 媛쒖닔 �꽕�젙
		pageMaker.setCriteria(criteria); // 湲곗� 媛� �꽕�젙

		if (searchType != null && searchText != null) {
			partnersList = companyService.listBySearchPartners(searchType, searchText);
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			criteria.setSearchText(searchText); // 寃��깋 媛� �꽕�젙
			criteria.setSearchType(searchType); // 寃��깋 �쑀�삎 �꽕�젙
			pageMaker.setTotalCount(partnersList.size()); // �럹�씠吏� 媛쒖닔瑜� �쟾泥� 由ъ뒪�듃 �겕湲곕줈 �꽕�젙
			partnersList = companyService.partnerListCriteriaBySearch(criteria); // 湲곗� �꽕�젙�뿉 �쓽�빐 �깉濡� 諛쏅뒗 由ъ뒪�듃
			mav.addObject("searchText", searchText); // 寃��깋 媛� �떎�떆 �럹�씠吏�濡� 蹂대궡怨�
			mav.addObject("searchType", searchType); // 寃��깋 �쑀�삎 �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
		} else { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆� �븡�븯�떎硫�
			partnersList = companyService.listPartners();
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			pageMaker.setTotalCount(partnersList.size()); // �럹�씠吏� 媛쒖닔 �꽕�젙
			partnersList = companyService.partnerListCriteria(criteria); // 湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �꽕�젙
		}
		mav.addObject("criteria", criteria);
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲�
		mav.addObject("pageMaker", pageMaker); // �럹�씠吏� 留뚮뱾�뼱吏� 媛� 蹂대궡湲�
		mav.addObject("partnersList", partnersList);
		return mav;
	}

	// �삊�젰�쉶�궗 寃��깋 �븷 �닔 �엳�뒗 硫붿냼�뱶
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

	// �쉶�궗 �벑濡앺븷 �닔 �엳�뒗 硫붿냼�뱶
	@Override
	@RequestMapping(value = "/company/addCompany.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView addCompany(@ModelAttribute("company") CompanyVO companyVO, @ModelAttribute("criteria") Criteria criteria, RedirectAttributes rttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage")); // perPage 蹂��닔�뿉 由ъ뒪�듃 �쓣�슱 媛쒖닔 ���옣
		// �븘�씠�뵒�옉 二쇱냼�뒗 add.jsp�뿉�꽌 �븞�꽆�뼱���꽌 而⑦듃濡ㅻ윭�뿉�꽌 媛믪쓣 �빀爾먯ㄼ�떎.
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

	// �삊�젰�쉶�궗, �쉶�궗愿�由� 由ъ뒪�듃�쓽 �쉶�궗紐낆쓣 �겢由��븯硫� 洹� �쉶�궗�쓽 �젙蹂닿� �쓣�뼱吏��뒗 硫붿냼�뱶
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

	// �쉶�궗 �닔�젙�븷 �닔 �엳�뒗 硫붿냼�뱶
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
		
		// 寃��깋 �썑 �쉶�궗 �꽑�깮�븯怨� �닔�젙�븳 �썑�뿉 �떎�떆 寃��깋 �럹�씠吏�濡� �룎�븘�삤寃�
		rttr.addAttribute("page", criteria.getPage());
		rttr.addAttribute("perPageNum", criteria.getPerPageNum());
		rttr.addAttribute("searchType", criteria.getSearchType());
		rttr.addAttribute("searchText", criteria.getSearchText());
		ModelAndView mav = new ModelAndView();
		// type�씠 �뙆�듃�꼫�씪 寃쎌슦 �삊�젰�쉶�궗濡� �삤寃�, �븘�땲硫� 而댄띁�땲濡� 媛�寃�
		if (type.equals("partner")) {
			mav.setViewName("redirect:/partner/listPartners.do");
		} else {
			mav.setViewName("redirect:/company/listCompanies.do");
		}
		return mav;
	}

	// �쉶�궗紐낆쓣 �꽑�깮�븯硫� �쉶�궗 �긽�꽭李쎌뿉�꽌 �쉶�궗瑜� �궘�젣�븷 �닔 �엳�뒗 硫붿냼�뱶
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

	// �쉶�궗 由ъ뒪�듃 李쎌뿉�꽌 泥댄겕�빐�꽌 �쉶�궗瑜� �궘�젣�븷 �닔 �엳�뒗 硫붿냼�뱶
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

	// �쟾泥� �쉶�궗 �뿊�� �떎�슫濡쒕뱶
	@Override
	@RequestMapping(value = "/company/excelDownload.do", method = RequestMethod.POST)
	@ResponseBody
	public void companyExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		companyService.companyExcelDownload(response);
	}

	// �삊�젰 �쉶�궗 �뿊�� �떎�슫濡쒕뱶
	@Override
	@RequestMapping(value = "/partner/partnersExcelDownload.do", method = RequestMethod.POST)
	@ResponseBody
	public void partnersExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		companyService.partnersExcelDownload(response);
	}

	// �븰�깮愿�由ъ쓽 �닔�젙李� �븞�뿉 �쉶�궗�닔�젙 �뙘�뾽李�
	@RequestMapping(value = "/company/popUp.do", method = { RequestMethod.GET, RequestMethod.POST })
	private ModelAndView popUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		String searchType = (String) request.getParameter("searchType");
		String searchText = (String) request.getParameter("searchText");

		// �럹�씠吏� 蹂��닔 �꽑�뼵
		int page = 0;
		// �럹�씠吏� 媛믪씠 �엳�쑝硫�
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page")); // �럹�씠吏� 媛� ���옣
		} else {
			page = 1; // �뾾�쑝硫� 1 ���옣
		}

		int perPage = 0; // 由ъ뒪�듃 媛쒖닔 媛� ���옣�븷 蹂��닔 �깮�꽦
		// perPage 媛� �엳�쑝硫�
		if (request.getParameter("perPage") != null) {
			perPage = Integer.parseInt(request.getParameter("perPage")); // �럹�씠吏� 媛� ���옣
		} else {
			perPage = 10; // �뾾�쑝硫� 10 ���옣
		}
		List companiesList = companyService.listCompanies();
		ModelAndView mav = new ModelAndView(viewName);
		Criteria criteria = new Criteria();
		PageMaker pageMaker = new PageMaker();

		criteria.setPerPageNum(perPage); // 由ъ뒪�듃 媛쒖닔 �꽕�젙
		pageMaker.setCriteria(criteria); // 湲곗� 媛� �꽕�젙

		if (searchType != null && searchText != null) { // 寃��깋 �쑀�삎�씠�옉 媛믪쓣 諛쏆븯�쑝硫�
			companiesList = companyService.searchFromPopUp(searchType, searchText);
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			criteria.setSearchText(searchText); // 寃��깋 媛� �꽕�젙
			criteria.setSearchType(searchType); // 寃��깋 �쑀�삎 �꽕�젙
			pageMaker.setTotalCount(companiesList.size()); // �럹�씠吏� 媛쒖닔瑜� �쟾泥� 由ъ뒪�듃 �겕湲곕줈 �꽕�젙
			companiesList = companyService.listCriteriaBySearchFromPopUp(criteria); // 湲곗� �꽕�젙�뿉 �쓽�빐 �깉濡� 諛쏅뒗 由ъ뒪�듃
			mav.addObject("searchText", searchText); // 寃��깋 媛� �떎�떆 �럹�씠吏�濡� 蹂대궡怨�
			mav.addObject("searchType", searchType); // 寃��깋 �쑀�삎 �떎�떆 �럹�씠吏�濡� 蹂대궡湲�
		} else { // type, text瑜� 諛쏆� �븡�쑝硫�
			companiesList = companyService.listCompanies(); // �쟾泥� 由ъ뒪�듃瑜� ���옣�븯怨�
			criteria.setPage(page); // �럹�씠吏� �꽕�젙
			pageMaker.setTotalCount(companiesList.size()); // �럹�씠吏� 媛쒖닔 �꽕�젙
			companiesList = companyService.listCriteria(criteria); // 湲곗��뿉 �쓽�빐 �굹�닠吏� 由ъ뒪�듃 �꽕�젙
		}
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲�
		mav.addObject("pageMaker", pageMaker); // �럹�씠吏� 留뚮뱾�뼱吏� 媛� 蹂대궡湲�
		mav.addObject("companiesList", companiesList); // �꽕�젙�맂 由ъ뒪�듃 蹂대궡湲�
		return mav;
	}

	// �븘�씠�뵒 以묐났�솗�씤
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
		int page = Integer.parseInt(request.getParameter("page")); // page 蹂��닔�뿉 媛믪쓣 ���옣
		int perPage = Integer.parseInt(request.getParameter("perPage")); // perPage 蹂��닔�뿉 由ъ뒪�듃 �쓣�슱 媛쒖닔 ���옣
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		mav.addObject("page", page);
		mav.addObject("perPage", perPage); // 由ъ뒪�듃 湲곗� 媛� 蹂대궡湲� 
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
