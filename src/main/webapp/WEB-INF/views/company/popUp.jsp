<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

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

#searchFrm {
	width: 92%;
}

.pageNumber ul {
	display: flex;
	justify-content: center;
	list-style: none;
	padding: 0px;
}

.pageNumber ul li {
	margin: 8px;
}

.pageNumber ul li a:link {
	color: black;
	text-decoration: none;
}

.searchType {
	display: flex;
	justify-content: flex-end;
	margin: 30px 0px 30px 0px;
}

#listFilter {
	background: #ECECEC;
	margin: 0px 0px 10px 10px;
	height: 35px;
	border: none;
	border-radius: 6px;
}

#popup_searchType {
	background: #ECECEC;
	margin: 0px 0px 10px 10px;
	height: 35px;
	border: none;
	border-radius: 6px;
}

#popup_searchText {
	background: #ECECEC;
	width: 200px;
	height: 35px;
	border-radius: 6px;
	margin: 0px 0px 10px 10px;
	border: none;
}

#popup_search {
	background: #969696;
	width: 50px;
	height: 35px;
	border-radius: 6px;
	margin: 0px 0px 10px 5px;
	color: #EFEFEF;
	cursor: pointer;
	font-size: 16px;
	border: none;
}

.popup_table {
	border-collapse: collapse;
	width: 90%;
	margin: 0px;
}

#popup_title {
	border-bottom: 2px solid;
}

.popup_tr>td {
	padding: 8px 0px 8px 0px;
	border-bottom: 0.3px solid;
	border-color: rgba(156, 157, 157, 0.2);
	font-size: 14px;
}

.companyNotFound {
	font-size: 23px;
	font-weight: 700;
}

.popup_companyNotFound {
	display: flex;
	flex-direction: column;
	align-items: center;
}

#inputCompanyName {
	background: #ECECEC;
	width: 200px;
	height: 35px;
	border-radius: 6px;
	border: none;
}

#inputCompanyName_button {
	background: #ED1C24;
	width: 50px;
	height: 35px;
	border-radius: 6px;
	margin: 0px 0px 0px 8px;
	color: #EFEFEF;
	cursor: pointer;
	font-size: 16px;
	border: none;
}

#popup_td1 {
	width: 25%;
	align: center;
}

#popup_td1 a:link {
	color: black;
	text-decoration: none;
}

#popup_td1 a:hover {
	color: #e91b23;
}

#popup_td2 {
	width: 25%;
	align: center;
}

#popup_td3 {
	width: 50%;
}

.popup_close {
	display: flex;
	justify-content: center;
}

.popup_close>input {
	background: #969696;
	width: 70px;
	height: 35px;
	border-radius: 6px;
	color: #EFEFEF;
	cursor: pointer;
	font-size: 16px;
	border: none;
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	window.onfocus = function() {
	}

	window.onload = function() {
		window.focus();
		window.scrollTo(0, 0)
	}

	// ????????? ?????? ??? ?????????????????? ?????? ??????
	function setCompanyName(name) {
		var name = $(name).text();
		opener.document.getElementById('companyName').value = name;
		window.close();
	}

	// ????????? ?????? ?????? ?????? ?????? ???????????? ??????
	function inputCompanyName() {
		var companyName = document.getElementById('inputCompanyName').value;
		opener.document.getElementById('companyName').value = companyName;
		window.close();
	}

	// ????????? ?????? ??????
	$(
			function() {
				$('#listFilter')
						.on(
								'change',
								function() {
									var perPage = $(this).val();
									var searchType = document
											.getElementById('popup_searchType').value;
									var searchText = document
											.getElementById('popup_searchText').value;
									/* alert(perPage+"??? ????????? ??????");
									alert(searchType);
									alert(searchText); */
									location.href = "${contextPath}/company/popUp.do?perPage="
											+ perPage
											+ "&searchType="
											+ searchType
											+ "&searchText="
											+ searchText;
								})
			})
</script>
<body>
	<div class="popup_container">
		<!-- ???????????? -->
		<%
		String searchType = request.getParameter("searchType");
		String searchText = request.getParameter("searchType");
		%>
		<form method="get" action="${contextPath }/company/popUp.do"
			id="searchFrm">
			<div class="searchType">
				<!-- ????????? ?????? ??? ?????? -->
				<select name="perPage" id="listFilter">
					<c:if test="${perPage == '10' }">
						<option value='10' selected>10???</option>
						<option value='20'>20???</option>
						<option value='50'>50???</option>
						<option value='100'>100???</option>

					</c:if>
					<c:if test="${perPage == '20' }">
						<option value='10'>10???</option>
						<option value='20' selected>20???</option>
						<option value='50'>50???</option>
						<option value='100'>100???</option>
					</c:if>
					<c:if test="${perPage == '50' }">
						<option value='10'>10???</option>
						<option value='20'>20???</option>
						<option value='50' selected>50???</option>
						<option value='100'>100???</option>
					</c:if>
					<c:if test="${perPage == '100' }">
						<option value='10'>10???</option>
						<option value='20'>20???</option>
						<option value='50'>50???</option>
						<option value='100' selected>100???</option>
					</c:if>
				</select>

				<!-- ?????? ?????? ?????? ?????? ????????? ????????? ??? ?????? -->
				<select name="searchType" id="popup_searchType">
					<c:if test="${searchType == 'name' }">
						<option value="name">??????</option>
						<option value="name" selected>?????????</option>
						<option value="id">???????????????</option>
					</c:if>
					<c:if test="${searchType == 'id' }">
						<option value="name">??????</option>
						<option value="name">?????????</option>
						<option value="id" selected>???????????????</option>
					</c:if>
					<c:if test="${empty searchType}">
						<option value="name" selected>??????</option>
						<option value="name">?????????</option>
						<option value="id">???????????????</option>
					</c:if>
				</select>
				
				<!-- ?????? ?????? ?????? ????????? ?????? ??? ???????????? ?????? -->
				<c:choose>
					<c:when test="${not empty searchText }">
						<input type="text" name="searchText" id="popup_searchText"
							value="${searchText }">
					</c:when>
					<c:otherwise>
						<input type="text" name="searchText" id="popup_searchText">
					</c:otherwise>
				</c:choose>
				<input type="submit" id="popup_search" value="??????">
			</div>
		</form>
		<!-- ?????? ????????? ?????? -->
		<table class="popup_table">
			<c:choose>
				<c:when test="${empty companiesList}">
					<tr height="10">
						<td>
							<div class="popup_companyNotFound">
								<p class="companyNotFound">????????? ????????? ????????????.</p>
								<div class="inputCompanyName">
									<input id="inputCompanyName" type="text" placeholder="?????? ??????">
									<button id="inputCompanyName_button" onclick="inputCompanyName();">??????</button>
								</div>
							</div>
						</td>
					</tr>
				</c:when>
				<c:when test="${companiesList !=null }">
					<tr>
						<td id="popup_title" align='left'><b>?????????</b></td>
						<td id="popup_title" align='left'><b>???????????????</b></td>
						<td id="popup_title" align='left'><b>??????</b></td>
					</tr>
					<c:forEach var="company" items="${companiesList }"
						varStatus="companyNum">
						<tr class="popup_tr">
							<td id="popup_td1" align='left'><a
								href='javascript:void(0);' onclick="setCompanyName(this);">${company.name }</a></td>
							<td id="popup_td2" align='left'>${company.id }</td>
							<td id="popup_td3" align='left'>${company.address }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>

		<!-- ?????? ????????? ????????? ?????? ????????? ????????? ????????? -->
		<div class="pageNumber" align="center">
			<ul>
				<c:if test="${pageMaker.prev }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/company/popUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">??????</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/company/popUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">??????</a></li>
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
								href="${contextPath }/company/popUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
								<a
								href="${contextPath }/company/popUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/company/popUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">??????</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/company/popUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">??????</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</div>

		<div class="popup_close">
			<input type="button" onclick="window.close()" value="??? ??????">
		</div>
	</div>
</body>
</html>