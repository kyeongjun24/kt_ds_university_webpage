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
<meta charset="UTF-8">
<title>수료증 출력</title>
<style>
@media only print {
	.completionPrint {
		position: absolute;
	}
	.completionText {
		position: absolute;
		transform: translateY(-100px);
	}
	header, #sidebar-left, #footer, .completionButton {
		display: none;
	}
}

@font-face {
	font-family: 'DX';
	src: url('${contextPath}/resources/font/DXSJStd-B.otf')
		format('opentype');
	font-weight: Medium;
	font-style: Regular;
}

.completionPrint {
	display: flex;
	justify-content: center;
	font-family: 'DX';
}

.completionText {
	position: absolute;
	z-index: 11;
	width: 430px;
	top: 175px;
}

#completionImg {
	width: 559px;
	height: 786px;
	z-index: 10;
}

.completion_serial {
	font-size: 14px;
	text-align: left;
}

.completion_main {
	font-size: 40px;
	margin: 55px;
	letter-spacing: 25px;
}

.completion_info {
	text-align: left;
}

.completion_info ul {
	list-style: none;
	font-size: 14px;
}

.completion_info ul li {
	margin: 4px;
}

.completion_content {
	margin: 40px;
	word-spacing: 4px;
}

.completion_date {
	margin: 30px;
	font-size: 14px;
}

.completion_logo {
	margin: 10px;
}

.completion_ceo {
	margin: 10px;
	font-size: 14px;
}

#compl_name {
	letter-spacing: 58px;
}

#compl_companyName {
	letter-spacing: 23px;
}

#compl_slb_name {
	letter-spacing: 5px;
}

#compl_crs_date {
	letter-spacing: 11px;
}
</style>

<script type="text/javascript">
	function onPrint()
	{
		const html = document.querySelector('html');
		const printContents = document.querySelector('.completionPrint').innerHTML;
		const printDiv = document.createElement("DIV");
		printDiv.className = "print-div";

		html.appendChild(printDiv);
		printDiv.innerHTML = printContents;
		window.print();
		printDiv.style.display = 'none';
	}
</script>
</head>
<body>
	<div id="printme">
		<div class="completionPrint">
			<img id="completionImg" alt=""
				src="${contextPath}/resources/image/completion.png">
			<div class="completionText">
				<div class="completion_serial">ktds ${enrollmentVO.syllabusVO.type }과정 제 2021030001호</div>
				<div class="completion_main">수료증</div>
				<div class="completion_info">
					<ul>
						<li><span id="compl_name">성</span>명 :
							${enrollmentVO.memberVO.name }</li>
						<li><span id="compl_companyName">회사</span>명 :
							${enrollmentVO.memberVO.companyName }</li>
						<li><span id="compl_slb_name">훈련과정</span>명 :
							${enrollmentVO.syllabusVO.name }</li>
						<li><span id="compl_crs_date">훈련기</span>간 :
							${enrollmentVO.courseVO.startDate } ~
							${enrollmentVO.courseVO.endDate }</li>
					</ul>
				</div>
				<div class="completion_content">위 사람은 상기 국가인적자원개발 컨소시엄 과정을
					수료하였으므로 이 증서를 수여합니다.</div>
				<div class="completion_date">${enrollmentVO.completeDate }</div>
				<div class="completion_logo">
					<img src="${contextPath}/resources/image/completionLogo2.png">
				</div>
				<div class="completion_ceo">
					대표이사 <span style="font-size: 16px;">우 정 민</span>
				</div>
			</div>
		</div>
	</div>
	<div class="completionButton">
		<input type="button" value="출력" onclick="window.print()" /> <input
			type="button" onclick="history.back()" value="취소">
	</div>
</body>
</html>