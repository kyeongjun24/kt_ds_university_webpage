<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String viewName = request.getParameter("viewName");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="side">
	<h1 class="side_title">과정관리</h1>

	<ul>
		<c:if test="${fn:startsWith(viewName, '/course/')}">
			<li><a href="${contextPath}/course/listCourses.do" class="no-underline"><b>과정관리</b></a></li><br>
			<li><a href="${contextPath}/syllabus/listSyllabuses.do">강의계획서관리</a></li><br>
			<li><a href="${contextPath}/courseCategory/listAllCourseCategories.do">카테고리관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/syllabus')}">
			<li><a href="${contextPath}/course/listCourses.do" class="no-underline">과정관리</a></li><br>
			<li><a href="${contextPath}/syllabus/listSyllabuses.do"><b>강의계획서관리</b></a></li><br>
			<li><a href="${contextPath}/courseCategory/listAllCourseCategories.do">카테고리관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/courseCategory')}">
			<li><a href="${contextPath}/course/listCourses.do" class="no-underline">과정관리</a></li><br>
			<li><a href="${contextPath}/syllabus/listSyllabuses.do">강의계획서관리</a></li><br>
			<li><a href="${contextPath}/courseCategory/listAllCourseCategories.do"><b>카테고리관리</b></a></li><br>
		</c:if>
	</ul>
</div>

