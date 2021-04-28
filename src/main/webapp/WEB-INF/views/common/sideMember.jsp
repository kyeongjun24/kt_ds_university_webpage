<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  request.setCharacterEncoding("UTF-8");
  String viewName = request.getParameter("viewName");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<div class="side">
	<h1 class="side_title">회원관리</h1>
	<ul>
		<c:if test="${fn:endsWith(viewName, 'listPartners' )}">
			<li><a href="${contextPath}/partner/listPartners.do" class="no-underline"><b>협력회사</b></a></li><br>
			<li><a href="${contextPath}/member/listMembers.do"  class="no-underline">학생관리</a></li><br>
			<li><a href="${contextPath}/company/listCompanies.do" class="no_unerline">회사관리</a></li><br>
			<li><a href="${contextPath}/manager/modManagerForm.do"  class="no-underline">계정관리</a></li><br>
			<li><a href="${contextPath}/event_security_log/listEvent_security_logs.do"  class="no-underline">로그관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/member')}">
			<li><a href="${contextPath}/partner/listPartners.do" class="no-underline">협력회사</a></li><br>
			<li><a href="${contextPath}/member/listMembers.do"  class="no-underline"><b>학생관리</b></a></li><br>
			<li><a href="${contextPath}/company/listCompanies.do" class="no_unerline">회사관리</a></li><br>
			<li><a href="${contextPath}/manager/modManagerForm.do"  class="no-underline">계정관리</a></li><br>
			<li><a href="${contextPath}/event_security_log/listEvent_security_logs.do"  class="no-underline">로그관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/company')}">
			<li><a href="${contextPath}/partner/listPartners.do" class="no-underline">협력회사</a></li><br>
			<li><a href="${contextPath}/member/listMembers.do"  class="no-underline">학생관리</a></li><br>
			<li><a href="${contextPath}/company/listCompanies.do" class="no_unerline"><b>회사관리</b></a></li><br>
			<li><a href="${contextPath}/manager/modManagerForm.do"  class="no-underline">계정관리</a></li><br>
			<li><a href="${contextPath}/event_security_log/listEvent_security_logs.do"  class="no-underline">로그관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/manager')}">
			<li><a href="${contextPath}/partner/listPartners.do" class="no-underline">협력회사</a></li><br>
			<li><a href="${contextPath}/member/listMembers.do"  class="no-underline">학생관리</a></li><br>
			<li><a href="${contextPath}/company/listCompanies.do" class="no_unerline">회사관리</a></li><br>
			<li><a href="${contextPath}/manager/modManagerForm.do"  class="no-underline"><b>계정관리</b></a></li><br>
			<li><a href="${contextPath}/event_security_log/listEvent_security_logs.do"  class="no-underline">로그관리</a></li><br>
		</c:if>
		<c:if test="${fn:startsWith(viewName, '/event_security_log')}">
			<li><a href="${contextPath}/partner/listPartners.do" class="no-underline">협력회사</a></li><br>
			<li><a href="${contextPath}/member/listMembers.do"  class="no-underline">학생관리</a></li><br>
			<li><a href="${contextPath}/company/listCompanies.do" class="no_unerline">회사관리</a></li><br>
			<li><a href="${contextPath}/manager/modManagerForm.do"  class="no-underline">계정관리</a></li><br>
			<li><a href="${contextPath}/event_security_log/listEvent_security_logs.do"  class="no-underline"><b>로그관리</b></a></li><br>
		</c:if>		
	</ul>
</div>

