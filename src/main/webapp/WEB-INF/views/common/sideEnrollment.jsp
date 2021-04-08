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
		<a href="${contextPath }/enrollment/listEnrollments.do"  class="no-underline">수강신청내역</a><br>
		<a href="${contextPath }/enrollment/listCompletion.do"  class="no-underline">수료관리</a><br>
	</h1>
	 
