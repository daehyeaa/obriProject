<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/proposal.css?after" rel="stylesheet">

<!-- 메시지 관련 js파일 -->
<%-- <script src="${path}/js/mypage/message.js"></script> --%>

<script type="text/javascript">
 	// 전체 선택
	function toggleAllCheckboxes() {
		var selectAllCheckbox = document.getElementById("selectAll");
		var msgNoCheckboxes = document.getElementsByName("check_msgno");
		
		for (var i = 0; i < msgNoCheckboxes.length; i++) {
			msgNoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}
	
 	// 삭제 버튼
 	function selectOneDel(msgNo) {
		if(!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		
		// 선택한 msgNo 저장해 둘 배열 선언
		var msgNoArray = new Array();
		msgNoArray.push(msgNo);
		console.log("msgNoArray : " + msgNoArray);
		
		if(msgNoArray.length == 1) {
			// 삭제 실행
			$.ajax({
				type: "DELETE",
				url: "deleteSelectMsg.do?msgNo=" + msgNoArray[0],
				success: function(result) {
			     	if (result.code == 1) {
			     		// 성공
			    	} else if(result.code == -1) {
						alert("항목 선택 삭제 실패");
			        }
				},
				error:function(e){
			    	// alert("data error : "+e);
			    },
				complete: function() {
					alert("1개 데이터 삭제 성공!");
	        		location.reload();
				}
			});
		} else {
			alert("항목 선택 삭제 실패");
		}
 	}
	
 	// 체크박스 다중 선택 삭제
	function check_selectDel() {
		if($("input[name='check_msgno']:checked").length == 0 ){
			alert("선택된 항목이 없습니다.");
			return;
		}
		
		if(confirm("정말 삭제하시겠습니까?")==false) {
			return;
		}
				
		// 선택한 msgNo 저장해 둘 배열 선언
		var msgNoArray = new Array();
 		$("input[name='check_msgno']:checked").each(function() {
		      // 선택된 체크박스 값(msgNo)을 배열에 추가
		      msgNoArray.push($(this).val());
		});
		console.log("msgNoArray : " + msgNoArray);
		
		var deleteCount = 0; // 삭제된 항목 수
        // 삭제 요청이 완료될 때마다 호출되는 함수
        function onDeleteComplete() {
            deleteCount++;

            // 모든 삭제 요청이 완료되면 페이지 리로드
            if (deleteCount === msgNoArray.length) {
            	console.log("deleteCount : " + deleteCount);
            	alert("선택 항목 삭제 성공!");
            	location.reload();
            }
        }		
		
		// 반복문으로 삭제 진행
		for(var i = 0; i < msgNoArray.length; i++) {
			$.ajax({
				type: "DELETE",
				url: "deleteSelectMsg.do?msgNo=" + msgNoArray[i],
				success: function(result) {
		            if (result.code == 1) {
		                // 삭제 성공
		            } else if(result.code == -1) {
						alert("항목 선택 삭제 실패");
		            }
				},
				error:function(e){
		    		// alert("data error : "+e);
		    	},
				complete: onDeleteComplete // AJAX 요청이 완료되면 호출될 콜백 함수
			});
		}
	}
</script>

<style type="text/css">
.cp_item_bot {
	width: 100%;
	text-align: center;
}

.cp_item_bot_Left {
	width: 100%;
	text-align: left;
}

.cp_item_bot .cp_wanted_modify {
	font-size: 12px;
	color: rgb(64, 64, 64);
	line-height: 2em;
	text-align: center;
	border: 1px solid rgb(190, 190, 190);
	border-radius: 4px;
	padding: 5px;
	box-sizing: border-box;
}

.cp_item_bot_Left .cp_wanted_modify {
	font-size: 12px;
	color: rgb(64, 64, 64);
	line-height: 2em;
	text-align: center;
	border: 1px solid rgb(190, 190, 190);
	border-radius: 4px;
	padding: 5px;
	box-sizing: border-box;
}
</style>
</head>

<form id="chkNoForm">
<div id="wrap">
	<div id="pp_wrap">
		<div class="pp_menu">
			<p class="pp_title">✉️쪽지함</p>
			<ul>
				<li class="pp_proposal"><a href="messagebox_rcv.do">rcv</a></li>
				<li class="pp_position"><a href="messagebox_snd.do">send</a></li>
			</ul>
		</div>


		<div class="pp_contents">
			<p class="pp_sub_title">📩 받은 쪽지함</p>
			<!-- 검색창 -->
			<div class="pp_search">
				<form name="searchProposal" action="messagebox_rcv.do">
					<input id="keyInTxt" type="text" placeholder="내용/수신인 검색"
						name="keyInTxt"
						value="${sessionScope.referer != null ? sessionScope.referer.keyInTxt : ''}">
					<button class="btn_search" type="submit"></button>
				</form>
			</div>

			<!-- 삭제버튼 -->
			<div class="pp_search">
				<div class="cp_item_bot_Left">
					<a class="cp_wanted_modify" id="deleteBtnMsg" onclick="check_selectDel();">선택 삭제</a>
				</div>
			</div>

			<div>
				<table class="pp_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="selectAll"
								onclick="toggleAllCheckboxes()"></th>
							<th>보낸 사람</th>
							<th>쪽지 내용</th>
							<th>받은 날짜</th>
							<th>확인/미확인</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="messageInfoVOs"
									items="${pagingMsgRcvListVO.messageInfoVOs}">
								<tr>
									<td>
										<label>
											<input type="checkbox" name="check_msgno"
												value="${messageInfoVOs.msgNo}">
											<span style="font-size: 12px"></span>
										</label>
									</td>
									<td>${messageInfoVOs.sendUserId}</td>
									<td>${messageInfoVOs.msgContents}</td>
									<td>${messageInfoVOs.msgDate}</td>
									<td><c:choose>
											<c:when test="${messageInfoVOs.isCheck == 0}">
												<p class="notyet">미확인</p>
											</c:when>
											<c:when test="${messageInfoVOs.isCheck == 1}">
												<p class="checked">확인</p>
											</c:when>
											<c:otherwise>
												<p class="notyet">미확인</p>
											</c:otherwise>
										</c:choose></td>
									<td>
										<div class="cp_item_bot">
											<a class="cp_wanted_modify" id="deleteBtnMsg" onclick="selectOneDel('${messageInfoVOs.msgNo}');">삭제</a>
										</div>
									</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 페이징 설정 -->
			<div class="paging">
				<ul class="pagaination">
					<!-- 맨 처음 페이지로 이동 -->
					<li class="page-item-prev"><a
						href="messagebox_rcv.do?page=0&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">◀◀</a>
					</li>
	
					<!-- 첫 페이지 인지 확인 -->
					<c:if test="${pagingMsgRcvListVO.pagingVO.currentPage eq 0}">
						<li class="page-item-prev-hidden">이전</li>
					</c:if>
					<c:if test="${pagingMsgRcvListVO.pagingVO.currentPage > 0}">
						<li class="page-item-prev"><a
							href="messagebox_rcv.do?page=${pagingMsgRcvListVO.pagingVO.currentPage - 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">이전</a>
						</li>
					</c:if>
	
					<c:forEach var="num" begin="${pagingMsgRcvListVO.pagingVO.startPageNum}"
						end="${pagingMsgRcvListVO.pagingVO.lastPageNum}">
						<c:choose>
							<c:when test="${num == pagingMsgRcvListVO.pagingVO.currentPage + 1}">
								<li class="page-item-select">[${num}]</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="messagebox_rcv.do?page=${num-1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">[${num}]</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
	
					<!-- 마지막 페이지인지 확인 -->
					<c:if
						test="${pagingMsgRcvListVO.pagingVO.totalPage eq pagingMsgRcvListVO.pagingVO.currentPage + 1}">
						<li class="page-item-next-hidden">다음</li>
					</c:if>
					<c:if
						test="${pagingMsgRcvListVO.pagingVO.totalPage != pagingMsgRcvListVO.pagingVO.currentPage + 1}">
						<li class="page-item-next"><a
							href="messagebox_rcv.do?page=${pagingMsgRcvListVO.pagingVO.currentPage + 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">다음</a>
						</li>
					</c:if>
	
					<!-- 마지막 페이지로 이동 -->
					<li class="page-item-next"><a
						href="messagebox_rcv.do?page=${pagingMsgRcvListVO.pagingVO.totalPage - 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">▶▶</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
</form>

<%@ include file="../layout/footer.jsp"%>