<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/viewpage.css">
</head>
<body class="bg-body-tertiary">
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">공지사항</h3>
			</div>
			<table>
				<thead>
					<tr>
						<th class="text-start pl-5"><c:out value="${map['NOTSUB']}" /></th>
						<th class="text-end pr-5"><fmt:formatDate
								value="${map['NOTDATE']}" pattern="yyyy-MM-dd" /></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2" class="text-start pl-5">작성자 : <c:out
								value="${map['ADMINNAME']}" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-start pl-5">조회수 : <c:out
								value="${map['NOTRCOUNT']}" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-start pl-5" height="300px"><pre>${map['NOTTEXT']}</pre>
						</td>
					</tr>
				</tbody>
			</table>

			<div align="center">
				<input type="button" class="btn" value="목록"
					onclick="location.href='notice_list.do?page=${page}'">
			</div>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>