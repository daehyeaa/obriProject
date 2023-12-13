<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회원관리</title>
<meta charset="utf-8">
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
.center {
	text-align: center;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 4px 8px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}

.sh {
	text-align: right;
	margin-top: 20px;
}
.btg{
	text-align: right;
}
</style>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 사이드바 부분 -->
			<c:import url="/WEB-INF/views/admin/adminsidenav.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">회원관리</h1>
				</div>
				<h2></h2>
				<div class="table-responsive small">
					<table class="table table-sm">
						<tr>
							<th scope="col">ID</th>
							<td>${map['USERID']}</td>
							<th scope="col">이름</th>
							<td>${map['USERNAME']}</td>
						</tr>
						<tr>
							<th scope="col">연락처</th>
							<td colspan=3>${map['USERPHONE']}</td>
						</tr>
						<tr>
							<th scope="col">E-mail</th>
							<td colspan=3>${map['USEREMAIL']}</td>
						</tr>
						<tr>
							<th scope="col">전공</th>
							<td>${map['USERMAJOR']}</td>
							<th scope="col">졸업유무</th>
							<td>
							<c:if test="${map['USERGRU'].trim() eq 'Y'}">졸업</c:if>
							<c:if test="${map['USERGRU'].trim() eq 'N'}">&nbsp;</c:if>
							</td>
						</tr>
						<tr>
							<th scope="col">생성일</th>
							<td>${map['USERDATE']}</td>
							<th scope="col">수정일</th>
							<td>${map['USERUPDATE']}</td>
						</tr>
						<tr>
							<th>상태</th>
							<td colspan=3>
								<c:if test="${map['USERDELYN'].trim() eq 'Y'}">탈퇴</c:if>
								<c:if test="${map['USERDELYN'].trim() eq 'X'}">정지</c:if>
								<c:if test="${map['USERDELYN'].trim() eq 'N'}">정상</c:if>
							</td>
						</tr>
						<tr>
							<td colspan=4 align="center">
							    <button type="button" class="btn btn-sm btn-outline-secondary"
							        onclick="location='admin_member_block.do?userId=${map['USERID']}&pageNum=${pageNum}'">정지</button>
							    <button type="button" class="btn btn-sm btn-outline-secondary"
							        onclick="location='admin_member_nonblock.do?userId=${map['USERID']}&pageNum=${pageNum}'">해제</button>
							    <button type="button" class="btn btn-sm btn-outline-danger"
							        onclick="location='admin_member_delete.do?userId=${map['USERID']}&pageNum=${pageNum}'">탈퇴</button>
							</td>
						</tr>
					</table>
				</div>
			</main>
		</div>
	</div>
</body>
</html>