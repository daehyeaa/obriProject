<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구인게시판 글 작성 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="<%=request.getContextPath() %>/js/job_board.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {		
				document.getElementById('jobAddress').value = data.address;				
			}
		}).open();
	}
</script>

<style>
table tr td {
	text-overflow: ellipsis;
	white-space: nowrap;
	max-width: 140px;
}

table {
	margin-left: auto;
	margin-right: auto;
}

textarea {
	width: 98%;
	border: none;
	resize: none;
}
</style>

</head>
<body>
	<form method="post" action="write_ok.do" onSubmit="return check()">
		<input type="hidden" name="userId" value="${jb.userId}">
		<table border="1" width="500px" height="300px" align="center">

			<tr>
				<th width="20px">모집인원</th>
				<td width="480px"><input type="text" name="jobSpace"
					class="form-control" size="4">명</td>
			</tr>
			<tr>
				<th width="20px">모집 마감일</th>
				<td width="480px"><input type="date" name="jobConcert1"></td>
			</tr>
			<tr>
				<th width="20px">공연일</th>
				<td width="480px"><input type="date" name="jobEndDate1"></td>
			</tr>
			<tr>
				<th width="20px">장소</th>
				<td width="480px">
				<input type="text" id="jobAddress" name="jobAddress">
				<input type="button" value="주소검색" onClick="openDaumPostcode()">
				</td>
			</tr>
			<tr>
				<th width="20px">분류</th>
				<td width="480px">
					<input type="radio" name="jobCd" id="e1" value="결혼식">결혼식 
					<input type="radio" name="jobCd" id="e2" value="종교행사">종교행사
					<input type="radio" name="jobCd" id="e3" value="사내행사">사내행사 
					<input type="radio" name="jobCd" id="e4" value="기내행사">기내행사</td>
			</tr>
			<tr>
				<th width="20px">제목</th>
				<td width="480px"><textarea class="form-control" rows="3" cols="500"
						width="140px" id="jobSub" name="jobSub"></textarea></td>
			</tr>
			<tr>
				<th width="20px">내용</th>
				<td width="480px"><textarea class="form-control" rows="20"
						cols="4000" width="140px" id="jobText" name="jobText"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" width="500px"><input
					type="submit" value="확인"></td>
			</tr>
		</table>
	</form>
</body>
</html>