<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
   request.setCharacterEncoding("UTF-8");
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
	.menuCategory{
		height: 5%; 
		width: 100%;
		margin-bottom: 1%;
		text-align: left;
	}
</style>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
		
%>
	
	<div class="menuCategory">
		<h5>과정 관리 > 카테고리 수정</h5>
	</div>
	
	<h1  class="text_center">카테고리 수정</h1>
	<form method="post"   action="${contextPath}/courseCategory/updateCourseCategory.do">
		<input type="hidden" name="id" value="${courseCategoryVO.id }">
		<table  align="center" >
			<tr>
				<td>분류 명</td>
				<td><input type="text" name="name" value="${courseCategoryVO.name}">${courseCategoryVO.id }</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="수정"><input type="button" onclick="history.back()" value="취소"></td>
			</tr>
		</table>
	</form>
<%} else {  %>
<script>
	window.location.href="${contextPath}";
</script>
<% } %>	
</body>
</html>