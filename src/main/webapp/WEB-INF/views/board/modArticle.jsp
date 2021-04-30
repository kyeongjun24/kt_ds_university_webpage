<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
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
<title>게시판 글 수정</title>
<style>

.modArticle_category{
text-align : left;
margin-bottom : 1em;
color : grey
}

.modArticle_BigTitle{
margin-bottom : 20px;
}

.modArticle_table{
width: 70%; 
margin-left: auto; 
margin-right: auto;
}

.modArticle_important{
}

.modArticle_important_checkBox{
text-align : left;
}

.modArticle_titleBox{
}

.modArticle_contentsBox{
white-space: pre-line;
background-color : #ECECEC;
margin-top : 10px;
margin-bottom : 10px;
margin-left : 10px;
float : left;
border: none;
}

.modArticle_preFileTd{
text-align: left;
}

.modArticle_fileTd{
text-align: left;
}

.modArticle_attachfile{
vertical-align : baseline;
padding-top : 10px;
padding-bottom : 10px;
}

.modArticle_button{
padding-top: 20px;
padding-bottom: 20px;
display : right;

}

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	
<% 
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
%>	
	

	// 수정할 때 되묻는 함수
	$(document).ready(function(){	 
		$('#updateFrm').submit(function() {
			
			if (confirm('정말 수정하시겠습니까?') == true) {
				
			/* 	var page = $(this).val();
			var perPage = $(this).val();
			var searchType = document.getElementById('searchType').value;
			var searchText = document.getElementById('searchText').value; */
	        return true;
	        
	        } else {
	    
	        return false;
	        }
	     });
	});

</script>	

</head>

<body>



	<div class= "modArticle_category">
		<h5><span onclick="location.href='${contextPath}/board/listArticles.do'"
			style="cursor: pointer;">게시판관리</span> > <span onclick="location.href='${contextPath}/board/listArticles.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'"
			style="cursor: pointer;">공지사항</span> > <span onclick="location.href='${contextPath}/board/modArticleForm.do?page=${page}&searchText=${searchText }&searchType=${searchType }&perPage=${perPage }'"
			style="cursor:pointer;">공지사항 수정</span></h5>
	</div>

	<div class="modArticle_BigTitle">
		<h2>공지사항 수정</h2>
	</div>
	
	<form method="POST" id="updateFrm" action="${contextPath}/board/modArticle.do?id=${vo.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}" enctype="multipart/form-data" accept-charset="utf-8">
		
		<input type="hidden" name="id" value="${vo.id }">
		<input type="hidden" name="searchText" value="${searchText }">
		<input type="hidden" name="searchType" value="${searchType }">
		
		<table class="modArticle_table">
			
			<tr class="modArticle_important">
				<td>공지</td>
					<c:if test="${vo.important == '공지'}">
						<td class="modArticle_important_checkBox"><input type="checkbox" name="important" value="공지" checked >&nbsp;공지로 설정&nbsp;&nbsp;</td>
					</c:if>
					<c:if test="${vo.important == null}">
						<td class="modArticle_important_checkBox"><input type="checkbox" name="important" value="공지">&nbsp;공지로 설정&nbsp;&nbsp;</td>
					</c:if>
		   </tr>
			
		   <tr>
		      <td>제목</td>
		      <td><input type="text" name="title" maxlength="500" value="${vo.title }" class="modArticle_titleBox" style="width: 800px; float: left;" oninvalid="this.setCustomValidity(제목을 쓰시오.)" oninput = "this.setCustomValidity('')" required></td>
		   </tr>
		   
		   <tr>
		      <td>내용</td>
		      <td><textarea class = "modArticle_contentsBox" name="contents" rows="25" cols="105"  maxlength="4000" oninvalid="this.setCustomValidity(내용을 쓰시오.)" oninput = "this.setCustomValidity('')" required >${vo.contents }</textarea></td>
		   </tr>
		    
		    <tr>
		 		<td>기존파일</td>
		 		<td class="modArticle_preFileTd">${filevo.name }<input type="hidden" name="name" value="${filevo.name}"></td>
		 	</tr>
		    
		    <tr>
		      <td>파일첨부</td>
		      <td class="modArticle_fileTd"><input class = "modArticle_attachFile" type="file" name="uploadFile"></td>
		 	</tr>
		 	
		 </table>
	
		    <div class="modArticle_button">
		    	<input type="submit" value="수정" style="width: 8%; background-color:#E91B23; color:#efefef; cursor:pointer;">
		    	<input type="reset" value="재입력" id="reset" style="width: 8%;">
		    	<input type="button" onclick="history.back()" value="취소" style="width: 8%;">
		    </div>
	</form>
</body>
</html>