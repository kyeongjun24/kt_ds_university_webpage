<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수료관리</title>
<style type="text/css" >

.completion_table tr{
text-align: left;
}

.completion_position {
	display: flex;
    font-size: 0.8em;
    font-weight: 800;
    color: #808080;
}
</style>


</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	$(function() {
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
							location.href = "${contextPath}/enrollment/listCompletion.do?perPage="
									+ perPage
									+ "&searchType="
									+ searchType
									+ "&searchText=" + searchText;
						})
	})
</script>


<body>
	<div class="completion_position">
	<p>수강관리 > 수료관리</p>
	</div>
	<!-- controller에서 보낸 값 받아서 저장 -->
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	%>
	<form method="get" action="${contextPath}/enrollment/listCompletion.do"
		id="searchFrm">
		<div class="searchType">
			<!-- 리시트 필터 값 적용 -->
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

			<!-- 검색 유형 값에 따라 셀렉트 띄우는 값 설정 -->

			<select name="searchType" id="searchType">
				<c:if test="${searchType == 'name'}">
					<option value="">검색 종류</option>
					<option value="name" selected>이름</option>
					<option value="companyName">회사명</option>
				</c:if>
				<c:if test="${searchType == 'companyName' }">
					<option value="">검색 종류</option>
					<option value="name">이름</option>
					<option value="companyName" selected>회사명</option>
				</c:if>
				<c:if test="${empty searchType }">
					<option value="" selected>검색 종류</option>
					<option value="name">이름</option>
					<option value="companyName">회사명</option>
				</c:if>
			</select>
			<!-- 검색 값이 있냐 없냐에 따라 값 뛰우는거 설정 -->
			<c:choose>
				<c:when test="${not empty searchText }">
					<input type="text" name="searchText" id="searchText"
						value="${searchText }">
				</c:when>
				<c:otherwise>
					<input type="text" name="searchText" id="searchText">
				</c:otherwise>
			</c:choose>
			<input type="submit" id="searchSubmit" value="검색">
		</div>
	</form>

	<table class="completion_table" id="dynamicCompany">
		<tr id="attr">
			<td align="center"><b>아이디</b></td>
			<td align="center"><b>이름</b></td>
			<td align="center"><b>전화번호</b></td>
			<td align="left"><b>이메일</b>
			<td align="center"><b>소속회사</b></td>
			<td><b>과정명</b></td>
			<td align="center"><b>이수</b></td>
			<td align="center"><b>이수일</b></td>
			<td align="center"><b>신청일</b></td>
		</tr>
		<c:choose>
			<c:when test="${completionList ==null }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 회사가 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${completionList !=null }">
				<c:forEach var="enrollment" items="${completionList }"
					varStatus="enrdNum">
					<tr class="test">
						<td width="7%" align="left">${enrollment.memberVO.id }</td>
						<td width="7%" align="center">${enrollment.memberVO.name }</td>
						<td width="11%" align="center">${enrollment.memberVO.phone }</td>
						<td width="13%" align="left">${enrollment.memberVO.email }</td>
						<td width="11%" align="center">${enrollment.memberVO.companyName }</td>
						<td width="30%">${enrollment.syllabusVO.name }</td>
						<td width="5%" align="center"><c:if test="${not empty enrollment.completeDate }">
								<a id="button"
									href="${contextPath}/enrollment/completionDoc.do?id=${enrollment.id }">출력</a>
							</c:if> <c:if test="${empty enrollment.completeDate }">
							</c:if></td>
						<td width="7%" align="center">${enrollment.completeDate }</td>
						<td width="7%" align="center">${enrollment.joinDate }</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>

	<!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/enrollment/listCompletion.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/enrollment/listCompletion.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/enrollment/listCompletion.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
							<a
							href="${contextPath }/enrollment/listCompletion.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/enrollment/listCompletion.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/enrollment/listCompletion.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>

	<!-- <script>
function popupCompletion(){
    var url = "${contextPath}/enrollment/printCompletion.do";
    var name = "popup completionDcmt";
    var option = "width = 720, height = 600, top = 230, left = 580, location = no"
    window.open(url, name, option);

	 var popupWindow =  window.open(url, name, option);
	/* popupWindow.document.write( '<head>'); 
	popupWindow.document.write( '<link href="/resources/completionPrint.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '</head>' );
	popupWindow.document.write( '<body>'); 
	popupWindow.document.write( $("#printme").html());
	popupWindow.document.write( '</body>');
	popupWindow.document.close(); */
	setTimeout(function() {
		popupWindow.print();
	}, 200); 
	
} 
</script> -->
</body>
</html>