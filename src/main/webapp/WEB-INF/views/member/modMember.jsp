<%@page import="com.mySpring.springEx.manager.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="tel" value="${fn:split(vo.tel, '-')}"/>
<c:set var="phone" value="${fn:split(vo.phone, '-')}"/>
<c:set var="email" value="${fn:split(vo.email, '@')}"/>

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
   
   .process {
		text-align: left;
		color: #9C9D9D;
		margin-bottom: 2em;
	}
   
   .table_content{
		justify-content: center;
		display: flex;
		
	}
	
	.table_content td {
   	 border : none;
	}
	
  	#memberTable{
		width: 1000px;
	  	margin-top: 60px;
	  	justify-content: center;
		display: flex;
  	}
   
	#button {
		text-decoration: none;
		color: black;
		border: none;
		border-radius: 5px;
		background-color: #ECECEC;
		font-size: 13px;
		font-weight : 800;
		cursor: pointer;
		width: 90px;
		height: 35px;
		padding : 5px;
	}
	
	#inputTel{
		width: 15%;
	}
	
	#inputEmail{
		width: 25%;
	}
	
	#updateFrm input[type=submit]{
		margin-left: 20px;
	    width: 90px;
	    height: 35px;
	    border: none;
	    border-radius: 5px;
	    background-color: red;
	    font-size: 15px;
	    cursor: pointer;
	}
	
	#updateFrm input[type=button]{
		margin-left: 20px;
	    width: 90px;
	    height: 35px;
	    border: none;
	    border-radius: 5px;
	    background-color: #969696;
	    color: #EFEFEF;
	    font-size: 15px;
	    cursor: pointer;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		
		$('#pw2').on('keyup', function() {
			var pw = document.getElementById('pw').value;
			var pw2 = this.value;
			if (pw != pw2) {
				$('#pwCheck').html('??????????????? ????????????.').css('color','red');
				return;
			} else {
				$('#pwCheck').html('???????????? ??????').css('color','blue');
				return;
			}
			
		})
		
		$('#updateFrm').submit(function() {
			var frm = document.memberFrm;
			var id = frm.id.value;
			var pw = frm.pw.value;
			var pw2 = frm.pw2.value;
			var idCheck = document.getElementById("idCheck").innerHTML;
			var pwCheck = document.getElementById("pwCheck").innerHTML;
			var name = document.getElementById("name").value;
			
			// ???????????? ??????
			var tel1 = frm.tel1.value;
			var tel2 = frm.tel2.value;
			var tel3 = frm.tel3.value;
			var tel = tel1 + '-' + tel2 + '-' + tel3;
			if(tel1 != "" && tel2 != "" && tel3 != ""){
				frm.tel.value = tel;
				
			} else{
				frm.tel.value = "";
			}
					
			// ????????? ??????
			var phone1 = frm.phone1.value;
			var phone2 = frm.phone2.value;
			var phone3 = frm.phone3.value;
			var phone = phone1 + '-' + phone2 + '-' + phone3;
			frm.phone.value = phone;
			
			//????????? ??????
			var emailId = frm.emailId.value;
			var emailAddress = frm.emailAddress.value;
			var email = emailId + '@' + emailAddress;
			frm.email.value = email;
			
			
			if (id == "") {
				alert("???????????? ??????????????????.");
				frm.id.focus();
				return false;
			} else if(pw == "") {
				alert("??????????????? ??????????????????.");
				frm.pw.focus();
				return false;
			} else if(pw2 == "") {
				alert('???????????? ????????? ??????????????????.');
				frm.pw2.focus();
				return false;
			} else if(pwCheck != '???????????? ??????'){
				alert('???????????? ????????? ?????? ???????????????.');
				return false;
			} else if(name == "") {
				alert("????????? ???????????????.");
				return false;
			} else if(emailId == "") {
				alert("????????? ???????????? ???????????????.");
				return false;
			} else if(emailAddress == ""){
				alert('????????? ????????? ??????????????????.');
				frm.emailAddress.focus();
				return false;
			} else if (phone1 == "" || phone2 =="" || phone3 == "") {
				alert('???????????? ???????????? ???????????????.');
				if (phone1 == "") {
					frm.phone1.focus();
					return false;
				} else if (phone2 == "") {
					frm.phone2.focus();
					return false;
				} else if (phone3 == "") {
					frm.phone3.focus();
					return false;
				}
			} else if (tel1 != "" || tel2 != "" || tel3 != "") {
				if (tel1 == "" || tel2 == "" || tel3 == "") {
					alert("???????????? ????????? ????????? ????????????.");
					if (tel1 == "") {
						frm.tel1.focus();
						return false;
					} else if (tel2 == "") {
						frm.tel2.focus();
						return false;
					} else if (tel3 == "") {
						frm.tel3.focus();
						return false;
					}
				}
			} 
			
			return true;
		})
		
		
		$('#id').on('click', function() {
			alert('???????????? ?????? ???????????????.');
		})
		
		//????????? ?????? ??????
		$("select[name='emailAddresList']").on('change', function() {
			
			selectedAddress = $("select[name='emailAddresList'] option:selected").val();
			if (selectedAddress != "") {
				$("input[name='emailAddress']").attr('readonly', true);
			} else{
				$("input[name='emailAddress']").attr('readonly', false);
			}
			var frm = document.memberFrm;
			frm.emailAddress.value = selectedAddress;
			
		})
		
		$('input:checkbox[name="subscription"]').each(function() {
		    if(this.value == "${vo.subscription}"){ 
		            this.checked = true;
	        }
		});
		
 });
	
	//???????????? ?????????
	function initializePw(){
		if (confirm('???????????? ????????? ???????????????????') == true) {
			
		
			$('input[name=pw]').attr('value', '123456789a');
			$('input[name=pw2]').attr('value', '123456789a');
			$('#pwCheck').html('???????????? ??????').css('color','blue');
			alert('???????????? ????????????????????????.');
		} else { 
			return false;
		}
	}
	
	//?????? ????????? ??????
	function checkOnlyOne(element) {
		const checkboxes = document.getElementsByName("subscription");
		checkboxes.forEach((cb) => {
			  cb.checked = false;
			})
		element.checked = true;
	}
	
	//?????? ????????? ????????? ?????????
	function popup(){
	    var url = "${contextPath}/company/popUp.do";
	    var name = "popup test";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	    
	}
	
</script>

</head>
<body>
	<div class='process' >
		<h5>
			<span onclick="location.href='${contextPath}/member/listMembers.do'"
			style="cursor: pointer;">????????????</span> > <span
			onclick="location.href='${contextPath}/member/listMembers.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'"
			style="cursor: pointer;"> ????????????</span> > <span
			onclick="location.href='${contextPath}/member/modMemberForm.do?id=${vo.id }&page=${page}&searchText=${searchText }&searchType=${searchType }&perPage=${perPage }'"
			style="cursor:pointer;"> ????????????</span> 
		</h5>
	</div>
	
	<div style="width: 90%;">
		<h1  class="text_center">?????? ?????? ??????</h1>
	</div>
	
	<div class="table_content">
	
	<form method="post"   action="${contextPath}/member/modMember.do?page=${page}&searchText=${searchText}
			&searchType=${searchType}&perPage=${perPage}" name="memberFrm" id="updateFrm">
	
	<table  align="center" id="memberTable">
	   <tr>
	      <td width="20%" style="padding-right: 3%;"><p align="left">?????????</td>
	      <td width="80%" align="left" ><input type="text" name="id" id="id" value="${vo.id }" pattern="[0-9a-zA-z]+" readonly>
	      <span id="idCheck"></span></td>
	   </tr>
	   <tr>
	      <td style="padding-right: 3%;"><p align="left">????????????</td>
	      <td align="left"><input type="password" name="pw" id="pw" pattern="^(?=.*[0-9])(?=.*[a-zA-Z]).{8,16}$" value="${vo.pw }">&nbsp;&nbsp;&nbsp;<a onclick="initializePw()" id="button">?????????</a></td>
	    </tr>
	    <tr>
	      <td style="padding-right: 3%;"><p align="left">???????????? ??????</td>
	      <td align="left" ><input type="password" name="pw2" id="pw2" pattern="^(?=.*[0-9])(?=.*[a-zA-Z]).{8,16}$"><span id="pwCheck"></span></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="left">??????</td>
	       <td align="left" ><p><input type="text" name="name" id="name" value="${vo.name }"></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="left">????????????</td>
	       <td align="left"><p>
	       <c:choose>
		       	<c:when test="${empty vo.tel }">
	       			<select name="tel1" id="inputTel" class="tel1">
                        <option value="" selected="selected">??????</option>
                        <option value="02">02</option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="033">033</option>
                        <option value="041">041</option>
                        <option value="042">042</option>
                        <option value="043">043</option>
                        <option value="051">051</option>
                        <option value="052">052</option>
                        <option value="053">053</option>
                        <option value="054">054</option>
                        <option value="055">055</option>
                        <option value="061">061</option>
                        <option value="062">062</option>
                        <option value="063">063</option>
                        <option value="064">064</option>
                  </select>-
                  <input id="inputTel" type="tel" name="tel2" minlength='3' maxlength='4' pattern="[0-9]+" >- 
                  <input id="inputTel" type="tel" name="tel3" minlength='4' maxlength='4' pattern="[0-9]+" >
                  <input type="hidden" name="tel">
	       		</c:when>
	       		<c:otherwise>
	       			<select name="tel1" id="inputTel" class="tel1" >
                        <option value="" selected="selected">??????</option>
                        <option value="02" <c:if test="${tel[0] eq '02' }">selected</c:if>>02</option>
                        <option value="031" <c:if test="${tel[0] eq '031' }">selected</c:if>>031</option>
                        <option value="032" <c:if test="${tel[0] eq '032' }">selected</c:if>>032</option>
                        <option value="033" <c:if test="${tel[0] eq '033' }">selected</c:if>>033</option>
                        <option value="041" <c:if test="${tel[0] eq '041' }">selected</c:if>>041</option>
                        <option value="042" <c:if test="${tel[0] eq '042' }">selected</c:if>>042</option>
                        <option value="043" <c:if test="${tel[0] eq '043' }">selected</c:if>>043</option>
                        <option value="051" <c:if test="${tel[0] eq '051' }">selected</c:if>>051</option>
                        <option value="052" <c:if test="${tel[0] eq '052' }">selected</c:if>>052</option>
                        <option value="053" <c:if test="${tel[0] eq '053' }">selected</c:if>>053</option>
                        <option value="054" <c:if test="${tel[0] eq '054' }">selected</c:if>>054</option>
                        <option value="055" <c:if test="${tel[0] eq '055' }">selected</c:if>>055</option>
                        <option value="061" <c:if test="${tel[0] eq '061' }">selected</c:if>>061</option>
                        <option value="062" <c:if test="${tel[0] eq '062' }">selected</c:if>>062</option>
                        <option value="063" <c:if test="${tel[0] eq '063' }">selected</c:if>>063</option>
                        <option value="064" <c:if test="${tel[0] eq '064' }">selected</c:if>>064</option>
                  </select>-
                  <input id="inputTel" type="tel" name="tel2" minlength='3' maxlength='4' pattern="[0-9]+" value="${tel[1] }" >- 
                  <input id="inputTel" type="tel" name="tel3" minlength='4' maxlength='4' pattern="[0-9]+" value="${tel[2] }" >
                 <input type="hidden" name="tel">
                 </c:otherwise>
		       </c:choose></td>
	    </tr>
	    <tr>
	       <td ><p align="left">?????????</td>
		       <td align="left"><p>
		       <c:choose>
		       	<c:when test="${empty vo.phone }">
					<select name="phone1" id="inputTel" class="tel2">
                        <option value="" selected="selected">??????</option>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="018">018</option>
                        <option value="017">017</option>
                        <option value="019">019</option>
	                  </select>- 
	                  <input id="inputTel" type="tel" name="phone2" minlength='3' maxlength='4' pattern="[0-9]+" readonly>- 
	                  <input id="inputTel" type="tel" name="phone3" minlength='4' maxlength='4' pattern="[0-9]+" readonly>
	                  <input type="hidden" name="phone">
		       	</c:when>
		       	<c:otherwise>
		       		<select name="phone1" id="inputTel" class="tel2">
                        <option value="" selected="selected">??????</option>
                        <option value="010" <c:if test="${phone[0] eq '010' }">selected</c:if>>010</option>
                        <option value="011" <c:if test="${phone[0] eq '011' }">selected</c:if>>011</option>
                        <option value="016" <c:if test="${phone[0] eq '016' }">selected</c:if>>016</option>
                        <option value="018" <c:if test="${phone[0] eq '018' }">selected</c:if>>018</option>
                        <option value="017" <c:if test="${phone[0] eq '017' }">selected</c:if>>017</option>
                        <option value="019" <c:if test="${phone[0] eq '019' }">selected</c:if>>019</option>
	                  </select>- 
	                  <input id="inputTel" type="tel" name="phone2" minlength='3' maxlength='4' pattern="[0-9]+" value="${phone[1]}" >- 
	                  <input id="inputTel" type="tel" name="phone3" minlength='4' maxlength='4' pattern="[0-9]+" value="${phone[2]}" >
                 <input type="hidden" name="phone">
                 </c:otherwise>
		       </c:choose></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="left">?????????</td>
	       <td align="left"><p>
	       <input type="text" name="emailId" id="inputEmail" value="${email[0]}">@
	       <input type="text" name="emailAddress" id="inputEmail" value="${email[1] }" readonly>
	       <select name="emailAddresList">
	       	<option value="">????????????</option>
	       	<option value="naver.com" <c:if test="${email[1] eq 'naver.com'}"> selected </c:if>>naver.com</option>
	       	<option value="hanmail.net" <c:if test="${email[1] eq 'hanmail.net'}"> selected </c:if>>hanmail.net</option>
	       	<option value="gmail.com" <c:if test="${email[1] eq 'gmail.com'}"> selected </c:if>>gmail.com</option>
	       	<option value="kakao.com" <c:if test="${email[1] eq 'kakao.com'}"> selected </c:if>>kakao.com</option>
	       	<option value="nate.com" <c:if test="${email[1] eq 'nate.com'}"> selected </c:if>>nate.com</option>
	       	<option value="yahoo.co.kr" <c:if test="${email[1] eq 'yahoo.co.kr'}"> selected </c:if>>yahoo.co.kr</option>
	       </select>
	       <input type="hidden" name="email" ></td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="right">???????????? ??????</td>
	       <td align="left" ><p>
	       <input type="checkbox" name="subscription" value="T" onclick='checkOnlyOne(this)'>??????&nbsp;&nbsp;
			<input type="checkbox" name="subscription" value="F" onclick='checkOnlyOne(this)'>?????????</td>
	    </tr>
	    <tr>
	       <td style="padding-right: 3%;"><p align="left">?????????</td>
	       <td align="left" ><p><input type="text" name="companyName" id="companyName" value="${vo.companyName }" readonly>&nbsp;&nbsp;&nbsp;
	       <a onclick="popup()" id="button" >??????</a></td>
	    </tr>
	    <tr>
	       <td ></td>
	       <td ></td>
	    </tr>
	</table>
	<div style="width: 90%; margin-top: 30px;">
		<h1  class="text_center"><input type="submit" id="enrollButton" value="??????">&nbsp;&nbsp;
		<input type="button" onclick="history.back()" value="??????"></h1>
	</div>
	</form>
	</div>
</body>
</html>