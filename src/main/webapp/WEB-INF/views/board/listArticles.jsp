<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
 <style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
  </style>
  <meta charset="UTF-8">
  <title>글목록창</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function fn_articleForm(isLogOn,articleForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=articleForm;
	  }else{
	    alert("로그인 후 글쓰기가 가능합니다.")
	    location.href=loginForm+'?action=/board/articleForm.do';
	  }
	}
</script>

<script>
	//체크 된 걸 가져오는 함수
	function getCheckList() {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		alert(length);
		var arr = new Array();
		$("input:checkbox[type=checkbox]:checked").each(function(index) {
			/* alert($(this).attr('id')); */
			arr.push($(this).attr('id'));
		})
		
		if(length == 0){
			alert("선택된 값이 없습니다.");
			return false;
		} else{
			$.ajax({
				type: 'post',
				url: '${contextPath}/member/removeCheckedMembers.do',
				traditional : true, //Array 형태로 보내려면 설정 해줘야함
				data: {arr : arr},
				
				success: function(data) {
					alert('데이터 받기 성공');
					alert(data);
					window.location.href = "${contextPath}/member/listMembers.do";
				}, error:function(data,request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		             
		        }
			})
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
		
		
	}) //function
</script>
	
<body>
	<table align="center"  width="100%">
	<tr height="10" align="center"  bgcolor="white">
	<td><input type="checkbox" id="selectAll"></td>
     	<td ><b>번호</b></td>
     	<td ><b>제목</b></td>  
     	<td ><b>조회수</b></td>
     	<td ><b>등록일</b></td>
     </tr>
     
     <c:choose>
      <c:when test="${articlesList ==null }" >
    		<tr  height="10">
      			<td colspan="4">
         			<p align="center">
            		<b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
        			</p>
      			</td>  
    		</tr>
  		</c:when>
  		<c:when test="${articlesList !=null }" >
   			<c:forEach 	var="board" items="${articlesList }" varStatus="boardNum" >  
   			<tr align="center">
   				<td><input type="checkbox" name="selectedCheckbox" id="${member.id }"></td>
      			<td width="10%">${boardNum.count}</td>
      			<td align='center' width="30%">
	  				<span style="padding-right:10px" ></span>
      				<a class='cls1' href="${contextPath}/board/selectArticle.do?id=${board.id}">${board.title}</a>
      			</td>
      			<td>${board.hits}</td>
      			<td>${board.joinDate}</td>
    		</tr>
  			</c:forEach>  
  		</c:when>
  		</c:choose>
     	</table>
     	<button type="button" onclick="location.href='${contextPath}/board/articleForm.do'" style="width: 5%;">등록</button>
</body>
</html>
<%-- <body>
<table align="center" border="0"  width="80%"  >
  <tr height="10" align="center"  bgcolor="lightgreen">
     <td ><b>글번호</b></td>
     <td ><b>작성자</b></td>              
     <td ><b>제목</b></td>
     <td ><b>작성일</b></td>
  </tr>
<c:choose>
  <c:when test="${articlesList ==null }" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  <c:when test="${articlesList !=null }" >
    <c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >
     <tr align="center">
	<td width="5%">${articleNum.count}</td>
	<td width="10%">${article.title }</td>
	<td width="10%">${article.hits }</td>
	<td width="10%">${article.joinDate }</td>
	<td align='left'  width="35%">
	  <span style="padding-right:30px"></span>
	   <c:choose>
	      <c:when test='${article.level > 1 }'>  
	         <c:forEach begin="1" end="${article.level }" step="1">
	              <span style="padding-left:20px"></span>    
	         </c:forEach>
	         <span style="font-size:12px;">[답변]</span>
                   <a class='cls1' href="${contextPath}/board/viewArticle.do?id=${article.id}">${article.title}</a>
	          </c:when>
	          <c:otherwise>
	            <a class='cls1' href="${contextPath}/board/viewArticle.do?id=${article.id}">${article.title }</a>
	          </c:otherwise>
	        </c:choose>
	  </td>
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>
<!-- <a  class="cls1"  href="#"><p class="cls2">글쓰기</p></a> -->
<a  class="cls1"  href="javascript:fn_articleForm('${isLogOn}','${contextPath}/board/articleForm.do', 
                                                    '${contextPath}/member/loginForm.do')"><p class="cls2">글쓰기</p></a>
</body>
</html> --%>