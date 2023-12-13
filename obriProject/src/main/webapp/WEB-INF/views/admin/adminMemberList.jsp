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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/adminForm.css"
	type="text/css">
<style>
.btg{
	text-align: right;
}
.tb{
	padding = 20px;
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
						<thead class="table-primary">
							<tr>
								<th scope="col">ID</th>
								<th scope="col">이름</th>
								<th scope="col">생성일</th>
								<th scope="col">상태</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody class="tb">
							<c:forEach var="m" items="${memberlist}">
								<tr>
									<td>${m['USERID']}</td>
									<td><a href="admin_user_view.do?userId=${m['USERID']}&pageNum=${pageNum}&state=cont">${m['USERNAME']}</a></td>
									<td>${m['USERDATE']}</td>
									<td><c:if test="${m['USERDELYN'].trim() eq 'Y'}">탈퇴</c:if>
										<c:if test="${m['USERDELYN'].trim() eq 'X'}">정지</c:if> <c:if
											test="${m['USERDELYN'].trim() eq 'N'}">정상</c:if></td>
									<td><div class="btg">
											<button type="button"
												class="btn btn-sm btn-outline-secondary"
												onclick="location='admin_member_block.do?userId=${m['USERID']}&pageNum=${pageNum}'">정지</button>
											<button type="button"
												class="btn btn-sm btn-outline-danger"
												onclick="location='admin_member_delete.do?userId=${m['USERID']}&pageNum=${pageNum}'">탈퇴</button>
										</div></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="center">
					<div class="pagination">
						<c:if test="${not empty keyword}">
							<c:if test="${pp.startPage > pp.pagePerBlk }">
								<a
									href="admin_memberlist.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">&laquo;
								</a>
							</c:if>
							<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
								<c:if test="${pp.currentPage==i}"></c:if>
								<a
									href="admin_memberlist.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
							</c:forEach>
							<c:if test="${pp.endPage < pp.pageCount}">
								<a
									href="admin_memberlist.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}">&raquo;
								</a>
							</c:if>
						</c:if>

						<!-- 전체 목록의 페이징 처리 -->
						<c:if test="${empty keyword}">
							<c:if test="${pp.startPage > pp.pagePerBlk }">
								<a href="admin_memberlist.do?pageNum=${pp.startPage - 1}">&laquo;</a>
							</c:if>
							<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
								<c:if test="${pp.currentPage==i}"></c:if>
								<a href="admin_memberlist.do?pageNum=${i}">${i}</a>
							</c:forEach>
							<c:if test="${pp.endPage < pp.pageCount}">
								<a href="admin_memberlist.do?pageNum=${pp.endPage + 1}">&raquo;
								</a>
							</c:if>
						</c:if>
					</div>
				</div>
				<form action="admin_memberlist.do" class="sh">
					<input type="hidden" name="pageNum" value="1"> <select
						name="search">
						<option value="userId"
							<c:if test="${search=='userId'}">selected="selected" </c:if>>ID</option>
						<option value="userName"
							<c:if test="${search=='userName'}">selected="selected" </c:if>>이름</option>
					</select> <input type="text" name="keyword"> <input type="submit"
						value="확인">
				</form>
			</main>
		</div>
	</div>
</body>
</html>