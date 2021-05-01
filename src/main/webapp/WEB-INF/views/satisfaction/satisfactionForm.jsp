<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 
<html>
	<head>
		<meta charset="UTF-8">
		<title>만족도조사 등록창</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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

		<style type="text/css">
			#registerFrm {
				flex-direction: column;
				display: flex;
				align-items: center;
				margin-top: 2em;
			}

			.satisfactionForm_table {
				width: 55%;
			}

			.satisfactionForm_button {
				position: relative;
				left: 1.6em;
				top: 3em;
				margin-bottom: 7em;
			}

			#satisfaction_textarea {
				background-color: #ececec;
				border: none;
				border-radius: 0.6em;
				left: -0.4em;
				position: relative;
				width: 36em;
			}

			#state {
				zoom: 1.5;
				margin-right: 0.4em;
			}
		</style>


	</head>

	<body>
		<h1 style="text-align:center">등록창</h1>
		<form name="satisfactionForm" method="post" action="${contextPath}/satisfaction/addSatisfaction.do" id=registerFrm>
			<table class="satisfactionForm_table">

				<tr>
					<td align="right">제목: </td>
					<td colspan="2"><input style="width: 36em;" type=text size="67" maxlength="500" required name="title" />
					</td>
				</tr>
				<tr>
					<td align="right">강의코드: </td>
					<td colspan="2"><input style="width: 36em;" type=text size="67" maxlength="500" required name="crsId" />
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><br>글내용: </td>
					<td colspan=2><textarea id="satisfaction_textarea" name="contents" rows="10" cols="65" required
							maxlength="4000"></textarea> </td>
				</tr>

				<tr>
					<td align="right" valign="top"><br>URL링크: </td>
					<td colspan=2><textarea id="satisfaction_textarea" name="url" rows="4" cols="65" required
							maxlength="2000"></textarea> </td>
				</tr>

				<tr>
					<td width="200">
						<p align="right">개설 상태
					</td>
					<td colspan=2 style="display: flex; justify-content: center;"><input type="checkbox" name="state"
							id="state" value="활성" onclick='checkOnlyOne(this)'>
						<p>활성</p>&nbsp;&nbsp;
						<input type="checkbox" name="state" id="state" value="비활성" onclick='checkOnlyOne(this)' checked>
						<p>비활성</p>
					</td>
				</tr>
			</table>
			<div class="satisfactionForm_button">
				<input style="background-color:#e91b23;" type=submit value="등록" />
				<input style="margin-left: 1em;" type=button value="취소" onClick="history.back()" />
			</div>
		</form>
	</body>
</html>
