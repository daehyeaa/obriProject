<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job</title>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
<style>
li{
	display: inline;
	list-style: none;
}

li a{
	text-decoration: none;
	font-size: 24pt;
	color: #444;
}
</style>
</head>
<body>
	<ul>
		<!-- 쪽지보내기 버튼 -->
		<c:if test="${sessionScope.userId != null && sessionScope.userId != jobBoardVO.userId}">
			<li><a href=""><i class="fa-solid fa-envelope"></i>
			</a></li>
		</c:if>
		<!-- 신청하기 버튼 -->
		<c:if test="${sessionScope.userId != null && sessionScope.userId != jobBoardVO.userId}">
			<li><a href=""><i class="fa-solid fa-check"></i>
			</a></li>
		</c:if>
		<!-- 신청자목록보기 버튼 -->
		<c:if test="${sessionScope.userId != null && sessionScope.userId == jobBoardVO.userId}">
			<li><a href="appList.do"><i class="fa-solid fa-list"></i>
			</a></li>
		</c:if>
		<!-- 신청자수 -->
		<div>
			<p>신청자수 : ${jobAppVO.appNo}</p>
		</div>
	</ul>
</body>
</html>