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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	
/* 	$(function() {
		$('#id').on('keyup', function(){
			var courseId = this.value;
			
				$.ajax({
					type:'post',
					url:'${contextPath}/enrollment/checkEnrollment.do',
					data: 'memId='+memberId+'crsId='+courseId,
			//뒤가 jsp id 데이터값
					success: function(result){
						if(result == 1){
							$('#idCheck').html('과목 중복').css('color','red');
						}else {
							$('#idCheck').html('적절한 과목').css('color','blue');
						}
						
					}, error:function(result,request,status,error){
			             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        }
				})
		})
		
		$('#registerFrm').submit(function() {
			var idCheck = document.getElementById("idCheck").innerHTML;
			
			if (idCheck == "적절한 과목") {
				return true;
			} else if(idCheck != "적절한 과목") {
				alert("과목 중복 확인 해주세요.");
				return false;
			}
			
			return false;
		})
		
		$('#reset').on('click', function() {
			$('#idCheck').html('');
		})
	
	}) */
			
	
	
	//아이디 검색 팝업
	function popup(){
		var url = "${contextPath}/member/memberSearchPopUp.do";
		var name = "popup test";
		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
	
</script>

</head>
<body>
	<form method="post" action="${contextPath}/enrollment/addEnrollment.do" id=registerFrm>
		<h1 class="text_center">수강 등록 페이지</h1>

		<table align="center">
			<tr>
				<td width="200"><p align="right">아이디</td>
				<!-- <td width="400"><input type="text" name="memberVO.id"></td> -->
				<td width="400"><p align="center">
						<input type="text" name="memberVO.id" id="memberId"
							value="${enrollmentVO.memberVO.id }" readonly> <a type="button"
							onclick="popup()">아이디 검색</a>
			</tr>
			<tr>
				<td width="200"><p align="right">과정명</td>
				<!-- <td width="400"><input type="text" name="courseVO.id"></td> -->
				<br>
				<td width="400"><select name="courseVO.id" id="courseId">
						<option value="" disabled selected></option>
						<c:forEach var="enrollmentVO" items="${syllabusesCoursesList}">
							<option value="${enrollmentVO.courseVO.id }">${enrollmentVO.syllabusVO.name }</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
	      <td width="200"><p align="right">아이디 중복확인</td>
	      <td><span id="idCheck"></span></td>
	   	</tr>
	   
		</table>

		<input type="submit" value="등록" style="width: 5%;">&nbsp;<input
			type="reset" value="다시입력" id="reset" style="width: 5%;">&nbsp;
		<button type="button"
			onclick="location.href = '${contextPath}/enrollment/listEnrollments.do' "
			style="width: 5%;">목록</button>

	</form>
</body>
</html>