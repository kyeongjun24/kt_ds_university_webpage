<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수요조사 수정창</title>
<style>
   .text_center{
     text-align:center;
   }
   
   .modEvent_security_log_content{
   width : 500px;
   height : 200px;
   }
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	
	
function checkOnlyOne(element) {
	const checkboxes = document.getElementsByName("text");
	checkboxes.forEach((cb) => {
		  cb.checked = false;
		})
	element.checked = true;
}
	
	
</script>

</head>
<body>
	<form method="post"   action="${contextPath}/event_security_log/modEvent_security_log.do" id=updateFrm>
	<h1  class="text_center">수요조사 수정창</h1>
	<table  align="center" >
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><input type="text" name="id" id="id" value="${vo.user }" readonly></td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">이벤트 타입</td>
	      <td width="400"><input type="text" name="type" id="type" value="${vo.type }"></td>
	    </tr>
	    
	    <tr>
			<td align="right" valign="top"><br>로그 텍스트: </td>
			<td colspan=2><input class="modEvent_security_log_content" name="contents" rows="10" cols="65" maxlength="4000" value="${vo.text }"></input>
			
     	</tr>
	    
	    
	    
	    
	    
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><input type="submit" value="수정하기"><input type="reset" value="다시입력" id="reset"><input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	</form>
</body>
</html> --%>