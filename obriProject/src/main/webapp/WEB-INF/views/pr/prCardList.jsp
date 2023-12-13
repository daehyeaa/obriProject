<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Date"%>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>커뮤니티</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/8c929515d1.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.js"></script>

<!-- 부트스트랩 JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/prlist.css">

<!-- 게시판 정렬 -->
<script>
function comSort() {
	var sortValue = $("#sort").val();
	location.href = "boardList.do?sort=" + sortValue;
}
</script>

<script>
var sessionId = '<%=(String) session.getAttribute("userId")%>';
console.log("세션ID " + sessionId);

$(document).ready(function() {
	if (sessionId === "null") {
		console.log("여기들감?");
		$("#commInsert").hide();
	}else {
		$("#commInsert").show();
	}
});

function prDetailPageMove(prNo) {
	// 클릭한 div의 prNo 값을 사용하여 원하는 페이지로 이동
	location.href = '${path}/prDetail.do?pageNum=${pp.currentPage}&prNo=' + prNo;
}

// 이벤트를 처리할 함수
function sortOrderChange() {
	let sort = $("#sortOrder").val();
	location.href = '${path}/prCardList.do?pageNum=${pp.currentPage}&sortOrder=' + sort;
}
</script>
<body class="bg-body-tertiary">
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">홍보</h3>
			</div>
			<div class="row justify-content-between mb-3 pr-header">
				<div class="col-2 sort-container">
					<select name="sort" id="sortOrder" onchange="sortOrderChange()"
						class="sort_box">
						<option value="">선택</option>
						<option value="regDate">등록순</option>
						<option value="view">조회순</option>
						<!-- <option value="like">좋아요순</option> -->
					</select>
				</div>
				<div class="col-2 btn-container">
					<input type="button" value="글작성" class="btn"
						onclick="location.href='prInsertForm.do'" id="commInsert"
						style="width: 100px;">
				</div>
			</div>

			<div class="pr-content">
				<div class="row no-gutters">
					<!-- 반복문 시작 -->
					<c:if test="${empty prList}">
						<p>등록된 정보가 없습니다.</p>
					</c:if>

					<c:forEach var="pr" items="${prList}">
						<div class="col-md-6 mb-3">
							<div class="card" onclick="prDetailPageMove('${pr.prNo}')">
								<div class="row no-gutters">
									<!-- 카드 이미지 -->
									<div class="col-md-4">
										<c:if test="${empty pr.prFile}">
											<img src="https://via.placeholder.com/150" class="card-img">
										</c:if>
										<c:if test="${!empty pr.prFile}">
											<img src="<%=request.getContextPath()%>/upload/${pr.prFile}"
												class="card-img">
										</c:if>
									</div>
									<!-- 카드 텍스트 -->
									<div class="col-md-8 mb-2">
										<div class="card-body">
										<h5 class="card-title">
										<c:set var="truncatedSub"
												value="${fn:substring(pr.prSub, 0, 15)}" />
											${truncatedSub} <c:if
												test="${fn:length(community.commSub) > 15}">...</c:if>
										</h5>
										</div>
										<div class="hashtag-container">
											<c:if test="${!empty pr.prHash}">
												<span class="hashtag">${pr.prHash}</span>
											</c:if>
										</div>

									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<div align="center">
				<ul class="pagination">
					<c:if test="${not empty keyword }">
						<c:if test="${pp.startPage > pp.pagePerBlk}">
							<li><a class="page-link"
								href="${path}/prCardList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li<c:if test="${pp.currentPage == i}"> active</c:if>"><a
								class="page-link"
								href="${path}/prCardList.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.totalPage}">
							<li><a class="page-link"
								href="${path}/prCardList.do?pageNum=${pp.endPage+1}&search=${search}&keyword=${keyword}">다음</a></li>
						</c:if>
					</c:if>
					<c:if test="${empty keyword }">
						<c:if test="${empty sortOrder}">
							<c:if test="${pp.startPage > pp.pagePerBlk}">
								<li><a class="page-link"
									href="${path}/prCardList.do?pageNum=${pp.startPage - 1}">이전</a></li>
							</c:if>
							<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
								<li<c:if test="${pp.currentPage == i}"> active</c:if>"><a
									class="page-link" href="${path}/prCardList.do?pageNum=${i}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pp.endPage < pp.totalPage}">
								<li><a class="page-link"
									href="${path}/prCardList.do?pageNum=${pp.endPage+1}">다음</a></li>
							</c:if>
						</c:if>
						<c:if test="${not empty sortOrder}">
							<c:if test="${pp.startPage > pp.pagePerBlk}">
								<li><a class="page-link"
									href="${path}/prCardList.do?pageNum=${pp.startPage - 1}&sortOrder=${sortOrder}">이전</a></li>
							</c:if>
							<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
								<li<c:if test="${pp.currentPage == i}"> active</c:if>"><a
									class="page-link"
									href="${path}/prCardList.do?pageNum=${i}&sortOrder=${sortOrder}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pp.endPage < pp.totalPage}">
								<li><a class="page-link"
									href="${path}/prCardList.do?pageNum=${pp.endPage+1}&sortOrder=${sortOrder}">다음</a></li>
							</c:if>
						</c:if>
					</c:if>
				</ul>
				<form class="search_bar"
					action="${path}/prCardList.do?pageNum=${currentPage}">
					<select name="search" class="search_box">
						<option value="prSub"
							<c:if test="${search=='prSub'}">selected="selected" </c:if>>제목</option>
						<option value="prText"
							<c:if test="${search=='prText'}">selected="selected" </c:if>>내용</option>
						<option value="subcon"
							<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
					</select> <input type="text" name="keyword" class="search_text"> <input
						type="submit" class="btn" value="찾기" style="margin-left: 5px;">
				</form>
			</div>
		</main>
	</div>
	<c:import url="/WEB-INF/views/footer.jsp" />

</body>
</html>