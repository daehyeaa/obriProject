<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${result == 2 }">
	<script>
		alert("파일은 1MB까지 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 3 }">
	<script>
		alert("첨부파일은 jpg,jpeg, gif, png파일만 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>

