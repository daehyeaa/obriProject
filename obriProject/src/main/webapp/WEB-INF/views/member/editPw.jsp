<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/findid.css" type="text/css">

<script src="./js/member/edit.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-findid w-500 m-auto">
		<form method="post" action="editPwOk.do"
			onsubmit="return editPwCheck()">
			<br> <img src="./images/logo.png" alt="Logo" width="100px" height="40px"
					onclick="location.href='home.do'" style="cursor: pointer;">
			<br> <br>
			<h1 class="h4 mb-3">
				<b>오브리</b>&nbsp; 비밀번호 변경하기
			</h1>
			<br>

			<div class="row mb-3" hidden>
				<label for="userId" class="form-label mb-0" align="left">아이디</label>
				<div class="row mb-0 g-1 align-items-center">
					<div class="col-9 mb-1">
						<input type="text" class="form-control" id="userId" name="userId"
							value="${userId}" readonly>
					</div>
				</div>
			</div>

			<div class="row mb-2">
				<label for="userPw" class="form-label" align="left">새 비밀번호</label>
				<input type="password" class="form-control" id="userPw" name="userPw"
					placeholder="6~12자 영대소문자, 숫자 이용" maxlength="12"
					oninput="numberMaxLength(this);">
			</div>
			<div class="form-text mb-2" id="pwGuide" align="left"></div>

			<div class="row mb-2">
				<label for="userPwCheck" class="form-label" align="left">새 비밀번호 확인</label>
				<input type="password" class="form-control" id="userPwCheck" name="userPwCheck" 
				placeholder="동일하게 입력" maxlength="12" oninput="numberMaxLength(this);">
			</div>
			<div class="form-text mb-2" id="pwCheckGuide" align="left"></div>

			<div class="form-text mb-2" id="pwDCGuide" align="left"></div>

			<button class="btn w-100 pr-100 fw-bold" type="submit">확인</button>
		</form>

		<p class="mt-5 mb-3 text-body-secondary" align="center"
			style="font-size: 80%">&copy; 2023. 1조</p>
	</main>
</body>
</html>