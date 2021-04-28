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
<title>로그 목록창</title>
<style>
.event_security_logButton {
margin-top : 100px;
display : flex;
justify-content: flex-start;
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
						url : '${contextPath}/event_security_log/removeCheckedEvent_security_logs.do',
						traditional : true, //Array 형태로 보내려면 설정 해줘야함
						data : {
							arr : arr
						},

						success : function(data) {
							alert('삭제 완료');
							alert(data);
							window.location.href = "${contextPath}/event_security_log/listEvent_security_logs.do";
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
									/* alert(perPage+"씩 리스트 출력");
									alert(searchType);
									alert(searchText); */
									location.href = "${contextPath}/event_security_log/listEvent_security_logs.do?perPage="
											+ perPage
											+ "&searchType="
											+ searchType
											+ "&searchText="
											+ searchText;
								})

			}) //function
</script>

<body>
	<!-- controller에서 보낸 값 받아서 저장 -->
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>
	<form method="get" action="${contextPath}/event_security_log/listEvent_security_logs.do" id="searchFrm">

		<!-- 리시트 필터 값 적용 -->
		<div class="listFilter">
			<select name="perPage" id="listFilter">
				<c:if test="${perPage == '20' }">
					<option value='10'>10</option>
					<option value='20' selected>20</option>
					<option value='50'>50</option>

				</c:if>
				<c:if test="${perPage == '50' }">
					<option value='10'>10</option>
					<option value='20'>20</option>
					<option value='50' selected>50</option>
				</c:if>
				<c:if test="${perPage == '10' }">
					<option value='10' selected>10</option>
					<option value='20'>20</option>
					<option value='50'>50</option>
				</c:if>
			</select>
		</div>

		<!-- 검색 유형 값에 따라 셀렉트 띄우는 값 설정 -->
		<div class="searchType">
			<select name="searchType" id="searchType">
				<c:if test="${searchType == 'user'}">
					<option value="">검색 종류</option>
					<option value="user" selected>아이디</option>
					<option value="text">로그 텍스트</option>
				</c:if>
				<c:if test="${searchType == 'text' }">
					<option value="">검색 종류</option>
					<option value="user">아이디</option>
					<option value="text" selected>로그 텍스트</option>
				</c:if>
				<c:if test="${empty searchType }">
					<option value="" selected>검색 종류</option>
					<option value="user">아이디</option>
					<option value="text">로그 텍스트</option>
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



	<table border="0" align="center" width="80%">
		<tr align="center" id="attr">
	
			<td><b>번호</b></td>
			<td><b>아이디</b></td>
			<td><b>이벤트 타입</b></td>
			<td><b>발생일시</b></td>
			<td><b>로그 텍스트</b></td>
			
		</tr>
		<c:choose>
			<c:when test="${not empty event_security_logsList}">
				<c:forEach var="event_security_log" items="${event_security_logsList}" varStatus="event_security_logNum">
					<tr align="center">
						
						<td>${event_security_log.id-89999}</td>
						<td>${event_security_log.user}</td>
						<td>${event_security_log.type}</td>
						<td>${event_security_log.date}</td>
						<td>${event_security_log.text}</td>
						
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${empty event_security_logsList}">
				<c:forEach var="event_security_log" items="${event_security_logsList}" varStatus="event_security_logNum">
					<h1>데이터가 없습니다.</h1>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>

	<!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center" style="width: 80%; height: 10%;">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/event_security_log/listEvent_security_logs.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/event_security_log/listEvent_security_logs.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/event_security_log/listEvent_security_logs.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
							<a
							href="${contextPath }/event_security_log/listEvent_security_logs.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/event_security_log/listEvent_security_logs.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/event_security_log/listEvent_security_logs.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>

</body>
</html>
