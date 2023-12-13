<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>

<html>
<head>
	
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<title>홍보 상세 페이지</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="stylesheet" href="./css/prstyle.css">

<script>
    var j = jQuery.noConflict();
    
    var sessionId = '<%=(String) session.getAttribute("userId")%>';
    console.log(sessionId);
    let userId = '${map['USERID']}';
    let PageNum = '${pageNum}';
    const prLikeStatus = '${prLikeStatus}';

    j(document).ready(function() {
        if(sessionId == userId){
            j("#updelButton").show();
        } else {
            console.log("들어왔나?1");
            j("#updelButton").hide();
        }

        console.log("라이크status"+ prLikeStatus);
        console.log(${map['PRNO']});
        console.log("세션IDID"+ sessionId);

        let likeImageEle = j("#likeImage");

        if (prLikeStatus == 'Y') {
            console.log("여기가 YY");
            likeImageEle.attr("src", "${path}/images/pr/prLikeColor.png");
        } else {
            console.log("여기가 NN");
            likeImageEle.attr("src", "${path}/images/pr/prLikeBlack.png");

        }

        j("#messageBtn").click(function(){
            if(sessionId === 'null'){
                alert("로그인 후 가능합니다.")
                return false;
            }
        });

    });

    function prDelete(prNo) {
        console.log("번호"+ prNo);

        if(confirm("삭제 하시겠습니까??") == true){
            location.href = '${path}/prDetailDelete.do?pageNum=${pageNum}&prNo='+prNo;
        } else {
            return false;
        }
    }

    function message() {
        let msgText = j("#msgText").val();
        let jsonData = {
            userId : '<%=request.getAttribute("id")%>',
            recvId : userId,
            msgText : msgText
        };

        j.ajax({
            method: "POST",
            url: "msgInsert.do",
            contentType : "application/json; charset=utf-8",
            data : JSON.stringify(jsonData),
        }).done(function(data) {
            console.log(data);
            if(data == 1){
                alert("전송 성공하였습니다.");
                j('#myModal').modal('hide');
            } else {
                alert("전송 실패하였습니다.");
            }
        });
    }

    function prLike() {
        if (sessionId === 'null') {
            alert("로그인 후 가능합니다.");
            return false;
        }

        let likePrNo = ${map['PRNO']};
        let likeUserId = sessionId;
        let jsonData = { prNo: likePrNo, userId: likeUserId };

        j.ajax({
            method: "POST",
            url: "prLike.do",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(jsonData),
        }).done(function (data) {
            let likeImageElement = j("#likeImage");

            if (data.prLike == 'Y') {
                likeImageElement.attr("src", "${path}/images/pr/prLikeColor.png");
            } else {
                likeImageElement.attr("src", "${path}/images/pr/prLikeBlack.png");
            }
        });
    }
</script>

<body>
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<!-- Wrapper -->
	<input type="hidden" value="${map['PRNO']}" />
	<input type="hidden" value="${map['USERID']}" id="detailId" />
	<!-- Main -->
	<main style="margin-bottom: 50px;">
		<div class="container" style="max-width: 960px; padding: 40px;">
			<!-- Content -->
			<section>
				<header class="main" style="padding-top: 20px;">
					<h2>${map['PRSUB']}</h2>
				</header>

				<div class="row">
					<div class="col-6 col-12-small prDetailImage">
						<img src="<%=request.getContextPath() %>/upload/${map['PRFILE']}"
							class="imga" alt="사진들어갈곳" />
					</div>
					<!-- 좋아요! -->
					<div class="col-5 col-11-small prDetailSub">
						<h3>${map['USERNAME']}
						<span><img id="likeImage"
								class="likeImage" src="./images/pr/prLikeBlack.png"
								onclick="prLike()" width="20px" height="20px"></span>
						</h3>
						<br>

						<div>활동지역 : ${map['PRLOC']}</div>
						<div>좋아요수 : ${prlikeNumber} 오브리수 :</div>
						<div>조회수 : ${map['PRRCOUNT']}</div>
						<br>
						<div>
							<button class="btn" type="button" data-toggle="modal"
								id="messageBtn" data-target="#myModal">쪽지보내기</button>
						</div>
					</div>
				</div>

				<hr>
				<div class="box basic">
					<h3>기본 정보</h3>
					<div class="box basic ml-3">
					경력 : ${map['PRCAREER']}년<br> 세부 분야 : ${map['USERMAJOR']}
					</div>
				</div>

				<hr>

				<div class="box basic">
					<h3>글 내용</h3>
					<div class="box basic ml-3">
					<pre>${map['PRTEXT']}</pre>
					</div>
				</div>
				<hr>
				<h3>동영상</h3>
				<div class="box basic" style="text-align: center;">
					<div style="width: 100%; max-width: 600px; margin: 0 auto;">
						<iframe src="https://www.youtube.com/embed/${map['PRVIDEO']}"
							frameborder="0"
							allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
							allowfullscreen style="width: 100%; height: 340px;"></iframe>
					</div>
				</div>

				<div class="row justify-content-end mb-3 mt-3" id="updelButton">
					<button type="button" class="btn"
						onclick="location.href='prUpdateForm.do?prNo=${map['PRNO']}'">수정</button>
					<button type="button" class="btn ml-2 mr-3"
						onclick="prDelete(${map['PRNO']})">삭제</button>
				</div>
			</section>
		</div>
	</main>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />


	<!-- modal start -->

	<div class="modal fade" id="myModal" data-backdrop="static"
		data-keyboard="false">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">쪽지보내기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">수신자
								이름:</label> <input type="text" class="form-control" id="recvId"
								name="recvId" value="${map['USERNAME']}" readonly
								style="background-color: #F5F5F5;">
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">Message:</label>
							<textarea class="form-control" id="msgText" name="msgText"
								style="height: 200px"></textarea>
						</div>
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn" onclick="message()">보내기</button>
					<button type="button" class="btn" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- modal end -->
</body>
</html>