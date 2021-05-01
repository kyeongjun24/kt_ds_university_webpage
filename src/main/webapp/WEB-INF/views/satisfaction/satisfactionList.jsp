<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>


<html>
<head>
<meta charset=UTF-8">
<title>만족도조사 목록창</title>
<style>
.satisfactionButton {
	width: 90%;
    display: flex;
    justify-content: flex-end;
}

#satisfactionButton {
	background-color: #e91b23;
}


.process {
	text-align: left;
	margin-bottom: 2em;
	color: #9C9D9D;
}

</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	//체크 된 걸 가져오는 함수
	function getCheckList() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		alert(length+'개 선택하였습니다');
		var arr = new Array();
		$("input:checkbox[type=checkbox]:checked").each(function(index) {
			arr.push($(this).attr('id'));
		})

		if (length == 0) {
			alert("선택된 값이 없습니다.");
			return false;
		} else {
			$
					.ajax({
						type : 'post',
						url : '${contextPath}/satisfaction/removeCheckedSatisfactions.do',
						traditional : true, //Array 형태로 보내려면 설정 해줘야함
						data : {
							arr : arr
						},

						success : function(data) {
							alert('삭제 완료');
							window.location.href = "${contextPath}/satisfaction/listSatisfactions.do";
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
	$(
			function() {
				$('#selectAll').click(function() {
					if ($("input:checkbox[id='selectAll']").prop("checked")) {
						$("input[type=checkbox]").prop("checked", true);
					} else {
						$("input[type=checkbox]").prop("checked", false);
					}
				})

				$('#listFilter')
						.on(
								'change',
								function() {
									var perPage = $(this).val();
									var searchType = document
											.getElementById('searchType').value;
									var searchText = document
											.getElementById('searchText').value;
								
									location.href = "${contextPath}/satisfaction/listSatisfactions.do?perPage="
											+ perPage
											+ "&searchType="
											+ searchType
											+ "&searchText="
											+ searchText;
								})

			}) //function
</script>

<body>

	<div class="process">
		<h5>
			<span onclick="location.href='${contextPath}/survey/listSurveys.do'"
				style="cursor: pointer;">설문조사관리</span> > <span
				onclick="location.href='${contextPath}/satisfaction/listSatisfactions.do'"
				style="cursor: pointer;"> 만족도 평가</span>
		</h5>
	</div>

	<!-- controller에서 보낸 값 받아서 저장 -->
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>
	<form method="get" action="${contextPath}/satisfaction/listSatisfactions.do" id="searchFrm">

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
				<c:if test="${searchType == 'title'}">
					<option value="title" selected>제목</option>
					<option value="state">개설 상태</option>
				</c:if>
				<c:if test="${searchType == 'state' }">
					<option value="title">제목</option>
					<option value="state" selected>개설 상태</option>
				</c:if>
				<c:if test="${empty searchType }">
					<option value="" selected>제목</option>
					<option value="state">개설 상태</option>
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

	<div class="satisfactionButton">
		<button type="button" id="satisfactionButton"
			onclick="location.href='${contextPath}/satisfaction/satisfactionForm.do'">등록</button>
		<button type="button" style="margin-left: 1em;" onclick='getCheckList()'>삭제</button>
	</div>

	<table border="0" align="center" width="80%">
		<tr align="center" id="attr">
			<td><input type="checkbox" id="selectAll"></td>
	
			<td><b>번호</b></td>
			<td><b>제목</b></td>
			<td><b>등록일</b></td>
			<td><b>개설상태</b></td>
			
		</tr>
		<c:choose>
			<c:when test="${not empty satisfactionsList}">
				<c:forEach var="satisfaction" items="${satisfactionsList}" varStatus="satisfactionNum">
					<tr align="center">
						<td><input type="checkbox" name="selectedCheckbox" id="${satisfaction.id }"></td>
						<td>${satisfaction.id-119999}</td> <%-- 번호 --%>
						<td><a style="color:black;" href="${contextPath}/satisfaction/informationSatisfactionForm.do?id=${satisfaction.id }">${satisfaction.title}</a></td>
						<td>${satisfaction.joinDate}</td>
						<td>${satisfaction.state}</td>
						
						
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${empty satisfactionsList}">
				<c:forEach var="satisfaction" items="${satisfactionsList}" varStatus="satisfactionNum">
					<h1>데이터가 없습니다.</h1>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	
	<div class="under satisfactionButton">
		<button type="button" id="satisfactionButton"
			onclick="location.href='${contextPath}/satisfaction/satisfactionForm.do'">등록</button>
		<button type="button" style="margin-left: 1em;" onclick='getCheckList()'>삭제</button>
	</div>

	<!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/satisfaction/listSatisfactions.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/satisfaction/listSatisfactions.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/satisfaction/listSatisfactions.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
							<a
							href="${contextPath }/satisfaction/listSatisfactions.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/satisfaction/listSatisfactions.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/satisfaction/listSatisfactions.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>
</body>
</html>
