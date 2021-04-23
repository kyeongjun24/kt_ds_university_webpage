package com.mySpring.springEx.enrollment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.common.paging.PageMaker;
import com.mySpring.springEx.course.service.CourseService;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.service.EnrollmentService;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.service.MemberService;
import com.mySpring.springEx.member.vo.MemberVO;

@Controller("enrollmentController")
public class EnrollmentControllerImpl implements EnrollmentController{

	@Autowired
	private EnrollmentService enrollmentService;
	
	@Autowired
	CourseService courseService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MemberVO memberVO;
	
	@Autowired
	CourseVO courseVO;

	@Override
	@RequestMapping(value="/enrollment/listEnrollments.do" ,method = RequestMethod.GET)
	public ModelAndView listEnrollments(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		List enrollmentsList = enrollmentService.listEnrollments();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("enrollmentsList", enrollmentsList);
		return mav;
	}
	
	//수료관리 리스트 출력 메소드
	@Override
	@RequestMapping(value="/enrollment/listCompletion.do" ,method = RequestMethod.GET)
	public ModelAndView listCompletion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		String searchType = (String)request.getParameter("searchType");
		String searchText = (String)request.getParameter("searchText");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+searchText);
		
		// page 기본 변수 생성
				int page = 0;
				
				// 받은 페이지 값이 있다면
				if(request.getParameter("page") != null) {
					page = Integer.parseInt((String)request.getParameter("page")); //page 변수에 값을 저장
				} else {
					page = 1; //아니면 page 1로 기본 지정
				}
				
				int perPage = 0; //리스트 개수 값 저장할 변수 생성
				
				// perPage 값이 있다면
				if(request.getParameter("perPage") != null) {
					perPage = Integer.parseInt((String)request.getParameter("perPage")); // perPage 변수에 리스트 띄울 개수 저장
				} else {
					perPage = 10; // 기본 10개로 지정
				}
				System.out.println("전달 받은 페이지 번호 page:"+page); // 전달 받은 페이지 번호 page 
				System.out.println("리스트 띄울 개수 Perpage:"+perPage); // 전달 받은 페이지 번호 page 
				
				List completionList = null; 
				ModelAndView mav = new ModelAndView(viewName);
				Criteria criteria = new Criteria();
				PageMaker pageMaker = new PageMaker();
				
				
				criteria.setPerPageNum(perPage); // 리스트 개수 설정
				pageMaker.setCriteria(criteria); // 기준 값 설정
				
				if (searchType != null && searchText != null) { // 검색 유형이랑 값을 받았다면
					System.out.println(searchType);
					System.out.println(searchText);
					System.out.println("@@@@@@@@@검색필터 적용됨요");
					completionList = enrollmentService.listBySearchCompletion(searchType, searchText);
					System.out.println("@@@@@@@@@@서치된 리스트"+completionList.size()); // 검색해서 받은 전체 리스트 사이즈
					criteria.setPage(page); // page 설정
					criteria.setSearchText(searchText); // 검색 값 설정
					criteria.setSearchType(searchType); // 검색 유형 설정
					pageMaker.setTotalCount(completionList.size()); // 페이지 개수를 전체 리스트 크기로 설정
					completionList = enrollmentService.listCriteriaBySearch(criteria); // 기준 설정에 의해 새로 받는 리스트
					System.out.println("page@@@"+page+"번호에 해당하는 리스트 크기"+completionList.size());
					
					mav.addObject("searchText", searchText); // 검색 값 다시 페이지로 보내기
					mav.addObject("searchType", searchType); // 검색 유형 다시 페이지로 보내기
				} else { // 검색 유형이랑 값을 받지 않았다면
					System.out.println("@@@@@@@@검색필터적용안됨요");
					completionList = enrollmentService.listCompletion(); //전체 리스트 저장
//					membersList = memberService.listCriteria(criteria);
					
					 System.out.println(completionList.size()); //전체 사이즈 
					 criteria.setPage(page); //페이지 설정 
					 pageMaker.setTotalCount(completionList.size()); //페이지 개수 설정
					 completionList = enrollmentService.listCriteria(criteria); //기준에 의해 나눠진 리스트 설정
					 			}
				System.out.println("perPage@@@@@@@@@@@@"+perPage);
				mav.addObject("perPage", perPage); // 리스트 기준 값 보내기
				mav.addObject("pageMaker", pageMaker); // 페이지 만들어진 값 보내기
				mav.addObject("completionList", completionList); //설정된 리스트 보내기
				return mav; //리스트 페이지로
			}
	
	//수료증 출력 메소드
	@Override
	@RequestMapping(value="/enrollment/completionDoc.do", method = RequestMethod.GET)
	public ModelAndView completionDoc(@RequestParam int id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		EnrollmentVO enrollmentVO = enrollmentService.selectCompletion(id);
		mv.addObject("enrollmentVO", enrollmentVO);
		return mv;
	}
	
	/*
	 * //수료증 출력 메소드2
	 * 
	 * @RequestMapping(value = "/enrollment/printCompletion.do", method =
	 * RequestMethod.GET)
	 * 
	 * @Override public ModelAndView printCompletion(HttpServletRequest request,
	 * HttpServletResponse response) throws Exception { String viewName =
	 * (String)request.getAttribute("viewName"); System.out.println(viewName);
	 * ModelAndView mav = new ModelAndView(); mav.setViewName(viewName); return mav;
	 * }
	 */
	
}
