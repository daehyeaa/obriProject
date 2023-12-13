<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 1}">
	<script>
		alert("존재하지 않는 회원 입니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 2}">
	<script>
		alert("관리자에 의해 사용이 정지된 계정입니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 3}">
	<script>
		alert("인증되지 않은 계정입니다.\n메일 인증을 완료해주시기 바랍니다.")
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 4}">
	<script>
		alert("회원 정보가 일치하지 않습니다.");
		history.go(-1);
	</script>
</c:if>