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
		transform: translateX(320px);
	}
	.completionText {
		position: absolute;
		transform: translateY(-204px);
	}
	header, #sidebar-left, #footer, .completionButton {
		display: none;
	}
	#completionImg {
	width: 800px;
	height: 1132.1px;
	position: absolute;
	transform: translateY(-100px); 
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
	width: 630px;
	top: 16em;
}

 #completionImg {
	width: 800px;
	height: 1132.1px;
	z-index: 10;
}

.completion_serial {
	font-size: 20px;
	text-align: left;
}

.completion_main {
	font-size: 65px;
	margin: 55px;
	letter-spacing: 25px;
}

.completion_info {
	text-align: left;
}

.completion_info ul {
	list-style: none;
	font-size: 20px;
}

.completion_info ul li {
	margin: 4px;
}

.completion_content {
	margin: 40px;
	word-spacing: 6px;
	font-size: 28px;	
}

.completion_date {
	margin: 60px;
	font-size: 20px;
}

#completion_logo {
	margin: 10px;
	/* width : 282.17px;
	height : 48px; */
}

.completion_ceo {
	margin: 10px;
	font-size: 23px;
}

.completionButton {
	margin : 50px;
}

.completionButton > input {
	width : 90px;
	height: 40px;
	font-size : 18px;
}

#compl_name {
	letter-spacing: 73px;
}

#compl_companyName {
	letter-spacing: 28px;
}

#compl_slb_name {
	letter-spacing: 5px;
}

#compl_crs_date {
	letter-spacing: 13px;
}
</style>

</head>
<body>
	<div id="printme">
		<div class="completionPrint">
			<img id="completionImg" alt=""
				src="${contextPath}/resources/image/completion8.jpg">
			<div class="completionText">
				<div class="completion_serial">ktds ${enrollmentVO.syllabusVO.type }과정 제 ${enrollmentVO.id }호</div>
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
				<div id="completion_logo">
					<img src="${contextPath}/resources/image/completionLogo3.png">
				</div>
				<div class="completion_ceo">
					대표이사 <span style="font-size: 28px;">우 정 민</span>
				</div>
			</div>
		</div>
	</div>
	<div class="completionButton">
		<input style="background : #E91B23;"type="button" value="출력" onclick="window.print()" /> <input
			type="button" onclick="history.back()" value="취소">
	</div>
</body>
</html>