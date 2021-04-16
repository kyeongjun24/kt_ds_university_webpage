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
	border-bottom: 2px solid #a3a3a3;
}

.line2 {
	border-bottom: 0.5px solid #d3d3d3;
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
	$(
			function() {
				$('#listFilter')
						.on(
								'change',
								function() {
									var perPage = $(this).val();
									var searchType = document
											.getElementById('searchType').value;
									var searchText = document
											.getElementById('searchText').value;
									/* alert(perPage+"씩 리스트 출력");
									alert(searchType);
									alert(searchText); */
									location.href = "${contextPath}/company/listPartners.do?perPage="
											+ perPage
											+ "&searchType="
											+ searchType
											+ "&searchText="
											+ searchText;
								})
			})
</script>
<body>
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>
	<form method="get" action="${contextPath }/company/listPartners.do"
		id="searchFrm">
		
		<!-- 리시트 필터 값 적용 -->
		<div class="listFilter">
			<select name="perPage" id="listFilter">
				<c:if test="${perPage == '10' }">
					<option value='10' selected>10</option>
					<option value='20'>20</option>
					<option value='30'>30</option>

				</c:if>
				<c:if test="${perPage == '20' }">
					<option value='10'>10</option>
					<option value='20' selected>20</option>
					<option value='30'>30</option>
				</c:if>
				<c:if test="${perPage == '30' }">
					<option value='10'>10</option>
					<option value='20'>20</option>
					<option value='30' selected>30</option>
				</c:if>
			</select>
		</div>
		
		<select id="searchType" name="searchType">
			<c:if test="${empty searchType}">
				<option value="name" selected>선택</option>
				<option value="name">회사명</option>
				<option value="contractName">담당자</option>
			</c:if>
			<c:if test="${searchType == 'name' }">
				<option value="name">선택</option>
				<option value="name" selected>회사명</option>
				<option value="contractName">담당자</option>
			</c:if>
			<c:if test="${searchType == 'contractName' }">
				<option value="name">선택</option>
				<option value="name">회사명</option>
				<option value="contractName" selected>담당자</option>
			</c:if>
		</select>

		<c:choose>
			<c:when test="${not empty searchText}">
				<input type="text" name="searchText" value="${searchText }"
					id="searchText" style="width: 100px; margin-right: 20px;">
			</c:when>
			<c:otherwise>
				<input type="text" name="searchText" id="searchText"
					placeholder="검색어를 입력하세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='검색어를 입력하세요.'"
					style="width: 100px; margin-right: 20px;">
			</c:otherwise>
		</c:choose>
		<input type="submit" value="검색">
	</form>

	<table align="center" border="0" width="80%" id="partners">
		<tr height="15" align="center">
			<td class=line1><b>회사명</b></td>
			<td class=line1><b>협약 상태</b></td>
			<td class=line1><b>담당자</b></td>
			<td class=line1><b>전화번호</b>
			<td class=line1><b>사업자등록번호</b></td>
			<td class=line1><b>등록/수정일</b></td>
		</tr>
		<c:choose>
			<c:when test="${empty partnersList}">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 회사가 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${not empty partnersList}">
				<c:set var="num" value="${company.totalCount - ((company.curPage -1)*10) }" />
				<c:forEach var="company" items="${partnersList }" varStatus="articleNum">
					<tr align="center">
						<td class=line2 align='center' width="20%"><span
							style="padding-right: 10px"></span> <a class='cls1'
							href="${contextPath}/company/companyForm.do?id=${company.id}">${company.name }</a>
						</td>
						<td class=line2>${company.contractType }</td>
						<td class=line2>${company.contractName }</td>
						<td class=line2>${company.managerPhone }</td>
						<td class=line2>${company.id }</td>
						<td class=line2>${company.modDate }</td>
					</tr>
					<c:set var="num" value="${num-1 }"></c:set>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	
	<!-- 전체 페이지 개수에 의한 페이지 리스트 띄우기 -->
		<div class="pageNumber" align="center"
			style="width: 80%; height: 10%;">
			<ul>
				<c:if test="${pageMaker.prev }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/company/listPartners.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/company/listPartners.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
								<a
								href="${contextPath }/company/listPartners.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
								<a
								href="${contextPath }/company/listPartners.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/company/listPartners.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/company/listPartners.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</div>
</body>
</html>