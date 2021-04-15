<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
<style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
</style>
  <meta charset="UTF-8">
  <title>과정관리 리스트</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function getCheckList() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
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
				url: '${contextPath}/course/removeCheckedCourses.do',
				traditional : true, //Array 형태로 보내려면 설정 해줘야함
				data: {arr : arr},
			
				success: function(data) {
					alert('삭제 완료');
					alert(data);
					window.location.href = "${contextPath}/course/listCourses.do";
				}, error:function(data,request,status,error){
	            	 /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); */
	            	 alert("이 과정에 대한 수강신청 데이터를 먼저 지워주세요.");
	             
	     	   }
			})
		}
	}

	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
	})
</script>


<body>
<%String searchType = request.getParameter("searchType");
  String searchText = request.getParameter("searchType");
%>
<form method="get" action="${contextPath}/course/listCourses.do" id="searchFrm">
	<select name="searchType" id="searchType">
		<c:if test="${searchType == 'crs_id'}">
		<option value="">검색 종류</option>
		<option value="crs_id" selected>번호</option>
		<option value="slb_name">과정명</option>
		</c:if>
		<c:if test="${searchType == 'slb_name' }">
		<option value="">검색 종류</option>
		<option value="crs_id">번호</option>
		<option value="slb_name" selected>과정명</option>
		</c:if>
		<c:if test="${searchType == null }">
		<option value="" selected>검색 종류</option>
		<option value="crs_id">번호</option>
		<option value="slb_name">과정명</option>
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

<table align="center" border="0"  width="80%"  >
  <tr height="10" align="center">
     <td><input type="checkbox" id="selectAll"></td>
     <td><b>번호</b></td>
     <td><b>과정명</b></td>
     <td ><b>수강인원</b></td>              
     <td><b>접수기간</b></td>
     <td><b>수강기간</b></td>
     <td><b>등록일</b></td>
  </tr>
<c:choose>
  <c:when test="${coursesList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 과정이 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  <c:when test="${coursesList !=null }" >
    <c:forEach  var="course" items="${coursesList }" varStatus="articleNum" >
     <tr align="center">
	<!--<td width="5%">${articleNum.count}</td>  -->
	<td><input type="checkbox" name="selectedCheckbox" id="${course.id }"></td>
	<td width="10%">${course.id }</td>
	<td align='left'  width="30%">
	  <span style="padding-right:10px"></span>
	  <a class='cls1' href="${contextPath}/course/selectCourse.do?id=${course.id}">${course.syllabusVO.name }</a>
	 </td>
	 <td>${course.capacity }</td>
	 <td>${course.startDate } ~ ${course.endDate }</td>
	 <td>${course.rsDate } ~ ${course.reDate }</td>
	 <td>${course.joinDate }</td>
	
	 <%-- <td><a href="${contextPath}/course/updateCourseForm.do?id=${course.id}&slbId=${course.slbId}">수정하기</a></td>
	 <td><a href="${contextPath}/course/removeCourse.do?id=${course.id}">삭제하기</a></td> --%>
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>
<button type="button" onclick="location.href='${contextPath}/course/courseForm.do'" style="width: 5%;">등록</button>
<button type="button" onclick='getCheckList()' style="width: 5%;">삭제</button>
</body>
</html>