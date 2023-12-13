<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/likes.css" rel="stylesheet" />

<script src="${path}/js/mypage/like.js"></script>
</head>

<div class="container">
	<div class="photosetting">
		<div class="liketitle">💖 좋아요한 커뮤니티 글 💖</div>
		<c:if test="${empty likesListComm}">
			<div class="replay_box">
				<div class="full_setting">
				    <div class="notice">
				    	<div class="text">
				        	<h3>⚠️ 좋아요 설정한 글 없음</h3>
				        </div>
					</div>
				</div>
			</div>
		</c:if>
		
		<c:if test="${!empty likesListComm}">
		<c:forEach var="likesComm" items="${likesListComm}">
			<div class="replay_box">
				<div class="full_setting">
					<div class="photocompany">
						<c:choose>
							<c:when test="${empty likesComm.commFile}">
								<a href="boardContent.do?commNo=${likesComm.commNo}&pageNum=1"><img class="companyphoto" src='https://via.placeholder.com/250x250' alt="커뮤니티 첨부 이미지"></a>
							</c:when>
							<c:otherwise>
								<a href="boardContent.do?commNo=${likesComm.commNo}&pageNum=1"><img class="companyphoto" src="${path}/upload/${likesComm.commFile}" width="250" height="250" alt="커뮤니티 첨부 이미지"></a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="company_story">
						<div class="contect_title">${likesComm.commSub}</div>
						<div class="explanation">
							<div class="explanation_text">${likesComm.commText}</div>
						</div>

						<div class="company_image">
							<div class="test">
								<c:choose>
									<c:when test="${empty likesComm.prFile}">
										<a href="#?id=${likesComm.writerId}"><img class="conpany_min_iphoto" src='https://picsum.photos/250/250' alt="작성자 프로필 이미지"
											width="25" height="25"></a>
									</c:when>
									<c:otherwise>
										<a href="#?id=${likesComm.writerId}"><img class="conpany_min_iphoto" src="${path}/upload/${likesComm.prFile}" alt="작성자 프로필 이미지" width="25" height="25"></a>
									</c:otherwise>
								</c:choose>
								
								<a class="test2">${likesComm.writerName}(${likesComm.writerId})</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		</c:if>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>