<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath }" />

<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<!-- <script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

<style>
* {
	position: static;
}

.table {
	display: table;
	width: 600px;
}

#tr {
	display: table-row;
	margin-right: 33%;
}

.td {
	display: table-cell;
	display: inline-table;
	margin: 10px;
	max-width: 600px;
	word-wrap: break-word; "
	text-align: left;
}

#writer {
	width: 100%;
	text-align: left;
	display: table-row;
	height: auto;
	text-overflow: ellipsis;
	word-break: break-all;
	word-wrap: break-word;
}

.text {
	display: inline-table;
	text-overflow: ellipsis;
	word-break: break-all;
	word-wrap: break-word;
	max-width: 550px;
	margin: auto;
	text-align: left;
}

.group {
	margin-left: 30%;
	align-content: left;
	text-overflow: ellipsis;
	text-align: start;
	height: auto;
	width: 100%;
}

#reInsert {
	margin-left: 52%;
}

textarea {
	resize: none;
}

.my-custom-page {
	margin: 0 auto !important;
}
</style>

<script type="text/javascript">
<%-- var sessionId = '<%=(String)session.getAttribute("userId")%>'; --%>
	
	var pageGingPage; // pageNumber
	var rowUserId; // 쪽지를 보낼때 수신자 ID

	$(function() {
		console.log("넘버"+${jobBoard.jobNo});
 		$('#rlist').load('${path}/rlist/jobNo/${jobBoard.jobNo}/let.do')
 		
 		/* 모달안에 있는 신청자 리스트 .load div = #appList 로 appList에 있는 내용을 가져오기 */
 		//$("#appList").load('${path}/appList/jobNo/${jobBoard.jobNo}/let.do')
		$('#reInsert').click(function() {
			if(!reform.jobReText.value){
				alert('댓글을 입력해주세요.');
				reform.jobReText.focus();
				return false;
			}
			var reformData = $('form').serialize();
			$.post('${path}/rInsert.do', reformData, function(data) {
				$('#rlist').html(data);
				reform.jobReText.value= '';
			});
		});
	});
	
	
	   <!-- 모달 창 뜨고 리스트 조회  -->
	    function jobAppModalPage(currentPage) {
	          console.log("현재페이지 +"+currentPage);
	          pageGingPage = currentPage;
	    
	             $.get('${path}/jobAppList.do',{ pageNum: pageGingPage, jobNo: '${jobBoard.jobNo}' }, function(data){
	                console.log(data);
	                console.log(data.pp.currentPage);
	                console.log(data.pp.rowPerPage);
	                makeApp(data);   // 리스트 출력   
	                movePage(data); // 페이지 이동
	             }).fail(function(error) {
	                console.error('Ajax 요청 실패:' , error);
	             });
	            
	             function makeApp(data){
	            	 // 페이지 이동시 내용을 삭제 하기 위한 처리
	            	 $('#applist table tr#rowApp').remove();
	                $.each(data.appList, function(index, app){
	                	
	                   var row = $('<tr id="rowApp">');
	                      row.append('<td>' +app.APPNO+ '</td>');
	                      row.append('<td>' +app.USERID+'</td>');
	                      row.append('<td>'+app.USERNAME+'</td>');
	                      row.append('<td>'+app.APPCHECK+'</td>');
						  row.append("<td><input type=\"button\" value=\"확정\" id=\"appCheck" + app.APPNO + "\" " + (app.APPCHECK === 'Y' ? 'disabled' : '') + " onclick=\"confirmApp(" + app.JOBNO + "," + app.APPNO + ",'" +app.USERID+ "')\"></td>");						  
	                      row.append('<td>'+ '<input type="button" value="취소" onclick="cancelApp(' + app.JOBNO + ',' + app.APPNO + ')">' + '</td>');// 	                      
	                      row.append("<td><button type=\"button\" id=\"msgModal\" class=\"btn btn-primary\" data-bs-toggle=\"modal\" data-bs-target=\"#appMsgModal\" onclick=\"prepareMessageModal('" +app.USERID+ "', '" +app.USERNAME+ "')\">쪽지</button></td>");

                          $('#applist table').append(row);
	                               
	                });
	             } // end makeApp
	             
	      function movePage(data){        
	            	 
	           // 기존 페이지 제거
 	       	   $('ul').remove();
	            	 	
	           var mPage = $('<ul class="pagination" id="appPage" >');
	              if (data.pp.startPage > data.pp.pagePerBlk) {
	                 var previousButton = $('<li class="page-item"><a class="page-link" onclick="jobAppModalPage(' + (data.pp.startPage - 1) + ')">Previous</a></li>');
	                 mPage.append(previousButton);
	              }
	              for (var i = data.pp.startPage; i <= data.pp.endPage; i++) {
	                  var pageButton = $('<li class="page-item' + (data.pp.currentPage == i ? ' active' : '') + '"><a class="page-link" href="#" onclick="jobAppModalPage(' + i + ')">' + i + '</a></li>');
	                  mPage.append(pageButton);
	              }

	              if (data.pp.endPage < data.pp.totalPage) {
	                   var nextButton = $('<li class="page-item"><a class="page-link" href="#" onclick="jobAppModalPage(' + (pp.endPage + 1) + ')">Next</a></li>');
	                   mPage.append(nextButton);
	              }
	                   mPage.append('</ul>');
	                // paginationContainer를 적절한 위치에 추가 또는 대체하도록 로직 추가
	                   $('#modalPage').append(mPage);
	                
	             }// end movePage
	             
	      } // end jobAppModalPage 
	
	      
	      // 구인 확정
	      function confirmApp(jobNo,appNo , appUserId){
	    	  
	    	  console.log("아아아 "+appUserId);
	  		let formData="jobNo="+jobNo+"&appNo="+appNo+"&userId="+appUserId;
	  		console.log("구인확정"+formData);
 	  		$.post("${path}/confirmApp.do",formData,function(data){
 	  			console.log("성공");
 	  			$('#appCheck'+appNo).prop('disabled', true); // 해당 버튼 비활성화
	  		}).fail(function () {
	  	        console.log("실패");
	  	    });
	  	  }
	      
	      // 구인 취소
	      function cancelApp(jobNo,appNo){ 
	    	let formData="jobNo="+jobNo+"&appNo="+appNo;
	  		console.log("구인취소"+formData);
 	  		$.post("${path}/confirmAppCancel.do",formData,function(data){
//  	  			$('#rlist').html(data);
				console.log("취소 성공");
				// 다시 재조회 해서 취소한 부분이 없어지도록 하기
				jobAppModalPage(pageGingPage);
 	  		}).fail(function (){
 	  			console.log("취소 실패");
 	  		});
	  	  }
	      
	   // 쪽지 버튼 클릭
	      function prepareMessageModal(userId, userName){
		   console.log("쪽지 클릭");
		   $("#receiver").val(userName);
		   rowUserId = userId;
		   console.log("줄의 아이디"+rowUserId);
		   
	   	  }
	  
	    
	   
	   	  function message(){
	   		  let msgText = $("#msgText").val();
	   		  
	   		  if ($.trim($("#msgText").val()) == "") {
	   			alert("메세지를 입력하세요!");
	   			$("#msgText").val("").focus();
	   			return false;
	   		  }
	   		  
	   		  console.log(msgText);
// 	   		  rowUserId = userId; 
			  console.log("정말되요?"+'<%=request.getAttribute("userId")%>');
			  console.log(rowUserId);
	   		  let jsonData = {
	   				userId : '<%=request.getAttribute("userId")%>',
	   				recvId : rowUserId,
	   				msgText : msgText
	   		  };
	   		  
	   		$.ajax({
	 			method: "POST",
	 			url: "msgInsert.do",
	 			contentType : "application/json; charset=utf-8",
	 			data : JSON.stringify(jsonData),
				
	 		}).done(function(data) {
				
	 			console.log(data);
	 				if(data == 1){
	 					alert("전송 성공하였습니다.");
	 					// 쪽지 전송 성공 시 모달 닫기
//  						$("#appMsgModal").modal('hide');
	 					// 위에 $("#appMsgModal").modal('hide'); 안먹혀서 
	 					document.getElementById('appMsgModal').style.display = 'none';
						document.body.classList.remove('modal-open'); // 배경 어두움 제거
						document.querySelector('.modal-backdrop').remove(); // 배경 요소 제거

	 				}else {
	 					alert("전송 실패하였습니다.");
	 				}
	 		});
	   	  }
</script>

</head>
<body>

	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#jobAppModal" onclick="jobAppModalPage(1)">
		신청하기</button>

	<!-- Modal -->
	<div class="modal fade" id="jobAppModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">신청자 목록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="applist" align="center">
						<table>
							<tr>
								<td>신청번호</td>
								<td>신청자ID</td>
								<td>신청자이름
								<td>
								<td>승인여부</td>
							</tr>
						</table>
					</div>

					<!-- pagination -->
					<div class="pageDiv my-custom-page">
						<!-- Pagination -->
						<nav aria-label="Page navigation example" id="modalPage"></nav>
					</div>
					<!-- pagination 끝 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>
	<form id="reform" name="reform" style="margin-left: 30%;">
		<input type="hidden" name="userId" value="${sessionScope.userId}">
		<input type="hidden" name="jobNo" value="${jobBoard.jobNo}">
		<textarea rows="5" cols="80" name="jobReText" id="jobReText"></textarea>
		<br> <br>
		<c:if test="${!empty sessionScope.userId}">
			<input type="button" value="댓글" id="reInsert">
		</c:if>
	</form>
	<br>
	<br>
	<div id="rlist" align="center"></div>

	<!-- 쪽지 모달 -->
	
	<div class="modal fade" id="appMsgModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">New message</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form>
						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">수신자:</label>
							<input type="text" class="form-control" id="receiver" readonly>
						</div>
						<div class="mb-3">
							<label for="message-text" class="col-form-label">Message:</label>
							<textarea class="form-control" id="msgText"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="msgSend" onclick="message()">쪽지 보내기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>