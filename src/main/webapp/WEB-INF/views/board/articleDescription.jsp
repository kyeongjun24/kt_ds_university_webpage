<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />



<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<%-- <c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<style>
.cls1 {text-decoration:none;}
.cls2{text-align:center; font-size:30px;}
</style>
<link href="${contextPath}/resources/css/style.css" rel="stylesheet"> --%>

<meta charset="UTF-8">
<title >게시판 상세 설명</title>
</head>

<body>
 
	<tr>
	<td width="200" style="font-size:24px; 	color:red;">id : </td>
	<td width="400" style="font-size:24px; 	color:red;">${vo.id}</td>
	</tr>
	<br></br>
	<tr>
	<td width="200" style="font-size:24px; 	color:red;">중요도 : </td>
	<td width="400" style="font-size:24px; 	color:red;">${vo.important}</td>
	</tr>
	<br></br>
	<tr>
	<td width="200">제목 : </td>
	<td width="400">${vo.title}</td>
	</tr>
	<br></br>
	<tr>
	<td width="200">내용 : </td>
	<td width="400">${vo.contents}</td>
	</tr>
	<br></br>
	<tr>
	<td width="200">파일 : </td>
	<td width="400">${filevo.name}</td>
	</tr>
	<br></br>
	<tr>
	<td width="200">작성일 : </td>
	<td width="400">${vo.joinDate}</td>
	</tr>
	<br></br>


<tr>
	 <td>
	 <button onclick="location.href='${contextPath}/board/removeArticle.do?id=${vo.id }'">삭제</button>  &nbsp;&nbsp;&nbsp;
	 <button onclick="location.href='${contextPath}/board/modArticleForm.do?id=${vo.id }'">수정</button> &nbsp;&nbsp;&nbsp;
	<input type="button" onclick="history.back()" value="취소">
	 </td>
</tr>
</body>
</html>