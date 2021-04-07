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

<title>Insert title here</title>
</head>
<style>
.input_text {
	width: 200px;
	height: 20px;
	font-size: 20px;
	border: 1px solid #ff0000;
}
</style>
	  
<body>

<form method="post"   action="${contextPath}/syllabus/addSyllabus.do" id="syllabusRegister">
	<h1  class="text_center">강의 계획서 등록</h1>
	<table  align="center">
	   <tr>
	      <td width="200"><p align="right">강의명</td>
	      <td width="600"><p><input type="text" name="name" class="input_text"></td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">보고용 강의명</td>
	      <td width="400"><p><input type="text" name="reportName" class="input_text"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">교육 시간</td>
	      <td width="400"><p><input type="text" name="time" class="input_text"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">교육 일수</td>
	      <td width="400"><p><input type="text" name="days" class="input_text"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">1차 분류</td>
	      <td width="400"><p>
	      <select name="type">
	        <option value="">유형 선택</option>
	      	<option value="재직자">재직자</option>
	      	<option value="채용예정자">채용예정자</option>
	      	<option value="구직자">구직자</option>
	      </select>
	      </td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">2차 분류</td>
	      <td width="400"><p>
	      <select name="category">
	        <option value="">유형 선택</option>
	      	<option value="DATA ANALSYS">DATA ANALSYS</option>
	      	<option value="WEB APPLICATION">WEB APPLICATION</option>
	      	<option value="DATABASE">DATABASE</option>
	      </select></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">학습 개요</td>
	      <td width="400"><p><input type="text" name="overview" class="input_text"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">학습 목표</td>
	      <td width="400"><p><input type="text" name="objectives" class="input_text"></td>
	   </tr>
	    <tr>
	       <td width="200"><p align="right">학습 대상</td>
	       <td width="400"><p><input type="text" name="target" class="input_text"></td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">학습 내용</td>
	       <td width="400"><p><input type="text" name="contents" class="input_text"></td>
	    </tr>
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><input type="submit" value="등록하기"><input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	</form>
</body>
</html>