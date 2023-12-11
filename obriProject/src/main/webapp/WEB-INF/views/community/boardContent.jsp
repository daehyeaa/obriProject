<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="loginOutLink"
	value="${sessionScope.userId==null ? 'login.do' : 'logout.do'}" />
<c:set var="loginOut"
	value="${sessionScope.userId==null ? '로그인' : '로그아웃'}" />
<c:set var="myPageLink"
	value="${sessionScope.userId==null ? 'join.do' : 'editCheck.do'}" />
<c:set var="myPage"
	value="${sessionScope.userId==null ? '회원가입' : '마이페이지'}" />


<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
	
<style>
        /* 버튼 스타일링 */
        .imageButton {
            width: 40px; /* 버튼의 폭 설정 */
            height: 40px; /* 버튼의 높이 설정 */
            cursor: pointer; /* 포인터 모양으로 변경하여 클릭 가능한 것으로 보이게 함 */
        }

        /* 이미지 스타일링 */
        .imageButton img {
            width: 100%; /* 이미지를 버튼에 맞게 조절 */
            height: 100%; /* 이미지를 버튼에 맞게 조절 */
            border-radius: 50%; /* 이미지를 원 모양으로 만듭니다. */
        }
    </style>
 
 <!-- 로그인 확인 -->
 <script>
 
 var sessionId = '<%=(String)session.getAttribute("userId")%>';
 console.log("세션ID "+sessionId);
 
 $(document).ready(function() {
 	
 	if(sessionId === "null"){
 		console.log("여기들감?");
 		$("#comReInsert").hide();
 		$("#commReSession").hide();
 	}else {
 		$("#comReInsert").show();
 		$("#commReSession").show();
 	}
 });
 
 </script>

<!-- 글 삭제 confirm 창 띄우기 -->
<script>
    function deleteCheck() {
        if (confirm("정말로 삭제하시겠습니까?") == true) {	// 확인
            location.href = "boardDelete.do?commNo=${community.commNo}&page=${page}"
        } else {										// 취소
            alert("취소되었습니다.");
            return false;
        }
    }
</script>

 
 <!-- 좋아요 -->
<script>
console.log("session:", '${sessionScope.userId}');
console.log("userId:", '${community.userId}');


 function commLikeButton(state) {
	 
     if (${empty sessionScope.userId}) {
    	            alert("로그인이 필요한 서비스입니다!");
    	            return false;   
    		
    }else if ($.trim('${sessionScope.userId}')  ==  $.trim('${community.userId}')) {
            alert("자신의 글은 선택할 수 없습니다");
            return false;

    } else {
        	
		        	var result = confirm("좋아요를 선택 하시겠습니까?");
		        	if(result){
		               location.href="comLike.do?commNo=${community.commNo}&pageNum=${pageNum}&state="+state;
		               
		               return false;
		        	}     	
        }       
    }
</script>
          
 
<!--  댓글  -->
<script>

 			// 리스트 불러오기
        $(function () {	
            $('#commReList').load('commReList.do?commNo=${community.commNo}')	

            // 댓글창 유효성 검사
            $('#comReInsert').click(function () {
                if (!comForm.commReText.value) {
                    alert('댓글 입력 후에 클릭하세요');
                    comForm.commReText.focus();
                    return false;
                }else{
                	 alert("댓글 작성 완료");
                }
                
             // 비밀 댓글
//                 if($('#commSecret').is(":checked") == true ){
// 						$('#commSecret').val('Y1');
// 						alert("y");
					
// 				}else{
// 					$('#commSecret').val('N1');
// 						alert("null");
					
// 				}   				  		
                
                     // 댓글 입력, 입력후           
                var formData = $('#comForm').serialize();	    // serialize() : 아래의 form태그를 읽어옴
                $.post('commReInsert.do', formData, function (data) {
                    $('#commReList').html(data);
                    comForm.commReText.value = '';

                });
            });
        });
 			
 			
 </script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/animation.css">
<link rel="stylesheet" href="./css/intro.css">

</head>

<body>
 <!-- navbar start -->
	<nav class="navbar">
		<div class="navbar_logo" id="navbar_logo">
			<a href="<c:url value='/home.do'/>"><img src="./images/184.png"></a>
		</div>
		<ul class="navbar_menu" id="navbar_menu">
			<li><a href="boardListShow.do">구인</a></li>
			<li><a href="prCardList.do">홍보</a></li>
			<li><a href="boardList.do">커뮤니티</a></li>
			<li><a href="notice_list.do">공지</a></li>
		</ul>
		<ul class="navbar_icons" id="navbar_icons">
			<li><a href="<c:url value='${loginOutLink}'/>"> <i
					class="fa-solid fa-user"></i>&nbsp;&nbsp;${loginOut}
			</a></li>
			<li><a href="<c:url value='${myPageLink}'/>"> <i
					class="fa-solid fa-right-to-bracket"></i>&nbsp;&nbsp;${myPage}
			</a></li>
		</ul>
		<a href="#" class="navbar_toggle_btn" id="navbar_toggle_btn"> <i
			class="fa-solid fa-bars"></i>
		</a>
	</nav>
	<!-- navbar end -->

<main style="padding-top: 80px; padding-bottom: 80px">

		<!-- header start -->
		<section class="header">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>
		<!-- header end -->
 

<h2 align="center">상세페이지</h2>
<form method=post action="boardDelete.do">
	<div align="center">
		<table width=600>
			<tr>
				<th>작성자 </th>
				<td>${community.userId}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${community.commSub }</td>
			</tr>
			<tr>
				<th>사진</th>
				<c:if test="${community.commFile == null}">
					<td>사진이 없습니다.</td>
				</c:if>

				<c:if test="${community.commFile != null}">
					<td><img
						src="<%=request.getContextPath() %>/upload/${community.commFile}"
						width="200" height="200" /></td>
				</c:if>
			</tr>
			<tr>
				<th>내용</th>
				<td>${Content}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${community.commUpdate }"
						pattern="MM월 dd일 HH:mm EEE요일" /></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${community.commCount }</td>
			</tr>
			<tr>
				<th>좋아요 수</th>
				<td>${likeCnt}</td>
			</tr>
		</table>
	</div>
	<br>

	<div id="boardContent_menu" class="body-menu" align="center">
	<table>
		<tr>
			<td>
		<input type="button" value="목록으로"
			onClick="location.href='boardList.do?page=${page}'">
			&nbsp;
			</td>
		
			<td>
				<!-- 로그인 구현 되면 테스트 해야댐 -->
				
			<c:if test="${sessionScope.userId == null}">
					<img id="likeCheck" src="images/notgood.png"     onClick="commLikeButton()">
			</c:if>		 	
			
			<c:if test="${sessionScope.userId != null}">
				<!-- 좋아요 여부에 따른 이미지 출력 -->
				<c:if test="${state == 'Y' }">
					<img id="likeCheck" src="images/good.png"     onClick="commLikeButton('Y')">
				</c:if>		
		
		        <c:if test="${state == 'N' ||  empty state }">
					<img id="likeCheck" src="images/notgood.png"     onClick="commLikeButton('N')">
				</c:if>			
			</c:if>  		
				
		&nbsp;
			</td>
	
<c:if test="${fn:trim(sessionScope.userId) ==  fn:trim(community.userId) }">	
	<td>
		&nbsp;
		<input type="button" value="수정"
			onClick="location.href='boardUpdateForm.do?commNo=${community.commNo}&pageNum=${pageNum}'">&nbsp;
			</td>
			
			<td>
				<input type="button" value="삭제" onClick="deleteCheck()">	&nbsp;
		</td>
</c:if>
	
	</tr>
</table>
	</div>

</form>


<hr>


<div align="center" id="commRe">
	<h3>댓글 쓰기</h3> 
	작성자:<input type="text" value=" ${sessionScope.userId }" readOnly>

   
	<form name="comForm"   id="comForm">	
		
		<input type="hidden"   name="commReId"  value="${sessionScope.userId }">
		<br>
		
		<input type="hidden"   name="commNo"  value="${community.commNo} ">
		<textarea rows="3" cols="50"   name="commReText"  placeholder="댓글을 작성하세요" ></textarea><br><br>
		
		<div id="commReSession">
		<input type="button"  value="댓글작성"   id="comReInsert" >
		&nbsp;
		&nbsp;
		
	
		비밀댓글<input type="checkbox"  name="commSecret"  id="commSecret"  >
	</div>
	</form>
</div>

<hr>
<h2 align="center">댓글 목록</h2>
<div id="commReList" align="center"></div>

</main>

		<!-- footer start -->
	<footer class="nav_foot">
		<div class="nav_container">
			<h2>오브리</h2>
			<p>O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
		</div>
		<ul class="nav_menu">
			<li><a href="notice_list.do">공지사항</a></li>
			<li><a href="qna_form.do">문의하기</a></li>
			<li><a href="">개인정보 처리방침</a></li>
			<li><a href="">서비스 이용약관</a></li>
		</ul>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</footer>
	<!-- footer end -->
		
		
</body>
</html>

