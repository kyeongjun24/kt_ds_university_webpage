<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
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
<meta charset="UTF-8">
<title>회원 가입창</title>
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
//회사 리스트 팝업창 뛰우기
	function popup(){
	    var url = "${contextPath}/company/popUp.do";
	    var name = "popup test";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	    
	}
	
	$(function() {
		$('#id').on('keyup', function(){
			var id = this.value;
			
			if(id.length < 4 ||  id.length >12) {
				$('#idCheck').html('아이디는 4자이상, 12자 이하').css('color','red');
				return;
			} else{
				
				$.ajax({
					type:'post',
					url:'${contextPath}/member/idCheckMember.do',
					data: 'id='+id,
					
					success: function(result){
						if(result==1){
							$('#idCheck').html('아이디 중복').css('color','red');
						}else {
							$('#idCheck').html('적절한 아이디').css('color','blue');
						}
						
					}, error:function(result,request,status,error){
			             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			             
			        }
				})
			}
		})
		
		$('#pw2').on('keyup', function() {
			var pw = document.getElementById('pw').value;
			var pw2 = this.value;
			
			if (pw2.length < 8 || pw2.length > 32) {
				$('#pwCheck').html('비밀번호는 8자 이상, 32자 이하').css('color', 'red');
			} else if (pw != pw2) {
				$('#pwCheck').html('비밀번호가 틀립니다.').css('color','red');
				return;
			} else {
				$('#pwCheck').html('비밀번호 확인').css('color','blue');
			}
			
		})
		
		$('#registerFrm').submit(function() {
			var idCheck = document.getElementById("idCheck").innerHTML;
			/* alert(idCheck); */
			
			var pwCheck = document.getElementById("pwCheck").innerHTML;
			/* alert(pwdCheck); */
			
			var name = document.getElementById("name").value;
			/* alert(name); */
			
			var email = document.getElementById("email").value;
			/* alert(email); */
			
			if (idCheck == "적절한 아이디" && pwCheck == "비밀번호 확인" && name != "" && email != "") {
				return true;
			} else if(idCheck != "적절한 아이디") {
				alert("아이디 중복 확인 해주세요.");
				return false;
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
		})
		
		$('#reset').on('click', function() {
			$('#idCheck').html('');
			$('#pwCheck').html('');
		})

	})
	
	// 체크 하마나 가능
	function checkOnlyOne(element) {
		const checkboxes = document.getElementsByName("subscription");
		checkboxes.forEach((cb) => {
			  cb.checked = false;
			})
		element.checked = true;
	}
	
</script>
</head>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
	
%>
	<div class="menuCategory">
		<h5>회원 관리 > 회원 등록</h5>
	</div>
	<div style="width: 80%;">
		<h1  class="text_center">회원 등록</h1>
	</div>
	<form method="post"   action="${contextPath}/member/addMember.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}" id=registerFrm>
	<table  align="center" id="memberTable" >
	   <tr>
	      <td width="58%" style="padding-right: 3%;"><p align="right">아이디</td>
	      <td width="42%" align="left" style="padding-left: 2%;"><input type="text" name="id" id="id"></td> 
	   </tr>
	   <tr>
	      <td style="padding-right: 3%;"><p align="right">아이디 중복확인</td>
	      <td align="left" style="padding-left: 2%;"><span id="idCheck"></span></td>
	   </tr>
	   <tr>
	      <td style="padding-right: 3%;"><p align="right">비밀번호</td>
	      <td align="left" style="padding-left: 2%;"><input type="password" name="pw" id="pw"></td>
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
	       <td align="left" style="padding-left: 2%;"><p><input type="text" name="name" id="name"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">연락처</td>
	       <td align="left" style="padding-left: 2%;"><p> <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"></p></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">전화번호</td>
	       <td align="left" style="padding-left: 2%;"><p> <input type="tel" id="tel" name="tel" placeholder="02-9876-5432" pattern="[0-9]{2}-[0-9]{4}-[0-9]{4}"></p></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">이메일</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="email" name="email" id="email"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">수신동의 여부</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="checkbox" name="subscription" id="subscription" value="T" onclick='checkOnlyOne(this)'>동의&nbsp;&nbsp;
	       					  <input type="checkbox" name="subscription" id="subscription" value="F" onclick='checkOnlyOne(this)' checked>미동의</td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">회사명</td>
	       <td align="left" style="padding-left: 2%;"><p><input type="text" name="companyName" id="companyName"><a onclick="popup()" >검색</a></td>
	    </tr>
	</table>
	<div style="width: 80%;">
		<h1  class="text_center"><input type="submit" id="enrollButton" value="가입하기">&nbsp;<input type="reset" value="다시입력" id="reset">&nbsp;<input type="button" onclick="history.back()" value="취소"></h1>
	</div>
	</form>
	<%} else {  %>
	<script>
		window.location.href="${contextPath}";
	</script>
	<% } %>
</body>


