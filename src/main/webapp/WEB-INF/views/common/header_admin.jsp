a<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<body>
<header>
    <div id="layout_header">
        <div style="height:40px">
        <ul style="float:right;">
        	<li>
        	<c:choose>
	          <c:when test="${isLogOn == true  && manager!= null}">
	            <a href="${contextPath}/manager/logout.do">로그아웃</a>
	          </c:when>
	          <c:otherwise>
		        <%-- <a href="${contextPath}">로그인</a>
		        <a  href="${contextPath}/member/memberForm.do">회원가입</a> --%>
		      </c:otherwise>
	  		 </c:choose>
	  		 </li>
            <li>
            <%-- <c:choose>
	          <c:when test="${isLogOn == true  && manager!= null}">
	            <a href="#">마이페이지</a>
	          </c:when>
	  		 </c:choose> --%>
            </li>
        </ul>
        </div>
        <c:choose>
          <c:when test="${isLogOn == true  && manager!= null}">
	      	<ul>
	            <li><a href="${contextPath}"><img src="${contextPath}/resources/image/logo.png"></a></li>
	            <li class="header_menu"><a href="${contextPath}/member/listMembers.do">회원관리</a></li>
	            <li class="header_menu"><a href="${contextPath}/course/listCourses.do">과정관리</a></li>
	            <li class="header_menu"><a href="#">수강관리</a></li>
	            <li class="header_menu"><a href="#">설문조사관리</a></li>
	            <li class="header_menu"><a href="${contextPath}/board/listArticles.do">게시판관리</a></li>
        	</ul>
          </c:when>
          <c:otherwise>
	        <ul>
	            <li><a href="${contextPath}"><img src="${contextPath}/resources/image/logo.png"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
	            <li class="header_menu"><a href="#"></a></li>
        	</ul>
	      </c:otherwise>
 		 </c:choose>
    </div>
</header>
</body>