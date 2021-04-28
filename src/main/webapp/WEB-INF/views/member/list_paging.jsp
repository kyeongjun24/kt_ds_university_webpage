<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    


<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
		
		if(length == 0){
			alert("선택된 값이 없습니다.");
			return false;
		} else{
			$.ajax({
				type: 'post',
				url: '${contextPath}/member/removeCheckedMembers.do',
				traditional : true, //Array 형태로 보내려면 설정 해줘야함
				data: {arr : arr},
				
				success: function(data) {
					alert('데이터 받기 성공');
					alert(data);
					window.location.href = "${contextPath}/member/listMembers.do";
				}, error:function(data,request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		             
		        }
			})
		}
	}
	
	// 전체 체크되게 하는 함수
	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
		
		
	}) //function
	
</script>

<body>
<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
%>
<form method="get" action="${contextPath}/member/listMembers.do">
	<select name="searchType" id="searchType">
		<c:if test="${searchType == 'name'}">
			<option value="">검색 종류</option>
			<option value="name" selected>이름</option>
			<option value="companyName">회사명</option>
		</c:if>
		<c:if test="${searchType == 'companyName' }">
			<option value="">검색 종류</option>
			<option value="name">이름</option>
			<option value="companyName" selected>회사명</option>
		</c:if>
		<c:if test="${empty searchType }">
			<option value="" selected>검색 종류</option>
			<option value="name">이름</option>
			<option value="companyName">회사명</option>
		</c:if>
	</select>
	<c:choose>
		<c:when test="${searchText != null }">
			<input type="text" name="searchText" id="search" value="${searchText }" style="width: 100px; margin-right: 20px;">
		</c:when>
		<c:otherwise>
			<input type="text" name="searchText" id="search" style="width: 100px; margin-right: 20px;">
		</c:otherwise>
	</c:choose>
	<input type="submit" value="검색">
</form>
<table border="0"  align="center"  width="80%" >
    <tr align="center">
      <td><input type="checkbox" id="selectAll"></td>
      <td ><b>아이디</b></td>
      <td><b>회사명</b></td>
      <td><b>이름</b></td>
      <td><b>이메일</b></td>
      <td><b>가입일</b></td>
   </tr>
 <c:choose>
	 <c:when test="${not empty members }" >
	 	<c:forEach var="member" items="${members}" varStatus="memberNum">     
	   		<tr align="center" >
		      	<td><input type="checkbox" name="selectedCheckbox" id="${member.id }"></td>
		      	<td><a href="${contextPath}/member/informationMemberForm.do?id=${member.id }">${member.id}</a></td>
		      	<td>${member.companyName}</td>
		      	<td>${member.name}</td>
		      	<td>${member.email}</td>
		     	<td>${member.joinDate}</td>
	   		</tr>
  		</c:forEach>   
	 </c:when>
	 <c:when test="${empty members }">
		   	<h1>데이터가 없습니다.</h1>
	 </c:when>
 </c:choose>  
</table>
<ul>
	<c:if test="${pageMaker.prev }">
		<li><a href="${contextPath}/member/listPaging.do?page=${pageMaker.startPage - 1 }">이전</a></li>
	</c:if>
	<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
		<li <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
			<a href="${contextPath }/member/listPaging.do?page=${idx}">${idx }</a></li>
	</c:forEach>
	<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
		<li><a href="${contextPath}/member/listPaging.do?page=${pageMaker.endPage + 1 }">다음</a></li>
	</c:if>
</ul>
<button type="button" onclick="location.href='${contextPath}/member/memberForm.do'" style="width: 5%;">등록</button>
<button type="button" onclick='getCheckList()' style="width: 5%;">삭제</button>
<!-- 등록 버튼 추가해서 함수 실행하게 만들어야함 -->

      <td><a href="${contextPath}/member/removeMember.do?id=${member.id }">삭제</a></td>
</body>
</html>
