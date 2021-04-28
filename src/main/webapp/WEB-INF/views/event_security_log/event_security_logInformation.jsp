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
<title>로그 조회창</title>
<style>
   .text_center{
     text-align:center;
   }
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	
</script>
</head>
<body>
	<table>
	   <tr>
	      <td width="200"><p align="right">번호</td>
	      <td width="400"><p align="center">${vo.id-89999 }</td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><p align="center">${vo.user }</td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">이벤트 타입</td>
	      <td width="400"><p align="center">${vo.type }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">발생일시</td>
	       <td width="400"><p align="center">${vo.date }</td>
	    </tr>    
	    <tr>
	       <td width="200"><p align="right">로그 텍스트</td>
	       <td width="400"><p align="center">${vo.text }</td>
	    </tr>
	    
	    
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><p align="center"><input type="button" onclick="history.back()" value="목록"></td>
	    </tr>
	</table>
	
</body>
</html>