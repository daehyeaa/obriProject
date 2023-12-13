<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/join.css" type="text/css">

<script>
	function editCheck() {
		$("#nameGuide").hide();
		$("#phoneGuide").hide();
		$("#emailGuide").hide();

		if ($.trim($("#userName").val()) == "") {
			var newtext = '<font color="red">이름을 입력해주세요.</font>';
			$("#nameGuide").text('');
			$("#nameGuide").show();
			$("#nameGuide").append(newtext);
			$("#userName").val("").focus();
			return false;
		}
		if ($.trim($("#userPhone").val()) == "") {
			var newtext = '<font color="red">휴대폰번호를 입력해주세요.</font>';
			$("#phoneGuide").text('');
			$("#phoneGuide").show();
			$("#phoneGuide").append(newtext);
			$("#userPhone").val("").focus();
			return false;
		}
		if ($.trim($("#userEmail").val()) == "") {
			var newtext = '<font color="red">이메일을 입력해주세요.</font>';
			$("#emailGuide").text('');
			$("#emailGuide").show();
			$("#emailGuide").append(newtext);
			$("#userEmail").val("").focus();
			return false;
		}
	}
</script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/member/member.js"></script>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-joinin w-1000 m-auto">

		<form name="e" method="post" action="editMemOk.do"
			onsubmit="return editCheck()">
			<br> <img src="./images/logo.png" alt="Logo" width="100px" height="40px"
					onclick="location.href='home.do'" style="cursor: pointer;"><br>
			<br>
			<h1 class="h4 mb-3" align="center">
				연주자를 위한 커뮤니티,<br> <b>오브리</b>에 오신 것을 환영합니다.
			</h1>
			<br>

			<h2 class="h6 fw-bold" align="center">필수 입력 항목</h2>
			<hr>

			<div class="row mb-3" hidden>
				<label for="userId" class="form-label mb-0" align="left">아이디</label>
				<div class="row mb-0 g-1 align-items-center">
					<div class="col-9 mb-1">
						<input type="text" class="form-control" id="userId" name="userId"
							value="${userId}" readonly>
					</div>
				</div>
			</div>

			<div class="row mb-3">
				<button class="btn w-100 pr-100 fw-bold" type="button"
					onclick="location.href='editPw.do';">비밀번호 변경하기</button>
			</div>

			<div class="row mb-3">
				<label for="userName" class="form-label" align="left">성명</label> <input
					type="text" class="form-control" id="userName" name="userName"
					value="${editm.userName}">
			</div>
			<div class="form-text mb-2" id="nameGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userPhone" class="form-label" align="left">휴대폰번호</label>
				<input type="text" maxlength="11"
					oninput="this.value=this.value.replace(/[^0-9.]/g, '');"
					class="form-control" id="userPhone" name="userPhone"
					value="${editm.userPhone}">
			</div>
			<div class="form-text mb-2" id="phoneGuide" align="left"></div>

			<div class="row mb-3">
				<label for="userEmail" class="form-label" align="left">이메일</label> <input
					type="text" class="form-control" id="userEmail" name="userEmail"
					value="${editm.userEmail}">
			</div>
			<div class="form-text mb-2" id="emailGuide" align="left"></div>
			<br>
			<h2 class="h6 fw-bold" align="center">선택 입력 항목</h2>
			<hr>

			<div class="row mb-3">
				<label for="userMajor" class="form-label" align="left">전공</label> <input
					type="text" class="form-control" id="userMajor" name="userMajor"
					value="${editm.userMajor}">
			</div>

			<div class="row mb-3">
				<label for="userGru" class="form-label" align="left">졸업유무</label> <select
					class="form-select" name="userGru" id="userGru">
					<option value="N">선택</option>
					<option value="Y"
						<c:if test="${userGru == 'Y'}">${'selected'}
            </c:if>>네</option>
					<option value="N"
						<c:if test="${userGru == 'N'}">${'selected'}
            </c:if>>아니요</option>
				</select>
			</div>

			<br>
			<button class="btn w-100 pr-100 fw-bold" type="submit">수정</button>

			<p class="mt-5 mb-3 text-body-secondary" align="center"
				style="font-size: 90%">
				계정 삭제를 원하시나요?&nbsp;<a href="delMem.do" style="color: gray">회원탈퇴</a>
			</p>

			<p class="mt-2 mb-3 text-body-secondary" align="center"
				style="font-size: 80%">&copy; 2023. 1조</p>
		</form>
	</main>
</body>
</html>