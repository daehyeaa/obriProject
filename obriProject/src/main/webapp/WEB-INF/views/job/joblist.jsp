<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://getbootstrap.com/docs/5.3/assets/css/docs.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin/adminNav.css" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	
	function jobListSort() {
	    // 폼 선택
	    var form = document.getElementById("selectForm");
	    
	    // jobListSel 값을 폼에 추가
	    var input = document.createElement("input");
	    input.type = "hidden";
	    input.id = "jobListSel";
	    input.value = $("#jobListSel").val();
	    form.appendChild(input);
	    
	    // 폼 서브밋
	    form.submit();
	}	
</script>	

	
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

.form-control {
	max-width: 100px;
	margin-left: 540px;
}

.container{
	width: 900px;	
}

.subject{
	white-space: nowrap;    
    overflow: hidden;          
    text-overflow: ellipsis;
}

</style>
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary" align="left"><a href="joblist.do?pageNum=1" style="text-decoration: none;">구인게시판</a></h2>
		<div class="col-md-6 sort" align="right">
			<form id="selectForm" action="joblist.do" method="get">
				<select class="form-control" id="jobListSel" name="jobListSel" onchange="jobListSort()">
					<option value=" ">선택</option>
					<option value="Date">최신순</option>
					<option value="View">조회수순</option>
				</select>
			</form>
		</div>
	
	<div id="table">
		<table id="tab" class="table table-striped">
			<thead>
				<tr>
					<td align="center">번호</td>
					<td colspan="2">제목</td>
					<td align="center">작성자</td>
					<td align="center">모집마감일</td>
					<td align="center">공연일</td>
					<td align="center">조회수</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="job" items="${list}">
					<tr>
						<td align="center">${job['JOBNO']}</td>
						<td colspan="2" id="subject">
							<a href="job_board_view.do?jobNo=${job['JOBNO']}&pageNum=${pp.currentPage}&state=cont"
							class="btn btn-default">${job['JOBSUB']}</a>
						</td>
						<td align="center">${job['USERNAME']}</td>
						<td align="center"><fmt:formatDate value="${job['JOBENDDATE']}"
								pattern="yyyy-MM-dd" /></td>
						<td align="center"><fmt:formatDate value="${job['JOBCONCERT']}"
								pattern="yyyy-MM-dd" /></td>
						<td align="center">${job['JOBRCOUNT']}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>

		<form action="joblist.do">
			<input type="hidden" name="pageNum" value="1"> 
			<select name="search">
				<option value="jobSub"
					<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
				<option value="jobText"
					<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> <input type="text" name="keyword"> 
					  <input type="submit" value="확인">
		</form>

		<div class="center">
			<div class="pagination">
				<c:if test="${not empty keyword}">
					<c:if test="${pp.startPage > pp.pagePerBlk }">
						<a href="joblist.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</c:if>
					<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
						<c:if test="${pp.currentPage==i}"></c:if>
						<a href="joblist.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
					</c:forEach>
					<c:if test="${pp.endPage < pp.totalPage}">
						<a href="joblist.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</c:if>					
				</c:if>

				<!-- 전체 목록의 페이징 처리 -->
				<c:if test="${empty keyword}">
					<a href ="joblist.do?page=1"> [처음] </a>
					<c:if test="${pp.startPage > pp.pagePerBlk }">
						<a href="joblist.do?pageNum=${pp.startPage - 1}">
							<span aria-hidden="true">&laquo;</span></a>
					</c:if>
					
					<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
						<c:if test="${pp.currentPage == i}"></c:if><a
							href="joblist.do?pageNum=${i}">${i}</a>
					</c:forEach>
					
					<c:if test="${pp.endPage < pp.totalPage}">
						<a href="joblist.do?pageNum=${pp.endPage + 1}"><span
							aria-hidden="true">&raquo;</span></a>			
					</c:if>
					<a href ="joblist.do?pageNum=${pp.totalPage}"> [마지막] </a>
					</c:if>
			</div>
		</div>
		<div align="left">
			<a href="${path}/job_board_write.do?pageNum=${pp.currentPage}"
				class="btn btn-info">글 작성</a>
		</div>
	</div>
</body>
</html>