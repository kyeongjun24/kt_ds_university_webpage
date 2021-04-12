<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>

<!-- 협약회사 페이지 -->
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
.line1 {
border-bottom : 2px solid #a3a3a3;
}
.line2 {
border-bottom : 0.5px solid #d3d3d3;
}
#partners {
border-collapse: collapse;
}
</style>
<meta charset="UTF-8">
<title>협약회사 목록창</title>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	$(function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	})
</script>
<body>
	<form id="searchFrm">
		<select id="searchType"><option value="">선택</option>
			<option value="comName">회사명</option>
			<option value="contractName">담당자</option></select> <input type="text"
			id="search" style="width: 100px; margin-right: 20px;"><input
			type="submit" value="검색" id="searchSubmit">
	</form>
	<table align="center" border="0" width="80%" id="partners">
		<tr height="15" align="center" >
			<td class = line1><b>번호</b></td>
			<td class = line1><b>회사명</b></td>
			<td class = line1><b>담당자</b></td>
			<td class = line1><b>전화번호</b>
			<td class = line1><b>사업자등록번호</b></td>
			<td class = line1><b>등록/수정일</b></td>
		</tr>
		<c:choose>
			<c:when test="${partnersList ==null }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 회사가 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${partnersList !=null }">
				<c:forEach var="company" items="${partnersList }"
					varStatus="articleNum">
					<tr align="center">
						<!--<td width="5%">${articleNum.count}</td>  -->
						<td class = line2>${articleNum.count }</td>
						<%-- <td><!-- 순번 위치. 전체 레코드 수 -((현재 페이지 번호 -1)*한 페이지 당 보여지는 레코드 수 + 현재 게시물 출력 순서 --> 
						${(paginationInfo.totalRecordCount-articleNum.index) - ((paginationInfo.currentPageNo-1) )} 
						</td> --%>
						<td class = line2 align='center' width="20%"><span
							style="padding-right: 10px"></span> <a class='cls1'
							href="${contextPath}/company/companyForm.do?id=${company.id}">${company.name }</a>
						</td>
						<td class = line2>${company.contractName }</td>
						<td class = line2>${company.managerPhone }</td>
						<td class = line2>${company.id }</td>
						<td class = line2>${company.modDate }</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
</body>
</html>