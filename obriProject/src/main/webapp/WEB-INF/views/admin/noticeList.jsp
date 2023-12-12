<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/custom-styles.css">

</head>
<body>
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<div class="row">
			<main>
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h2>공지사항</h2>
				</div>
				<table>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="n" items="${noticelist}">
							<tr>
								<td>${n['NOTNO']}</td>
								<td><a
									href="notice_read.do?notNo=${n['NOTNO']}&pageNum=${pageNum}&state=cont">${n['NOTSUB']}</a></td>
								<td>${n['ADMINNAME']}</td>
								<td><fmt:formatDate value="${n['NOTDATE']}"
										pattern="yyyy-MM-dd" /></td>
								<td>${n['NOTRCOUNT']}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<ul class="pagination">
					<c:if test="${not empty keyword}">
						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a class="page-link"
								href="notice_list.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li <c:if test="${pp.currentPage==i}"></c:if>><a
								class="page-link"
								href="notice_list.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.pageCount}">
							<li><a class="page-link"
								href="notice_list.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</c:if>
					<!-- 전체 목록의 페이징 처리 -->
					<c:if test="${empty keyword}">
						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a class="page-link"
								href="notice_list.do?pageNum=${pp.startPage - 1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li <c:if test="${pp.currentPage==i}"></c:if>><a
								class="page-link" href="notice_list.do?pageNum=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.pageCount}">
							<li><a class="page-link"
								href="notice_list.do?pageNum=${pp.endPage + 1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</c:if>
				</ul>
				<form class="search_bar" action="admin_notice.do">
					<input type="hidden" name="pageNum" value="1"> <select
						name="search" class="search_box">
						<option value="notSub"
							<c:if test="${search=='notSub'}">selected="selected" </c:if>>제목</option>
						<option value="notText"
							<c:if test="${search=='notText'}">selected="selected" </c:if>>내용</option>
						<option value="subcon"
							<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
					</select> <input class="search_text" type="text" name="keyword"> <input
						class="search_button" type="submit" value="검색">
				</form>
			</main>
		</div>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>