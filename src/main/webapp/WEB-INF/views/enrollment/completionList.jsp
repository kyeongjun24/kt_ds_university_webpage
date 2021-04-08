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
  <title>수료관리</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	/* function fn_articleForm(isLogOn,courseForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=courseForm;
	  }else{
	    alert("로그인 후 과정 등록이 가능합니다.")
	    location.href=loginForm+'?action=/course/courseForm.do';
	  }
	} */
	
	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
		
		/* 검색기능 수정해야함 */
		/* $('#searchSubmit').on('click', function(){
			var searchText = $('#search').val();
			var searchType = $('#searchType').val();
			var comName = '';
			var contractName = '';
			
			
			if (searchType == 'comName') {
				comName = searchText;
			} else if (searchType == 'contractName') {
				contractName = searchText;
			}
			
			if (comName != '' || contractName != ''){
				alert(contractName);
				alert(searchType);
				
				$.ajax({
					type: 'post',
					url:'${contextPath}/company/listBySearch.do',
					data: 'contractName='+contractName+'&comName='+comName,
					
					success: function(result){
						
						if (result.length > 0) {
							var str = '<tr align="center" bgcolor="lightgreen">';
							str += '<td><input type="checkbox" id="selectAll"></td><td ><b>상태</b></td><td><b>회사명</b></td><td><b>담당자</b></td><td><b>전화번호</b></td><td><b>사업자등록번호</b></td><td><b>등록 / 수정일</b></td></tr>';
							for (var i = 0; i<result.length; i++){
								str += '<tr><td><input type="checkbox"></td>';
								str += '<td>'+result[i].contractStat+'</td>';
								str += '<td>'+result[i].comName+'</td>';
								str += '<td>'+result[i].contractName+'</td>';
								str += '<td>'+result[i].managerPhone+'</td>';
								str += '<td>'+result[i].comId+'</td>';
								str += '<td>'+result[i].modDate+'</td>';
								}
								$('#dynamicCompany').html(str);
								
							} else{ $('#dynamicCompany').html(''); }
		
					}, error:function(result,request,status,error){
			             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			             
			        }
				})
				return false;
			}
			
		}) */
	})
	
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
     <td><b>이수</b></td>
     <td><b>이수일</b></td>
     <td><b>신청일</b></td>
  </tr>
<c:choose>
  <c:when test="${completionList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 회사가 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  <c:when test="${completionList !=null }" >
   <c:forEach  var="enrollment" items="${completionList }" varStatus="enrdNum" >
	    <tr align="center">
		<td><input type="checkbox"></td>
		<td width="15%">${enrollment.memberVO.id }</td>
		<td align='left'  width="20%">
		  <span style="padding-right:10px"></span>
		  <a href="#">${enrollment.memberVO.name }</a>
		 </td>
		 <td>${enrollment.memberVO.phone }</td>
		 <td>${enrollment.memberVO.email }</td> 
		 <td>${enrollment.memberVO.companyName }</td>
		 <td>${enrollment.syllabusVO.name }</td>
		 <td>${enrollment.stat }</td>
		 <td>${enrollment.completeDate }</td>
		 <td>${enrollment.joinDate }</td>
		</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>
<button type="button" style="width: 5%;">등록</button>
<button type="button" style="width: 5%;">삭제</button>
<!-- 등록 버튼 추가해야함 -->
<%-- <a  class="cls1"  href="javascript:fn_articleForm('${isLogOn}','${contextPath}/company/companyForm.do', 
                                                    '${contextPath}/member/loginForm.do')"><p class="cls2">회사등록하기</p></a> --%>
</body>
</html>