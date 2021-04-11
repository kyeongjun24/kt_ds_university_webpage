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
<style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
</style>
  <meta charset="UTF-8">
  <title>글목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
	})
</script>
<body>
<table align="center" border="0" >
  <tr height="10" align="center" id="attr">
     <td><input type="checkbox" id="selectAll"></td>
     <td><b>아이디</b></td>
     <td><b>과정명</b></td>
     <td ><b>시작날짜</b></td>              
     <td ><b>종료날짜</b></td>
     <td><b>등록날짜</b>
  </tr>
<c:choose>
  <c:when test="${coursesList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 과정이 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  <c:when test="${coursesList !=null }" >
    <c:forEach  var="course" items="${coursesList }" varStatus="articleNum" >
     <tr align="center">
	<!--<td width="5%">${articleNum.count}</td>  -->
	<td><input type="checkbox"></td>
	<td width="10%">${course.id }</td>
	<td align='left'  width="30%">
	  <span style="padding-right:10px"></span>
	  <a class='cls1' href="${contextPath}/course/selectCourse.do?id=${course.id}">${course.syllabusVO.name }</a>
	 </td>
	 <td>${course.startDate }</td>
	 <td>${course.endDate }</td>
	 <td>${course.joinDate }</td>
	 <%-- <td><a href="${contextPath}/course/updateCourseForm.do?id=${course.id}&slbId=${course.slbId}">수정하기</a></td>
	 <td><a href="${contextPath}/course/removeCourse.do?id=${course.id}">삭제하기</a></td> --%>
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>
<button type="button" onclick="location.href='${contextPath}/course/courseForm.do'" style="width: 5%;">등록</button>
<button type="button" onclick="location.href='#'" style="width: 5%;">삭제</button>
</body>
</html>