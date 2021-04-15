<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    


<html>
<head>
<style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
</style>
<meta charset=UTF-8">
<title>회원 정보 목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	/* function fn_syllabusForm(isLogOn,syllabusForm,loginForm,syllabusId){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=syllabusForm;
	  }else{
	    alert("로그인 후 과정 등록이 가능합니다.")
	    location.href=loginForm+'?action=/syllabus/updateSyllabusForm.do?id='+syllabusId;
	  }
	} */
	
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
<table border="0"  align="center"  width="80%">
    <tr align="center" id="attr">
      <td><input type="checkbox" id="selectAll"></td>
      <td><b>강의명</b></td>
      <td><b>보고용</b></td>
      <td><b>가입일</b></td>
      <td><b>수정</b></td>
      <td><b>삭제</b></td>
   </tr>
   
 <c:forEach var="syllabus" items="${syllabusesList}" >     
   <tr align="center">
      <td><input type="checkbox"></td>
      <td><a class='cls1' href="${contextPath}/syllabus/selectSyllabus.do?id=${syllabus.id}">${syllabus.name}</a></td>
      <td>${syllabus.reportName}</td>
      <td>${syllabus.joinDate}</td>
      <td><a href="${contextPath }/syllabus/updateSyllabusForm.do?id=${syllabus.id}">수정하기</a></td>
      <td><a href="${contextPath }/syllabus/removeSyllabus.do?id=${syllabus.id}">삭제하기</a></td>
    </tr>
  </c:forEach>   
</table>
<button type="button" onclick="location.href='${contextPath}/syllabus/syllabusForm.do'" style="width: 5%;">등록</button>
<button type="button" onclick="location.href='#'" style="width: 5%;">삭제</button>
</body>
</html>
