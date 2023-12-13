<%@page import="music.model.jobBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구인게시판 글 수정 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var jobFin = '${jb.jobFin}'
</script>
<script src="./js/job_board.js"></script>
<script>
	$(function() {

		$("#jobFin").click(function() {
			if ($("#jobFin").is(":checked")) {
				$(this).val("Y");
			} else {
				$(this).val("N");
			}
		});

		  	var jobFinValue = "${jb.jobFin}";
		      if (jobFinValue == 'Y') {
		         $("#jobFin").prop('readonly', true);
		         $("#jobFin").prop('checked', true);
		         $("#jobFin").prop('disabled', true);
     		}
	});
	
</script>
<script>
$(function() {
    var jobCdValue = "${jb.jobCd}";

    // jobCd에 해당하는 라디오 버튼을 체크
    $("input[name='jobCd'][value='" + jobCdValue + "']").prop('checked', true);
    
});
</script>
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
	<form method="post" action="edit_ok.do" onSubmit="return check()">
		<input type="hidden" name="userId" value="${jb.userId}">
		<input type="hidden" name="jobNo" value="${jb.jobNo}"> 
		<input type="hidden" name="pageNum" value="${pageNum}">
		<input type="hidden" id="fin" value="${jb.jobFin}">
		<table border="1" width="500px" height="300px" align="center">
			<tr>
				<td colspan="2">
					<input type="checkbox" id="jobFin" name="jobFin1" value="N">공연후 체크
				</td>
			</tr>
			<tr>
				<th width="40px">모집인원</th>
				<td width="480px"><input type="text" id="jobSpace"
					name="jobSpace" class="form-control" size="4"
					value="${jb.jobSpace}">명</td>
			</tr>
			<tr>
				<th width="40px">모집 마감일</th>
				<td width="480px"><input type="date" id="jobEndDate"
					name="jobEndDate2"></td>
			</tr>
			<tr>
				<th width="40px">행사일</th>
				<td width="480px"><input type="date" id="jobConcert"
					name="jobConcert2"></td>
			</tr>
			<tr>
				<th width="40px">장소</th>
				<td width="480px">
				<input type="text" id="jobAddress" name="jobAddress" 
					   value="${jb.jobAddress}">
				<input type="button" value="주소검색" onClick="openDaumPostcode()">
				</td>
			</tr>
			<tr>
				<th width="40px">분류</th>
				<td width="480px">
					<input type="radio" name="jobCd" id="e1" value="결혼식">결혼식 
					<input type="radio" name="jobCd" id="e2" value="종교행사">종교행사 
					<input type="radio" name="jobCd" id="e3" value="사내행사">사내행사 
					<input type="radio" name="jobCd" id="e4" value="기내행사">기내행사
				</td>
			</tr>
			<tr>
				<th width="40px">제목</th>
				<td width="480px"><textarea class="form-control" rows="3" cols="500"
						width="140px" id="jobSub" name="jobSub">${jb.jobSub}</textarea></td>
			</tr>
			<tr>
				<th width="40px">내용</th>
				<td width="480px"><textarea class="form-control" rows="20"
						cols="4000" width="140px" id="jobText" name="jobText">${jb.jobText}</textarea>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" width="500px">
				<input type="submit" value="확인">
				<input type="button" value="취소" onClick="history.go(-1);">
			</td>
			</tr>
		</table>
	</form>
</body>
</html>