<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"
 %>
 <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
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
		
		#content {
			width: 85%;
			position: absolute;
			diplay: flex;
			justify-content: center;
			text-align: center;
		}
		
		a {
			text-decoration: none;
		}
		
		.pageNumber {
			display: flex;
			align-items: center;
			justify-content: center;
			text-align: center;
			/* position : absolute;
			left : 50px; */
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
		
		table {
			width: 500px;
		}
		
    </style>
    <title><tiles:insertAttribute name="title" /></title>
  </head>
    <body>
      <div id="content">
          <tiles:insertAttribute name="body"/>
      </div>
  </body>
</html>