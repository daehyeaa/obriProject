<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- jsp파일에서 프로퍼티 설정 -->
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@property('naverId.login.develApp.key')" var="client_Id"/> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NAVER 로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>


<script type="text/javascript">

// .gitignore 
  var naver_id_login = new naver_id_login("", "http://localhost/obriProject/loginNaver.do");
//  alert(naver_id_login.oauthParams.access_token);
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
//  alert('콜백실행');
  
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	id = naver_id_login.getProfileData('id');
    name = naver_id_login.getProfileData('name');
    email = naver_id_login.getProfileData('email');

    $.ajax({
    	type: 'POST',
    	url: 'joinNaverMem.do',
    	data: {'userId':id, 'userName':name, 'userEmail':email},
    	success: function(result){
    		if(result=="Y"){
    			alert('환영합니다. '+name+'님!\n오브리에서 다양한 연주자들과 소통하세요.');
	    		location.href="home.do";
    		}else if(result=="N"){
    			alert('탈퇴한 계정입니다.\n소셜로그인으로 재가입을 원하실 경우 문의 메일을 남겨주세요.');
    			location.href="home.do";
    		}else if(result=="X"){
    			alert('관리자에 의해 사용이 정지된 계정입니다.');
    			location.href="home.do";
    		}else{
	    		alert('네이버 로그인에 실패했습니다.\n가입 후 로그인을 시도해주세요.');
    			location.href="login.do";
    		}
    	},
    	error: function(result){
    		alert('네이버 로그인에 실패했습니다.\n가입 후 로그인을 시도해주세요.');
    		location.href="login.do";
    	}
    })
  }
</script>
</body>
</html>