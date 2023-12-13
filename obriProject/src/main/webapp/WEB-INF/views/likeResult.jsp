<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 1 }">
	<script>
		 
		alert("좋아요가 선택 되었습니다.");	
		location.href="boardContent.do?commNo=${commNo}&pageNum=${pageNum}";
	</script>
</c:if>




