<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 관리</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
	// modal 창 띄우기
	$(document).ready(function() {
		$("#Grant_manager").click(function(){
			$("#modal").attr("style", "display:block");
		});
		$("#Revoke_manager").click(function(){
			$("#modal_Two").attr("style", "display:block");
		});
		// 닫기버튼
		$("#close").click(function(){
	        $("#modal").attr("style", "display:none");
	        
	        $('input:checkbox[name="authorization"]').prop("checked", false);
	        
	    });
		$("#close_Two").click(function(){
			$("#modal_Two").attr("style", "display:none");
			$('input:checkbox[name="authorization"]').prop("checked", false);
		});
	});
	
	// 전송하기
	function Grant(){
		document.grantForm.action = '/manager/authorization';
		document.grantForm.submit();
	}
	// 전송하기
	function Revoke(){
		document.revokeForm.action = '/manager/authorization';
		document.revokeForm.submit();
	}
	
</script>
<h1>권한 관리</h1>
현재 사용자 : ${manager.name} 님
<button type="button" onclick="location.href='${path}/manager/logout.do'">로그아웃하기</button>
<div>
	<button type="button" id="Grant_manager">관리자 권한 부여하기</button>
	<button type="button" id="Revoke_manager">관리자 권한 해제하기</button>
</div>
<!-- 관리자 권한 부여하기 -->
<div id="modal">
    <div class="modal_content">
    	<div class="modal-header">
    		일반 관리자 리스트
    		<button type="button" class="close" id="close">&times;</button>
    	</div>
    	<form name="grantForm" method="post">
        	<div class="modal-body">
        		<div style="visibility:hidden">
        			<input type="checkbox" name="authorization" value="일반관리자(개인정보 조회 가능)" checked/>
        			<input type="checkbox" name="authorization" value="상위관리자(모든정보 조회 가능)" checked/>
        		</div>
        		
        		<c:forEach var="manager" items="${authorization}">
        			<input type="checkbox" name="Nomalauthorization" value="${user.user_id}" />${user.user_id}(${user.user_name})
        		</c:forEach>
        	</div>
      		<div class="modal-last">
        		<input type="button" class="btn btn-white btn-right" onclick="Grant()" value="부여하기" />
        	</div>
        </form>
    </div>
    <div class="modal_layer"></div>
</div>
<!-- 관리자 권한 해제하기 -->
<div id="modal_Two">
    <div class="modal_content">
    	<div class="modal-header">
    		관리자 리스트
    		<button type="button" class="close" id="close_Two">&times;</button>
    	</div>
    	<form name="revokeForm" method="post">
        	<div class="modal-body">
        		<div style="visibility:hidden">
        			<input type="checkbox" name="UserAuth" value="1" checked/>
        			<input type="checkbox" name="AdminAuth" value="1" checked/>
        		</div>
        		
        		<c:forEach var="user" items="${totalAdminUser}">
        			<input type="checkbox" name="AdminAuth" value="${user.user_id}" />${user.user_id}(${user.user_name})
        		</c:forEach>
        	</div>
      		<div class="modal-last">
        		<input type="button" class="btn btn-white btn-right" onclick="Revoke()" value="해제하기" />
        	</div>
        </form>
    </div>
    <div class="modal_layer"></div>
</div>
</body>
</html>