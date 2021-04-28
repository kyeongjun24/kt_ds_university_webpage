<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세 접수내용</title>
<style>
   .text_center{
     text-align:center;
   }
   
   .process {
	text-align: left;
	color: #9C9D9D;
	margin-bottom: 2em;
	}
	
	td:nth-child(2n-1) {
		background-color: #b3b3b3;
        color: #f2f2f2;
	}
	
	td:nth-child(2n) {
        color: #4d4d4d;
        text-align: left;
        padding-left:60px;
	}
	
	#lastTd {
		border-style: hidden;
		background-color: #ffffff;
	}
	
	.erollmentMember_table {
		border-bottom: 0.3px solid;
		border-color: rgba(156, 157, 157, 0.2);
		width : 75%;
	}
	
	.searchButton {
	  background-color: #969696;
	  border: none;
	  border-radius: 5px;
	  color: #EFEFEF;
	  padding: 5px 12px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 15px;
	  cursor: pointer; 
	}
	
	#stat {
		background-color: #ffffff;
	  	border: none;
	  	width : 100px;
	}
	
	#companyName, #datepicker1 {
		width : 180px;
	}
	
		
	
</style>
</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	
	//팝업창
	function popup(){
		var url = "${contextPath}/company/popUp.do";
		var name = "popup test";
		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
	
	//달력
	$(function() {
        //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
        	dateFormat: 'yymmdd' //Input Display Format 변경
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
           ,changeYear: true //콤보박스에서 년 선택 가능
           ,changeMonth: true //콤보박스에서 월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "${contextPath}/resources/image/calendar.png" //버튼 이미지 경로
           ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
           ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
           ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
           ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                        
        });

        //datepicker로 선언
        $("#datepicker1").datepicker();
        
        //시작 날짜 초기값을 오늘 날짜로 설정
        //$('#datepicker1').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

    }); 

	//datepicker1 = 수료일
    //stat = 상태
    /* $('#stat').on('keyup', function() {
		var completeDate = document.getElementByName('completeDate').value;
		var stat = this.value;
		
		if (completeDate != null && stat != '수료') {
			$('#pwCheck').html('수료 상태가 아니면 수료일을 입력할 수 없습니다.').css('color','red');
			return;
		} else {
			$('#pwCheck').html('정상').css('color','blue');
		}
		
	}) */
	
	//삭제 안내창
	function deleteConfirm(){
		
		if(!confirm("삭제 하시겠습니까?")){
			return false;
		}else{
			location.href="${contextPath}/enrollment/deleteEnrollment.do?id=${enrollmentVO.id }";
		}
	}
	
</script>
<body>

	<div class="process">
		<h4>
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;">수강관리</span> > 
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;"> 수강신청내역</span> >
			<span onclick="window.location.reload()"
				style="cursor: pointer;"> 상세내역(회원)</span>
		</h4>
	</div>
	
	<form method="post" action="${contextPath}/enrollment/modEnrollment.do">
	<table class="erollmentMember_table" align="center" border="1">
	   <tr>
	      <td width="200"><p align="center">성명</td>
	      <td width="400">${enrollmentVO.memberVO.name }</td>
	      <td width="200"><p align="center">아이디</td>
	      <td width="400" colspan='2'>${enrollmentVO.memId }</td>
	   </tr>
	   
	    <tr>
	      <td><p align="center">연락처</td>
	      <td>${enrollmentVO.memberVO.phone }</td>
	      <td><p align="center">이메일</td>
	      <td colspan='2' width="400">${enrollmentVO.memberVO.email }</td>
	    </tr>
	    <tr> 
	      <td><p align="center">접수일</td>
	      <td>${enrollmentVO.joinDate }</td>
	      <td><p align="center">현재상태</td>
	      <td>
	      
	      <input type="text" id="stat" value="${enrollmentVO.stat }" readonly>
	      
	      
	       <select name="stat" onchange="document.getElementById('stat').value = this.options[this.selectedIndex].value" >
	       		<option value="." disabled selected>현재상태</option>
	       		<option value="신청">신청</option>
	       		<option value="승인">승인</option>
	       		<option value="취소">삭제</option>
	       		<option value="수료">수료</option>
	       </select></td>
	    </tr>
	    <tr>
	       <td><p align="center">회사정보</td>
	       
	       <td>
	       <input type="text" name="memberVO.companyName" id="companyName" value="${enrollmentVO.memberVO.companyName }" readonly>
	       <a class="searchButton" 	type="button" onclick="popup()" >수정</a></td>  
	       
	       <td><p align="center">수료일</td>
	       <td colspan='2'>
	       <input type="text" name="completeDate" id="datepicker1" placeholder="수료일을 선택하세요." value="${enrollmentVO.completeDate }" readonly><br>
	       <span id="pwCheck"></span></td>
	    </tr>
	</table>
	
	<table class="erollmentMember_table" align="center" border="1">
		<tr>
	      <td width="200"><p align="center">강좌명</td>
	      <td colspan='3' width="1000">${enrollmentVO.syllabusVO.name }</td>
	    </tr>
	    <tr>
	       <td width="200"><p align="center">보고용 강좌명</td>
	      <td colspan='3' width="1000">${enrollmentVO.syllabusVO.reportName }</td>
	    </tr>
	    <tr>
	      <td width="200"><p align="center">강좌유형 / 분류</td>
	      <td width="400">${enrollmentVO.syllabusVO.type } / 
	      		<c:choose>
	      			<c:when test="${empty enrollmentVO.syllabusVO.category }">
	      				<font color="red">미기재</font>
	      			</c:when>
	      			<c:otherwise>
	      				${enrollmentVO.syllabusVO.category }
	      			</c:otherwise>
	      		</c:choose>
	      </td>
	      <td width="200"><p align="center">수강신청일</td>
	      <td width="400">${enrollmentVO.courseVO.crsrsdate } ~ ${enrollmentVO.courseVO.crsredate }</td>
	   	</tr>
	    <tr>
	      <td ><p align="center">교육기간</td>
	      <td>${enrollmentVO.courseVO.startDate } ~ ${enrollmentVO.courseVO.endDate }</td>
	      <td><p align="center">강의시간</td>
	      <td>
	      		<c:choose>
	      			<c:when test="${empty enrollmentVO.courseVO.startTime || empty enrollmentVO.courseVO.endTime }">
	      				<font color="red">미기재</font>
	      			</c:when>
	      			<c:otherwise>
	      				${enrollmentVO.courseVO.startTime } ~ ${enrollmentVO.courseVO.endTime }
	      			</c:otherwise>
	      		</c:choose>
	      </td>
	   	</tr>
	   	<tr>
	      <td><p align="center">강의실 정보</td>
	      <td>${enrollmentVO.courseVO.classroom } 호</td>
	      <td><p align="center">수강인원수</td>
	      <td>${enrollmentVO.courseVO.capacity } 명</td> 
	   	</tr>
	   	<tr>
	      <td><p align="center">교육일수</td>
	      <td>${enrollmentVO.syllabusVO.days } 일</td>
	      <td><p align="center">교육시간</td>
	      <td>${enrollmentVO.syllabusVO.time } 시간</td>
	   	</tr>
		<tr>
	      <td style="display:none;"><input type="text" name="id" id="id" value="${enrollmentVO.id }"  readonly></td>
	      <td style="display:none;"><input type="text" name="memberVO.id" id="memberVO.id" value="${enrollmentVO.memberVO.id }"  readonly></td>
	   	</tr>
		<tr>
			<td id="lastTd" colspan="4" width="250">
				<input type="submit" id="enrollButton" value="수정">&nbsp;&nbsp;&nbsp;
				<button type="button" onclick="deleteConfirm()">삭제</button>&nbsp;&nbsp;&nbsp;
				<input type="button" onclick="location.href='${contextPath}/enrollment/listEnrollments.do'" value="목록"></td>
		</tr>
	</table>
	
	</form>
</body>
</html>