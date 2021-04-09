<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />


	<h1>사이드 메뉴</h1>
	
	<h1>
		<a href="${contextPath}/company/listPartners.do" class="no-underline">협약회사</a><br>
		<a href="${contextPath}/member/listMembers.do"  class="no-underline">학생관리</a><br>
		<a href="${contextPath}/company/listCompanies.do" class="no_unerline">회사관리</a><br>
		<a href="#"  class="no-underline">계정관리</a><br>
	</h1>
	 
