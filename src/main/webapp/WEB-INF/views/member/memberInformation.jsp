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
<title>회원 정보 수정창</title>
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
	<h1  class="text_center">${vo.name } 회원 정보</h1>
	<table  align="center" >
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><p align="center">${vo.id }</td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">비밀번호</td>
	      <td width="400"><p align="center">${vo.pw }</td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">비밀번호 확인</td>
	      <td width="400"><p align="center">${vo.pw }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">이름</td>
	       <td width="400"><p align="center">${vo.name }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">연락처</td>
	       <td width="400"><p align="center">${vo.phone }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">이메일</td>
	       <td width="400"><p align="center">${vo.email }
	    </tr>
	    <tr>
	       <td width="200"><p align="right">수신동의 여부</td>
	       <td width="400"><p align="center">${vo.subscription }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">회사명</td>
	       <td width="400"><p align="center">${vo.companyName }</td> 
	    </tr>
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><p align="center"><button type="button" onclick="location.href='${contextPath}/member/modMemberForm.do?id=${vo.id }'">수정하기</button>&nbsp;&nbsp;&nbsp;<input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	
</body>
</html>