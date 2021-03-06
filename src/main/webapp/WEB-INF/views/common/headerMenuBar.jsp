<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
header {
	background-color: #333;
	height: 3.8em;
	border-top: 2px solid #e91b23;
	display: flex;
	font-family: 'Noto Sans KR', sans-serif;
}

/* header 부분에만 적용되게 추가... ul li a 태그까지 */
header ul {
	list-style-type: none;
	display: flex;
}

header ul li {
	
}

header ul li a {
	color: #fff;
    font-weight: 300;
    padding: 1.3em 5.5em;
    font-size: 0.9em;
    border-right: 0.5px solid #969696;
}

.logo {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 11%;
	border-right: 0.5px solid #969696;
}

.main_menu {
    position: relative;
    top: 1em;
}

img {
    width: 8.8em;
    height: 1.4em;
	object-fit: cover;
}
</style>
<body>

	<header>
		<div class="logo">
			<a href="${contextPath}/member/adminMain.do"><img class="mainLogoImg"
				src="${contextPath}/resources/image/adminLogo2.png"></a>
			<!-- 로고 클릭 시 회원리스트로 이동 -->
		</div>
		<div class="main_menu">
			<ul>
				<li class="header_menu"><a
					href="${contextPath}/member/listMembers.do">회원관리</a></li>
				<li class="header_menu"><a
					href="${contextPath}/course/listCourses.do">과정관리</a></li>
				<li class="header_menu"><a
					href="${contextPath}/enrollment/listEnrollments.do">수강관리</a></li>
				<li class="header_menu"><a href="${contextPath}/survey/listSurveys.do">설문조사관리</a></li>
				<li class="header_menu"><a href="${contextPath}/board/listArticles.do">게시판관리</a></li>
				<li><c:choose>
						<c:when test="${isLogOn == true  && manager!= null}">
							<a href="${contextPath}/manager/logout.do">로그아웃</a>
						</c:when>
						<c:otherwise>
							<a href="${contextPath}">로그인</a>
						</c:otherwise>
					</c:choose></li>
			</ul>
		</div>
	</header>
</body>