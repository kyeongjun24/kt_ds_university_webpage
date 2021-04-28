<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>로그 등록창</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
 <title>로그 등록창</title>
</head>
<body>
<h1 style="text-align:center">등록창</h1>
  <form name="event_security_logForm" method="post" action="${contextPath}/event_security_log/addEvent_security_log.do" id=registerFrm>
   	 <table border="0" align="left">
	    
	    <tr>
			<td align="right" >아이디: </td>
			<td colspan="2"><input type=text size="67"  maxlength="500" name="user" /></td>
		</tr>
	 	<tr>
			<td align="right" valign="top"><br>타입: </td>
			<td colspan=2><textarea name="type" rows="10" cols="65" maxlength="4000"></textarea> </td>
     	</tr>
     	
     	<tr>
			<td align="right" valign="top"><br>텍스트: </td>
			<td colspan=2><textarea name="text" rows="4" cols="65" maxlength="2000"></textarea> </td>
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
 --%>