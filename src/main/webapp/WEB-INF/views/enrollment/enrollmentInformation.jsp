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
<title>상세 접수내용</title>
<style>
   .text_center{
     text-align:center;
   }
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script language="javascript">
	
	function popup(){
		var url = "${contextPath}/company/popUp.do";
		var name = "popup test";
		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
	
	
</script>
</head>
<body>
	<h1  class="text_center"> 상세 접수내용 페이지</h1>
	<form method="post" action="${contextPath}/enrollment/modEnrollment.do">
	<table  align="center" border="1">
	   <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">성명</td>
	      <td width="400"><p align="center">${enrollmentVO.memberVO.name }</td>
	      <td width="200" bgcolor="lightblue"><p align="center">아이디</td>
	      <td colspan='2' width="400"><p align="center">${enrollmentVO.memId }</td>
	   </tr>
	   
	    <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">연락처</td>
	      <td width="400"><p align="center">${enrollmentVO.memberVO.phone }</td>
	      <td width="200" bgcolor="lightblue"><p align="center">이메일</td>
	      <td colspan='2' width="400"><p align="center">${enrollmentVO.memberVO.email }</td>
	    </tr>
	    <tr> 
	       <td width="200" bgcolor="lightblue"><p align="center">접수일</td>
	       <td width="400"><p align="center">${enrollmentVO.joinDate }</td>
	       <td width="200" bgcolor="lightblue"><p align="center">현재상태</td>
	       <td width="200"><p align="center"><input type="text" name="stat" id="stat" value="${enrollmentVO.stat }" readonly></td>
	       <td width="200">     변경 : 
	       <select name="stat" onchange="document.getElementById('stat').value = this.options[this.selectedIndex].value" >
	       		<option value="." disabled selected>현재상태</option>
	       		<option value="승인대기">승인대기</option>
	       		<option value="승인">승인</option>
	       		<option value="취소">취소</option>
	       		<option value="수료">수료</option>
	       </select></td>
	    </tr>
	    <tr>
	       <td width="200" bgcolor="lightblue"><p align="center">회사정보</td>
	       <td width="400" ><p align="center"><input type="text" name="companyName" id="companyName" value="${enrollmentVO.memberVO.companyName }" readonly><br>*새로운 회사명 선택시 변경됩니다.
	       <br><a onclick="popup()" >회사 수정</a>
	       </td>
	       <td width="200" bgcolor="lightblue"><p align="center">수료일</td>
	       <td colspan='2' width="400"><p align="center">${enrollmentVO.completeDate }</td> 
	    </tr>
	    
	</table>
	
	<h6> .</h6>
	<h6> .</h6>
	<table  align="center" border="1">
	   <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">강좌유형</td>
	      <td width="400"><p align="center">${enrollmentVO.syllabusVO.type }</td>
	      <td width="200" bgcolor="lightblue"><p align="center">강좌분류</td>
	      <td width="400"><p align="center">${enrollmentVO.syllabusVO.category }</td>
	   </tr>
	   
	    <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">강좌명</td>
	      <td colspan='3' width="1000"><p align="left">${enrollmentVO.syllabusVO.name }</td>
	    </tr>
	    <tr>
	       <td width="200" bgcolor="lightblue"><p align="center">보고용 강좌명</td>
	      <td colspan='3' width="1000"><p align="left">${enrollmentVO.syllabusVO.reportName }</td>
	    </tr>
	    <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">강의실 정보</td>
	      <td width="400"><p align="center">${enrollmentVO.courseVO.classroom } 호</td>
	      <td width="200" bgcolor="lightblue"><p align="center">수강신청일</td>
	      <td width="400"><p align="center">${enrollmentVO.courseVO.crsrsdate } ~ ${enrollmentVO.courseVO.crsredate }</td>
	   </tr>
	   <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">교육기간</td>
	      <td width="400"><p align="center">${enrollmentVO.courseVO.startDate } ~ ${enrollmentVO.courseVO.endDate }</td>
	      <td width="200" bgcolor="lightblue"><p align="center">강의시간</td>
	      <td width="400"><p align="center">${enrollmentVO.courseVO.startTime } ~ ${enrollmentVO.courseVO.endTime }</td>
	   </tr>
	   <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">수강인원수</td>
	      <td width="400"><p align="center">${enrollmentVO.courseVO.capacity } 명</td> 
	      <td width="200" bgcolor="lightblue"><p align="center">교육일수</td>
	      <td width="400"><p align="center">${enrollmentVO.syllabusVO.days } 일</td>
	   </tr>
	   <tr>
	      <td width="200" bgcolor="lightblue"><p align="center">교육시간</td>
	      <td width="400"><p align="center">${enrollmentVO.syllabusVO.time } 시간</td>
	   </tr> 
	    
	</table>
	
	<button type="button" onclick="location.href = '${contextPath}/enrollment/listEnrollments.do'" style="width: 5%;">목록</button>
	<input type="submit" value="수정">
	<button type="button" style="width: 5%;">삭제</button>
	</form>
</body>
</html>