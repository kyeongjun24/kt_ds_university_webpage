<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
<title>만족도조사 등록창</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">

function checkOnlyOne(element) {
	const checkboxes = document.getElementsByName("state");
	checkboxes.forEach((cb) => {
		  cb.checked = false;
		})
	element.checked = true;
}


</script>
 <title>만족도조사 등록창</title>
</head>
<body>
<h1 style="text-align:center">등록창</h1>
  <form name="satisfactionForm" method="post" action="${contextPath}/satisfaction/addSatisfaction.do" id=registerFrm>
   	 <table border="0" align="left">
	    
	    <tr>
			<td align="right" >제목: </td>
			<td colspan="2"><input type=text size="67"  maxlength="500" name="title" /></td>
		</tr>
		<tr>
			<td align="right" >강의코드: </td>
			<td colspan="2"><input type=text size="67"  maxlength="500" name="crsId" /></td>
		</tr>
	 	<tr>
			<td align="right" valign="top"><br>글내용: </td>
			<td colspan=2><textarea name="contents" rows="10" cols="65" maxlength="4000"></textarea> </td>
     	</tr>
     	
     	<tr>
			<td align="right" valign="top"><br>URL링크: </td>
			<td colspan=2><textarea name="url" rows="4" cols="65" maxlength="2000"></textarea> </td>
     	</tr>
     	
     	<tr>
	       <td width="200"><p align="right">개설 상태</td>
	       <td width="400"><p><input type="checkbox" name="state" id="state" value="활성" onclick='checkOnlyOne(this)' >활성&nbsp;&nbsp;
	       					  <input type="checkbox" name="state" id="state" value="비활성" onclick='checkOnlyOne(this)' checked>비활성</td>
	    </tr>
 
	    <tr>
	      <td align="center"> </td>
	      <td colspan="2">
	       <input type=submit value="글쓰기"/>
	       <input type=button value="목록보기" onClick="history.back()" />
	      </td>
     </tr>
    </table>
  </form>
</body>
</html>
