<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>

<head>
	<style>
		#herfId1:link,
		#herfId2:link {
			text-decoration: none;
			color: black;
		}

		#herfId1:visited,
		#herfId2:visited {
			text-decoration: none;
			color: black;
		}


		#herfId1:hover,
		#herfId2:hover {
			color: #c2c2c2;
		}

		.process {
			text-align: left;
			margin-bottom: 2em;
			color: #9C9D9D;
		}

		#type_color {
			font-size: 15px;
			width: 90%;
			display: flex;
			justify-content: space-between;
		}

		#type_color span {
			font-size: 0.9em;
			margin-right: 7px;
		}

		#excel {
			width: 7em;
			margin-left: 1em;
		}
	</style>
	<meta charset="UTF-8">
	<title>글목록창</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	// 전체 체크되게 하는 함수
	$(function () {
		$('#selectAll').click(function () {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})

		$('#listFilter').on(
			'change',
			function () {
				var perPage = $(this).val();
				var searchType = document
					.getElementById('searchType').value;
				var searchText = document
					.getElementById('searchText').value;
				location.href = "${contextPath}/enrollment/listEnrollments.do?perPage="
					+ perPage
					+ "&searchType="
					+ searchType
					+ "&searchText=" + searchText;
			})
	})

	//체크 된 걸 가져오는 함수
	function getCheckList(stat) {
		var length = $("input:checkbox[name='selectedCheckbox']:checked").length;
		var arr = new Array();
		$("input:checkbox[name='selectedCheckbox']:checked").each(
			function (index) {
				arr.push($(this).attr('id'));
			})

		if (length == 0) {
			alert("선택된 값이 없습니다.");
			return false;
		} else {

			// 상태 '취소완료' 로 변경
			if (stat == "delete") {

				if (!confirm("취소 하시겠습니까?")) {
					return false;
				} else {
					$.ajax({
						type: 'post',
						url: '${contextPath}/enrollment/modDeleteEnrollments.do',
						traditional: true, //Array 형태로 보내려면 설정 해줘야함
						data: {
							arr: arr
						},

						success: function (data) {
							window.location.href = "${contextPath}/enrollment/listEnrollments.do";
						},
						error: function (data, request, status, error) {
							alert("code:" + request.status + "\n"
								+ "message:" + request.responseText
								+ "\n" + "error:" + error);
						}
					})
				}

				// 상태 '승인' 으로 변경
			} else if (stat == "approve") {
				$.ajax({
					type: 'post',
					url: '${contextPath}/enrollment/modApproveEnrollments.do',
					traditional: true,
					data: {
						arr: arr
					},

					success: function (data) {
						window.location.href = "${contextPath}/enrollment/listEnrollments.do";
					},
					error: function (data, request, status, error) {
						alert("code:" + request.status + "\n"
							+ "message:" + request.responseText
							+ "\n" + "error:" + error);
					}
				})

				// 상태 '수료' 로 변경			
			} else if (stat == "complete") {
				$.ajax({
					type: 'post',
					url: '${contextPath}/enrollment/modCompleteEnrollments.do',
					traditional: true,
					data: {
						arr: arr
					},

					success: function (data) {
						window.location.href = "${contextPath}/enrollment/listEnrollments.do";
					},
					error: function (data, request, status, error) {
						alert("code:" + request.status + "\n"
							+ "message:" + request.responseText
							+ "\n" + "error:" + error);
					}
				})
			}
		}
	}

	$(document).on("click", '#selectAll', function () {
		$('#selectAll').click(function () {
			if ($("input:checkbox[id='selectAll']").prop("checked")) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})
	})

	//엑셀 다운로드 사유 입력 안하면 다운로드 불가능
	$(function () {
		$('.excelDownloadForm').submit(function () {

			var frm = document.excelForm;
			var log = frm.log.value;
			if (log == '') {
				alert('사유를 입력해주세요.');
				frm.log.focus();
				return false;
			}
			return true;
		})
	})

</script>

<body>
	<div class='process'>
		<h5>
			<span onclick="location.href='${contextPath}/enrollment/listEnrollments.do'"
				style="cursor: pointer;">수강관리</span> > <span
				onclick="location.href='${contextPath}/enrollment/listEnrollments.do'" style="cursor: pointer;">
				수강신청내역</span>
		</h5>
	</div>

	<!-- controller에서 보낸 값 받아서 저장 -->
	<% String searchType=request.getParameter("searchType"); String searchText=request.getParameter("searchType"); %>

		<form method="get" action="${contextPath}/enrollment/listEnrollments.do" id="searchFrm">

			<!-- 리시트 필터 값 적용 -->
			<div class="listFilter">
				<select name="perPage" id="listFilter">
					<c:if test="${perPage == '10' }">
						<option value='10' selected>10</option>
						<option value='20'>20</option>
						<option value='50'>50</option>
						<option value='100'>100</option>
					</c:if>
					<c:if test="${perPage == '20' }">
						<option value='10'>10</option>
						<option value='20' selected>20</option>
						<option value='50'>50</option>
						<option value='100'>100</option>
					</c:if>
					<c:if test="${perPage == '50' }">
						<option value='10'>10</option>
						<option value='20'>20</option>
						<option value='50' selected>50</option>
						<option value='100'>100</option>
					</c:if>
					<c:if test="${perPage == '100' }">
						<option value='10'>10</option>
						<option value='20'>20</option>
						<option value='50'>50</option>
						<option value='100' selected>100</option>
					</c:if>
				</select>
			</div>

			<!-- 검색 유형 값에 따라 셀렉트 띄우는 값 설정 -->
			<div class="searchType">
				<select name="searchType" id="searchType">
					<c:if test="${searchType == 'name' }">
						<option value="name" selected>이름</option>
						<option value="companyName">회사명</option>
						<option value="slbName">과정명</option>
						<option value="stat">상태</option>
					</c:if>
					<c:if test="${searchType == 'companyName' }">
						<option value="name">이름</option>
						<option value="companyName" selected>회사명</option>
						<option value="slbName">과정명</option>
						<option value="stat">상태</option>
					</c:if>
					<c:if test="${searchType == 'slbName' }">
						<option value="name">이름</option>
						<option value="companyName">회사명</option>
						<option value="slbName" selected>과정명</option>
						<option value="stat">상태</option>
					</c:if>
					<c:if test="${searchType == 'stat' }">
						<option value="name">이름</option>
						<option value="companyName">회사명</option>
						<option value="slbName">과정명</option>
						<option value="stat" selected>상태</option>
					</c:if>
					<c:if test="${empty searchType }">
						<option value="name">이름</option>
						<option value="companyName">회사명</option>
						<option value="slbName" selected>과정명</option>
						<option value="stat">상태</option>
					</c:if>
				</select>

				<!-- 검색 값이 있냐 없냐에 따라 값 뛰우는거 설정 -->
				<c:choose>
					<c:when test="${not empty searchText }">
						<input type="text" name="searchText" id="searchText" value="${searchText }">
					</c:when>
					<c:otherwise>
						<input type="text" name="searchText" id="searchText">
					</c:otherwise>
				</c:choose>
				<input type="submit" id="searchSubmit" value="검색">
			</div>
		</form>

		<!-- 엑셀 다운로드 버튼-->
		<form action="${contextPath}/enrollment/excelDownload.do" class="excelDownloadForm" method="get" name="excelForm">
			<div id="type_color">
				<div>
					<span style="color: black">협약상태 구분: </span><span style="color:red">●협약서없음</span><span style="color:green"> ●상호변경 </span><span style="color:black"> ●협약완료</span><span style="color:blue"> ●협약서사본</span>
				</div>
				<div>
					열람사유 : <input type="text" name="log" id="log">
					<input type="submit" value='엑셀 다운로드' id="excel">
				</div>
			</div>
		</form>
		<!-- 버튼 모음집-->
		<div class="memberButton" style="margin: 20px 0px;">
			<button type="button" id="enrollButton"
				onclick="location.href='${contextPath}/enrollment/enrollmentForm.do'" style="width: 5%;">등록</button>
			<button type="button" id="approveButton" onclick='getCheckList("approve")' style="width: 5%;">승인</button>
			<button type="button" id="completeButton" onclick='getCheckList("complete")' style="width: 5%;">수료</button>
			<button type="button" id="cancelButton" onclick='getCheckList("delete")' style="width: 5%;">취소</button>
		</div>


		<table align="center" border="0" width="80%" id="dynamicCompany">
			<tr height="15" align="center" id="attr">
				<td><input type="checkbox" id="selectAll"></td>
				<td><b>과정명</b></td>
				<td><b>교육기간</b></td>
				<td><b>이름</b></td>
				<td><b>소속회사</b></td>
				<td><b>상태</b></td>
				<td><b>신청일</b></td>
			</tr>

			<!-- 리스트 반복문 -->
			<c:choose>
				<c:when test="${empty enrollmentsList}">
					<tr height="10">
						<td colspan="7">
							<p align="center">
								<b><span style="font-size: 9pt;">찾으시는 데이터가 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${enrollmentsList !=null }">
					<c:forEach var="enrollment" items="${enrollmentsList }" varStatus="enrdNum">
						<tr align="center">
							<td style="width: 5%"><input type="checkbox" name="selectedCheckbox" id="${enrollment.id }">
							</td>

							<!-- 과목별 상세 조회 -->
							<td align="left" style="width: 35%; padding-left:20px"><a id="herfId1" href="${contextPath}/enrollment/enrollmentCourse.do?
											id=${enrollment.courseVO.id }">${enrollment.syllabusVO.name }</a></td>

							<td style="width: 20%">${enrollment.courseVO.startDate } ~
								${enrollment.courseVO.endDate }</td>

							<td style="width: 5%"><a id="herfId2" href="${contextPath}/enrollment/informationEnrollment.do?
											id=${enrollment.id }">${enrollment.memberVO.name }</a></td>
							<td style="width: 15%">
								<!-- 회사가 없는 경우 -->
								<c:if test="${enrollment.memberVO.companyName == null }">
									<font color="red">비협력사</font>
								</c:if>

								<!-- 회사가 있는 경우 -->
								<c:if test="${enrollment.memberVO.companyName != null }">

									<c:choose>
										<c:when test="${enrollment.companyVO.contractType eq '협약서 없음'}">
											<font color="red">${enrollment.memberVO.companyName }
											</font>

										</c:when>
										<c:when test="${enrollment.companyVO.contractType eq '상호 변경'}">
											<font color="green">${enrollment.memberVO.companyName }
											</font>

										</c:when>
										<c:when test="${enrollment.companyVO.contractType eq '협약 완료'}">
											<font color="black">${enrollment.memberVO.companyName }
											</font>

										</c:when>
										<c:when test="${enrollment.companyVO.contractType eq '협약서 사본'}">
											<font color="blue">${enrollment.memberVO.companyName }
											</font>
										</c:when>
										<c:otherwise>
											<font color="red">${enrollment.memberVO.companyName }
											</font>
										</c:otherwise>
									</c:choose>
								</c:if>
							</td>

							<td style="width: 5%">
								<c:choose>
									<c:when test="${enrollment.stat == '신청' }">
										<font color="black">${enrollment.stat }</font>
									</c:when>

									<c:when test="${enrollment.stat == '승인' }">
										<font color="blue">${enrollment.stat }</font>
									</c:when>
									<c:otherwise>
										<font color="red">${enrollment.stat }</font>
									</c:otherwise>
								</c:choose>

							<td style="width: 15%">${enrollment.joinDate }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>

		<!-- 버튼 모음집 -->
		<div class="under memberButton">
			<button type="button" id="enrollButton"
				onclick="location.href='${contextPath}/enrollment/enrollmentForm.do'" style="width: 5%;">등록</button>
			<button type="button" id="approveButton" onclick='getCheckList("approve")' style="width: 5%;">승인</button>
			<button type="button" id="completeButton" onclick='getCheckList("complete")' style="width: 5%;">수료</button>
			<button type="button" id="cancelButton" onclick='getCheckList("delete")' style="width: 5%;">취소</button>
		</div>

		<!-- 전체 페이지개수에 의한 페이지 리스트 띄우기 -->
		<div class="pageNumber" align="center">
			<ul>
				<c:if test="${pageMaker.prev }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a href="${contextPath}/enrollment/listEnrollments.do?page=${pageMaker.startPage - 1 }
			&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${contextPath}/enrollment/listEnrollments.do?page=${pageMaker.startPage - 1 }
			&searchText=${searchText}&searchType=${searchType}">이전</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:choose>
					<c:when test="${not empty searchType and not empty searchText }">
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
							<a href="${contextPath }/enrollment/listEnrollments.do?page=${idx}&searchText=${searchText}
			&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }" />>
							<a href="${contextPath }/enrollment/listEnrollments.do?page=${idx}&searchText=${searchText}
			&searchType=${searchType}&perPage=${perPage}">${idx }</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<c:choose>
						<c:when test="${not empty searchType and not empty searchText }">
							<li><a href="${contextPath}/enrollment/listEnrollments.do?page=${pageMaker.endPage + 1 }
			&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${contextPath}/enrollment/listEnrollments.do?page=${pageMaker.endPage + 1 }
			&searchText=${searchText}&searchType=${searchType}">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</div>


</body>

</html>