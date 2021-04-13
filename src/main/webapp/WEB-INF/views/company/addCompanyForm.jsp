<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 등록창</title>
<style>
.text_left {
	text-align: left;
}

input:focus {
	outline: none;
}

table {
	border-spacing: 22px;
}

button {
	
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
/* 등록할 때 input에 값이 안 들어가 있으면 alert창을 띄우고 커서가 그 곳으로 가는 메소드 */
	$(function() {
		$('#registerCheck').submit(function() {

			theForm = document.addFrm;
			if (theForm.contractStat.value == "") {
				alert("상태를 입력해주세요.")
				theForm.contractStat.focus();
				return false;
			}
			if (theForm.name.value == "") {
				alert("회사명을 입력해주세요.")
				theForm.name.focus();
				return false;
			}
			if (theForm.companyTel.value == "") {
				alert("대표번호를 입력해주세요.")
				theForm.companyTel.focus();
				return false;
			}
			if (theForm.homePage.value == "") {
				alert("홈페이지를 입력해주세요.")
				theForm.homePage.focus();
				return false;
			}
			if (theForm.address.value == "") {
				alert("주소를 입력해주세요.")
				theForm.address.focus();
				return false;
			}
			if (theForm.id.value == "") {
				alert("사업자등록번호를 입력해주세요.")
				theForm.id.focus();
				return false;
			}
			if (theForm.contractName.value == "") {
				alert("담당자를 입력해주세요.")
				theForm.contractName.focus();
				return false;
			}
			if (theForm.managerPhone.value == "") {
				alert("담당자전화번호를 입력해주세요.")
				theForm.managerPhone.focus();
				return false;
			}
			if (theForm.managerEmail.value == "") {
				alert("담당자이메일을 입력해주세요.")
				theForm.managerEmail.focus();
				return false;
			}
			if (!$(':input:radio[name=contractAgree]:checked').val()) {
				alert("1개 이상 선택해주세요.")
				$('input:radio[name=contractAgree]').eq(0).attr("checked", true);
				return false;
			}
			if (theForm.contractType.value == "") {
				alert("협약상태를 입력해주세요.")
				theForm.contractType.focus();
				return false;
			}
			return true;
		})
	})
</script>
<body>
	<form method="post" action="${contextPath}/company/addCompany.do"
		id=registerCheck name=addFrm>
		<h1 class="text_left">회사 등록</h1>
		<table align="left">
			<tr>
				<td width="200"><p align="right">상태</p></td>
				<td width="250"><select name="contractStat">
						<option value="">상태를 선택하세요</option>
						<option value="협의중">협의중</option>
						<option value="협약서 접수">협약서 접수</option>
						<option value="탈퇴">탈퇴</option>

				</select>
			<tr>
				<td width="200"><p align="right">회사명</p></td>
				<td width="250"><input type="text" name="name"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">대표번호</p></td>
				<td width="250"><input type="text" name="companyTel"
					placeholder="예) 02-123-4567" onfocus="this.placeholder=''"
					onblur="this.placeholder='예) 02-123-1234'"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">홈페이지</p></td>
				<td width="250"><input type="text" name="homePage"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">주소</p></td>
				<td width="250"><input type="text" name="address"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">사업자등록번호</p></td>
				<td width="250"><input type="text" name="id"
					placeholder="예) 010-1234-5678" onfocus="this.placeholder=''"
					onblur="this.placeholder='예) 00-000-0000'"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자</p></td>
				<td width="250"><input type="text" name="contractName"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자전화번호</p></td>
				<td width="250"><input type="text" name="managerPhone"
					placeholder="예) 010-1234-5678" onfocus="this.placeholder=''"
					onblur="this.placeholder='예) 010-1234-5678'"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자이메일</p></td>
				<td width="250"><input type="text" name="managerEmail"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">협약업체 동의 구분</p></td>
				<td width="250"><input type="radio" name="contractAgree"
					value="컨소시엄 협약" id="radio1">컨소시엄 협약 <input type="radio"
					name="contractAgree" value="컨소시엄 비협약" id="radio2">컨소시엄 비협약</td>
			</tr>
			<%-- <tr>
			<td width="200"><p align="right">협약업체 동의 구분</p></td>
			<td width="400"><input type="radio" name="" value="${company.contractStat }"></td>
		</tr> --%>
			<tr>
				<td width="200"><p align="right">협약 상태 구분</p></td>
				<td width="250"><select name="contractType">
						<option value="">상태를 선택하세요</option>
						<option value="협약서 없음">협약서없음</option>
						<option value="상호 변경">상호 변경</option>
						<option value="협약 완료">협약 완료</option>
						<option value="협약서 사본">협약서 사본</option>
				</select></td>
			</tr>
		</table>

		<!-- 등록, 취소 버튼 만들기 -->
		<input type="submit" value="등록" style="width: 5%;" id="add">
		<button type="button" onclick="history.back()" style="width: 5%;">취소</button>
	</form>
</body>
</html>