<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="java.util.*"%>
<%@ page import="music.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
<link rel="stylesheet" href="./css/mainTable.css">
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
<script>
	function showlist() {
		window.parent.location.href = 'boardList.do';
	}
</script>
</head>
<body>
	<table>
		<tr>
			<th width="50%">제목</th>
			<th width="20%">작성자</th>
			<th width="20%">날짜</th>
			<th width="5%"><i class="fas fa-light fa-eye"></i></th>
			<th width="5%"><i class="fas fa-light fa-thumbs-up"></i></th>
		</tr>
		<tbody>
			<c:forEach var="community" items="${list}">
				<c:if test="${community.commDelYn != 'Y'}">
					<tr align="center">
						<td class="truncate-text" align="center" width="50%"><fmt:formatDate
								var="today" value="<%=new Date()%>" pattern="yy/MM/dd" /> <fmt:formatDate
								var="dbtoday" value="${community.commDate}" pattern="yy/MM/dd" />
							<a href="javascript:showlist();"> <c:set var="truncatedSub"
									value="${fn:substring(community.commSub, 0, 15)}" />
								${truncatedSub} <c:if
									test="${fn:length(community.commSub) > 15}">...</c:if> <!-- 조회수 30 이상이면 -->
								<c:if test="${dbtoday == today}">
									<img alt="" src="images/new.png" width="20" height="10">
								</c:if>
						</a></td>

						<td width="20%">${community.userId}</td>
						<td width="20%"><fmt:formatDate value="${community.commDate}"
								pattern="yy/MM/dd" /></td>
						<td width="5%">${community.commCount}</td>
						<td width="5%">${community.likeCnt}</td>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>