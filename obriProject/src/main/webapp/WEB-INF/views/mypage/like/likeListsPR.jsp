<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<%-- <script src="${path}/js/mypage/like.js"></script> --%>

</head>

<div class="wanteds_page">
	<div class="search_wanted">
		<form name="selectOption" action="likeListsPR.do">
		<div class="all_position">
			<div class="select_head">포지션 선택</div>
			<div class="select_all">
				<select class="all" id="positionCode" name="prmajorName" onchange="ChangeValue('positionCode')">
					<option value="all" ${empty param.prmajorName ? 'selected' : ''}>전체 포지션(전공)</option>
					<c:if test="${prMajor.length > 0}">
						<c:forEach var="PrMajors" items="${PrMajors}">
							<option value="${PrMajors.prMajor}" ${param.prmajorName eq PrMajors.prMajor ? 'selected' : ''}>${PrMajors.prMajor}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>
			<button class="select_position" type="submit" id="btnSearch">
				<a><i class="fa fa-search"></i></a>
			</button>
		</div>

		<div class="selects">
			<div class="select_career">
				<select class="career" id="careerCode" name="prcareerName"
						onchange="ChangeValue('careerCode')">
					<option value="all" ${empty param.prcareerName ? 'selected' : ''}>신입/경력</option>
					<c:if test="${!empty PrCareers}">
						<c:forEach var="PrCareers" items="${PrCareers}">
							<option value="${PrCareers.prCareer}" ${param.prcareerName eq PrCareers.prCareer ? 'selected' : ''}>${PrCareers.prCareer}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>

			<div class="select_region">
				<select class="region" id="regionCode" name="prlocName"
						onchange="ChangeValue('regionCode')">
					<option value="all" ${empty param.prlocName ? 'selected' : ''}>지역 선택</option>
					<c:if test="${!empty PrLocs}">
						<c:forEach var="PrLocs" items="${PrLocs}">
							<option value="${PrLocs.prLoc}" ${param.prlocName eq PrLocs.prLoc ? 'selected' : ''}>${PrLocs.prLoc}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>

			<div class="select_skill">
				<select class="skill" id="skillsCode" name="prhashName"
						onchange="ChangeValue('skillsCode')">
					<option value="all" ${empty param.prhashName ? 'selected' : ''}>해시태그</option>
					<c:if test="${!empty PrHashes}">
						<c:forEach var="PrHashes" items="${PrHashes}">
							<option value="${PrHashes.prHash}" ${param.prhashName eq PrHashes.prHash ? 'selected' : ''}>#${PrHashes.prHash}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>

			<div class="selected_skills">
				<ul>
					<li class="selected_skills_items" id="skill1" style="display: none;"><strong class="skill_name" id="skillName1">test1</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill1')">
							<a>x</a>
						</p></li>
					<li class="selected_skills_items" id="skill2" style="display: none;"><strong class="skill_name" id="skillName2">test2</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill2')">
							<a>x</a>
						</p></li>
					<li class="selected_skills_items" id="skill3" style="display: none;"><strong class="skill_name" id="skillName3">test3</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill3')">
							<a>x</a>
						</p></li>
				</ul>
			</div>

			<div class="select_sort">
<!--				<select class="sort">
 					<option selected></option>
					<option></option>
				</select> -->
			</div>
		</div>
		</form>
	</div>

	<div class="overBox">
		<div class="liked">
			<div class="liked_wanted">
				<div class="liked_title">💖 좋아요한 PR(홍보 글) 💖</div>
				<div class="wanteds">
					<c:if test="${empty pagingPrListVO.likesListPRVOs}">
						<div class="wanted">
						    <div class="notice">
						    	<div class="text">
						        	<h3>⚠️ 좋아요 설정한 PR(홍보글)없음</h3>
						        </div>
							</div>
						</div>
					</c:if>
				
				
					<c:if test="${!empty pagingPrListVO.likesListPRVOs}">
					<c:forEach var="likesListPRVOs" items="${pagingPrListVO.likesListPRVOs}">
						<div class="wanted">
							<a href="prDetail.do?prNo=${likesListPRVOs.prNo}&pageNum=1">
								<div class="picture">
									<c:choose>
										<c:when test="${empty likesListPRVOs.prFile}">
											<img src="https://via.placeholder.com/200x300">
										</c:when>
										<c:otherwise>
											<img src="${path}/upload/${likesListPRVOs.prFile}" width="200" height="300">
										</c:otherwise>
									</c:choose>
								</div>

								<div class="wanted_text">
									<div class="text">
										<ul>
											<li class="title">
												<h2>${likesListPRVOs.prSub}</h2>
											</li>
											<li class="content">
												<p>${likesListPRVOs.prText}</p>
											</li>
										</ul>
									</div>
									<div class="company_intro">
										<p class="company_region">${likesListPRVOs.prCareer}</p>
										<p class="company_name">${likesListPRVOs.prMajor}</p>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<!-- 페이징 설정 -->
	<div class="paging">
		<ul class="pagaination">
			<!-- 맨 처음 페이지로 이동 -->
			<li class="page-item-prev">
				<a href="likeListsPR.do?page=0&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">◀◀</a>
			</li>

			<!-- 첫 페이지 인지 확인 -->
			<c:if test="${pagingPrListVO.pagingVO.currentPage eq 0}">
				<li class="page-item-prev-hidden">이전</li>
			</c:if>
			<c:if test="${pagingPrListVO.pagingVO.currentPage > 0}">
				<li class="page-item-prev"><a
					href="likeListsPR.do?page=${pagingPrListVO.pagingVO.currentPage - 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">이전</a>
				</li>
			</c:if>

			<c:forEach var="num" 
						begin="${pagingPrListVO.pagingVO.startPageNum}" 
						end="${pagingPrListVO.pagingVO.lastPageNum}">
				<c:choose>
					<c:when test="${num == pagingPrListVO.pagingVO.currentPage + 1}">
						<li class="page-item-select">[${num}]</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="likeListsPR.do?page=${num-1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">[${num}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막 페이지인지 확인 -->
			<c:if test="${pagingPrListVO.pagingVO.totalPage eq pagingPrListVO.pagingVO.currentPage + 1}">
				<li class="page-item-next-hidden">다음</li>
			</c:if>
			<c:if test="${pagingPrListVO.pagingVO.totalPage != pagingPrListVO.pagingVO.currentPage + 1}">
				<li class="page-item-next">
					<a href="likeListsPR.do?page=${pagingPrListVO.pagingVO.currentPage + 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">다음</a>
				</li>
			</c:if>

			<!-- 마지막 페이지로 이동 -->
			<li class="page-item-next">
				<a href="likeListsPR.do?page=${pagingPrListVO.pagingVO.totalPage - 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">▶▶</a>
			</li>
		</ul>
<%-- 		<div>first: ${pagingPrListVO.pagingVO.first ? "-hidden" : "none"}</div>
		<div>last: ${pagingPrListVO.pagingVO.last ? "-hidden" : "none"}</div>
		<div>currentBlock: ${pagingPrListVO.pagingVO.currentBlock}</div>
		<div>startPageNum: ${pagingPrListVO.pagingVO.startPageNum}</div>
		<div>lastPageNum: ${pagingPrListVO.pagingVO.lastPageNum}</div>
		<div>totalCount: ${pagingPrListVO.pagingVO.totalCount}</div>
		<div>totalPage: ${pagingPrListVO.pagingVO.totalPage}</div>
		<div>currentPage: ${pagingPrListVO.pagingVO.currentPage}</div> --%>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>