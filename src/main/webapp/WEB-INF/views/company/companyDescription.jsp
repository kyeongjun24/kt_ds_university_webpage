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
</style>
</head>
<body>
	<form method="post" action="${contextPath}/company/selectCompany.do">
		<h1 class="text_left">회사 관리</h1>
		<table align="left">
			<%-- <tr>
			<td width="200"><p align="right">상태</p></td>
			<td width="400"><input type="text" name="contractStat" value="${company.contractStat }"></td>
		</tr> --%>
			<tr>
				<td width="200"><p align="right">상태</p></td>
				<td width="200"><select name="comStatus">
						<option value="" selected>상태를 선택하세요</option>
						<option value="협의중" <c:if test="${companyVO.contractStat eq '협의중' }"> selected</c:if>>협의중</option>
						<option value="협약서 접수"<c:if test="${companyVO.contractStat eq '협약서 접수' }"> selected</c:if>>협약서 접수</option>
						<option value="탈퇴" <c:if test="${companyVO.contractStat eq '탈퇴'}"> selected</c:if>>탈퇴</option>
						
						<%-- <c:forEach var="supplier" items="${suppliersList}" >
	      			<option  value="${companyVO.id }">${companyVO.contractStat }</option>
	      		</c:forEach> --%>
				</select>
			<tr>
				<td width="200"><p align="right">회사명</p></td>
				<td width="200"><input type="text" name="name"
					value="${companyVO.name}" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">대표번호</p></td>
				<td width="200"><input type="text" name="companyTel"
					value="${companyVO.companyTel}" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">홈페이지</p></td>
				<td width="200"><input type="text" name="homePage"
					value="${companyVO.homePage }" readOnly style="border: none"></td>
			</tr><tr>
				<td width="200"><p align="right">주소</p></td>
				<td width="200"><input type="text" name="address"
					value="${companyVO.address }" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">사업자등록번호</p></td>
				<td width="200"><input type="text" name="id"
					value="${companyVO.id }" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자</p></td>
				<td width="200"><input type="text" name="contractName"
					value="${companyVO.contractName }" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자전화번호</p></td>
				<td width="200"><input type="text" name="managerPhone"
					value="${companyVO.managerPhone }" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">담당자이메일</p></td>
				<td width="200"><input type="text" name="managerEmail"
					value="${companyVO.managerEmail }" readOnly style="border: none"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">협약업체 동의 구분</p></td>
				<td width="200"><input type="radio" name="contractAgree"
					value="컨소시엄 협약"<c:if test="${companyVO.contractAgree eq '컨소시엄 협약' }">checked</c:if>>컨소시엄 협약
					<input type="radio" name="contractAgree"
				value="컨소시엄 비협약"<c:if test="${companyVO.contractAgree eq '컨소시엄 비협약' }">checked</c:if>>컨소시엄 비협약</td>
			</tr>
			<%-- <tr>
			<td width="200"><p align="right">협약업체 동의 구분</p></td>
			<td width="400"><input type="radio" name="" value="${company.contractStat }"></td>
		</tr> --%>
			<tr>
				<td width="200"><p align="right">협약 상태 구분</p></td>
				<td width="200"><select name="solid">
						<option value="" selected>상태를 선택하세요</option>
						<option value="협약서 없음" <c:if test="${companyVO.contractType eq '협약서 없음' }"> selected</c:if>>협약서 없음</option>
						<option value="상호 변경" <c:if test="${companyVO.contractType eq '상호 변경' }"> selected</c:if>>상호 변경</option>
						<option value="협약 완료" <c:if test="${companyVO.contractType eq '협약 완료' }">selected</c:if>>협약 완료</option>
						<option value="협약서 사본" <c:if test="${companyVO.contractType eq '협약서 사본' }"> selected</c:if>>협약서 사본</option>
				</select>
				</td>
			</tr>
			<tr>
				<td width="200"><p align="right">등록 / 수정일</p></td>
				<td width="200"><input type="text" name="regDate"
					value="${companyVO.regDate }" readOnly style="border: none"></td>
			</tr>
		</table>
	</form>
</body>
</html>