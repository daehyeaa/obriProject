<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
console.log("왜안돼??");
console.log("여기 들어왔나요???");

	$(function(){
		// 수정 버튼 클릭
		// .load 모든것을 가져오는것
		$('.redit').click(function(){
			console.log("클릭할때 떠야해");
			var id = $(this).attr('id');
			var jobNo = $(this).attr('data-jobNo');

			var text = $('#td_'+id).text();
			$('#td_'+id).html("<textarea rows='5' cols='60' id='tt_"+id+"'>"
							  			 +text+"</textarea>");
			$('#btn_'+ id).html( // 안의 내용을 바꾸는거 .html은
				"<input type='button' value='확인' onclick='reUp("+id+","+jobNo+")'> "
			   +"<input type='button' value='취소' onclick='rstop("+jobNo+")'>");	
		});
	});
	function reUp(id,jobNo){  // 수정 버튼
		console.log("수정은 들어왔니?");
		var jobReText = $('#tt_'+ id).val();
		var formData = "jobReNo="+id+'&jobReText='+jobReText
			+"&jobNo="+jobNo;
			$.post('${path}/reUpdate.do',formData, function(data) {
				$('#rlist').html(data);
			});
	}
	function rstop(jobNo) { // 취소 버튼
		$('#rlist').load('${path}/rlist/jobNo/'+jobNo+'/let.do');
	}
	function del(jobReNo,jobNo){ // 댓글 삭제
		var formData="jobReNo="+jobReNo+"&jobNo="+jobNo;
		$.post("${path}/reDelete.do",formData,function(data){
			$('#rlist').html(data);
		});
	}		
</script>

</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">댓글</h2>
		<table>
			<tr>
				<td>작성자</td>
				<td>내용</td>
				<td>수정일</td>
				<td></td>
				
			</tr>
			<c:forEach var="jrb" items="${rlist}">
				<tr>
					<td>${jrb.userId}</td>
					<td id="td_${jrb.jobReNo}">${jrb.jobReText}</td>
					<td>${jrb.jobReUpdate}</td>
					<td>${jrb.jobNo}</td>
					<td id="btn_${jrb.jobReNo}">
						<c:if test="${jrb.userId == sessionScope.userId}">
							<input type="button" value="수정" class="redit" id="${jrb.jobReNo}" data-jobNo="${jrb.jobNo}">
							<input type="button" value="삭제" onclick="del(${jrb.jobReNo},${jrb.jobNo})">
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table> 
	</div>
	<%-- <div class="card my-4">
		<h5 class="card-header">댓글쓰기</h5>
		<div class="card-body">
			<form name="comment-form" action="/board/comment/write" method="post" autocomplete="off">
				<div class="form-group">
					<input type="hidden" name="jobReRel" value="${jobReRel}" />
					<textarea name="content" class="form-control" rows="3"></textarea>
				</div>
				<button type="submit" class="btn btn-primary">입력</button>
			</form>
		</div>
	</div> --%>
</body>
</html>