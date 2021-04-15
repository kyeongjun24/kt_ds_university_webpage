<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="side">
	<h1 class="side_title">설문조사관리</h1>

	<ul>
		<li><a href="#" class="no-underline">사전사후 이해도 조사</a></li>
		<br>
		<li><a href="#" class="no-underline">만족도 평가</a></li>
		<br>
		<li><a href="#" class="no-underline">수요조사</a></li>
		<br>
	</ul>
</div>
