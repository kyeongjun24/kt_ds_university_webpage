<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
   .text_center{
     text-align:center;
   }
   
   #memberTable{
   	width: 1100px;
   	margin-top: 60px;
   }
   
   td{
   	border : none;
   }
   
   .menuCategory{
   	height: 5%;
   	 width: 100%;
   	  margin-bottom: 1%;
   	   text-align: left;
   }
   
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
	function checkInfo() {
		var memberId = '${vo.id}';
		
		Swal.fire({ 
			title: '${vo.id}의 정보를\n 조회하시겠습니까?',
			text: "정보를 조회하면 관리자의 조회 기록이 저장됩니다.",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: 'Yes',
			cancelButtonText: 'No'
			}).then((result) => {
				
			if(result.isConfirmed) {
				$.ajax({
					type: 'post',
					url : '${contextPath}/member/insertLogByInformationInquiry.do',
					data: { id : memberId},
					
					success: function(result) {
						Swal.fire( 
								'${vo.id} 정보 조회가 완료되었습니다.',
								'',
								'success' 
							)
					}, error:function(error){
						alert('잠시 후 시도해주세요.');
					}
				}) //ajax
				
				$('input[name=id]').attr('value', '${vo.id}');
				$('input[name=name]').attr('value', '${vo.name}');
				$('input[name=phone]').attr('value', '${vo.phone}');
				$('input[name=tel]').attr('value', '${vo.tel}');
				$('input[name=email]').attr('value', '${vo.email}');
				$('#inquiryInfo').attr('disabled', true);
				$('#enrollButton').removeAttr('onclick');
				$('#enrollButton').attr('onclick', "updateFormMember('T')");
			} else {
				Swal.fire("취소되었습니다.")
			}
		})

		
		
		/* if (confirm('정보 조회 시 관리자 정보 기록이 저장됩니다. 동의하십니까?') == true) {
			
			alert('정보 조회되었습니다.');
			
			$.ajax({
				type: 'post',
				url : '${contextPath}/member/insertLogByInformationInquiry.do',
				data: { id : memberId},
				
				success: function(result) {
					alert('기록이 되었습니다.');
					
				}, error:function(error){
					alert('잠시 후 시도해주세요.');
				}
			}) //ajax
			
			$('input[name=id]').attr('value', '${vo.id}');
			$('input[name=name]').attr('value', '${vo.name}');
			$('input[name=phone]').attr('value', '${vo.phone}');
			$('input[name=tel]').attr('value', '${vo.tel}');
			$('input[name=email]').attr('value', '${vo.email}');
			$('#inquiryInfo').attr('disabled', true);
		} else {
			alert('취소되었습니다.');
			return false;
		} //if(confirm) */
		
	} //checkInfo
	
	function removeMember() {
		if (confirm('탈퇴시키겠습니까?') == true) {
			window.location.href = '${contextPath}/member/removeMember.do?id=${vo.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}';
		} else{
			return;
		}
	} //removeMember
	
	function updateFormMember(stat) {
		btn_stat = document.getElementById('enrollButton').disabled;
		if (stat == 'F') {
			alert('정보 조회 하신 이후에 수정 창으로 이동 가능합니다.');
			document.getElementById('inquiryInfo').focus();
		} else {
			window.location.href = '${contextPath}/member/modMemberForm.do?id=${vo.id }&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}';			
		}
	}
</script>
</head>
<body>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
	
	if (manager != null && isLogOn == true) {
		
	
%>
	<div class="menuCategory">
		<h5>회원 관리 > 회원 정보</h5>
	</div>
	<div style="width: 80%;">
		<h1  class="text_center">회원 정보</h1>
	</div>
	<table  align="center" id="memberTable">
	   <tr>
	      <td width="58%" style="padding-right: 3%;"><p align="right">아이디</td>
	      <td width="42%" align="left" style="padding-left: 2%;"><input type="text" name="id" value="${fn:substring(vo.id, 0, fn:length(vo.id)-3)}***" readonly><button onclick="checkInfo()" id="inquiryInfo">정보 조회</button></td>
	   </tr>
	   <tr>
	      <td style="padding-right: 3%;"><p align="right"><p align="right">비밀번호</td>
	      <td align="left" style="padding-left: 2%;"><input type="text" name="pw" value="${fn:replace(vo.pw, vo.pw, '********')}" readonly></td>
	    </tr>
	    <tr>
	      <td style="padding-right: 3%;"><p align="right"><p align="right">비밀번호 확인</td>
	      <td align="left" style="padding-left: 2%;"><input type="text" value="${fn:replace(vo.pw, vo.pw, '********') }" readonly></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right"><p align="right">이름</td>
	       <td align="left" style="padding-left: 2%;"><input type="text" name="name" value="${fn:substring(vo.name, 0, fn:length(vo.name) - 1)}*" readonly></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right"><p align="right">연락처</td>
	       <td align="left" style="padding-left: 2%;">
	       
	       <c:set var="memberPhone" value="${fn:split(vo.phone, '-')}"/>
			<input type="text" name="phone" value="${fn:substring(memberPhone[0], 0, 2)}*-${fn:substring(memberPhone[1], 0, 2)}**-${fn:substring(memberPhone[2], 0, 2)}**" readonly></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">전화번호</td>
	       <td align="left" style="padding-left: 2%;">
	       <c:choose>
	       	<c:when test="${empty vo.tel}">
	       		<input type="tel" id="tel" name="tel" value="${vo.tel }" readonly>
	       	</c:when>
	       	<c:otherwise>
	       		<c:set var="telPhone" value="${fn:split(vo.tel, '-')}"/>
	       		<input type="tel" id="tel" name="tel" value="${telPhone[0]}-${fn:substring(telPhone[1], 0, 2)}**-${fn:substring(telPhone[2], 0, 2)}**" pattern="[0-9]{2}-[0-9]{4}-[0-9]{4}" readonly>
	       	</c:otherwise>
	       </c:choose>
	       </td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right"><p align="right">이메일</td>
	       <td align="left" style="padding-left: 2%;">
	       <c:set var="email" value="${fn:split(vo.email, '@')}"/>
	       <input type="text" value="${fn:replace(email[0], fn:substring(email[0], 0, 3), '***')}@${email[1]}" name="email" id="email" readonly>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right"><p align="right">수신동의 여부</td>
	       <td align="left" style="padding-left: 2%;">
	       <c:choose>
		       	<c:when test="${vo.subscription == 'T' }">
		       		<input type="text" value="동의" readonly>
		       	</c:when>
		       	<c:when test="${vo.subscription == 'F' }">
		       		<input type="text" value="미동의" readonly>
		       	</c:when>
		       	<c:otherwise>
		       		<input type="text" value="" readonly>
		       	</c:otherwise>
	       </c:choose>
	       </td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right"><p align="right">회사명</td>
	       <td align="left" style="padding-left: 2%;"><input type="text" value="${vo.companyName }" readonly></td> 
	    </tr>
	    <tr>
	       <td colspan="2" align="center" style="padding-left: 25%;">
	       <button id="enrollButton" onclick="updateFormMember('F')">수정하기</button>&nbsp;&nbsp;&nbsp;
	       <button onclick="removeMember()">탈퇴</button>&nbsp;&nbsp;&nbsp;
	       <button onclick="history.back()" >뒤로</button></td>
	    </tr>
	</table>
	<%} else {  %>
	<script>
		window.location.href="${contextPath}";
	</script>
	<% } %>
</body>
</html>