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
		<a href="#"  class="no-underline">공지사항</a><br>
		<a href="#"  class="no-underline">FAQ</a><br>
		<a href="#"  class="no-underline">자료실</a><br>
		<a href="#"  class="no-underline">이벤트</a><br>
		<a href="#"  class="no-underline">이름</a><br>
	</h1>
	 
