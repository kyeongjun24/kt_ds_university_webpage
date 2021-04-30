<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 정보 관리</title>
<style>
   /* .text_center{
     text-align:left;
   } */
.text_center {
	text-align:center;
}
#manager{
	width: 1100px;
	margin-top: 60px;
}   
.menuCategory{
	height: 5%;
	width: 100%;
	margin-bottom: 1%;
	text-align: left;
}
td{
	border : none;
}    
   
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> --> 
<script type="text/javascript">
	$(function() {
		$('#pw2').on('keyup', function() {
			var pw = document.getElementById('pw').value;
			/* var pw = ${vo.pw }; */
			var pw2 = this.value;
			
			if (pw != pw2) {
				$('#pwCheck').html('비밀번호가 틀립니다.').css('color','red');
				return;
			} else {
				$('#pwCheck').html('비밀번호가 일치합니다.').css('color','blue');
				return;
			}
			
		})
		
		$('#updateFrm').submit(function() {
			
			var pwCheck = document.getElementById("pwCheck").innerHTML;
			var name = document.getElementById("name").value;
			var email = document.getElementById("email").value;
			var textEmail = document.getElementById("textEmail").value;
			
			//이메일 앞 뒤 정보 합치기
			email = email + "@" + textEmail;
			//email에 합쳐진 값 세팅
			document.getElementById("email").value = email;		
			
			var strArray = textEmail.split('@');
			
			if (confirm('수정하시겠습니까? 확인 버튼을 누르시면 로그인 페이지로 이동하게됩니다.') == true){	
			if (pwCheck == "비밀번호가 일치합니다." && name != "" && email != "") {
				return true;
			} else if(pwCheck != "비밀번호가 일치합니다.") {
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
	
	$(function() {
        $('#select').change(function() {
            if ($('#select').val() == '') {
                $('#textEmail').attr("disabled", false);
                $('#textEmail').val("");
                $('#textEmail').focus();
            } else {
                $('#textEmail').val($('#select').val());
            }
        })
    });


	
	
	
	
	
</script>

</head>
<body>
	<div class="menuCategory">
		<h5>회원 관리 > 계정 관리</h5>
	</div>
	<div style="width: 80%;">
		<h1  class="text_center">관리자 정보 관리</h1>
	</div>
	<form method="post"   action="${contextPath}/manager/modManager.do" id=updateFrm>
	<table  align="center" id="manager" >
	   <tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">아이디</td>
	      <td width="400" align="left" style="padding-left: 2%;"><input type="text" id="txt1" readonly name="id" id="id" value="${managerVO.id }" readonly></td>
	   </tr>
	   <tr>
	       <td width="200" style="padding-right: 3%;"><p align="right">이름</td>
	       <td width="400" align="left" style="padding-left: 2%;"><p><input type="text" name="name" id="name" value="${managerVO.name }"></td>
	    </tr>
	  
	    <tr>
	    	<c:set var="email" value="${fn:split(managerVO.email, '@')}"/>
	       <td width="200" style="padding-right: 3%;"><p align="right">이메일</td>
	       
	       <td width="400" align="left" style="padding-left: 2%;"><p><input type="text" name="email" id="email" value="${email[0] }" placeholder="이메일 입력">
	       	 <span>@</span>
			 <input type="text" name="textEmail" id="textEmail" placeholder="이메일을 선택하세요." value="${email[1] }"> 
			 <select id="select">
            <option value="" disabled selected>E-Mail 선택</option>
            <option value="naver.com" <c:if test="${email[1] eq 'naver.com' }">selected</c:if> id="naver.com">naver.com</option>
            <option value="hanmail.net" <c:if test="${email[1] eq 'hanmail.net' }">selected</c:if> id="hanmail.net">hanmail.net</option>
            <option value="gmail.com" <c:if test="${email[1] eq 'gmail.com' }">selected</c:if> id="gmail.com">gmail.com</option>
            <option value="nate.com" <c:if test="${email[1] eq 'nate.com' }">selected</c:if> id="nate.com">nate.com</option>
            <option value="" id="textEmail">직접 입력하기</option>
        	</select>
	       </td>
	    </tr> 
	   
	   <tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">비밀번호</td>
	      <td width="400" align="left" style="padding-left: 2%;"><input type="password" name="pw" id="pw" value="${managerVO.pw }"></td>
	    </tr>
	    <tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">비밀번호 확인</td>
	      <td width="400" align="left" style="padding-left: 2%;"><input type="password" name="pw2" id="pw2"></td>
	    </tr>
	    <tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">비밀번호 최종 확인</td>
	      <td><span id="pwCheck" style="float: left; margin-left: 20px;"></span></td>
	   </tr>
		<tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">관리자 권한</td>
	      <td width="400" align="left" style="padding-left: 2%;"><input type="text" id="authorization1" readonly name="authorization" id="authorization" value="${managerVO.authorization }"></td>
	    </tr>

		<tr>
	      <td width="200" style="padding-right: 3%;"><p align="right">등록일</td>
	      <td width="400" align="left" style="padding-left: 2%;"><input type="text" id="joindate1" readonly name="joindate" id="joindate" value="${managerVO.joindate }"></td>
	    </tr>

	</table>
	<div style="width: 80%;">
		<h1  class="text_center"><input type="submit" id="enrollButton" value="수정">&nbsp;<input type="reset" value="다시입력" id="reset">&nbsp;<input type="button" onclick="history.back()" value="취소"></h1>
	</div>
	</form>
</body>
</html>