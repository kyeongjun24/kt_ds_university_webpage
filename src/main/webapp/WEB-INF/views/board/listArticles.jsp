<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
 
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
 <style>
 
.article_category{
text-align : left;
margin-bottom : 3em;
color : grey
}

.listArticles_listFilter{
display : flex;
justify-content : flex-end;
width: 100%;
}

.listArticles_searchBox{
margin: 5px;
}

#listArticles_searchFrm{
display: flex;
justify-content : space-between;
width: 95%;
}

select {
margin : 5px;
}

.listArticles_table{
border: 0px; 
align: center;  
width : 95%;
}

.listArticles_titleValue{
text-align : left;
padding-top : 10px;
padding-bottom : 10px;
}

.listArticles_titleValue a{
color : black;
}

.listArticles_titleValue a:hover{
color : blue;
}

.listArticle_button {
display : flex;
justify-content: flex-end;
width: 95%;
margin-top: 5px;
}



</style>
<meta charset="UTF-8">
<title>글목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>

	//체크 된 걸 가져오는 함수
	function getCheckList() {
		if (confirm('정말 삭제하시겠습니까?') == true ){
			var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
 			var arr = new Array();
			$("input:checkbox[type=checkbox]:checked").each(function(index) {
 			arr.push($(this).attr('id'));
		})
		if(length == 0){
			alert("선택된 값이 없습니다.");
			return false;
		} else {
			$.ajax({
				type: 'post',
				url: '${contextPath}/board/removeCheckedArticles.do',
				traditional : true, //Array 형태로 보내려면 설정 해줘야함 */
				data: {arr: arr},			
				success: function(data) {
					window.location.href = "${contextPath}/board/listArticles.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}";
				}, error:function(data,request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		             
		        	}
				})
			}
		} else {
		return;
		}
	}
	
	// 전체 체크되게 하는 함수
	$(function(){
		$('#selectAll').click(function(){
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else{
				$("input[type=checkbox]").prop("checked", false);
			}
		})	
		
		// searchType 과 searchText에 따른 page 수 
		$('#listFilter')
						.on(
								'change',
								function() {
									var perPage = $(this).val();
									var searchType = document.getElementById('searchType').value;
									var searchText = document.getElementById('searchText').value;
									location.href = "${contextPath}/board/listArticles.do?&perPage="
											+perPage
											+ "&searchType="
											+ searchType
											+ "&searchText="
											+ searchText;
								})
	})
	
</script>
	
<body>

<% 
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
%>
<!-- 로그인 세션 처리 -->

<div class= "article_category">
	<h5><span onclick="location.href='${contextPath}/board/listArticles.do'"
			style="cursor: pointer;">게시판관리</span> > <span
			onclick="location.href='${contextPath}/board/listArticles.do'"
			style="cursor: pointer;"> 공지사항</span></h5>
</div>

	<form method="get" action="${contextPath}/board/listArticles.do" id="listArticles_searchFrm" accept-charset="utf-8" >
	
		<!-- 리시트 필터 값 적용 -->
		<div class="listArticles_listFilter">
			<select name="perPage" id="listFilter">
			
				<c:if test="${perPage == '10' }">
					<option value='10' selected>10개</option>
					<option value='20'>20개</option>
					<option value='50'>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '20' }">
					<option value='10'>10개</option>
					<option value='20' selected>20개</option>
					<option value='50'>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '50' }">
					<option value='10'>10개</option>
					<option value='20'>20개</option>
					<option value='50' selected>50개</option>
					<option value='100'>100개</option>
				</c:if>
				<c:if test="${perPage == '100' }">
					<option value='10'>10개</option>
					<option value='20'>20개</option>
					<option value='50'>50개</option>
					<option value='100' selected>100개</option>
				</c:if>
				
			</select>
	
			<!-- 검색 유형 값(title만)에 따라 셀렉트 띄우는 값 설정 -->
			<select class= "listArticles_searchType" name="searchType" id="searchType">
				<c:if test="${searchType == 'title'}">
					<option value="title" selected>제목</option>
					<option value="contents">내용</option>
				</c:if>
				<c:if test="${searchType == 'contents'}">
					<option value="title">제목</option>
					<option value="contents" selected>내용</option>
				</c:if>
				<c:if test="${empty searchType }">
					<option value="title" selected >제목</option>
					<option value="contents">내용</option>
				</c:if>
			</select>
		
			<!-- 검색 값이 있냐 없냐에 따라 값 뛰우는거 설정 -->
			<c:choose>
				<c:when test="${searchText != null }">
					<input class="listArticles_searchBox" type="text" name="searchText" id="searchText" value="${searchText }">
				</c:when>
				<c:otherwise>
					<input class="listArticles_searchBox" type="text" name="searchText" id="searchText">
				</c:otherwise>
			</c:choose>
			<input type="submit" value="검색" style="cursor: pointer; margin: 5px;">
		</div>
	</form>

	<div class="listArticle_button">
		<button type="button" onclick="location.href='${contextPath}/board/addArticleForm.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'" style=" width: 8%; margin-right: 5px; background-color:#E91B23; color:#efefef; cursor:pointer;" >등록</button>
		<button type="button" onclick='getCheckList()'style="width: 8%;" >삭제</button>
	</div>

	<table class = "listArticles_table">
		<tr>
			<td><input type="checkbox" id="selectAll"></td>
			<td><b>번호</b></td>
			<td class="listArticles_title"><b>제목</b></td>  
			<td><b>조회수</b></td>
			<td><b>등록일</b></td>
		</tr>
		
		<c:choose>
			
			<c:when test="${empty articlesList }" >
				<tr height="10">
					<td colspan="5">
						<p align="center">
						<b><span style="font-size:12pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>  
				</tr>
			</c:when>
			<c:when test="${articlesList != null }" >
				<c:forEach var="board" items="${impArticlesList }">
					<tr align="center">
						<td><input type="checkbox" name="selectedCheckbox" id="${board.id }"></td>
						
						<td width="10%"><h4 style="color: red;">${board.important}</h4></td>
						
							<td class='listArticles_titleValue'><a href="${contextPath}/board/selectArticle.do?id=${board.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${board.title}</a>
								<c:if test="${board.file == 'T'}">
									<a href="${contextPath}/board/selectArticle.do?id=${board.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}" ><img style="width: 20px; margin-bottom: -5px;" src="${contextPath}/resources/image/diskette.png"></a>
								</c:if>
								<c:if test="${board.file == 'F'}">
								</c:if>
							</td>
						
						<td>${board.hits}</td>
						
						<td>${board.joinDate}</td>
					</tr>
				</c:forEach>
				
				<c:forEach 	var="board" items="${articlesList }" varStatus="boardNum" >  
					<tr align="center">
						<td><input type="checkbox" name="selectedCheckbox" id="${board.id }"></td>
						<td width="10%">${board.id - 69999}</td>

						
						<td class='listArticles_titleValue'><a href="${contextPath}/board/selectArticle.do?id=${board.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${board.title}</a>
							<c:if test="${board.file == 'T'}">
								<a href="${contextPath}/board/selectArticle.do?id=${board.id}&page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}" ><img style="width: 20px; margin-bottom: -5px;" src="${contextPath}/resources/image/diskette.png"></a>
							</c:if>
								<c:if test="${board.file == 'F'}">
							</c:if>
						</td>
						
						<td>${board.hits}</td>
						<td>${board.joinDate}</td>
					</tr>
				</c:forEach>  
			</c:when>
		</c:choose>
	</table>

 	 <div class="listArticle_button">
     	<button type="button" onclick="location.href='${contextPath}/board/addArticleForm.do?page=${page}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}'" style="width: 8%; margin-right: 5px; background-color:#E91B23; color:#efefef; cursor:pointer;" >등록</button>
     	<button type="button" onclick='getCheckList()'style="width: 8%;" >삭제</button>
     </div>
     	
     <!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
	<div class="pageNumber" align="center" style="width: 80%;">
		<ul>
			<c:if test="${pageMaker.prev }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/board/listArticles.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/board/listArticles.do?page=${pageMaker.startPage - 1 }&searchText=${searchText}&searchType=${searchType}">이전</a></li>
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
							href="${contextPath }/board/listArticles.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="idx">
						<li
							<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>>
							<a
							href="${contextPath }/board/listArticles.do?page=${idx}&searchText=${searchText}&searchType=${searchType}&perPage=${perPage}">${idx }</a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<li><a
							href="${contextPath}/board/listArticles.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${contextPath}/board/listArticles.do?page=${pageMaker.endPage + 1 }&searchText=${searchText}&searchType=${searchType}">다음</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>
     
</body>
</html>