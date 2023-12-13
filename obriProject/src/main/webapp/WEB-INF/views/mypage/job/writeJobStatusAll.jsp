<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/application_status_all.css" rel="stylesheet" />

<script src="${path}/js/mypage/writejobstatus.js"></script>

<style type="text/css">
	.cp_item_bot {
		width: 100%;
		text-align: center;
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
</style>
</head>

<div id="wrap">
	<div id="asa_wrap">
		<div class="asa_menu">
			<p class="asa_title">구인 게시판</p>
			<ul>
				<li class="asa_proposal"><a href="applyStatusAll.do">지원 현황</a></li>
				<li class="asa_position"><a href="writeJobStatusAll.do">구인 현황</a></li>
			</ul>
		</div>

		<div class="asa_contents">
			<div class="asa_counts">
				<c:forEach var="statusCountVOs" items="${jobstatusAllVO.statusCountVOs}">
					<div class="asa_count_all">
						<a href="writeJobStatusAll.do">
							<p class="asa_all_count">${statusCountVOs.jobstatusAll}</p>
							<p class="asa_all_text">전체</p>
						</a>
					</div>
					<div class="asa_count_c">
						<a href="writeJobStatus.do">
							<p class="asa_count">${statusCountVOs.jobstatusCont}</p>
							<p class="asa_text">진행중</p>
						</a>
					</div>
					<div class="asa_count_final">
						<a href="writeJobStatusFin.do">
							<p class="asa_final_count">${statusCountVOs.jobstatusFin}</p>
							<p class="asa_final_text">컨택 완료</p>
						</a>
					</div>
				</c:forEach>
			</div>

			<div class="asa_search">
				<form name="searchAll" action="writeJobStatusAll.do">
					<input id="keyword" placeholder="공고 제목/내용 검색" type="text" name="keyword" value="${sessionScope.referer != null ? sessionScope.referer.keyword : ''}" />
					<%-- <input type="hidden" name="id" value="${jobstatusAllVO.userId}" /> --%>
					<button class="btn_search" type="submit"></button>
				</form>
			</div>

			<div>
				<table class="asa_table">
					<thead>
						<tr>
							<th>작성 공고 제목</th>
							<th>신청자 이름</th>
							<th>모집 마감일</th>
							<th>진행 상태</th>
							<th>수정</th>
							<th>공고 삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="statusInfoVOs" items="${jobstatusAllVO.statusInfoVOs}">
							<tr>
								<td><a href="#?jobNo=${statusInfoVOs.jobNo}">${statusInfoVOs.jobSub}</a></td>
								<td>${statusInfoVOs.appName}(${statusInfoVOs.userId})</td>
								<td>${statusInfoVOs.jobEndDate}</td>
								<td><c:choose>
										<c:when test="${statusInfoVOs.appCheck == Y}">
											<p class="pass">승인</p>
										</c:when>
										<c:when test="${statusInfoVOs.appCheck == N}">
											<p class="fail">불합격</p>
										</c:when>
										<c:otherwise>
											<p class="waiting">대기중</p>
										</c:otherwise>
									</c:choose></td>
								<td>
									<div class="cp_item_bot">
										<a href="#" class="cp_wanted_modify">공고수정</a>
									</div>
								</td>
								<td>
									<div class="cp_item_bot">
										<a href="#" class="cp_wanted_modify">공고삭제</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>
