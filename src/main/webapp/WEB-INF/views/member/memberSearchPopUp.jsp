<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 검색 팝업창</title>
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

#searchText {
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

#popup_td0 {
	width: 10%;
	align: left;
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
   	width: 40%;
	align: left;
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	
	window.onfocus=function(){
	}

	window.onload=function(){
		window.focus();
		window.moveTo(3,0);
		window.resizeTo(510,450);
		window.scrollTo(0,0)
	}

	function setMemberId(id) {
		var id = $(id).text();
		//document.getElementById('search').value = name;
		opener.document.getElementById('memberId').value = id;
		window.close();
	}
	
</script>
<body>
	<!-- 파라미터 -->
	<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
	%>
	<!-- <div class="popup_container"> -->
	<!-- 검색 유형 값에 따라 셀렉트 띄우는 값 설정 -->
	<form method="get" action="${contextPath}/member/memberSearchPopUp.do" id="searchFrm">
		<div class="searchType">
		
			<select name="searchType" id="searchType">
				<c:if test="${searchType == 'name' || empty searchType}">
					<option value="name" selected>이름</option>
					<option value="id">아이디</option>
				</c:if>
				<c:if test="${searchType == 'id'}">
					<option value="name">이름</option>
					<option value="id" selected>아이디</option>
				</c:if>
			</select>
		
			<!-- 검색 값이 있냐 없냐에 따라 값 뛰우는거 설정 -->
			<c:choose>
				<c:when test="${not empty searchText }">
				<input type="text" name="searchText" id="searchText" value="${searchText }">
				</c:when>
				<c:otherwise>
					<input type="text" name="searchText" id="searchText">
				</c:otherwise>
			</c:choose>
		<input type="submit" id="popup_search" value="검색">
	</div>
 </form>
 
	
	<div>
		<table class="popup_table">
			<c:choose>
				<c:when test="${membersList == null }" >
					<tr  height="10">
						<td>
					    	<p align="center">
					            <b><span style="font-size:9pt;">등록된 아이디가 없습니다.</span></b>
					        </p>
					    </td>  
					</tr>
				</c:when>
					  
				<c:when test="${membersList !=null }" >
					<tr height="15" align="center" style="border-bottom: solid;">
						<td id="popup_title" style="width:10%" align='center'><b>번호</b></td>
			    		<td id="popup_title" style="width:25%" align='center'><b>아이디</b></td>     
			    		<td id="popup_title" style="width:25%" align='center'><b>이름</b></td>
			    		<td id="popup_title" style="width:40%" align='center'><b>회사</b></td>
					</tr>
				
					<c:forEach  var="member" items="${membersList }" varStatus="memberNum" >
						<tr class="popup_tr">
							<td id="popup_td0">${memberNum.count }</td>
							<td id="popup_td1">
								<!-- <span style="padding-right: 10px"></span> -->
							  <a href='javascript:void(0);' onclick="setMemberId(this);">${member.id }</a></td>
							<td id="popup_td2">${member.name }</td>
							<td id="popup_td3">${member.companyName }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
			</table>
		</div>
		
		<!-- 전체 페이지 개수에 의한 페이지 리스트 띄우기 -->
		<div class="pageNumber" align="center">
			<ul>
				<c:if test="${pageMaker.prev }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/member/memberSearchPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/member/memberSearchPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
								<a
								href="${contextPath }/member/memberSearchPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
								<a
								href="${contextPath }/member/memberSearchPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a
								href="${contextPath}/member/memberSearchPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${contextPath}/member/memberSearchPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</div>
	
		<div class="popup_close">
			<input type="button" onclick="window.close()" value="창 닫기">
		</div>
	<!-- </div> -->
</body>
</html>