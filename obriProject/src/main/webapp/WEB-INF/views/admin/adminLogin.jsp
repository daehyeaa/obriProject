<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>관리자 로그인</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin/adminLogin.css" type="text/css">
	
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
 function check(){
	 if($.trim($("#id").val())==""){
		 alert("로그인 아이디를 입력하세요!");
		 $("#id").val("").focus();
		 return false;
	 }
	 if($.trim($("#pw").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#pw").val("").focus();
		 return false;
	 }
 }
</script>
<style>
.logo-image {
    display: block;
    margin: 0 auto;
}
</style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100 bg-body-tertiary">
    <main class="form-signin text-center w-75">
		<img src="./images/logo.png" width="100px" height="40px" class="logo-image">
		<form method="post" action="admin_login_ok.do" onsubmit="return check()">
			<h1 class="h2 mb-3 fw-bold" align="center">관리자 로그인</h1>

			<div class="form-floating">
				<input type="text" class="form-control" id="id" name="id"> 
				<label for="ID">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="pw" name="pw"> 
				<label for="Password">Password</label>
			</div>

			<button class="btn btn-light w-100 pr-2" type="submit">Login</button>
			<p class="mt-5 mb-3 text-body-secondary">&copy; 2023. 1조</p>
		</form>
	</main>
</body>
</html>