<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="loginOutLink"
	value="${sessionScope.userId==null ? 'login.do' : 'logout.do'}" />
<c:set var="loginOut"
	value="${sessionScope.userId==null ? '로그인' : '로그아웃'}" />
<c:set var="myPageLink"
	value="${sessionScope.userId==null ? 'join.do' : 'mypage_Apply.do'}" />
<c:set var="myPage"
	value="${sessionScope.userId==null ? '회원가입' : '마이페이지'}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>
<!-- 부트스트랩 CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<!-- navbar start -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<a class="navbar-brand ml-5 my-auto py-auto" href="<c:url value='/home.do'/>"><img
			src="./images/logo.png" alt="Logo" width="90px" height="35px"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-between font-weight-bold" id="navbarNav">
			<ul class="navbar-nav ml-5">
					<li class="nav-item pr-3"><a class="nav-link"
						href="joblist.do">구인</a></li>
					<li class="nav-item pr-3"><a class="nav-link" href="prCardList.do">홍보</a>
					</li>
					<li class="nav-item pr-3"><a class="nav-link" href="boardList.do">커뮤니티</a>
					</li>
					<li class="nav-item pr-3"><a class="nav-link" href="notice_list.do">공지</a>
					</li>
			</ul>
			<ul class="navbar-nav mr-5">
				<li class="nav-item pl-3"><a class="nav-link"
					href="<c:url value='${myPageLink}'/>"><i class="fas fa-user"></i>
						${myPage}</a></li>
				<li class="nav-item pl-3"><a class="nav-link"
					href="<c:url value='${loginOutLink}'/>"><i
						class="fas fa-right-to-bracket"></i> ${loginOut}</a></li>
			</ul>
		</div>
	</nav>
	<!-- navbar end -->

	<!-- 부트스트랩 JS 및 jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>