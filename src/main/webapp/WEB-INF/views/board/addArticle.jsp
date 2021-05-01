<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 


<!DOCTYPE html>
 <% request.setCharacterEncoding("UTF-8"); %>

<html>

<head>
	<meta charset="UTF-8">
	<title>게시판 글 추가</title>
	<style>
		.addArticle_category {
			text-align: left;
			margin-bottom: 1em;
			color: grey
		}

		.addArticle_BigTitle {
			margin-bottom: 20px;
		}

		.addArticle_table {
			width: 70%;
			margin-left: auto;
			margin-right: auto;
		}

		.addArticle_important {}

		.addArticle_importantTd {
			text-align: left;
		}

		.addArticle_checkBox {
			margin-bottom: 5px;
			font-size: 1em;
		}

		.addArticle_title {
			padding-top: 10px;
			padding-bottom: 10px;
		}

		.addArticle_titleTd {
			text-align: left;
		}

		.addArticle_titleBox {
			margin-top: 5px;
			margin-bottom: 5px;
			background-color: #ECECEC;

		}

		.addArticle_contentsTd {
			text-align: left;
		}

		.addArticle_contentsBox {
			width: 800px;
			margin-top: 10px;
			margin-bottom: 10px;
			background-color: #ECECEC;
			white-space: pre-line;
			border: none;
		}

		.addArticle_fileTd {
			text-align: left;
		}

		.addArticle_attachFile {
			vertical-align: baseline;
			padding-top: 10px;
			padding-bottom: 10px;
		}

		.addArticle_buttons {
			padding-top: 10px;
			display: right;
			padding-bottom: 10px;

		}
	</style>
	<title>글쓰기창</title>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">

		// 전 페이지로 이동
		function backToList(obj) {
			obj.action = "${contextPath}/board/listArticles.do?searchText=${searchText}&searchType=${searchType}&perPage=${perPage}";
			obj.submit();
		}

		$(document).ready(function () {

			$('#addArticleForm').submit(function () {
				if (confirm('정말 등록하시겠습니까?') == true) {
					return true;
				} else {
					return false;
				}
			})
		})

	</script>
	<title>글쓰기창</title>
</head>

<body>
	<%request.setCharacterEncoding("UTF-8");%>

		<div class="addArticle_category">
			<h5><span onclick="location.href='${contextPath}/board/listArticles.do'"
					style="cursor: pointer;">게시판관리</span> > <span
					onclick="location.href='${contextPath}/board/listArticles.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'"
					style="cursor: pointer;">공지사항</span> > <span
					onclick="location.href='${contextPath}/board/addArticleForm.do?page=${page}&searchText=${searchText }&searchType=${searchType }&perPage=${perPage }'"
					style="cursor:pointer;">공지사항 등록</span></h5>
		</div>

		<div class="addArticle_BigTitle">
			<h2>공지사항 등록</h2>
		</div>

		<?xml version="1.0" encoding="utf-8"?>
		<form name="addArticleForm" id="addArticleForm" method="POST"
			action="${contextPath}/board/addNewArticle.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}"
			enctype="multipart/form-data" accept-charset="utf-8">

			<table class="addArticle_table">

				<tr class="addArticle_important">
					<td>공지</td>
					<td class="addArticle_importantTd"><input class="addArticle_checkBox" type="checkbox"
							name="important" value="공지">&nbsp;공지로 설정&nbsp;&nbsp;</td>
				</tr>

				<tr class="addArticle_title">
					<td>제목</td>
					<td class="addArticle_titleTd"><input class="addArticle_titleBox" type="text" size="500"
							maxlength="500" name="title" style="width:800px;"
							oninvalid="this.setCustomValidity(제목을 쓰시오.)" oninput="this.setCustomValidity('')"
							required /></td>
				</tr>

				<tr class="addArticle_contents">
					<td>내용</td>
					<td class="addArticle_contentsTd"><textarea class="addArticle_contentsBox" name="contents" rows="25"
							cols="105" maxlength="4000" wrap="hard" oninvalid="this.setCustomValidity(제목을 쓰시오.)"
							oninput="this.setCustomValidity('')" required></textarea></td>
				</tr>

				<tr class="addArticle_file">
					<td>파일첨부</td>
					<td class="addArticle_fileTd"><input class="addArticle_attachFile" type="file" size="67"
							maxlength="500" name="fileName" /></td>
				</tr>
			</table>

			<div class="addArticle_buttons">
				<input type="submit" value="등록" style="background-color:#E91B23; color:#efefef; margin-right: 6px; cursor:pointer;" />
				<input type="button" value="취소" onClick="backToList(this.form)" />
			</div>

		</form>
</body>

</html>