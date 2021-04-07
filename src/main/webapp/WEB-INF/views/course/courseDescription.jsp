<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 설명</title>

</head>
<body>
	<h1>${vo.id }</h1>
	<h1>${vo.startDate }</h1>
	<h1>${vo.endDate }</h1>
	<h3>${vo.startTime }</h3>
	<h3>${vo.endTime }</h3>
	<h3>${vo.capacity }</h3>
	<h1>${vo.classroom }</h1>
	<h1>${vo.joinDate }</h1>
	
</body>
</html>