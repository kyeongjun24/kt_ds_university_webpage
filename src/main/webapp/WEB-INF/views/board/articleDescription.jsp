<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />   

<!DOCTYPE html>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<html>
<head>


<style>

td{
text-align: left;
}

.articleDes_category{
text-align : left;
margin-bottom : 3em;
color : grey
}

.articleDes_BigTitle{
text-align : center;
margin-bottom : 50px;
}

.articleDes_table{
width: 70%; 
margin-left: auto; 
margin-right: auto;
} 

.articleDes_important{
width: 10%;
}

.articleDes_id{
text-align: left;
width: 150%;
}

.articleDes_joinDate{
}

.articleDes_title{
padding-top : 10px;
padding-bottom : 10px;
}

.articleDes_fileDown a{
color : black;
}

.articleDes_fileDown a:hover{
color : blue;
}
.articleDes_fileDown{
float: right;
border : none ;
padding-top : 10px;
}

.articleDes_joinDate {
margin-left : 45em;
}

.articleDes_contents{
padding-top: 10px;
white-space: pre-line;
}

.articleDes_buttons{
display:flex;
justify-content: flex-end;
margin-top: 20px;
margin-bottom: 20px;
width: 85%;
}
</style>

<meta charset="UTF-8">
<title >게시판 상세 설명</title>
</head>

<script type="text/javascript">

	//제거할 때 되묻는 함수
	function ask_removeArticle() {

		if (confirm('정말 삭제하시겠습니까?') == true ){
			window.location.href = "${contextPath}/board/removeArticle.do?id=${vo.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}";
		} else {
			return ;
		}
	}

</script>

<body>
<%
  request.setCharacterEncoding("UTF-8");
%> 
	<div class= "articleDes_category">
		<h4>게시판관리 > 공지사항 > ${vo.id - 69999}</h4>
	</div>
	
	<div class="articleDes_BigTitle">
		<h1>공지사항</h1>
	</div>
 	
 	<input type="hidden" name="id" value="${vo.id }">
	
	<table class = "articleDes_table">
			<tr>
				<td class="articleDes_important">
				<c:if test="${vo.important == '공지'}">
	      			<a style="color: red; font-weight : bold;">${vo.important}</a>
	      		</c:if>
	      		<c:if test="${vo.important == null}">
	      			<a>일반</a>
	      		</c:if>
	      		</td>
				<td class="articleDes_id">번호 : <a style="text-align: left;"> ${vo.id - 69999}</a><a class="articleDes_joinDate">작성일 : ${vo.joinDate}</a></td>
	      	</tr>
	      	
	      	<tr>
	      		<td><a>제목</a></td>
	      		<td class="articleDes_title">${vo.title}</td>
			</tr>
			
			<tr>
				<td style="border:none;"></td>
				<c:if test="${filevo.name != null}">
					<td class ="articleDes_fileDown"> 파일 : <a href="${contextPath}/articleFileDown.do?filename=${filevo.name}&id=${vo.id}" > ${filevo.name }</a></td>
				</c:if>
				<c:if test="${filevo.name == null}">
					<td class ="articleDes_fileDown"></td>
				</c:if>	
			</tr>
			<tr>	
				<td style="border:none; padding-line: 0px;">내용</td>
				<td class="articleDes_contents" style="border:none;">${vo.contents}</td>
			</tr>
	</table>
			
			<div class="articleDes_buttons">
		 		<button type="button" onclick="location.href='${contextPath}/board/modArticleForm.do?id=${vo.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'" style="width: 8%; background-color:#E91B23; color:#efefef; cursor:pointer;">수정</button>&nbsp;&nbsp;&nbsp;
		 		<button type="button" onclick="ask_removeArticle()" style="width: 8%;">삭제</button>&nbsp;&nbsp;&nbsp;
				<button type="button" onclick="location.href='${contextPath}/board/listArticles.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'" style="width: 8%;">목록</button>
			</div>
			
</body>
</html>