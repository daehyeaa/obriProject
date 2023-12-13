<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/mypage.css" rel="stylesheet" />
<link href="${path}/css/mypage/subscribes.css" rel="stylesheet" />
<link href="${path}/css/mypage/proposal.css" rel="stylesheet" />
<link href="${path}/css/mypage/companypage_recruit_manage.css" rel="stylesheet" />

<script>
	function changePage() {
		var select = document.getElementById("cp_option_select");
		var selectedValue = select.options[select.selectedIndex].value;

		if (selectedValue === "applyStatus_main") {
			window.location.href = "mypage_Apply.do";
		} else if (selectedValue === "recruitStatus_main") {
			window.location.href = "mypage_JobBoard.do";
		}
	}
</script>
</head>

<div id="wrap">
	<div id="mp_wrap">
		<div class="mypage">
			<p class="mypage_title">My Page</p>

			<div class="mp_info">
				<div class="mp_account">
					<c:forEach var="userInfoVOs" items="${infoAllDto.userInfoVOs}">
						<div class="mp_img"></div>
						<div class="mp_acc">
							<p class="mp_name">${userInfoVOs.userName}</p>
							<p class="mp_call">${userInfoVOs.userPhone}</p>
							<p class="mp_email">${userInfoVOs.userEmail}</p>
						</div>
						<div class="mp_acc_setting">
							<button>
								<a href="editCheck.do">계정 설정하기</a>
							</button>
						</div>
					</c:forEach>
				</div>


				<div class="cp_menu">
					<select name="cp_option" id="cp_option_select"
						onchange="changePage()">
						<option value="applyStatus_main">지원 공고 관리</option>
						<option value="recruitStatus_main" selected="selected">
							작성 공고 관리</option>
					</select>
				</div>

				<div class="cp_status">
					<c:forEach var="infoCountVOs" items="${infoAllDto.infoCountVOs}">
						<ul>
							<li><a href="writeJobStatusAll.do">
									<div class="cp_status_li2">구인 현황</div>
									<div>${infoCountVOs.jobstatusAll}</div>
							</a></li>
							<li><a href="likeListsPR.do">
									<div class="mp_status_li2">좋아요 한 PR</div>
									<div>${infoCountVOs.prlikesCount}</div>
							</a></li>
							<li><a href="messagebox_snd.do">
									<div class="mp_status_li3">쪽지함</div>
									<p class="proposal_notifications"></p>
									<div>${infoCountVOs.messagesCount}</div>
							</a></li>
							<li><a href="commWroteAll.do">
									<div class="mp_status_li4">커뮤니티 글 관리</div>
									<div>${infoCountVOs.commCountAll}</div>
							</a></li>
							<li><a href="myQnALists.do">
									<div class="mp_status_li4">문의 글 관리</div>
									<div>${infoCountVOs.qnaCountAll}</div>
							</a></li>
						</ul>
					</c:forEach>
				</div>
			</div>

			<div class="logout">
				<button>
					<a href="logout.do">로그아웃</a>
				</button>
			</div>
		</div>

		<div class="cp_contents">
			<div class="cp_applications">
				<a href="writeJobStatusAll.do" class="cp_apply_manage">
					<div class="cp_apply_text">
						<p>지원자 관리 바로가기</p>
						<span>지원/열람/승인한 지원자들을 한 눈에 볼 수 있습니다.</span>
					</div>
					<div class="cp_arrow">></div>
				</a>

				<div class="cp_search">
					<a href="#" class="subtitle_btn">구인공고 작성</a>

					<div class="cp_select">
						<form name="selectOption" action="mypage_JobBoard.do">
							<select name="jobplaceName" id="selectPlace">
								<option value="all" ${empty param.jobplaceName ? 'selected' : ''}>지역</option>
								<c:forEach var="JobPlaces" items="${JobPlaces}">
									<option value="${JobPlaces.jobplace}" ${param.jobplaceName eq JobPlaces.jobplace ? 'selected' : ''}>
										${JobPlaces.jobplace}</option>
								</c:forEach>
							</select>
							<select name="jobcdName" class="select_position" id="selectCategory">
								<option value="all" ${empty param.jobcdName ? 'selected' : ''}>테마(분류)</option>
								<c:forEach var="JobCDs" items="${JobCDs}">
									<option value="${JobCDs.jobcd}" ${param.jobcdName eq JobCDs.jobcd ? 'selected' : ''}>${JobCDs.jobcd}</option>
								</c:forEach>
							</select>
							
							<button class="btn_search" type="submit"></button>
						</form>
					</div>
				</div>

				<div class="cp_content_wrapper">
					<c:forEach var="jobBoardVOs" items="${pagingJobManageVO.jobBoardVOs}">
						<div class="cp_content_item">
							<div class="cp_item_top">
								<div class="cp_item_wanted">
									<a href="#" class="cp_wanted_link">
										<p class="wanted_title">${jobBoardVOs.jobsub}</p>
										<p class="wanted_discribes">${jobBoardVOs.jobtext}</p>
									</a>
								</div>
								<div class="cp_item_state">${jobBoardVOs.jobcd}</div>
								<div class="cp_item_state">${jobBoardVOs.rno}</div>
							</div>
							<div class="cp_item_bot">
								<a href="#?jobno=${jobBoardVOs.jobno}" class="cp_wanted_modify">수정하기</a>
							</div>
						</div>
					</c:forEach>
					
					<div class="paging">
						<ul class="pagaination">
							<!-- 맨 처음 페이지로 이동 -->
							<li class="page-item-prev">
								<a href="mypage_JobBoard.do?page=0&jobplaceName=${empty param.jobplaceName ? 'all' : param.jobplaceName}&jobcdName=${empty param.jobcdName ? 'all' : param.jobcdName}">◀◀</a>
							</li>
							
							<!-- 첫 페이지 인지 확인 -->
							<c:if test="${pagingJobManageVO.pagingVO.currentPage eq 0}">
								<li class="page-item-prev-hidden">이전</li>
							</c:if>
							<c:if test="${pagingJobManageVO.pagingVO.currentPage > 0}">
								<li class="page-item-prev">
									<a href="mypage_JobBoard.do?page=${pagingJobManageVO.pagingVO.currentPage - 1}&jobplaceName=${empty param.jobplaceName ? 'all' : param.jobplaceName}&jobcdName=${empty param.jobcdName ? 'all' : param.jobcdName}">이전</a>
								</li>
							</c:if>
							
														
							<c:forEach var="num" 
										begin="${pagingJobManageVO.pagingVO.startPageNum}" 
										end="${pagingJobManageVO.pagingVO.lastPageNum}">
								<c:choose>
									<c:when test="${num == pagingJobManageVO.pagingVO.currentPage + 1}">
										<li class="page-item-select">[${num}]</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a href="mypage_JobBoard.do?page= ${num-1}&jobplaceName=${empty param.jobplaceName ? 'all' : param.jobplaceName}&jobcdName=${empty param.jobcdName ? 'all' : param.jobcdName}">[${num}]</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 마지막 페이지인지 확인 -->
							<c:if test="${pagingJobManageVO.pagingVO.totalPage eq pagingJobManageVO.pagingVO.currentPage + 1}">
								<li class="page-item-next-hidden">다음</li>
							</c:if>
							<c:if test="${pagingJobManageVO.pagingVO.totalPage != pagingJobManageVO.pagingVO.currentPage + 1}">
								<li class="page-item-next">
									<a href="mypage_JobBoard.do?page=${pagingJobManageVO.pagingVO.currentPage + 1}&jobplaceName=${empty param.jobplaceName ? 'all' : param.jobplaceName}&jobcdName=${empty param.jobcdName ? 'all' : param.jobcdName}">다음</a>
								</li>
							</c:if>
							
							<!-- 마지막 페이지로 이동 -->
							<li class="page-item-next">
								<a href="mypage_JobBoard.do?page=${pagingJobManageVO.pagingVO.totalPage - 1}&jobplaceName=${empty param.jobplaceName ? 'all' : param.jobplaceName}&jobcdName=${empty param.jobcdName ? 'all' : param.jobcdName}">▶▶</a>
							</li>
						</ul>
<%-- 						<div>first: ${pagingJobManageVO.pagingVO.first ? "-hidden" : "none"}</div>
						<div>last: ${pagingJobManageVO.pagingVO.last ? "-hidden" : "none"}</div>
						<div>currentBlock: ${pagingJobManageVO.pagingVO.currentBlock}</div>
						<div>startPageNum: ${pagingJobManageVO.pagingVO.startPageNum}</div>
						<div>lastPageNum: ${pagingJobManageVO.pagingVO.lastPageNum}</div>
						<div>totalCount: ${pagingJobManageVO.pagingVO.totalCount}</div>
						<div>totalPage: ${pagingJobManageVO.pagingVO.totalPage}</div>
						<div>currentPage: ${pagingJobManageVO.pagingVO.currentPage}</div> --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>
