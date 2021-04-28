<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>만족도조사 수정창</title>
<style>
   .text_center{
     text-align:center;
   }
   
   .modSatisfaction_content{
   width : 500px;
   height : 200px;
   }
</style>

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

</head>
<body>
	<form method="post"   action="${contextPath}/satisfaction/modSatisfaction.do" id=updateFrm>
	<h1  class="text_center">만족도조사 수정창</h1>
	<table  align="center" >
	   <tr>
	      <td width="200"><p align="right">아이디</td>
	      <td width="400"><input type="text" name="id" id="id" value="${vo.id }" readonly></td>
	   </tr>
	   <tr>
	      <td width="200"><p align="right">제목</td>
	      <td width="400"><input type="text" name="title" id="title" value="${vo.title }"></td>
	    </tr>
	    
	    <tr>
	      <td width="200"><p align="right">강의 코드</td>
	      <td width="400"><input type="text" name="crsId" id="crsId" value="${vo.crsId }"></td>
	    </tr>
	    
	    <tr>
			<td align="right" valign="top"><br>글내용: </td>
			<td colspan=2><input class="modSatisfaction_content" name="contents" rows="10" cols="65" maxlength="4000" value="${vo.contents }"></input>
			<%-- <input type="text" name="contents" id="contents" value="${vo.contents }"> </td> --%>
     	</tr>
	    
	    <tr>
	      <td width="200"><p align="right">URL링크</td>
	      <td width="400"><input type="text" name="url" id="url" value="${vo.url }"></td>
	    </tr>
	   
	    <tr>
	       <td width="200"><p align="right">개설 상태</td>
	       <td width="400"><p><input type="checkbox" name="state" id="state" value="활성" onclick='checkOnlyOne(this)'>활성&nbsp;&nbsp;
	       					  <input type="checkbox" name="state" id="state" value="비활성" onclick='checkOnlyOne(this)' checked>비활성</td>
	    </tr>
	    
	    
	    <tr>
	       <td width="200"><p>&nbsp;</p></td>
	       <td width="400"><input type="submit" value="수정하기"><input type="reset" value="다시입력" id="reset"><input type="button" onclick="history.back()" value="취소"></td>
	    </tr>
	</table>
	</form>
</body>
</html>