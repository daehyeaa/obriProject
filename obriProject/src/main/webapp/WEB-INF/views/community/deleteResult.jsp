<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>


<c:if test="${result == 1 }">
	<script>
		alert("삭제성공!");
		location.href = "boardList.do?pageNum=${pageNum}";
	</script>
</c:if>




