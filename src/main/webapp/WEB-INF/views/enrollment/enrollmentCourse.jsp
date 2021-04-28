<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수강신청 강의 상세내용</title>
<style>
   .text_center{
     text-align:center;
   }
   
   .process {
	text-align: left;
	color: #9C9D9D;
	margin-bottom: 2em;
	}
	
</style>
</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	
</script>
<body>
	
	<div class="process">
		<h4>
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;">수강관리</span> > 
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;"> 수강신청내역</span> >
			<span onclick="window.location.reload()"
				style="cursor: pointer;"> 상세내역(강좌)</span>
		</h4>
	</div>
	
	<table align="center" border="0" width="80%" id="dynamicCompany">
		<tr height="15" align="center" id="attr">
			<td><b>번호</b></td>
			<td><b>아이디</b></td>
			<td><b>이름</b></td>
			<td><b>전화번호</b></td>
			<td><b>이메일</b></td>
			<td><b>회사</b></td>
			<td><b>과정명</b></td>
			<td><b>진행일자</b></td>
			<td><b>상태</b></td>
			<td><b>신청일</b></td>
		</tr>
		
		<c:choose>
			<c:when test="${enrollmentsList == null }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">신청한 회원이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			
			<c:when test="${enrollmentsList !=null }">
				<c:forEach var="enrollment" items="${enrollmentsList }" varStatus="enrdNum">
					<tr align="center">
						<td>${enrdNum.count}</td>
						<td>${enrollment.memberVO.id }</td>
						<td>${enrollment.memberVO.name }</td>
						<td>${enrollment.memberVO.phone }</td>
						<td>${enrollment.memberVO.email }</td>
						<td>${enrollment.memberVO.companyName }</td>
						<td>${enrollment.syllabusVO.name }</td>
						<td>${enrollment.courseVO.startDate } ~ ${enrollment.courseVO.endDate }</td>
						<td>${enrollment.stat }</td>
						<td>${enrollment.joinDate }</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	
	
	
	<button type="button" onclick="location.href = '${contextPath}/enrollment/listEnrollments.do'" style="width: 5%;">목록</button>
</body>
</html>