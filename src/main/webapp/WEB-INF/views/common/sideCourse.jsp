<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="side">
	<h1 class="side_title">과정관리</h1>

<ul>
	<li><a href="${contextPath}/course/listCourses.do" class="no-underline">과정관리</a></li><br>
	<li><a href="${contextPath}/syllabus/listSyllabuses.do">강의계획서관리</a></li><br>
	<li><a href="#">카테고리관리</a></li><br>
	</ul>
</div>
