<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');
* {
   margin: 0px;
   padding: 0px;
   box-sizing: border-box;
   font-family : "Noto Sans KR", sans-serif;
}
header {
   background-color: #333;
   height: 60px;
   border-top: 2px solid #e91b23;
   display: flex;
}

ul {
   list-style-type: none;
}

ul li {
   float: left;
}

ul li a {
   color: #fff;
   font-weight: 400;
   padding : 5px 15px;
   border-left : 0.5px solid #969696;
}

#layout_header {
   padding-bottom: 30px;
   float: left;
   display: block;
   width: 100%;
   background-color: #333;
}

.logo {
   padding: 10px 15px;
}

.header_menu {
   margin: 20px 60px;
   font-size: 15px;
}

img {
   width: 180px;
   height: 30px;
   object-fit: cover;
}
</style>
<body>
   <header>
      <div class="logo">
         <a href="${contextPath}"><img
            src="${contextPath}/resources/image/adminLogo.png"></a>
      </div>

      <div class="sub_menu">
         <ul style="float: right;">
            <%-- <li>
            <c:choose>
             <c:when test="${isLogOn == true  && manager!= null}">
               <a href="#">마이페이지</a>
             </c:when>
             <c:otherwise>
              <a  href="${contextPath}/manager/memberForm.do">회원가입</a>
            </c:otherwise>
            </c:choose>
            </li> --%>
         </ul>
      </div>
      <div class="main_menu">
         <ul>
            <li class="header_menu"><a
               href="${contextPath}/member/listMembers.do">회원관리</a></li>
            <li class="header_menu"><a
               href="${contextPath}/course/listCourses.do">과정관리</a></li>
            <li class="header_menu"><a
               href="${contextPath}/enrollment/listEnrollments.do">수강관리</a></li>
            <li class="header_menu"><a href="#">설문조사관리</a></li>
            <li class="header_menu"><a
               href="#">게시판관리</a></li>
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