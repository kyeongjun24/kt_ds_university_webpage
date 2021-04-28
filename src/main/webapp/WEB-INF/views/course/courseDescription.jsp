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
	<h1  class="text_center">강의 정보</h1>
	<table  align="center" >
	   <tr>
	      <td width="200"><p align="right">강의 아이디</td>
	      <td width="400"><p align="center">${vo.id }</td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">강의 계획서</td>
	      <td width="400"><p align="center">${vo.slbId }</td>
	      
	    </tr>
	    <tr>
	      <td width="200"><p align="right">수강 기간</td>
	      <td width="400"><p align="center">${vo.startDate }~${vo.endDate }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">접수 기간</td>
	       <td width="400"><p align="center">${vo.rsDate }~${vo.reDate }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">강의 시간</td>
	       <td width="400"><p align="center">${vo.startTime }~${vo.endTime }</td>
	    </tr>
	    
	    <tr>
	       <td width="200"><p align="right">강의실 정보</td>
	       <td width="400"><p align="center">${vo.classroom }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">파일첨부</td>
	       <td width="400"><p align="center">${vo.bannerImg }</td> 
	    </tr>
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><p align="center"><button type="button" onclick="location.href='${contextPath}/course/updateCourseForm.do?id=${vo.id }&slbId=${vo.slbId}'">수정하기</button>&nbsp;&nbsp;&nbsp;<input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	
</body>
</html>