<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<c:if test="${result == 1 }">
	<script>
		alert("수정 성공");
 		location.href="boardContent.do?commNo=${commNo}&pageNum=${pageNum}";  
  	</script>
</c:if>

<c:if test="${result != 1 }">
	<script>
		alert("수정 실패");
		history.go(-1);
	</script>
</c:if>


