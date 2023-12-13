<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의 내용보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin/adminNav.css"
	type="text/css">
<style>
td {
	height: 400px;
}

.container input[type="button"] {
	margin-bottom: 10px;
	margin-left: 5px;
	float: right;
}
.file{
	height : 40px;
}
</style>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 사이드바 부분 -->
			<c:import url="/WEB-INF/views/admin/adminsidenav.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<h2 class="qnatitle">1:1 문의</h2>
				<br> <br>
				<table id="qnatable" class="table">
					<tr class="table-active">
						<th scope="col" style="width: 60%"><c:out
								value="${map['QNASUB']}" /><br> <c:out
								value="${map['USERNAME']}(${map['USERID']})" /></th>
						<th scope="col" style="width: 40%" class="text-right"><c:if
								test="${map['QNADELYN'].trim() eq 'Y'}">완료</c:if> <c:if
								test="${map['QNADELYN'].trim() eq 'N'}">미완료</c:if> <br> <fmt:formatDate
								value="${map['QNADATE']}" pattern="yyyy-MM-dd" /></th>
					</tr>
					<tr>
						<td colspan=2 scope="col"><pre>${map['QNATEXT']}</pre></td>
					</tr>
					<tr>
						<th scope="col">첨부파일</th>
						<td class="file"><c:if test="${not empty map['QNAFILE']}">
    						<a href="downloadFile.do?qnaNo=${qnaNo}" target="_blank">첨부 파일 다운로드</a>
							</c:if>
						</td>
					</tr>
				</table>

				<div id="menu">
					<input type="button" value="처리완료" class="btn btn-outline-secondary"
						data-bs-toggle="modal" data-bs-target="#qnaDelete" /> <input
						type="button" value="목록" class="btn btn-outline-secondary"
						onclick="location='admin_qna.do?pageNum=${pageNum}'" />
				</div>
			</main>
		</div>
	</div>

	<!-- 모달 -->
	<!-- Modal -->
	<div class="modal fade" id="qnaDelete" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">처리완료 하시겠습니까?</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">이 작업은 되돌릴 수 없습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="location.href='qna_delete.do?qnaNo=${qnaNo}&pageNum=${pageNum}'">처리완료</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>