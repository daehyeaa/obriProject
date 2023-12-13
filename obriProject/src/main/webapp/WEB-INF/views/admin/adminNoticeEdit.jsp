<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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
</style>
<script src="<%=request.getContextPath()%>/js/notice.js"></script>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 사이드바 부분 -->
			<c:import url="/WEB-INF/views/admin/adminsidenav.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">공지사항수정</h1>
				</div>
				<h2></h2>
				<div class="table-responsive small">
					<form method="post"
						action="notice_edit.do"
						onsubmit="return notice_check()">
						<input type="hidden" name="notNo" value="${map['NOTNO']}">
						<input type="hidden" name="pageNum" value="${pageNum}">
						<input type="text" name="notSub" id="notSub"
							class="form-control mt-4 mb-2" value="<c:out value="${map['NOTSUB']}" />" required> 
						<div class="form-group">
							<textarea class="form-control" rows="10" name="notText"
								id="notText" required>${map['NOTTEXT']}</textarea>
						</div>
						<div id="menu" align="center">
							<input type="submit" value="등록" class="btn btn-outline-dark mb-3">
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>
</body>
</html>