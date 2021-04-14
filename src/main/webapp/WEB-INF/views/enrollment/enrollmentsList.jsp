<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  <title>글목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	
	// 전체 체크되게 하는 함수
	$(function() {
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
	})
		
	//체크 된 걸 가져오는 함수
	function getCheckList() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		alert(length);
		var arr = new Array();
		$("input:checkbox[name='selectedCheckbox']:checked").each(function(index) {
			/* alert($(this).attr('id')); */
			arr.push($(this).attr('id'));
			alert($(this).attr('id'));	
		})
		
		if(length == 0){
			alert("선택된 값이 없습니다.");
			return false;
		} else{
			$.ajax({
				type: 'post',
				url: '${contextPath}/enrollment/modEnrollments.do',
				traditional : true, //Array 형태로 보내려면 설정 해줘야함
				data: {arr : arr},
				
				success: function(data) {
					alert('데이터 받기 성공');
					alert(data);
					window.location.href = "${contextPath}/enrollment/listEnrollments.do";
				}, error:function(data,request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        }
			})
		}
	}
	
	$(document).on("click", '#selectAll', function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
	});

</script>
<body>
<form id="searchFrm">
	<select id="searchType"><option value="">선택</option><option value="comName">회사명</option><option value="contractName">담당자</option></select>
	<input type="text" id="search" style="width: 100px; margin-right: 20px;"><input type="submit" value="검색" id="searchSubmit">
</form>
<table align="center" border="0"  width="80%" id="dynamicCompany" >
  <tr height="15" align="center" style="border-bottom: solid;">
     <td><input type="checkbox" id="selectAll"></td>         
     <td ><b>아이디</b></td>
     <td><b>이름</b></td>
     <td><b>전화번호</b></td>
     <td><b>이메일</b>
     <td><b>소속회사</b></td>
     <td><b>과정명</b></td>
     <td><b>승인</b></td>
     <td><b>신청일</b></td>
  </tr>
<c:choose>
  <c:when test="${enrollmentsList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 회사가 없습니다.</span></b>
        </p></td>  
    </tr>
  </c:when>
  <c:when test="${enrollmentsList !=null }" >
   <c:forEach  var="enrollment" items="${enrollmentsList }" varStatus="enrdNum" >
	    <tr align="center">
			<td><input type="checkbox" name="selectedCheckbox" id="${enrollment.id }"></td>
			<td width="15%">${enrollment.memId }</td>
			<td align='center'  width="20%">
		  		<span style="padding-right:10px"></span>
		  		<a href="${contextPath}/enrollment/informationEnrollment.do?id=${enrollment.id }">${enrollment.memberVO.name }</a>
		 	</td>
		 	<td>${enrollment.memberVO.phone }</td>
		 	<td>${enrollment.memberVO.email }</td> 
		 	<td>${enrollment.memberVO.companyName }</td>
	 		<td>${enrollment.syllabusVO.name }</td>
	 		<td>
	 			<c:if test="${enrollment.stat == '신청' }">
	 				<font color="red">${enrollment.stat }</font>
	 			</c:if>
	 			<c:if test="${enrollment.stat == '승인' }">
	 				<font color="green">${enrollment.stat }</font>
	 			</c:if>
	 			<c:if test="${enrollment.stat eq '수료' }">
	 				<font color="blue">${enrollment.stat }</font>
	 			</c:if>
	 		</td>
		 	<td>${enrollment.joinDate }</td>
		</tr>
    </c:forEach>	</c:when>	</c:choose>
</table>
<button type="button" onclick="location.href='${contextPath}/enrollment/enrollmentForm.do'" style="width: 5%;">등록</button>
<button type="button" style="width: 5%;">승인</button>
<button type="button" onclick='getCheckList()' style="width: 5%;">삭제</button>
<button type="button" style="width: 5%;">수료</button>
<!-- 등록 버튼 추가해야함 -->
<%-- <a  class="cls1"  href="javascript:fn_articleForm('${isLogOn}','${contextPath}/company/companyForm.do', 
                                                    '${contextPath}/member/loginForm.do')"><p class="cls2">회사등록하기</p></a> --%>
</body>
</html>