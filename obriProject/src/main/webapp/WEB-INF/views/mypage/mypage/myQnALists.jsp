<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/proposal.css?after" rel="stylesheet">
<link href="${path}/css/mypage/application_status_all.css" rel="stylesheet" />

<style type="text/css">
	.pp_table td a:hover {
	  color: #a490d5;
	}
	
	.pp_table td .notYetCheck {
	  color: #e7bcbc;
	}
	
	.pp_table td .Checked {
	  color: #cde661;
	}
</style>

<script type="text/javascript">
 	// 전체 선택
	function toggleAllCheckboxes() {
		var selectAllCheckbox = document.getElementById("selectAll");
		var NoCheckboxes = document.getElementsByName("check_qnaNo");
		
		for (var i = 0; i < NoCheckboxes.length; i++) {
			NoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}
	
 	// 삭제 버튼
 	function selectOneDel(qnaNo) {
		if(!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		
		// 선택한 qnaNo 저장해 둘 배열 선언
		var NoArray = new Array();
		NoArray.push(qnaNo);
		console.log("NoArray : " + NoArray);
		
		if(NoArray.length == 1) {
			// 삭제 실행
			$.ajax({
				type: "DELETE",
				url: "deleteQnA.do?qnaNo=" + NoArray[0],
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
		if($("input[name='check_qnaNo']:checked").length == 0 ){
			alert("선택된 항목이 없습니다.");
			return;
		}
		
		if(confirm("정말 삭제하시겠습니까?")==false) {
			return;
		}
				
		// 선택한 commNo 저장해 둘 배열 선언
		var NoArray = new Array();
 		$("input[name='check_qnaNo']:checked").each(function() {
		      // 선택된 체크박스 값(qnaNo)을 배열에 추가
		      NoArray.push($(this).val());
		});
		console.log("NoArray : " + NoArray);
		
		var deleteCount = 0; // 삭제된 항목 수
        // 삭제 요청이 완료될 때마다 호출되는 함수
        function onDeleteComplete() {
            deleteCount++;

            // 모든 삭제 요청이 완료되면 페이지 리로드
            if (deleteCount === NoArray.length) {
            	console.log("deleteCount : " + deleteCount);
            	alert("선택 항목 삭제 성공!");
            	location.reload();
            }
        }		
		
		// 반복문으로 삭제 진행
		for(var i = 0; i < NoArray.length; i++) {
			$.ajax({
				type: "DELETE",
				url: "deleteQnA.do?qnaNo=" + NoArray[i],
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

<div id="wrap">
	<div id="pp_wrap">
		<div class="pp_menu">
			<p class="pp_title">문의 글 관리</p>
			<ul>
				<li class="pp_proposal"><a href="myQnALists.do">작성 글</a></li>
			</ul>
		</div>

		<div class="pp_contents">
			<p class="pp_sub_title">1:1 문의</p>
			<div class="pp_search">
				<form name="searchProposal" action="myQnALists.do">
					<input id="keyword" type="text" placeholder="글 제목/내용 검색" name="keyword" value="${sessionScope.referer != null ? sessionScope.referer.keyword : ''}">
					<button class="btn_search" type="submit"></button>
				</form>
			</div>
			
			<!-- 삭제버튼 -->
<!-- 			<div class="pp_search">
				<div class="cp_item_bot_Left">
					<a href="#" class="cp_wanted_modify" id="deleteBtnQnA" onclick="check_selectDel();">선택 삭제</a>
				</div>			
			</div> -->

			<div>
				<form action="deleteQnA.do" name="deleteQnA" id="deleteQnA">
					<table class="pp_table">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()"></th>
								<th>제목</th>
								<th>문의 내용</th>						
								<th>파일</th>						
								<th>상태</th>
								<th>작성일</th>
<!-- 								<th>수정</th>
								<th>삭제</th>
 -->							</tr>
						</thead>
						<tbody>
							<c:forEach var="qnaListsInfoVOs" items="${qnaListsVO.qnaListsInfoVOs}">
								<tr>
									<td>
										<label>
											<input type="checkbox" name="check_qnaNo" value="${qnaListsInfoVOs.qnaNo}">
											<span style="font-size: 12px"></span>
										</label>
									</td>
									<td><a href="qna_read.do?qnaNo=${qnaListsInfoVOs.qnaNo}">${qnaListsInfoVOs.qnaSub}</a></td>
									<td>${qnaListsInfoVOs.qnaText}</td>
									<td>${qnaListsInfoVOs.qnaFile}</td>
									<td>
										<%-- <c:choose> --%>
											<c:if test="${qnaListsInfoVOs.qnaDelYn == 'N'}">
												<p class="notYetCheck">답변대기</p>
											</c:if>
											<c:if test="${qnaListsInfoVOs.qnaDelYn == 'Y'}">
												<p class="Checked">답변완료</p>
											</c:if>
<%-- 											<c:otherwise>
												<p class="fail">미열람</p>
											</c:otherwise> --%>
										<%-- </c:choose> --%>
									</td>
									<td><p class="cnt_highlight">${qnaListsInfoVOs.qnaDate}</p></td>
<%-- 									<td>
										<div class="cp_item_bot">
											<a href="#?qnaNo=${qnaListsInfoVOs.qnaNo}" class="cp_wanted_modify">수정</a>
										</div>
									</td>
									<td>
										<div class="cp_item_bot">
											<a href="#" class="cp_wanted_modify" onclick="selectOneDel('${qnaListsInfoVOs.qnaNo}');">삭제</a>
										</div>
									</td> --%>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>