<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>

<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/animation.css">
<link rel="stylesheet" href="./css/intro.css">

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
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>

<script>
	// 숫자 카운트 애니메이션
	(function($) {
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
	})(jQuery);
</script>
</head>

<body class="bg-body-tertiary">
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<main class="mt-2 mb-2 pt-5 pb-5">

		<!-- header start -->
		<section class="header p-2">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>
		<!-- header end -->
		<br> <br>
		<!-- animation start -->
		<section class="animation p-2">
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
		<section class="intro p-2">
			<div class="container mb-3">
				<div class="banner">
					<div class="bann_icon">
						<i class="fa-solid fa-magnifying-glass"></i>
					</div>
					<div class="bann_text">
						<p>최신 구인글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"
						style="width: 500px; height: 300px;" class="no-margin"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='boardList.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
			<div class="container mb-3">
				<div class="banner">
					<div class="bann_icon">
						<i class="fa-regular fa-comments"></i>
					</div>
					<div class="bann_text">
						<p>최신 커뮤니티글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"
						style="width: 500px; height: 300px;" class="no-margin"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='boardList.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
		</section>
		<br> <br>
		<!-- intro end -->
	</main>
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>