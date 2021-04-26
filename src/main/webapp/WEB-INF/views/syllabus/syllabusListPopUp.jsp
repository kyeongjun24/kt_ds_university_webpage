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
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	window.onfocus=function(){
	}
	
	window.onload=function(){
		window.focus();
		window.moveTo(3,0);
		window.resizeTo(510, auto);
		window.scrollTo(0,0)
	}
	
	function setSyllabusName(name, index) {
		var name = $(name).text();
		var slbId = document.getElementById('slbId'+index).value;
		var bannerImg = document.getElementById('bannerImg'+index).value;
		var reportName = document.getElementById('reportName'+index).value;
		opener.document.getElementById('syllabusName').value = name;
		opener.document.getElementById('slbId').value = slbId;
		opener.document.getElementById('imgArea').src = '${contextPath}/resources/image/'+slbId+'/'+bannerImg;
		window.close();
	}
	
	$(function(){
		$('#listFilter').on('change',
			function() {
				var perPage = $(this).val();
				var searchType = document
						.getElementById('searchType').value;
				var searchText = document
						.getElementById('searchText').value;
				location.href = "${contextPath}/syllabus/searchSyllabusByPopUp.do?perPage="
						+ perPage
						+ "&searchType="
						+ searchType
						+ "&searchText="
						+ searchText;
			})//listFilter
		
	})
</script>
<body>
<%
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchType");
%>

	<div style="width: 520px; height: 500px;">
		<div style="width: 100%; height: 10%; background: red; text-align: center;">
			강의 계획서 리스트
		</div>
		<form method = "get" action="${contextPath }/syllabus/searchSyllabusByPopUp.do">
			
			<div style="width: 98%; height: 20%; background: green; margin: 2% 1%; ">
			
				<div class="listFilter">
					<select name="perPage" id="listFilter">
						<c:if test="${perPage == '10' || empty perPage }">
							<option value='10' selected>10</option>
							<option value='20'>20</option>
							<option value='30'>30</option>
						</c:if>
						
						<c:if test="${perPage == '20' }">
							<option value='10'>10</option>
							<option value='20' selected>20</option>
							<option value='30'>30</option>
						</c:if>
						
						<c:if test="${perPage == '30' }">
							<option value='10'>10</option>
							<option value='20'>20</option>
							<option value='30' selected>30</option>
						</c:if>
					</select>
				</div>
	
				<div class="searchType">
					<select name="searchType" id="searchType">
						<c:if test="${searchType == 'nameOfLecture' }">
							<option value="nameOfLecture">선택</option>
							<option value="nameOfLecture" selected>강의명</option>
						</c:if>
						<c:if test="${empty searchType }">
							<option value="nameOfLecture" selected>선택</option>
							<option value="nameOfLecture">강의명</option>
						</c:if>
					</select>
					
					<c:choose>
						<c:when test="${not empty searchText }">
							<input type="text" name="searchText" id="searchText"
								value="${searchText }">
						</c:when>
						<c:otherwise>
							<input type="text" name="searchText" id="searchText">
						</c:otherwise>
					</c:choose>
					<input type="submit" id="searchSubmit" value="검색">
				</div>
			</div>
		</form>
		
		<div style="width: 98%; height: auto; background: yellow; margin: 2% 1%">
			<table >
			<tr height="15" align="center" style="border-bottom: solid;">
			     <td><b>2차 분류</b></td>
			     <td><b>강의명</b></td>
			     <td><b>등록일</b></td>
			  </tr>
				<c:choose>
					  <c:when test="${empty syllabusesList }" >
					    <tr  height="10">
					      <td>
					         <p align="center">
					            <b><span style="font-size:9pt;">등록된 회사가 없습니다.</span></b>
					        </p>
					      </td>  
					    </tr>
					  </c:when>
					  <c:when test="${not empty syllabusesList }" >
					    <c:forEach  var="syllabus" items="${syllabusesList }" varStatus="statusNum">
					     <tr align="center">
							<td>${syllabus.courseCategoryVO.name }</td>
							<td align='left'  width="75%">
								<span style="padding-right: 10px"></span>
							  <a href='javascript:void(0);' onclick="setSyllabusName(this, ${statusNum.index});">${syllabus.name}</a>
							  <input type="hidden" id="slbId${statusNum.index }" value="${syllabus.id }">
							  <input type="hidden" id="bannerImg${statusNum.index }" value=${syllabus.bannerImg }>
							  <input type="hidden" id="reportName${statusNum.index }" value="${syllabus.reportName }">
							</td>
							<td>${syllabus.joinDate }</td>
						</tr>
					    </c:forEach>
				      </c:when>
				    </c:choose>
				</table>
			<div class="pageNumber" align="center" style="width: 80%; height: 10%;">
				<ul>
					<c:if test="${pageMaker.prev }">
						<c:choose>
							<c:when test="${not empty searchType and not empty searchText }">
								<li><a
									href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
									<a
									href="${contextPath }/syllabus/searchSyllabusByPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
								</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
									<a
									href="${contextPath }/syllabus/searchSyllabusByPopUp.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
						<c:choose>
							<c:when test="${not empty searchType and not empty searchText }">
								<li><a
									href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="${contextPath}/syllabus/searchSyllabusByPopUp.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</ul>
			</div>
		</div>
		<div style="width: 98%; height: 10%; background: gray; margin: 2% 1%;">
			<input type="button" value="창 닫기" onclick="window.close()">
		</div>
</div>
</body>
</html>