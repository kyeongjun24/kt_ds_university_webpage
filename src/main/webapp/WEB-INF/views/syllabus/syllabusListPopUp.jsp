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
<title>강의 계획서 리스트</title>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap')
	;

.popup_container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 600px;
	margin: 0px;
	padding: 0px;
	font-family: 'Noto Sans KR', sans-serif;
}

#popup_searchFrm {
	width: 92%;
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	window.onfocus=function(){
	}
	
	window.onload=function(){
		window.focus();
		window.moveTo(3,0);
		window.resizeTo(510, auto);
		window.scrollTo(0,0)
	}
	
	function setSyllabusName(name, index) {
		var name = $(name).text();
		var slbId = document.getElementById('slbId'+index).value;
		var bannerImg = document.getElementById('bannerImg'+index).value;
		var reportName = document.getElementById('reportName'+index).value;
		opener.document.getElementById('syllabusName').value = name;
		opener.document.getElementById('slbId').value = slbId;
		opener.document.getElementById('imgArea').src = '${contextPath}/resources/image/'+slbId+'/'+bannerImg;
		window.close();
	}
	
	//회사명 검색 안될 시 직접입력하여 등록
	   function inputSyllabusName() {
	      var syllabusName = document.getElementById('inputSyllabusName').value;
	      opener.document.getElementById('syllabusName').value = syllabusName;
	      window.close();
	   }
	
	$(function(){
		$('#listFilter').on('change',
			function() {
				var perPage = $(this).val();
				var searchType = document
						.getElementById('searchType').value;
				var searchText = document
						.getElementById('searchText').value;
				location.href = "${contextPath}/syllabus/searchSyllabusByPopUp.do?perPage="
						+ perPage
						+ "&searchType="
						+ searchType
						+ "&searchText="
						+ searchText;
			})//listFilter
		
	})
</script>
<body>
	<div class="popup_container">
		<%
		String searchType = request.getParameter("searchType");
		String searchText = request.getParameter("searchType");
		%>
		<form method="get"
			action="${contextPath }/syllabus/searchSyllabusByPopUp.do"
			id="popup_searchFrm">
			<div class="searchType">
				<!-- 리시트 필터 값 적용 -->
				<select name="perPage" id="listFilter">
					<c:if test="${perPage == '10' || empty perPage }">
						<option value='10' selected>10</option>
						<option value='20'>20</option>
						<option value='50'>50</option>
						<option value='100'>100</option>
					</c:if>
					<c:if test="${perPage == '20' }">
						<option value='10'>10</option>
						<option value='20' selected>20</option>
						<option value='50'>30</option>
						<option value='100'>100</option>
					</c:if>

					<c:if test="${perPage == '50' }">
						<option value='10'>10</option>
						<option value='20'>20</option>
						<option value='50' selected>30</option>
						<option value='100'>100</option>
					</c:if>
					<c:if test="${perPage == '100' }">
						<option value='10'>10</option>
						<option value='20'>20</option>
						<option value='50'>30</option>
						<option value='100' selected>100</option>
					</c:if>
				</select> <select name="searchType" id="popup_searchType">
					<c:if test="${empty searchType }">
						<option value="nameOfLecture" selected>선택</option>
						<option value="nameOfLecture">강의명</option>
					</c:if>
					<c:if test="${searchType == 'nameOfLecture' }">
						<option value="nameOfLecture">선택</option>
						<option value="nameOfLecture" selected>강의명</option>
					</c:if>
				</select>
				<!-- 검색 값이 있냐 없냐에 따라 값 뛰우는거 설정 -->
				<c:choose>
					<c:when test="${not empty searchText }">
						<input type="text" name="searchText" id="popup_searchText"
							value="${searchText }">
					</c:when>
					<c:otherwise>
						<input type="text" name="searchText" id="popup_searchText">
					</c:otherwise>
				</c:choose>
				<input type="submit" id="popup_Search" value="검색">
			</div>
		</form>

		<table class="popup_table">
			<c:choose>
				<c:when test="${empty syllabusesList }">
					<tr height="10">
						<td>
							<div class="popup_syllabusNotFound">
								<p class="syllabusNotFound">등록된 회사가 없습니다.</p>
								<div class="inputsyllabusName">
									<input id="inputsyllabusName" type="text" placeholder="직접 입력">
									<button id="inputsyllabusName_button"
										onclick="inputSyllabusName();">등록</button>
								</div>
							</div>
						</td>
					</tr>
				</c:when>
				<c:when test="${not empty syllabusesList }">
					<tr>
						<td id="popup_title"><b>2차 분류</b></td>
						<td id="popup_title"><b>강의명</b></td>
						<td id="popup_title"><b>등록일</b></td>
					</tr>
					<c:forEach var="syllabus" items="${syllabusesList }"
						varStatus="statusNum">
						<tr class="popup_tr">
							<td id="popup_td1" align='left'><a
								href='javascript:void(0);' onclick="setSyllabusName(this);">${syllabus.courseCategoryVO.name }</a></td>
							<td id="popup_td2"><a href='javascript:void(0);'
								onclick="setSyllabusName(this, ${statusNum.index});">${syllabus.name}</a>
								<input type="hidden" id="slbId${statusNum.index }"
								value="${syllabus.id }"> <input type="hidden"
								id="bannerImg${statusNum.index }" value=${syllabus.bannerImg }>
								<input type="hidden" id="reportName${statusNum.index }"
								value="${syllabus.reportName }"></td>
							<td id="popup_td3">${syllabus.joinDate }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>

		<div class="pageNumber" align="center">
			<ul>
				<c:if test="${pageMaker.prev }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
								href="${contextPath }/syllabus/searchSyllabusByPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
								<a
								href="${contextPath }/syllabus/searchSyllabusByPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</div>

		<div class="popup_close">
			<input type="button" value="창 닫기" onclick="window.close()">
		</div>
	</div>
</body>
</html>