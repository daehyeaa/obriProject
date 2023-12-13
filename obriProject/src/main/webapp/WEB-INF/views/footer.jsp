<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>

<link rel="stylesheet" href="./css/footer.css">

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
   crossorigin="anonymous"></script>
<script>
	$(function() {
		$("#navbar_toggle_btn").click(function() {
			$("#navbar_menu").toggle();
			$("#navbar_icons").toggle();
		});
	});
</script>
</head>
<body>
  <!-- footer start -->
   <div class="nav_foot">
      <div class="nav_container">
      <br>
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
   </div>
   <!-- footer end -->
</body>
</html>