<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="table">
	<table border="1" width="600">
		<tr>
			<td align="center">이름</td>
			<td align="center">전공</td>
			<td align="center">승인</td>
			<td align="center">취소</td>
			<td align="center">쪽지</td>
		</tr>
		<c:forEach var="app" items="${applist}">
			<tr>
				<td align="center">${member.userName}</td>
				<td align="center">${member.userMajor}</td>
				<td align="center">오브리 횟수</td>
				<td><input type="button" value="승인" onclick=""></td>
				<td><input type="button" value="취소" onclick=""></td>
				<td><input type="button" value="쪽지" onclick=""></td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>