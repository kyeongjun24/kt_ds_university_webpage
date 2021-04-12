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
<title>수강 등록</title>
</head>
<body>
	<form method="post"   action="${contextPath}/enrollment/addEnrollment.do" id=registerFrm>
	<h1  class="text_center"> 수강 등록 페이지</h1>
	
	<table  align="center">
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><input type="text" name="=id" id="=id"></td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">과정명</td>
	      <td width="400"><input type="text" name="=id" id="=id"></td>
	   </tr>
	</table>
	
	<input type="submit" value="가입하기">&nbsp;<input type="reset" value="다시입력" id="reset">&nbsp;
	<button type="button" onclick="location.href = '${contextPath}/enrollment/listEnrollments.do' " style="width: 5%;">목록</button>
	
	</form>
</body>
</html>