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
  <title>글목록창</title>
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
		
		//지울거임
		$('#searchSubmit').on('click', function(){
			var searchText = $('#search').val();
			var searchType = $('#searchType').val();
			var comName = '';
			var contractName = '';
			
			/* alert(searchText);
			alert(searchType); */
			
			if (searchType == 'comName') {
				comName = searchText;
				/* alert('name : '+name); */
			} else if (searchType == 'contractName') {
				contractName = searchText;
				/* alert('companyName : '+companyName); */
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
			
		})
	})

</script>
<body>
<form id="searchFrm">
	<select id="searchType"><option value="">선택</option><option value="comName">회사명</option><option value="contractName">담당자</option></select>
	<input type="text" id="search" style="width: 100px; margin-right: 20px;"><input type="submit" value="검색" id="searchSubmit">
</form>
<table align="center" border="0"  width="80%" id="dynamicCompany" >
  <tr height="15" align="center" id="attr">
     <td><input type="checkbox" id="selectAll"></td>    
     <td><b>번호</b></td>     
     <td ><b>상태</b></td>
     <td><b>회사명</b></td>
     <td><b>담당자</b></td>
     <td><b>전화번호</b>
     <td><b>사업자등록번호</b></td>
     <td><b>등록 / 수정일</b></td>
  </tr>
<c:choose>
  <c:when test="${companiesList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 회사가 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  <c:when test="${companiesList !=null }" >
    <c:forEach  var="company" items="${companiesList }" varStatus="articleNum" >
     <tr align="center">
	<!--<td width="5%">${articleNum.count}</td>  -->
	<td><input type="checkbox"></td>
	<td>${articleNum.count }</td>
	<td width="15%">${company.contractStat }</td>
	<td align='left'  width="20%">
	  <span style="padding-right:10px"></span>
	  <a class='cls1' href="${contextPath}/company/selectCompany.do?comId=${company.id}">${company.name }</a>
	 </td>
	 <td>${company.contractName }</td>
	 <td>${company.managerPhone }</td>
	 <td>${company.id }</td>
	 <td>${company.modDate }</td>
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>
<button type="button" onclick="location.href=" style="width: 5%;">등록</button>
<button type="button" onclick="location.href=" style="width: 5%;">삭제</button>
<!-- 등록하기 function 추가해야함 -->
<%-- 'fn_articleForm('${isLogOn}','${contextPath}/company/companyForm.do', 
'${contextPath}/member/loginForm.do')'; --%>

</body>
</html>