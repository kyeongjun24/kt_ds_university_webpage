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
<script>
	function categoryRemove() {
		if (confirm('삭제하시겠습니까?') == true) {
			window.location.href = '${contextPath}/courseCateogry/removeCourseCategory.do?id=${courseCategoryVO.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${[perPage]}';
		} else {
			return false;
		}
	}
</script>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
		
	
%>
	
	<div class="menuCategory" >
		<h5>과정 관리 > 카테고리 상세 창</h5>
	</div>
	<h1  class="text_center">카테고리 상세 정보</h1>
		<table  align="center" >
			<tr>
				<td>분류 명</td>
				<td><input type="text" name="name" value="${courseCategoryVO.name}" readonly></td>
			</tr>
			<tr>
				<td></td>
				<td><button onclick="location.href='${contextPath}/courseCategory/updateCourseCategoryForm.do?id=${courseCategoryVO.id }'">수정하기</button><button onclick="location.href='${contextPath}/courseCategory/removeCourseCategory.do?id=${courseCategoryVO.id }'">삭제</button>
				<button onclick="categoryRemove()" >삭제</button></td>
			</tr>
		</table>
	<%} else {  %>
	<script>
		window.location.href="${contextPath}";
	</script>
	<% } %>	
</body>
</html>