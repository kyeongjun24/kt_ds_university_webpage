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
<style>
.cls1 {
	text-decoration: none;
}

.cls2 {
	text-align: center;
	font-size: 30px;
}
</style>
<meta charset="UTF-8">
<title>글목록창</title>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	//체크 된 걸 가져오는 함수
	function getCheckList() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		alert(length);
		var arr = new Array();
		$("input:checkbox[type=checkbox]:checked").each(function(index) {
			/* alert($(this).attr('id')); */
			arr.push($(this).attr('id'));
		})

		if (length == 0) {
			alert("선택된 값이 없습니다.");
			return false;
		} else {
			$
					.ajax({
						type : 'post',
						url : '${contextPath}/company/removeCheckedCompanies.do',
						traditional : true, //Array 형태로 보내려면 설정 해줘야함
						data : {
							arr : arr
						},

						success : function(data) {
							alert('데이터 받기 성공');
							alert(data);
							window.location.href = "${contextPath}/company/listCompanies.do";
						},
						error : function(data, request, status, error) {
							alert("code:" + request.status + "\n" + "message:"
									+ request.responseText + "\n" + "error:"
									+ error);

						}
					})
		}
	}

	// 전체 체크되게 하는 함수
	$(function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})

	}) //function
</script>

<body>
<<<<<<< HEAD
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>

	<form method="get" action="${contextPath }/company/listCompanies.do" id="searchFrm">
		<select name="searchType" id="searchType">
			<c:if test="${searchType == 'name'}">
				<option value="name">선택</option>
				<option value="name" selected>회사명</option>
				<option value="contractName">담당자</option>
			</c:if>
			<c:if test="${searchType == 'contractName'}">
				<option value="name">선택</option>
				<option value="name">회사명</option>
				<option value="contractName" selected>담당자</option>
			</c:if>
			<c:if test="${searchType == null}">
				<option value="name" selected>선택</option>
				<option value="name">회사명</option>
				<option value="contractName">담당자</option>
			</c:if>
		</select>
		
		<c:choose>
			<c:when test="${searchText != null}">
				<input type="text" name="searchText" id="search" value="${searchText }" style="width: 100px; margin-right: 20px;">
			</c:when>
			<c:otherwise>
				<input type="text" name="searchText" id="search" style="width: 100px; margin-right: 20px;">
			</c:otherwise>
		</c:choose>
		<input type="submit" value="검색">
	</form>

	<table align="center" border="0" width="80%" id="dynamicCompany">
		<tr height="15" align="center" style="border-bottom: solid;">
			<td><input type="checkbox" id="selectAll"></td>
			<td><b>번호</b></td>
			<td><b>상태</b></td>
			<td><b>회사명</b></td>
			<td><b>담당자</b></td>
			<td><b>전화번호</b>
			<td><b>사업자등록번호</b></td>
			<td><b>등록 / 수정일</b></td>
		</tr>
		<c:choose>
			<c:when test="${companiesList ==null }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 회사가 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${companiesList !=null }">
				<c:forEach var="company" items="${companiesList}"
					varStatus="articleNum">
					<tr align="center">
						<td><input type="checkbox" name="selectedCheckbox"
							id="${company.id }"></td>
						<td>${articleNum.count }</td>
						<td width="15%"><c:if test="${company.contractStat eq '협의중'}">
								<font color="blue">${company.contractStat }</font></c:if> 
								<c:if test="${company.contractStat eq '협약서 접수'}">
								<font color="green">${company.contractStat }</font></c:if> 
								<c:if test="${company.contractStat eq '탈퇴'}">
								<font color="red">${company.contractStat }</font></c:if></td>
						<td align='center' width="20%"><span
							style="padding-right: 10px"></span> <a class='cls1'
							href="${contextPath}/company/companyForm.do?id=${company.id}">${company.name }</a>
						</td>
						<td>${company.contractName }</td>
						<td>${company.managerPhone }</td>
						<td>${company.id }</td>
						<td>${company.modDate }</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	<button type="button"
		onclick="location.href='${contextPath}/company/addCompanyForm.do'"
		style="width: 5%;">등록</button>
	<button type="button" onclick='getCheckList()' style="width: 5%;">삭제</button>
</body>
</html>