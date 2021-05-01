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
.cls1:link {
	text-decoration: none;
	color: black;
}

.cls1:visited {
	text-decoration: none;
	color: black;
}

.cls1:hover {
	color: #c2c2c2;
}

.cls2 {
	text-align: center;
	font-size: 30px;
}

.process {
	text-align: left;
	margin-bottom: 2em;
	color: #9C9D9D;
}

.par_search {
	padding-left: 7px
}

#type_color {
	font-size: 15px;
    width: 90%;
    display: flex;
    justify-content: space-between;
}

#type_color span{
	font-size: 0.9em;
	margin-right: 7px;
}

#excel {
	width: 7em;
}

#under_excelButton {
	width: 90%;
    justify-content: flex-end;
    display: flex;
}

#pageNum {
	margin-bottom: 5%;
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
									location.href = "${contextPath}/partner/listPartners.do?perPage="
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
	<div class="process">
		<h5>
			<span onclick="location.href='${contextPath}/member/listMembers.do'"
				style="cursor: pointer;">회원관리</span> > <span
				onclick="location.href='${contextPath}/partner/listPartners.do?&page=${criteria.page}&searchText=${criteria.searchText}&searchType=${criteria.searchType}&perPageNum=${criteria.perPageNum}&type=company'"
				style="cursor: pointer;"> 협력회사</span>
		</h5>
	</div>
	<form method="get" action="${contextPath }/partner/listPartners.do"
		id="searchFrm">

		<!-- 리시트 필터 값 적용 -->
		<div class="listFilter">
			<select name="perPage" id="listFilter">
				<c:if test="${perPage == '10' }">
					<option value='10' selected>10개</option>
					<option value='20'>20개</option>
					<option value='50'>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '20' }">
					<option value='10'>10개</option>
					<option value='20' selected>20개</option>
					<option value='50'>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '50' }">
					<option value='10'>10개</option>
					<option value='20'>20개</option>
					<option value='50' selected>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '100' }">
					<option value='10'>10개</option>
					<option value='20'>20개</option>
					<option value='50'>50개</option>
					<option value='100' selected>100개</option>
				</c:if>
			</select>
		</div>

		<div class="searchType">
			<select id="searchType" name="searchType">
				<c:if test="${empty searchType}">
					<option value="name" selected>선택</option>
					<option value="name">회사명</option>
					<option value="contractName">담당자</option>
					<option value="contractType">협약 상태</option>
				</c:if>
				<c:if test="${searchType == 'name' }">
					<option value="name">선택</option>
					<option value="name" selected>회사명</option>
					<option value="contractName">담당자</option>
					<option value="contractType">협약 상태</option>
				</c:if>
				<c:if test="${searchType == 'contractName' }">
					<option value="name">선택</option>
					<option value="name">회사명</option>
					<option value="contractName" selected>담당자</option>
					<option value="contractType">협약 상태</option>
				</c:if>
				<c:if test="${searchType == 'contractType' }">
					<option value="name">선택</option>
					<option value="name">회사명</option>
					<option value="contractName">담당자</option>
					<option value="contractType" selected>협약 상태</option>
				</c:if>
			</select>

			<c:choose>
				<c:when test="${not empty searchText}">
					<input type="text" name="searchText" value="${searchText }"
						id="searchText">
				</c:when>
				<c:otherwise>
					<input type="text" name="searchText" id="searchText"
						class="par_search" placeholder="검색어를 입력하세요."
						onfocus="this.placeholder=''"
						onblur="this.placeholder='검색어를 입력하세요.'">
				</c:otherwise>
			</c:choose>
			<input type="submit" value="검색">
		</div>
	</form>

	<!-- 엑셀 다운로드 버튼 -->
	<form action="${contextPath}/partner/partnersExcelDownload.do" method="post">
		<div id="type_color">
			<div>
			<span style="color: black">협약상태 구분: </span><span style="color: red">●협약서없음
			</span><span style="color: green"> ●상호변경 </span><span style="color: black">
				●협약완료 </span> <span style="color: blue"> ●협약서사본</span><span
				style="color: #dd42f5"> ●탈퇴</span>
			</div>
		<input type="submit" value='엑셀 다운로드' id="excel">
		</div>
	</form>

	<table align="center">
		<tr id="attr">
			<td><b>회사명</b></td>
			<td><b>협약 상태</b></td>
			<td><b>담당자</b></td>
			<td><b>전화번호</b>
			<td><b>사업자등록번호</b></td>
			<td><b>등록일</b></td>
		</tr>
		<c:choose>
			<c:when test="${empty partnersList}">
				<tr align="center">
					<td class=line2 width="15%"><b><span
							style="font-size: 9pt;">등록된 회사가 없습니다.</span></b></td>
				</tr>
			</c:when>
			<c:when test="${not empty partnersList}">
				<c:forEach var="company" items="${partnersList }"
					varStatus="articleNum">
					<tr align="center">
						<td align='center' width="15%"><a class='cls1'
							href="${contextPath}/company/companyForm.do?id=${company.id}&page=${criteria.page}&searchText=${criteria.searchText}&searchType=${criteria.searchType}&perPageNum=${criteria.perPageNum}&type=partner">${company.name }</a>
						</td>
						<td width="15%"><c:if
								test="${company.contractType eq '협약서 없음'}">
								<font color="red">${company.contractType }</font>
							</c:if> <c:if test="${company.contractType eq '상호 변경'}">
								<font color="green">${company.contractType }</font>
							</c:if> <c:if test="${company.contractType eq '협약 완료'}">
								<font color="black">${company.contractType }</font>
							</c:if> <c:if test="${company.contractType eq '협약서 사본'}">
								<font color="blue">${company.contractType }</font>
							</c:if> <c:if test="${company.contractType eq '탈퇴'}">
								<font color="#dd42f5">${company.contractType }</font>
							</c:if></td>
						<td width="15%">${company.contractName }</td>
						<td width="15%">${company.managerPhone }</td>
						<td width="15%">${company.id }</td>
						<td width="15%">${company.regDate }</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	<form class="under" id="under_excelButton" action="${contextPath}/partner/partnersExcelDownload.do"
		method="post">
		<input type="submit" value='엑셀 다운로드' id="excel">
	</form>
	<!-- 전체 페이지 개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/partner/listPartners.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/partner/listPartners.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/partner/listPartners.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
							<a
							href="${contextPath }/partner/listPartners.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/partner/listPartners.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/partner/listPartners.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>
</body>
</html>