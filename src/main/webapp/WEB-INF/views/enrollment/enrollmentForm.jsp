<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강 등록</title>

<style>
   
   .process {
	text-align: left;
	color: #9C9D9D;
	margin-bottom: 2em;
	}
	
	.searchButton {
	  background-color: #969696;
	  border: none;
	  border-radius: 5px;	
	  color: #EFEFEF;
	  padding: 5px 12px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 15px;
	  cursor: pointer; 
	}
	
	.erollmentMember_table {
		border-bottom: 0.3px solid;
		border-color: rgba(156, 157, 157, 0.2);
		width : 75%;
	}
	
	#courseId {
		width: 500px;
	}
	
	#memberId {
		width: 430px;
		outline: none;
	}
	
	#lastTd {
		border-style: hidden;
	}
	
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	
	//아이디 검색 팝업
	function popup(){
		var url = "${contextPath}/member/memberSearchPopUp.do";
		var name = "popup test";
		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
	
	//입력 안하면 등록 불가능
	$(function() {
		$('.inputForm').submit(function(){
			
			var frm = document.registerForm;
			var member = document.getElementById('memberId').value;
			var course = document.getElementById('courseId').value;
			
			if (member == '') {
				alert('아이디를 선택해주세요.');
     			return false;
			} else if (course == '') {
				alert('과정명을 선택해주세요.');
				return false;
			}
			
			return true;
		}) 
	})
	
</script>

</head>
<body>

	<div class="process">
		<h4>
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;">수강관리</span> > 
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;"> 수강신청내역</span> >
			<span onclick="location.href='${contextPath}/enrollment/enrollmentForm.do'"
			style="cursor: pointer;"> 수강등록</span>
		</h4>
	</div>
	
	<form method="post" class="inputForm" action="${contextPath}/enrollment/addEnrollment.do" id="registerForm" name="registerForm">

		<table class="erollmentMember_table" align="center">
			<tr>
				<td width="200"><p align="right">아이디</td>
				<td width="400"><p align="center">
						<input type="text" name="memberVO.id" id="memberId" readonly
						 placeholder="아이디를 검색하세요."> 
						<a class="searchButton" type="button" onclick="popup()">검색</a>
			</tr>
			<tr>
				<td width="200"><p align="right">과정명</td>
				<td width="400">
					<select name="courseVO.id" id="courseId">
						<option id="selectBox" value="" disabled selected>과정명을 선택하세요</option>
							<c:forEach var="enrollmentVO" items="${syllabusesCoursesList}">
								<option value="${enrollmentVO.courseVO.id }">${enrollmentVO.syllabusVO.name } 
								(${enrollmentVO.courseVO.startDate } ~ ${enrollmentVO.courseVO.endDate })</option>
							</c:forEach>
					</select></td>
			</tr>
			<tr>
				<td id="lastTd" colspan="4" width="250">
					<input type="submit" id="enrollButton" value="등록">&nbsp;&nbsp;&nbsp;
					<input type="reset" value="초기화" id="reset">&nbsp;&nbsp;&nbsp;
					<input type="button" onclick="location.href='${contextPath}/enrollment/listEnrollments.do'" value="목록">
				</td>
			</tr>
		</table>

	</form>
</body>
</html>