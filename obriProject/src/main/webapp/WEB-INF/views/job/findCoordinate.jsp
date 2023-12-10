<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

지역명을 입력 하세요?
<form method="post" action="findCoordinate.do">
	주소 : <input type="text" name="address" required="required">
<input type="submit" value="검색">
</form>

</body>
</html>