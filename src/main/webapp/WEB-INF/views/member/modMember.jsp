<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
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
   
   #memberTable{
 	width: 1100px;
 	margin-top: 60px;
   }
   
   td{
	   	border : none;
	   } 
	   
	.menuCategory{
		height: 5%;
		width: 100%;
		margin-bottom: 1%;
		text-align: left;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		
		$('#pw2').on('keyup', function() {
			var pw = document.getElementById('pw').value;
			var pw2 = this.value;
			if (pw != pw2) {
				$('#pwCheck').html('비밀번호가 틀립니다.').css('color','red');
				return;
			} else {
				$('#pwCheck').html('비밀번호 확인').css('color','blue');
				return;
			}
			
		})
		
		$('#updateFrm').submit(function() {
			
			var pwCheck = document.getElementById("pwCheck").innerHTML;
			var name = document.getElementById("name").value;
			var email = document.getElementById("email").value;
			
			if (confirm('수정하시겠습니까?') == true) {
				
				if (pwCheck == "비밀번호 확인" && name != "" && email != "") {
					return true;
				} else if(pwCheck != "비밀번호 확인") {
					alert("비밀번호 최종 확인 해주세요.");
					return false;
				} else if(name == "") {
					alert("이름을 입력하세요.");
					return false;
				} else if(email == "") {
					alert("이메일을 입력하시오.");
					return false;
				} 
				
				return false;
				
			} else {
				return false;
			}
		})
		
		$('#reset').on('click', function() {
			$('#pwCheck').html('');
			$('input[name=subscription]').attr('value', ${vo.subscription});
			
		})
		
		$('#id').on('click', function() {
			alert('아이디는 변경 불가합니다.');
		})
		
		
		
		$('input:checkbox[name="subscription"]').each(function() {
		    if(this.value == "${vo.subscription}"){ 
		            this.checked = true;
	        }
		});
		
 });
	
	//비밀번호 초기화
	function initializePw(){
		if (confirm('비밀번호 초기화 하시겠습니까?') == true) {
			
		
			$('input[name=pw]').attr('value', '123456789a');
			$('input[name=pw2]').attr('value', '123456789a');
			$('#pwCheck').html('비밀번호 확인').css('color','blue');
			alert('비밀번호 초기화되었습니다.');
		} else { 
			return false;
		}
	}
	
	//체크 하나만 함수
	function checkOnlyOne(element) {
		const checkboxes = document.getElementsByName("subscription");
		checkboxes.forEach((cb) => {
			  cb.checked = false;
			})
		element.checked = true;
	}
	
	//회사 리스트 팝업창 뛰우기
	function popup(){
	    var url = "${contextPath}/company/popUp.do";
	    var name = "popup test";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	    
	}
	
</script>

</head>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
	
%>
	<div class='menuCategory' >
		<h5>회원 관리 > 회원 수정</h5>
	</div>
	<div style="width: 85%;">
		<h1  class="text_center">회원 정보 수정</h1>
	</div>
	<form method="post"   action="${contextPath}/member/modMember.do?page=${page}&searchText=${searchText}
			&searchType=${searchType}&perPage=${perPage}" id=updateFrm>
	
	<table  align="center" id="memberTable">
	   <tr>
	      <td width="58%" style="padding-right: 3%;"><p align="right">아이디</td>
	      <td width="42%" align="left" style="padding-left: 2%;"><input type="text" name="id" id="id" value="${vo.id }" readonly></td>
	   </tr>
	   <tr>
	      <td style="padding-right: 3%;"><p align="right">비밀번호</td>
	      <td align="left" style="padding-left: 2%;"><input type="password" name="pw" id="pw" value="${vo.pw }">&nbsp;&nbsp;&nbsp;<a onclick="initializePw()" >초기화</a></td>
	    </tr>
	    <tr>
	      <td style="padding-right: 3%;"><p align="right">비밀번호 확인</td>
	      <td align="left" style="padding-left: 2%;"><input type="password" name="pw2" id="pw2"></td>
	    </tr>
	    <tr>
	      <td style="padding-right: 3%;"><p align="right">비밀번호 최종 확인</td>
	      <td align="left" style="padding-left: 2%;"><span id="pwCheck"></span></td>
	   </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">이름</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="text" name="name" id="name" value="${vo.name }"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">연락처</td>
	       <td align="left" style="padding-left: 2%;"><p> <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" value="${vo.phone}"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">전화번호</td>
	       <td align="left" style="padding-left: 2%;"><p> <input type="tel" id="tel" name="tel" pattern="[0-9]{2}-[0-9]{3,4}-[0-9]{4}"></p></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">이메일</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="text" name="email" id="email" value="${vo.email }"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">수신동의 여부</td>
	       <td align="left" style="padding-left: 2%;"><p>
	       <input type="checkbox" name="subscription" value="T" onclick='checkOnlyOne(this)'>동의&nbsp;&nbsp;
			<input type="checkbox" name="subscription" value="F" onclick='checkOnlyOne(this)'>미동의</td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">회사명</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="text" name="companyName" id="companyName" value="${vo.companyName }" readonly>&nbsp;&nbsp;&nbsp;
	       <a onclick="popup()" >검색</a></td>
	    </tr>
	    <tr>
	       <td ><p>&nbsp;</p></td>
	       <td ></td>
	    </tr>
	</table>
	<div style="width: 85%;">
		<h1  class="text_center"><input type="submit" id="enrollButton" value="수정">&nbsp;&nbsp;&nbsp;<input type="reset" value="다시입력" id="reset"><input type="button" onclick="history.back()" value="취소"></h1>
	</div>
	</form>
	<%} else {  %>
	<script>
		window.location.href="${contextPath}";
	</script>
	<% } %>
</body>
</html>