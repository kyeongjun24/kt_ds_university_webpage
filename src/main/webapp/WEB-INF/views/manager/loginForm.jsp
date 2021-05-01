<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String result = (String)request.getParameter("result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인창</title>
<c:choose>
	<c:when test="${result=='loginFailed' }">
		
		<script>
			window.onload = function() {
				alert("아이디나 비밀번호가 틀립니다.다시 로그인 하세요!");
			}
		</script>
	</c:when>
</c:choose>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	$(function() {
		$('.adminLoginForm').submit(function(){
			
			var frm = document.frmLogin;
			var id = frm.id.value;
			var pw = frm.pw.value;
			
			if (id == '') {
				alert('아이디를 선택해주세요.');
     			frm.id.focus();
     			return false;
			} else if (pw == '') {
				alert('비밀번호를 입력해주세요.');
				frm.pw.focus();
				return false;
			}
			
			return true;
		}) 
	})
</script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap')
	;

* {
	font-family: 'Noto Sans KR', sans-serif;
}
.adminLogin {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 90vh;
}

.adminLoginForm {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	background-color: #3C3C3C;
	width: 600px;
	height: 260px;
	padding: 0px 40px;
	border-radius: 7px;
}

.adminLogin input[type=text], [type=password] {
	text-align: left;
	margin: 0px;
	background-color: rgb(240, 240, 240);
	border-radius: 3px;
	border: none; /* input 요소 테두리 없애기 */
	width: 230px;
	height: 40px;
}

.adminLogin input[type=submit] {
	height: 90px;
	width : 7em;
	background-color: #E91B23;
	border: 0px;
	color: #EFEFEF;
	border-radius: 3px;
}

.main_logo {
position : relative;
right : 50px;
}
</style>

</head>

<body>
	<div class="adminLogin">
		<form class="adminLoginForm" name="frmLogin" method="post"
			action="${contextPath}/manager/login.do">
			<div class="main_logo">
			<img src="${contextPath}/resources/image/adminLogo2.png">
		</div>
			<table>
				<tr align="center">
					<td><input type="text" name="id" value="" placeholder="아이디"></td>
				</tr>
				<tr align="center">
					<td><input type="password" name="pw" value=""
						placeholder="비밀번호"></td>
				</tr>
			</table>
			<input type="submit" value="로그인">
		</form>
	</div>
</body>
</html>
