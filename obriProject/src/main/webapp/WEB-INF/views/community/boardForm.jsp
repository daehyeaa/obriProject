<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title>커뮤니티 글작성</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">커뮤니티</h3>
			</div>
			<form method="post" action="boardWrite.do"
				enctype="multipart/form-data">
				<table>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="userId" id="userId"
							value="${fn:trim(sessionScope.userId)}" readonly="readonly"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="commSub" id="commSub" required></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols=40 rows=10 name="commText" id="commText"
								required></textarea> <br> <br></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input type="file" name="com_file1" id="com_file1"></td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan=2 align=center><input type="submit" class="btn"
							value="작성" id="submitButton">&nbsp;&nbsp;<input type="button"
							value="목록" class="btn" onclick="location.href='boardList.do'"></td>
					</tr>
				</div>
			</form>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>