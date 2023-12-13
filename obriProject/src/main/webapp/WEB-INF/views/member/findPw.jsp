<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/findid.css" type="text/css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function check() {
		if ($.trim($("#userId").val()) == "") {
			alert("아이디를 입력하세요.");
			$("#userId").val("").focus();
			return false;
		}
		if ($.trim($("#userEmail").val()) == "") {
			alert("이메일을 입력하세요.");
			$("#userEmail").val("").focus();
			return false;
		}
	}
</script>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-findid w-500 m-auto">
		<c:if test="${empty findpw}">
			<form method="post" action="findPwCheck.do" onsubmit="return check()">
			<div id="logo">
				<img src="./images/logo.png" alt="Logo" width="100px" height="40px"
					onclick="location.href='home.do'" style="cursor: pointer;">
			</div>
			<br>
			<h1 class="h4 mb-3" align="center">
				<br><b>오브리</b>&nbsp;비밀번호 찾기</h1>
			<br>
				<div class="form-floating">
					<input type="text" class="form-control" id="userId" name="userId"
						placeholder="id"> <label for="userId">아이디</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="userEmail"
						name="userEmail" placeholder="email"> <label
						for="userEmail">이메일</label>
				</div>

				<button class="btn w-100 pr-100 fw-bold" type="submit">비밀번호
					찾기</button>
				<br><br>
				<p class="mt-4 mb-3 text-body-secondary" align="center"
					style="font-size: 90%">
					아이디가 기억나지 않으신가요?<br> <a href="findId.do" style="color: gray">아이디
						찾기</a><br>
				</p>
				
			</form>
		</c:if>

		<c:if test="${!empty findpw}">
			<h1 class="h4 mb-3 fw-bold" align="center">비밀번호 찾기 결과</h1>
			<tr>
				<p>
					가입하신 메일 계정으로 임시 비밀번호를 발송했습니다.<br> 임시 비밀번호로 로그인하신 후 비밀번호를
					변경해주세요.
				</p>
			</tr>
			<br>
			<br>
			<button class="btn w-100 pr-100 fw-bold" type="button"
				onclick="location.href='login.do'">확인</button>
		</c:if>


		<p class="mt-5 mb-3 text-body-secondary" align="center"
			style="font-size: 80%">&copy; 2023. 1조</p>

	</main>
</body>
</html>