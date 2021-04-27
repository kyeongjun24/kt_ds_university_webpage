<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 상세창</title>
<style>
.title {
	padding-bottom: 30px;
	border-bottom: 0.3px solid;
	border-color: #9C9D9D;
}

input:focus {
	outline: none;
}

.process {
	text-align: left;
	padding-bottom: 50px;
	color: #9C9D9D;
}

#sel1, #sel2 {
	float: left;
	margin-left: 14%;
	width: 40%;
}

#t1 {
	float: left;
	margin-left: 4em;
	width: 40%;
	padding-left: 7px;
}

#address {
	float: left;
	margin-left: 4em;
	width: 85%;
	padding-left: 7px;
}

.td1 {
	border-bottom: none;
}

#company_mod {
	width: 1150px;
	border-spacing: 22px;
	height: 350px;
	margin: auto;
	margin-top: 70px;
}

.buttonZip {
	margin-top: 70px;
}

#rd {
	padding-left: 52px
}

#mod {
	background-color: #E91B23;
	color: #EFEFEF;
	cursor: pointer;
}

#num {
	width: 15%;
	padding-left: 7px;
}

.oNum {
	text-align: left;
	padding-left: 14%;
}

.td2 {
	border-bottom: none;
}

#search {
	float: left;
	width: 47px;
}

#zipCode {
	float: left;
	margin-left: 4em;
	width: 16%;
	padding-left: 7px;
}

#address {
	float: left;
	margin-left: 4em;
	padding-left: 7px;
	width: 50%;
}

#address2 {
	float: left;
	padding-left: 7px;
	width: 30%;
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* 주소 찾기 기능 사용하는 메소드 */
	function openZipSearch() {
		new daum.Postcode({
			oncomplete : function(data) {

				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var jibunAddr = data.jibunAddress; // 지번 주소 변수

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipCode').value = data.zonecode;
				if (roadAddr !== '') {
					document.getElementById("address").value = roadAddr;
				} else if (jibunAddr !== '') {
					document.getElementById("address").value = jibunAddr;
				}
			}
		}).open();
	}

	/* jquery로 상세창은 처음 들어왔을 땐 읽기 전용으로 만들고
	 수정을 클릭하면 읽기 전용에서 수정이 가능하도록 만들기 */

	/* 카운트 변수 선언*/
	var count = 0;

	$(document).ready(function() {
		$('input').prop('readonly', true);
		$('radio').prop('disabled', true);
		$('#sel1').prop('disabled', true);
		$('#sel2').prop('disabled', true);
		$("input[id=radio1]:radio").attr("disabled", "true");
		$("input[id=radio2]:radio").attr("disabled", "true");
		$('input').css('border', 'none');
		$('').css('border', 'none');
		$("#search").attr("disabled", true);
	});

	/* 수정 메소드 */
	function modify() {
		count++;
		if (count == 1) {
			$('input').prop('readonly', false);
			$('radio').prop('disabled', false);
			$('.regNum').prop('readonly', true);
			$('#sel1').prop('disabled', false);
			$('#sel2').prop('disabled', false);
			$("input[id=radio1]:radio").attr("disabled", "false");
			$("input[id=radio1]:radio").removeAttr("disabled");
			$("input[id=radio2]:radio").attr("disabled", "false");
			$("input[id=radio2]:radio").removeAttr("disabled");
			$("#mod").text("저장");
			$('input').css('border', "solid 1px");
			$('.regNum').css('border', 'none');
			$('#sel1').css('border', "solid 1px");
			$('#sel2').css('border', "solid 1px");
			$("#search").attr("disabled", false);
		} else {

			var registercheckfrm = document.companyForm;

			var tel1 = registercheckfrm.companyTel1.value;
			var tel2 = registercheckfrm.companyTel2.value;
			var tel3 = registercheckfrm.companyTel3.value;
			var companyTel = tel1 + '-' + tel2 + '-' + tel3;

			var id1 = registercheckfrm.id1.value;
			var id2 = registercheckfrm.id2.value;
			var id3 = registercheckfrm.id3.value;

			var mPhone1 = registercheckfrm.managerPhone1.value;
			var mPhone2 = registercheckfrm.managerPhone2.value;
			var mPhone3 = registercheckfrm.managerPhone3.value;
			var managerPhone = mPhone1 + '-' + mPhone2 + '-' + mPhone3;

			var address1 = registercheckfrm.address1.value;
			var address2 = registercheckfrm.address2.value;

			registercheckfrm.companyTel.value = companyTel;
			registercheckfrm.managerPhone.value = managerPhone;			
			if (confirm("수정하시겠습니까?") == true){
				document.companyForm.submit();
			} else {
				return false;
			}
		}
	};

	function del() {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			location.href = '${contextPath}/company/removeCompany.do?id=${companyVO.id }';
			self.location = "${contextPath}/company/listCompanies.do?"+"&perPageNum=${criteria.perPageNum}"+"&searchType=${criteria.searchType}"+"&searchText=${criteria.searchText}";
			
		} else {
			return false;
		}
	}

	/* 취소 메소드 */
	function cancel() {
		count++;
		if (count == 1) {
			history.back(-1);
		} else {
			$('input').prop('readonly', true);
			$('radio').prop('disabled', true);
			$('#sel1').prop('disabled', true);
			$('#sel2').prop('disabled', true);
			$("input[id=radio1]:radio").attr("disabled", "true");
			$("input[id=radio2]:radio").attr("disabled", "true");
			$('input').css('border', 'none');
			$("#mod").text("수정");
			$("#search").attr("disabled", true);
			if (confirm("정말 수정을 취소하시겠습니까?") == true) {
				history.back(-1);
			} else {
				history.go(0);
				return false;
			}
		}

	}
</script>
<body>
	<div class="process">
		<h4>
			<span onclick="location.href='${contextPath}/member/listMembers.do'"
				style="cursor: pointer;">회원관리</span> > <span
				onclick="location.href='${contextPath}/company/listCompanies.do'"
				style="cursor: pointer;"> 회사관리</span> > <span
				onclick="location.href='${contextPath}/company/companyForm.do?id=${companyVO.id }'"
				style="cursor: pointer;"> 회사수정</span>
		</h4>
	</div>
	<h1 class="title">회사 관리</h1>
	<form method="post" name="companyForm"
		action="${contextPath}/company/modCompany.do?type=${type}" id=modCheck>
		
		<input type="hidden" id="page" name="page" value="${criteria.page }"  />
		<input type="hidden" id="searchType" name="searchType" value="${criteria.searchType }"  /> 
		<input type="hidden" id="searchText" name="searchText" value="${criteria.searchText }"  />
		<input type="hidden" id="perPageNum" name="perPageNum" value="${criteria.perPageNum }" />
			
		<table id="company_mod">
			<tr>
				<td width="10%" class="td1"><p align="right">상태</p></td>
				<td width="20%" class="td1"><select name="contractStat" id=sel1
					required="required">
						<option value="">상태를 선택하세요</option>
						<option value="협력사"
							<c:if test="${companyVO.contractStat eq '협력사' }"> selected</c:if>>협력사</option>
						<option value="비협력사"
							<c:if test="${companyVO.contractStat eq '비협력사' }"> selected</c:if>>비협력사</option>
						<option value="협약 진행중"
							<c:if test="${companyVO.contractStat eq '협약 진행중' }"> selected</c:if>>협약
							진행중</option>
				</select>
				<td width="10%" class="td1"><p align="right">회사명</p></td>
				<td width="20%" class="td1"><input type="text" name="name"
					id=t1 value="${companyVO.name}"></td>
			</tr>

			<tr>
				<td width="10%" class="td1"><p align="right">대표번호</p></td>
				<td width="10%" class="td2">
					<div class="oNum">
						<input type="text" maxLength="3" name="companyTel1" id=num
							value="${fn:split(companyVO.companyTel, '-')[0]}">- <input
							type="text" maxLength="4" name="companyTel2" id=num
							value="${fn:split(companyVO.companyTel, '-')[1]}">- <input
							type="text" maxLength="4" name="companyTel3" id=num
							value="${fn:split(companyVO.companyTel, '-')[2]}"> <input
							type="hidden" name="companyTel">
					</div>
				</td>
				<td width="10%" class="td1"><p align="right">홈페이지</p></td>
				<td width="20%" class="td1"><input type="text" name="homePage"
					id=t1 value="${companyVO.homePage }"></td>
			</tr>

			<tr>
				<td width="10%" class="td1" rowspan="2"><p align="right">주소</p></td>
				<td width="20%" class="td1" colspan="1"><input type="text"
					id=zipCode name="zipCode" value="${companyVO.zipCode }">
					<button type="button" id=search name="search"
						onclick="openZipSearch()">검색</button></td>
				<td width="10%" class="td1" rowspan="2"><p align="right">사업자등록번호</p></td>
				<td width="20%" class="td2" rowspan="2">
					<div class="oNum">
						<input type="text" maxLength="3" name="id1" id=num class=regNum
							value="${fn:split(companyVO.id, '-')[0]}">- <input
							type="text" maxLength="2" name="id2" id=num class=regNum
							value="${fn:split(companyVO.id, '-')[1]}">- <input
							type="text" maxLength="5" name="id3" id=num class=regNum
							value="${fn:split(companyVO.id, '-')[2]}"> <input
							type="hidden" name="id" id="userId">
					</div>
				</td>
			</tr>

			<tr>
				<td width="20%" class="td1"><input type="text" id=address
					name="address1" value="${fn:split(companyVO.address, ',')[0] }">
					<input type="text" id=address2 name="address2"
					value="${fn:split(companyVO.address, ',')[1] }"> <input
					type="hidden" name="address"></td>
			</tr>



			<tr>
				<td width="10%" class="td1"><p align="right">담당자</p></td>
				<td width="20%" class="td1"><input type="text"
					name="contractName" id=t1 value="${companyVO.contractName }"></td>
				<td width="10%" class="td1"><p align="right">담당자전화번호</p></td>
				<td width="10%" class="td2">
					<div class="oNum">
						<input type="text" maxLength="3" name="managerPhone1" id=num
							value="${fn:split(companyVO.managerPhone, '-')[0]}">- <input
							type="text" maxLength="4" name="managerPhone2" id=num
							value="${fn:split(companyVO.managerPhone, '-')[1]}">- <input
							type="text" maxLength="4" name="managerPhone3" id=num
							value="${fn:split(companyVO.managerPhone, '-')[2]}"> <input
							type="hidden" name="managerPhone">
					</div>
				</td>
			</tr>

			<tr>
				<td width="10%" class="td1"><p align="right">담당자이메일</p></td>
				<td width="20%" class="td1"><input type="text"
					name="managerEmail" id=t1 value="${companyVO.managerEmail }"></td>
				<td width="10%" class="td1"><p align="right">협약업체 동의 구분</p></td>
				<td width="20%" class="td1" align="left"><p id="rd">
						<input type="radio" name="contractAgree" value="컨소시엄 협약"
							id="radio1"
							<c:if test="${companyVO.contractAgree eq '컨소시엄 협약' }">checked</c:if>>
						컨소시엄 협약 <input type="radio" name="contractAgree" value="컨소시엄 비협약"
							id="radio2"
							<c:if test="${companyVO.contractAgree eq '컨소시엄 비협약' }">checked</c:if>>
						컨소시엄 비협약</td>
			</tr>

			<tr>
				<td width="10%" class="td1"><p align="right">협약 상태 구분</p></td>
				<td width="20%" class="td1"><select name="contractType" id=sel2>
						<option value="">상태를 선택하세요</option>
						<option value="협약서 없음"
							<c:if test="${companyVO.contractType eq '협약서 없음' }"> selected</c:if>>협약서
							없음</option>
						<option value="상호 변경"
							<c:if test="${companyVO.contractType eq '상호 변경' }"> selected</c:if>>상호
							변경</option>
						<option value="협약 완료"
							<c:if test="${companyVO.contractType eq '협약 완료' }">selected</c:if>>협약
							완료</option>
						<option value="협약서 사본"
							<c:if test="${companyVO.contractType eq '협약서 사본' }"> selected</c:if>>협약서
							사본</option>
						<option value="탈퇴"
							<c:if test="${companyVO.contractType eq '탈퇴' }"> selected</c:if>>탈퇴</option>
				</select></td>
				<td width="10%" class="td1"><p align="right">수정일</p></td>
				<td width="20%" class="td1"><input type="text" readOnly
					name="modDate" id=t1 value="${companyVO.modDate }"></td>
			</tr>
		</table>

		<!-- 수정, 삭제 버튼 만들기 -->
		<div class=buttonZip>
			<button type="button" onclick="modify()" style="width: 5%;" id="mod">수정</button>
			<button type="button" onclick="del()" style="width: 5%;">삭제</button>
			<button type="button" onclick="cancel()" style="width: 5%;">취소</button>
		</div>
	</form>
</body>
</html>