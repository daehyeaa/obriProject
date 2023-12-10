<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="loginOutLink"
	value="${sessionScope.userId==null ? 'login.do' : 'logout.do'}" />
<c:set var="loginOut"
	value="${sessionScope.userId==null ? '로그인' : '로그아웃'}" />
<c:set var="myPageLink"
	value="${sessionScope.userId==null ? 'join.do' : 'editCheck.do'}" />
<c:set var="myPage"
	value="${sessionScope.userId==null ? '회원가입' : '마이페이지'}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/animation.css">
<link rel="stylesheet" href="./css/intro.css">

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>

<script>
	// 숫자 카운트 애니메이션
	$(function() {
		numCount();
	});
	function numCount() {
		$('.numCount').text($('input[id=num]').val())
		$('.numCount').each(function() {
			var t = $(this);
			$({
				Counter : 0
			}).delay(200).animate({
				Counter : t.text().replace(/,/g, "")
			}, {
				duration : 1800,
				easing : 'swing',
				step : function() {
					t.text(Math.ceil(this.Counter));
				},
				complete : function() {
					t.text(Math.ceil(this.Counter));
				}
			});
		});
	}
</script>

<script>
	$(function() {
		$("#navbar_toggle_btn").click(function() {
			$("#navbar_menu").toggle();
			$("#navbar_icons").toggle();
		});
	});
</script>

</head>

<body>
	<!-- navbar start -->
	<nav class="navbar">
		<div class="navbar_logo" id="navbar_logo">
			<a href="<c:url value='/home.do'/>"><img src="./images/184.png"></a>
		</div>
		<ul class="navbar_menu" id="navbar_menu">
			<li><a href="joblist.do">구인</a></li>
			<li><a href="prCardList.do">홍보</a></li>
			<li><a href="board_list.do">커뮤니티</a></li>
			<li><a href="board_list.do">공지</a></li>
		</ul>
		<ul class="navbar_icons" id="navbar_icons">
			<li><a href="<c:url value='${loginOutLink}'/>"> <i
					class="fa-solid fa-user"></i>&nbsp;&nbsp;${loginOut}
			</a></li>
			<li><a href="<c:url value='${myPageLink}'/>"> <i
					class="fa-solid fa-right-to-bracket"></i>&nbsp;&nbsp;${myPage}
			</a></li>
		</ul>
		<a href="#" class="navbar_toggle_btn" id="navbar_toggle_btn"> <i
			class="fa-solid fa-bars"></i>
		</a>
	</nav>
	<!-- navbar end -->

	<main style="padding-top: 80px; padding-bottom: 80px">

		<!-- header start -->
		<section class="header">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>
		<!-- header end -->

		<!-- animation start -->
		<section class="animation">
			<div class="num_container">
				<div class="num_item">
					<h2 class="title">누적 회원 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#444;">111</lable>
					<span class="unit">명</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 구인건 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#444;">222</lable>
					<span class="unit">건</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 좋아요 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#444;">333</lable>
					<span class="unit">개</span><br>
				</div>
			</div>
		</section>
		<!-- animation end -->

		<!-- intro start -->
		<section class="intro">
			<div class="container">
				<div class="banner">
					<div class="ban_img">
						<img src="./images/banner.png" alt="">
					</div>
					<div class="ban_text">
						<p>최신 구인글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='board_list.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
			<div class="container">
				<div class="banner">
					<div class="ban_img">
						<img src="./images/banner.png" alt="">
					</div>
					<div class="ban_text">
						<p>최신 커뮤니티글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='board_list.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
		</section>
		<!-- intro end -->

	</main>

	<!-- footer start -->
	<footer class="nav_foot">
		<div class="nav_container">
			<h2>오브리</h2>
			<p>O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
		</div>
		<ul class="nav_menu">
			<li><a href="">공지사항</a></li>
			<li><a href="">문의하기</a></li>
			<li><a href="">개인정보 처리방침</a></li>
			<li><a href="">서비스 이용약관</a></li>
		</ul>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</footer>
	<!-- footer end -->
</body>
</html>