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
<title>수요조사 조회창</title>
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
	      <td width="400"><p align="center">${vo.id-109999 }</td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">제목</td>
	      <td width="400"><p align="center">${vo.title }</td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">등록일</td>
	      <td width="400"><p align="center">${vo.joinDate }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">개설상태</td>
	       <td width="400"><p align="center">${vo.state }</td>
	    </tr>    
	    <tr>
	       <td width="200"><p align="right">내용</td>
	       <td width="400"><p align="center">${vo.contents }</td>
	    </tr>
	    
	    <tr>
	       <td width="200"><p align="right">URL링크</td>
	       <td width="400"><p align="center">
	       <a href=${vo.url } target='_blank'>설문 조사 바로가기</a></td>
	    </tr>
	    
	    <tr>
	       <td style="border : none" width="200"><p>&nbsp;</p></td>
	       <td style="border : none" width="400"><p align="center"><button type="button" id="enrollButton" onclick="location.href='${contextPath}/survey/modSurveyForm.do?id=${vo.id }'">수정</button>&nbsp;&nbsp;&nbsp;<input type="button" onclick="history.back()" value="목록"></td>
	    </tr>
	</table>
	
</body>
</html>