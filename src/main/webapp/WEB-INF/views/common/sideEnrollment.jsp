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
	<h1 class="side_title">수강관리</h1>

	<ul>
		<c:if test="${viewName eq '/enrollment/listEnrollments' }">
			<li><a href="${contextPath }/enrollment/listEnrollments.do"
				class="no-underline"><b>수강신청내역</b></a></li>
			<br>
			<li><a href="${contextPath }/enrollment/listCompletion.do"
				class="no-underline">수료관리</a></li>
			<br>
		</c:if> 
		
		<c:if test="${viewName eq '/enrollment/enrollmentForm' }">
			<li><a href="${contextPath }/enrollment/listEnrollments.do"
				class="no-underline"><b>수강신청내역</b></a></li>
			<br>
			<li><a href="${contextPath }/enrollment/listCompletion.do"
				class="no-underline">수료관리</a></li>
			<br>
		</c:if>
		
		<c:if test="${viewName eq '/enrollment/enrollmentCourse' }">
			<li><a href="${contextPath }/enrollment/listEnrollments.do"
				class="no-underline"><b>수강신청내역</b></a></li>
			<br>
			<li><a href="${contextPath }/enrollment/listCompletion.do"
				class="no-underline">수료관리</a></li>
			<br>
		</c:if>
		
		<c:if test="${viewName eq '/enrollment/informationEnrollment' }">
			<li><a href="${contextPath }/enrollment/listEnrollments.do"
				class="no-underline"><b>수강신청내역</b></a></li>
			<br>
			<li><a href="${contextPath }/enrollment/listCompletion.do"
				class="no-underline">수료관리</a></li>
			<br>
		</c:if>
		
		<c:if test="${viewName eq '/enrollment/listCompletion' }">
			<li><a href="${contextPath }/enrollment/listEnrollments.do"
				class="no-underline">수강신청내역</a></li>
			<br>
			<li><a href="${contextPath }/enrollment/listCompletion.do"
				class="no-underline"><b>수료관리</b></a></li>
			<br>
		</c:if>
	</ul>
</div>
