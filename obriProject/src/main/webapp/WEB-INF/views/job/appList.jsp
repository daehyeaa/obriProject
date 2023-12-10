<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모달 신청자 리스트</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
$(documnet).ready(function (){
	

	
});

function del(jobNo, appNo){
	console.log("삭제 들어오기");
// 	var 
}

</script>
</head>
<body>
	
	<div class="container" align="center">
		<table>
			<tr>
				<td>신청번호</td>
				<td>신청자ID</td>
				<td>신청자이름<td>
				<td>승인여부</td>
			</tr> 
			<c:forEach var="app" items="${applist}">
				<tr>
					<td>${app.appNo}</td>
<%-- 					<td id="td_${app.appNo}">${jrb.jobReText}</td> --%>
					<td>${app.userId}</td>
					<td>${app.appName}</td>
					<td>${app.appCheck}<td>
					<td id="btn_${app.appNo}">
							<input type="button" value="확정" class="appConfirm" id="appConfirm" data-jobNo="${app.jobNo}" data-appNo="${app.appNo}">
							<input type="button" value="취소" onclick="del(${app.jobNo},${app.appNo})">
							<input type="button" value="쪽지" class="msgModal" id="msgModal" data-jobNo="${app.jobNo}" data-appNo="${app.appNo}">
					</td>
				</tr>
			</c:forEach>
		</table>
	
	</div>
	
</body>
</html>