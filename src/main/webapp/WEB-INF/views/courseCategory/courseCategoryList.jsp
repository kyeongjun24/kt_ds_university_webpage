<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
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
  <meta charset="UTF-8">
</head>
<style>
	.menuCategory{
		height: 5%;
		width: 100%;
		margin-bottom: 1%;
		text-align: left;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function getCheckListRemove() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		var arr = new Array();
		$("input:checkbox[name='selectedCheckbox']:checked").each(function(index) {
			arr.push($(this).attr('id'));
		})
		
		if(length == 0){
			alert("선택된 값이 없습니다.");
			return false;
		} else{
			if (confirm('삭제하시겠습니까?') == ture) {
				
				$.ajax({
					type: 'post',
					url: '${contextPath}/courseCategory/removeCheckedCourseCategories.do',
					traditional : true, //Array 형태로 보내려면 설정 해줘야함
					data: {arr : arr},
					
					success: function(data) {
						window.location.href = "${contextPath}/courseCategory/listAllCourseCategories.do";
					}, error:function(data,request,status,error){
			             alert("개발자 : 왜요??");
			        }
				}) //ajax
			} else {
				return false;
			}
		}
	}
	
	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})//selectAll
		
	})
</script>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
		
	
%>
	<div class="menuCategory">
		<h5>과정 관리 > 카테고리 관리</h5>
	</div>
	
	<table align="center" >
	  <tr height="10">
	     <td><input type="checkbox" id="selectAll"></td>
	     <td><b>2차 분류</b></td>
	     <td><b>아이디</b></td>
	  </tr>
		<c:choose>
		  <c:when test="${empty courseCategoryList }" >
		    <tr  height="10">
		      <td colspan="4">
		         <p align="center">
		            <b><span style="font-size:9pt;">등록된 범주가 없습니다.</span></b>
		        </p>
		      </td>  
		    </tr>
		  </c:when>
		  <c:when test="${not empty courseCategoryList }" >
			    <c:forEach  var="courseCategory" items="${courseCategoryList }" varStatus="categoryNum" >
				    <tr align="center">
						<td><input type="checkbox" name="selectedCheckbox" id="${courseCategory.id }"></td>
						<td>
						  <span style="padding-right:10px"></span>
						  <a href="${contextPath}/courseCategory/selectCourseCategory.do?id=${courseCategory.id}">${courseCategory.name }</a>
						 </td>
						<td >${courseCategory.id }</td>
					</tr>
			    </c:forEach>
		   </c:when>
		</c:choose>
	</table>
	<div class="memberButton">
		<button type="button" id="enrollButton" onclick="location.href='${contextPath}/courseCategory/courseCategoryForm.do'" style="width: 5%;">등록</button>
		<button type="button" onclick="getCheckListRemove()" style="width: 5%;">삭제</button>
	 </div>
<%} else {  %>
<script>
	window.location.href="${contextPath}";
</script>
<% } %>	
</body>
</html>