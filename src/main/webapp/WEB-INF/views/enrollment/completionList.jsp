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
<style>
.content:after {
	content: "";
	display: block;
	border-bottom: teal 1px solid #bcbcbc;
}

#button {
	text-decoration: none;
	color: black;
	border: none;
	padding: 2px 4px;
	border-radius: 5px;
	background-color: #ECECEC;
	font-size: 15px;
	cursor: pointer;
	width: 90px;
	height: 35px;
		padding : 5px;
}


#dynamicCompany {
	
}
</style>
<meta charset="UTF-8">
<title>수료관리</title>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	/* function fn_articleForm(isLogOn,courseForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=courseForm;
	  }else{
	    alert("로그인 후 과정 등록이 가능합니다.")
	    location.href=loginForm+'?action=/course/courseForm.do';
	  }
	} */

	$(function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	})

	$(document).on("click", '#selectAll', function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	});
</script>


<body>
	<!-- controller에서 보낸 값 받아서 저장 -->
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>
	<form method="get" action="${contextPath}/enrollment/listCompletion.do"
		id="searchFrm">

		<!-- 리시트 필터 값 적용 -->
		<div class="listFilter">
			<select name="perPage" id="listFilter">
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
				<c:if test="${perPage == '10' }">
					<option value='10' selected>10</option>
					<option value='20'>20</option>
					<option value='30'>30</option>
				</c:if>
			</select>
		</div>

		<!-- 검색 유형 값에 따라 셀렉트 띄우는 값 설정 -->
		<div class="searchType">
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

	<div id="print">
		<table align="center" id="dynamicCompany">
			<tr align="center" id="attr">
				<td><input type="checkbox" id="selectAll"></td>
				<td><b>아이디</b></td>
				<td><b>이름</b></td>
				<td><b>전화번호</b></td>
				<td><b>이메일</b>
				<td><b>소속회사</b></td>
				<td><b>과정명</b></td>
				<td width="80px"><b>이수</b></td>
				<td><b>이수일</b></td>
				<td><b>신청일</b></td>
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
						<tr class="test" align="center">
							<td><input type="checkbox"></td>
							<td><a href="#">${enrollment.memberVO.id }</a></td>
							<td class="content">${enrollment.memberVO.name }</td>
							<td class="content">${enrollment.memberVO.phone }</td>
							<td>${enrollment.memberVO.email }</td>
							<td>${enrollment.memberVO.companyName }</td>
							<td>${enrollment.syllabusVO.name }</td>
							<td><a id="button"
								href="${contextPath}/enrollment/completionDoc.do?id=${enrollment.id }">출력</a></td>
							<td>${enrollment.completeDate }</td>
							<td>${enrollment.joinDate }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>

	<!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/member/listMembers.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/member/listMembers.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/member/listMembers.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
							<a
							href="${contextPath }/member/listMembers.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/member/listMembers.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/member/listMembers.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>


</body>
</html>