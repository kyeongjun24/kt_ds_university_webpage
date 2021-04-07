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
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
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
			
			if (pw != pw2) {
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
	
	function checkOnlyOne(element) {
		const checkboxes = document.getElementsByName("subscription");
		checkboxes.forEach((cb) => {
			  cb.checked = false;
			})
		element.checked = true;
	}
	
	
	/* function fn_check(){
		alert("${contextPath}/member/idCheckMember.do");
		var id = document.getElementById('id').value;
		alert(id);
		
		$.ajax({
			type='post',
			url='member/idCheckMember.do',
			data='id='+id,
			
			success: function(data){
				console.log("성공");
			}, error: function(){
				console.log("실패");
			}
		})
		
		/* $.ajax({
		type='post',
		url='${contextPath}/member/idCheckMember.do',
		data:'id='+id,
		
		success:function(result){
			if(data!='-1') $('#idCheck').html('아이디 중복 확인').css('color','green');
			else $('#idCheck').html('아이디 중복').css('color','red');
			alert("연결 성공");

		}, error: function(xhr,status,error){
			alert("code:"+xhr.status + "에러.");
			}
		})   
	} */
</script>

</head>
<body>
	<form method="post"   action="${contextPath}/member/addMember.do" id=registerFrm>
	<h1  class="text_center">회원 가입창</h1>
	<table  align="center">
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><input type="text" name="id" id="id"></td>
	   </tr>
	   <tr>
	      <!-- <td><p align="right"><button type="button" onclick="fn_check();">중복확인</button></td> -->
	      <td width="200"><p align="right">아이디 중복확인</td>
	      <td><span id="idCheck"></span></td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">비밀번호</td>
	      <td width="400"><input type="password" name="pw" id="pw"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">비밀번호 확인</td>
	      <td width="400"><input type="password" name="pw2" id="pw2"></td>
	    </tr>
	    <tr>
	      <td width="200"><p align="right">비밀번호 최종 확인</td>
	      <td><span id="pwCheck"></span></td>
	   </tr>
	    <tr>
	       <td width="200"><p align="right">이름</td>
	       <td width="400"><p><input type="text" name="name" id="name"></td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">연락처</td>
	       <td width="400"><p> <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"></p></td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">이메일</td>
	       <td width="400"><p><input type="email" name="email" id="email"></td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">수신동의 여부</td>
	       <td width="400"><p><input type="checkbox" name="subscription" id="subscription" value="T" onclick='checkOnlyOne(this)'>동의&nbsp;&nbsp;
	       					  <input type="checkbox" name="subscription" id="subscription" value="F" onclick='checkOnlyOne(this)' checked>미동의</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="right">회사명</td>
	       <td width="400"><p><input type="text" name="companyName" id="companyName"></td>
	    </tr>
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><input type="submit" value="가입하기">&nbsp;<input type="reset" value="다시입력" id="reset">&nbsp;<input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	</form>
</body>
