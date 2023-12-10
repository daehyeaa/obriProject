<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">구인게시판</h2>

		<div align="right">
			<select id="jobListSel" onchange="selectBoxChange(this.value);">
				<option value="latest" selected>정렬방법</a></option>
				<option value="latest" selected><a href="${path}/latest.do">최신순</a></option>
				<option value="rcount"><a href="${path}/rcount.do">조회수순</a></option>
			</select>
		</div>

		<div align=left class="form-check form-switch">
			<input class="form-check-input" type="checkbox" role="switch"
				id="flexSwitchCheckDefault"> <label class="form-check-label"
				for="flexSwitchCheckDefault">완료글 제외</label>
		</div>

		<table class="table table-striped">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>

			<c:if test="${empty list}">
				<tr>
					<td colspan="5">데이터가 없습니다</td>
				</tr>
			</c:if>

			<c:if test="${not empty list}">
				<c:set var="no1" value="${no }"></c:set>
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${no1}</td>
						<c:if test="${board.jobDelYn =='Y' }">
							<td colspan="4">삭제된 데이터 입니다</td>
						</c:if>
						<c:if test="${board.jobDelYn !='Y' }">
							<td><a href="job_board_view.do?jobNo=${board.jobNo}">${board.jobSub}</a></td>
							<td>${board.jobWriter}</td>
							<td><fmt:formatDate value="${board.jobDate}"
									pattern="yyyy-MM-dd" /></td>
							<td>${board.jobRcount}</td>
						</c:if>
					</tr>
					<c:set var="no1" value="${no1 - 1}"></c:set>
				</c:forEach>
			</c:if>
		</table>

		<form action="joblist.do">
			<input type="hidden" name="pageNum" value="1"> <select
				name="search">
				<option value="subject"
					<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
				<option value="content"
					<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
				<option value="writer"
					<c:if test="${search=='writer'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> <input type="text" name="keyword"> <input type="submit"
				value="확인">
		</form>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${not empty keyword}">
					<c:if test="${pp.startPage > pp.pagePerBlk }">
						<li class="page-item"><a class="page-link" href="joblist?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}"
							aria-label="이전"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
						<li class="page-item" <c:if test="${pp.currentPage==i}"></c:if>><a
							href="joblist?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a></li>
					</c:forEach>
					<c:if test="${pp.endPage < pp.totalPage}">
						<li class="page-item"><a
							href="joblist?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}">다음</a></li>
					</c:if>
				</c:if>

				<c:if test="${empty keyword}">
					<c:if test="${pp.startPage > pp.pagePerBlk }">
						<li class="page-item">
						<a href="joblist.do?pageNum=${pp.startPage - 1}">이전</a></li>
					</c:if>
					<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
						<li class="page-item" <c:if test="${pp.currentPage==i}"></c:if>>
							<a href="joblist.do?pageNum=${i}">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${pp.endPage < pp.totalPage}">
						<li class="page-item">
						<a href="joblist.do?pageNum=${pp.endPage + 1}">다음</a></li>
					</c:if>
				</c:if>
			</ul>
		</nav>
		<div align="left">
			<a href="${path}/job_board_write.do" class="btn btn-info">글 작성</a>
		</div>
	</div>
</body>
</html>