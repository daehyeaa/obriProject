<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/join.css" type="text/css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/member/member.js"></script>
</head>

<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-joinin w-1000 m-auto">
		<form name="f" method="post" action="insertMem.do"
			onsubmit="return check()">
			<div id="logo">
				<img src="./images/logo.png" alt="Logo" width="100px" height="40px"
					onclick="location.href='home.do'" style="cursor: pointer;">
			</div>
			<br>
			<h1 class="h4 mb-3" align="center">
				연주자를 위한 커뮤니티,<br> <b>오브리</b>에 오신 것을 환영합니다.
			</h1>
			<br>

			<h2 class="h6 fw-bold" align="center">필수 입력 항목</h2>
			<hr>

			<div class="row mb-0">
				<label for="userId" class="form-label mb-0" align="left">아이디</label>
				<div class="row mb-0 g-1 align-items-center">
					<div class="col-9 mb-1">
						<input type="text" class="form-control" id="userId" name="userId"
							aria-describedby="idGuide" placeholder="6~12자 영대소문자, 숫자 이용"
							maxlength="12" oninput="numberMaxLength(this);">
					</div>
					<div class="col mb-1">
						<button type="button" class="btn btn-outline-dark" onclick="checkId()"
							style="font-size: 14px;" >중복확인</button>
					</div>
				</div>
			</div>
			<div class="form-text row mb-2" id="idGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userPw" class="form-label" align="left">비밀번호</label> <input
					type="password" class="form-control" id="userPw" name="userPw"
					placeholder="6~12자 영대소문자, 숫자 이용" maxlength="12"
					oninput="numberMaxLength(this);">
			</div>
			<div class="form-text mb-2" id="pwGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userName" class="form-label" align="left">성명</label> <input
					type="text" class="form-control" id="userName" name="userName"
					placeholder="성명">
			</div>
			<div class="form-text mb-2" id="nameGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userPhone" class="form-label" align="left">휴대폰번호</label> <input
					type="text" maxlength="11"
					oninput="this.value=this.value.replace(/[^0-9.]/g, '');"
					class="form-control" id="userPhone" name="userPhone"
					placeholder="숫자만 입력">
			</div>
			<div class="form-text mb-2" id="phoneGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userEmail" class="form-label" align="left">이메일</label> <input
					type="text" class="form-control" id="userEmail" name="userEmail"
					placeholder="email@example.com">
			</div>
			<div class="form-text mb-2" id="emailGuide" align="left"></div>
			<br>
			<h2 class="h6 fw-bold" align="center">선택 입력 항목</h2>
			<hr>

			<div class="row mb-3">
				<label for="userMajor" class="form-label" align="left">전공</label> <input
					type="text" class="form-control" id="userMajor" name="userMajor"
					placeholder="ex)바이올린">
			</div>

			<div class="row mb-3">
				<label for="userGru" class="form-label" align="left">졸업유무</label> <select
					class="form-select" name="userGru" id="userGru">
					<option value="N">선택</option>
					<option value="Y">네</option>
					<option value="N">아니요</option>
				</select>
			</div>

			<br>
			<button class="btn btn-outline-dark w-100 pr-100 fw-bold" type="submit">회원가입</button>

			<p class="mt-4 mb-3 text-body-secondary" align="center"
				style="font-size: 90%">
				이미 회원이신가요?&nbsp;<a href="login.do" style="color: gray">로그인</a>
			</p>

			<p class="mt-5 mb-3 text-body-dark" align="center"
				style="font-size: 80%">&copy; 2023. 1조</p>
		</form>
	</main>
</body>
</html>