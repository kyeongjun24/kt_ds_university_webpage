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
<title>회사 상세창</title>
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	/* jquery로 상세창은 처음 들어왔을 땐 읽기 전용으로 만들고
	 수정을 클릭하면 읽기 전용에서 수정이 가능하도록 만들기 */

	/* 카운트 변수 선언*/
	var count = 0;

	$(document).ready(function() {
		$('input').prop('readonly', true);
		$('radio').prop('disabled', true);
		$('#sel1').prop('disabled', true);
		$('#sel2').prop('disabled', true);
		$("input[id=radio1]:radio").attr("disabled", "true");
		$("input[id=radio2]:radio").attr("disabled", "true");
		$('input').css('border','none');
	});

	function modify() {
		count++;
		if (count == 1) {
			$('input').prop('readonly', false);
			$('radio').prop('disabled', false);
			$('#sel1').prop('disabled', false);
			$('#sel2').prop('disabled', false);
			$("input[id=radio1]:radio").attr("disabled", "false");
			$("input[id=radio1]:radio").removeAttr("disabled");
			$("input[id=radio2]:radio").attr("disabled", "false");
			$("input[id=radio2]:radio").removeAttr("disabled");
			$("#mod").text("저장");
			$('input').css('border',"solid 1px");
		} else {

			alert("저장되었습니다.");
			document.companyForm.submit();

		}
	};
</script>
<body>
	<form method="post" name="companyForm" action="${contextPath}/company/modCompany.do">
		<h1 class="text_left">회사 관리</h1>
		<table align="left">
			<tr>
				<td width="200"><p align="right">상태</p></td>
				<td width="250"><select name="contractStat" id=sel1>
						<option value="">상태를 선택하세요</option>
						<option value="협의중"
							<c:if test="${companyVO.contractStat eq '협의중' }"> selected</c:if>>협의중</option>
						<option value="협약서 접수"
							<c:if test="${companyVO.contractStat eq '협약서 접수' }"> selected</c:if>>협약서 접수</option>
						<option value="탈퇴" 
							<c:if test="${companyVO.contractStat eq '탈퇴'}"> selected</c:if>>탈퇴</option>
				</select>
			<tr>
				<td width="200"><p align="right">회사명</p></td>
				<td width="250"><input type="text" name="name"
					value="${companyVO.name}"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">대표번호</p></td>
				<td width="250"><input type="text" name="companyTel"
					value="${companyVO.companyTel}"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">홈페이지</p></td>
				<td width="250"><input type="text" name="homePage"
					value="${companyVO.homePage }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">주소</p></td>
				<td width="250"><input type="text" name="address"
					value="${companyVO.address }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">사업자등록번호</p></td>
				<td width="250"><input type="text" name="id"
					value="${companyVO.id }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자</p></td>
				<td width="250"><input type="text" name="contractName"
					value="${companyVO.contractName }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자전화번호</p></td>
				<td width="250"><input type="text" name="managerPhone"
					value="${companyVO.managerPhone }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자이메일</p></td>
				<td width="250"><input type="text" name="managerEmail"
					value="${companyVO.managerEmail }"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">협약업체 동의 구분</p></td>
				<td width="250">
				<input type="radio" name="contractAgree" value="컨소시엄 협약" id="radio1"
					<c:if test="${companyVO.contractAgree eq '컨소시엄 협약' }">checked</c:if>>컨소시엄 협약 
					<input type="radio" name="contractAgree" value="컨소시엄 비협약"
					id="radio2" <c:if test="${companyVO.contractAgree eq '컨소시엄 비협약' }">checked</c:if>>컨소시엄 비협약</td>
			</tr>
			<tr>
				<td width="200"><p align="right">협약 상태 구분</p></td>
				<td width="250"><select name="contractType" id=sel2>
						<option value="">상태를 선택하세요</option>
						<option value="협약서 없음"
							<c:if test="${companyVO.contractType eq '협약서 없음' }"> selected</c:if>>협약서
							없음</option>
						<option value="상호 변경"
							<c:if test="${companyVO.contractType eq '상호 변경' }"> selected</c:if>>상호
							변경</option>
						<option value="협약 완료"
							<c:if test="${companyVO.contractType eq '협약 완료' }">selected</c:if>>협약
							완료</option>
						<option value="협약서 사본"
							<c:if test="${companyVO.contractType eq '협약서 사본' }"> selected</c:if>>협약서
							사본</option>
				</select></td>
			</tr>
			<tr>
				<td width="200"><p align="right">등록 / 수정일</p></td>
				<td width="250"><input type="text" readOnly name="regDate"
					value="${companyVO.regDate }"></td>
			</tr>
		</table>

		<!-- 수정, 삭제 버튼 만들기 -->
		<button type="button" onclick="modify()" style="width: 5%;" id="mod">수정</button>
		<button type="button" onclick="location.href='${contextPath}/company/removeCompany.do?id=${companyVO.id }'" style="width: 5%;">삭제</button>
		<button type="button" onclick="history.back()" style="width: 5%;">취소</button>
	</form>
</body>
</html>