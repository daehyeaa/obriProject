<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- jsp파일에서 프로퍼티 설정 -->
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@property('naverId.login.develApp.key')" var="client_Id"/> --%>

<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>로그인</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/login.css" type="text/css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 네이버 로그인 -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<!-- 카카오 로그인 -->
<script type="text/javascript"
	src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	function check() {
		if ($.trim($("#userId").val()) == "") {
			alert("아이디를 입력하세요.");
			$("#userId").val("").focus();
			return false;
		}
		if ($.trim($("#userPw").val()) == "") {
			alert("비밀번호를 입력하세요.");
			$("#userPw").val("").focus();
			return false;
		}
	}
</script>
</head>

<body class="d-flex align-items-center justify-content-center min-vh-100 py-4 bg-body-tertiary">
    <main class="form-signin w-500 m-auto">
		<form method="post" action="checkLogin.do" onsubmit="return check()">
			<input type="hidden" name="login_ok" value="1" />
			<div id="logo">
				<img src="./images/logo.png" alt="Logo" width="100px" height="40px"
					onclick="location.href='home.do'" style="cursor: pointer;">
			</div>
			<br>
			<h1 class="h4 mb-3" align="center">
				연주자를 위한 커뮤니티,<br> <b>오브리</b>에 오신 것을 환영합니다.
			</h1>
			<br>
			<div class="form-floating">
				<input type="text" class="form-control" id="userId" name="userId"
					placeholder="id"> <label for="userId">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="userPw"
					name="userPw" placeholder="pw"> <label for="userPw">비밀번호</label>
			</div>

			<button class="btn w-100 pr-100 fw-bold" type="submit">로그인</button>
			<br> <br>

			<h2 class="h6 fw-bold" align="center">SNS 계정으로 로그인</h2>
			<hr>

			<div class="d-flex justify-content-center column-gap-3">
				<!-- 네이버 로그인-->
				<div id="naver_id_login"></div>
				<script type="text/javascript">
				
				// .gitignore 
					var naver_id_login = new naver_id_login("",
							"http://localhost/obriProject/loginNaver.do");
				
					var state = naver_id_login.getUniqState();
					naver_id_login.setButton("green", 1, 40);
					naver_id_login
							.setDomain("http://localhost/obriProject/login.do");
					naver_id_login.setState(state);
					//	naver_id_login.setPopup();		// 팝업 방식 해제
					naver_id_login.init_naver_id_login();
				</script>

				<!-- 카카오 로그인 -->
				<div id="kakao_id_login">
					<a href="javascript:loginWithKakao()"> <img
						src="./images/kakao_logo.png" style="width: 40px; height: 40px;" />
					</a>
				</div>
			</div>
			<script type="text/javascript">
			
			// .gitignore  
				Kakao.init('');
			
				//console.log(Kakao.isInitialized());

				function loginWithKakao() {
					Kakao.Auth.login({
						success : function(authObj) {
							//console.log(authObj);
							Kakao.Auth.setAccessToken(authObj.access_token);
							getInfo();
						},
						fail : function(err) {
							//console.log(err);
						},
					})
				}
				function getInfo() {
					Kakao.API.request({
						url : '/v2/user/me',
						success : function(res) {
							//console.log(res);
							//console.log(res.id);
							//console.log(res.kakao_account.profile.nickname);
							kakaoLoginCallback(res);
						},
						fail : function(error) {
							alert('카카오 로그인에 실패했습니다.' + JSON.stringify(error));
						}
					});
				}
				function kakaoLoginCallback(res) {
					id = res.id;
					nickname = res.kakao_account.profile.nickname;

					$
							.ajax({
								type : 'POST',
								url : 'joinKakaoMem.do',
								data : {
									'userId' : id,
									'userName' : nickname
								},
								success : function(result) {
									if (result == "Y") {
										alert('환영합니다. ' + nickname
												+ '님!\n오브리에서 다양한 연주자들과 소통하세요.');
										location.href = "home.do";
									} else if (result == "N") {
										alert('탈퇴한 계정입니다.\n소셜로그인으로 재가입을 원하실 경우 문의 메일을 남겨주세요.');
										location.href = "home.do";
									} else if (result == "X") {
										alert('관리자에 의해 사용이 정지된 계정입니다.');
										location.href = "home.do";
									} else {
										alert('카카오 로그인에 실패했습니다.\n가입 후 로그인을 시도해주세요.');
										location.href = "login.do";
									}
								},
								error : function(result) {
									alert('카카오 로그인에 실패했습니다.\n가입 후 로그인을 시도해주세요.');
									location.href = "login.do";
								}
							});
				}
				function kakaoLogout() {
					if (!Kakao.Auth.getAccessToken()) {
						alert('Not logged in.');
						return;
					}
					Kakao.Auth.logout(function() {
						alert('logout ok\naccess token -> '
								+ Kakao.Auth.getAccessToken());
					});
				}
			</script>

			<p class="mt-4 mb-3 text-body-secondary" align="center"
				style="font-size: 90%">
				<a href="findId.do" style="color: gray">아이디 찾기</a>&nbsp;|&nbsp;<a
					href="findPw.do" style="color: gray">비밀번호 찾기</a><br>아직 회원이
				아니신가요?&nbsp;<a href="join.do" style="color: gray">회원가입</a>
			</p>

			<p class="mt-3 mb-3 text-body-secondary" align="center"
				style="font-size: 80%">&copy; 2023. 1조</p>
		</form>
	</main>
</body>
</html>