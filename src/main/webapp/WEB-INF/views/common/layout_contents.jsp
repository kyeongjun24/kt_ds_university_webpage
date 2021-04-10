<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap')
	;

* {
	font-family: 'Noto Sans KR', sans-serif;
}

#sidebar-left {
	width: 200px;
	float: left;
	height : 88vh;
	background-color: #e3e3e3;
	border-right: 0.5px solid #bcbcbc;
	font-size: 10px;
	text-align: center;
	justify-content: center;
	background-color: #e3e3e3;
	border-right: 0.5px solid #bcbcbc;
	font-size: 10px;
	text-align: center;
	display: flex;
	justify-content: center;
}

h1 {
	
}

.side ul {
	margin-top: 30px;
}

.side ul li {
	list-style: none;
}

.side ul li a {
	font-size: 15px;
	color: black;
}

.side_title {
	padding: 30px;
	width: 170px;
	border-bottom: 0.5px solid #bcbcbc;
}

#container {
	margin: 0px;
	padding: 0px;
	display: block;
}

#content {
	width: 85%;
	position: absolute;
	left: 250px;
	top: 200px;
	diplay: flex;
	justify-content: center;
	text-align: center;
}

#footer {
	clear: both;
	background-color: #F2F2F2;
	text-align: center;
	height: 5vh;
	align-items: center;
	justify-content: center;
	display: flex;
}

#attr {
	border-bottom: 2px solid #bcbcbc;
}

a {
	text-decoration: none;
}

table {
	width: 1500px;
	border-collapse: collapse;
}

td {
	padding-bottom: 5px;
	border-bottom: 0.3px solid;
	border-color: #9C9D9D;
}

.pageNumber {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	position : absolute;
	left : 100px;
	margin-top : 20px;
}

.pageNumber ul {
	list-style-type: none;
	display: flex;
}

/* .pageNumber ul li {
   float: left;
} */
.pageNumber ul li a {
	color: black;
	font-weight: 400;
	padding: 5px 15px;
}

input[type=submit] {
border : none;
width : 60px;
height : 35px;
font-size: 15px;
background-color : #969696;
color : #EFEFEF;
}

input[type=text] {
border : none;
width : 200px;
height : 35px;
background-color: #ECECEC;
margin-right: 10px;
}
select {
border : none;
width : 90px;
height : 35px;
background-color: #ECECEC;
font-size: 13px;
margin-right: 10px;
}

#enrollButton {
background-color: #E91B23;
color : #EFEFEF;
}

button {
margin-left : 20px;
width : 90px;
height : 35px;
border : none;
border-radius : 5px;
background-color: #ECECEC;
font-size: 15px;
}

.memberButton {
position : relative;
margin-top : 60px;
width : 1500px;
display : flex;
justify-content: flex-end;
}

#searchFrm {
display : flex;
justify-content: space-between;
width : 1500px;
margin-bottom : 20px;
}

</style>
<title><tiles:insertAttribute name="title" /></title>
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="sidebar-left">
			<tiles:insertAttribute name="side" />
		</div>
		<div id="content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>