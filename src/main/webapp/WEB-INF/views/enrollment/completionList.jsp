<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
.cls1 {
	text-decoration: none;
}

.cls2 {
	text-align: center;
	font-size: 30px;
}

.content:after {
	content: "";
	display: block;
	border-bottom: teal 1px solid #bcbcbc;
}



.button:link {
	text-decoration: none;
	color : black;
	border : 1px solid;
	padding : 2px 4px;
}

#dynamicCompany {

}

</style>
<meta charset="UTF-8">
<title>수료관리</title>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	/* function fn_articleForm(isLogOn,courseForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=courseForm;
	  }else{
	    alert("로그인 후 과정 등록이 가능합니다.")
	    location.href=loginForm+'?action=/course/courseForm.do';
	  }
	} */

	$(function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	})

	$(document).on("click", '#selectAll', function() {
		$('#selectAll').click(function() {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	});
</script>

<script type="text/javascript">
	function goPrint(MyPrint, print){
     var sw=screen.width;
     var sh=screen.height;
     var w=800;//팝업창 가로길이
     var h=600;//세로길이
     var xpos=(sw-w)/2; //화면에 띄울 위치
     var ypos=(sh-h)/2; //중앙에 띄웁니다.
     var title='ggggg'; //중앙에 띄웁니다.
 
     var pHeader="<html><head><link rel='stylesheet' type='text/css' href='/Exp_admin/css/print.css'><title>" + title + "</title></head><body>";
     var pgetContent=document.getElementById("print").innerHTML + "<br>";
     //innerHTML을 이용하여 Div로 묶어준 부분을 가져옵니다.
     var pFooter="</body></html>";
     pContent=pHeader + pgetContent + pFooter; 
      
     pWin=window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes"); //동적인 새창을 띄웁니다.
     pWin.document.open(); //팝업창 오픈
     pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
     pWin.document.close(); //클로즈
     pWin.print(); //윈도우 인쇄 창 띄우고
     pWin.close(); //인쇄가 되던가 취소가 되면 팝업창을 닫습니다.
    }
</script>
<body>
	<form id="searchFrm">
		<select id="searchType"><option value="">선택</option>
			<option value="comName">회사명</option>
			<option value="contractName">담당자</option></select> <input type="text"
			id="search" style="width: 100px; margin-right: 20px;"><input
			type="submit" value="검색" id="searchSubmit">
	</form>

	<div id="print">
		<table align="center" border="0" width="80%" id="dynamicCompany">
			<tr height="15" align="center" id="attr">
				<td><input type="checkbox" id="selectAll"></td>
				<td><b>아이디</b></td>
				<td><b>이름</b></td>
				<td><b>전화번호</b></td>
				<td><b>이메일</b>
				<td><b>소속회사</b></td>
				<td><b>과정명</b></td>
				<td width="80px"><b>이수</b></td>
				<td><b>이수일</b></td>
				<td><b>신청일</b></td>
			</tr>
			<c:choose>
				<c:when test="${completionList ==null }">
					<tr height="10">
						<td colspan="4">
							<p align="center">
								<b><span style="font-size: 9pt;">등록된 회사가 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${completionList !=null }">
					<c:forEach var="enrollment" items="${completionList }"
						varStatus="enrdNum">
						<tr class="test" align="center">
							<td><input type="checkbox"></td>
							<td><a href="#">${enrollment.memberVO.id }</a></td>
							<td class="content">${enrollment.memberVO.name }</td>
							<td class="content">${enrollment.memberVO.phone }</td>
							<td>${enrollment.memberVO.email }</td>
							<td>${enrollment.memberVO.companyName }</td>
							<td>${enrollment.syllabusVO.name }</td>
							<td><a class="button" href="javascript:goPrint('MyPrint', 'print')">출력</a></td>
							<td>${enrollment.completeDate }</td>
							<td>${enrollment.joinDate }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>
	<!-- 등록 버튼 추가해야함 -->
	<%-- <a  class="cls1"  href="javascript:fn_articleForm('${isLogOn}','${contextPath}/company/companyForm.do', 
                                                    '${contextPath}/member/loginForm.do')"><p class="cls2">회사등록하기</p></a> --%>

</body>
</html>