<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판 글 수정</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/custom-styles.css">

<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>

</head>

<body>
  <%@include file="../navbar.jsp" %>

<main style="padding-top: 80px; padding-bottom: 80px">
        <h2 id="title"  align=center>글수정</h2>
        <form method=post  action="boardUpdate.do"  enctype="multipart/form-data" >
        <input type="hidden"  name="commNo"  value="${community.commNo}">
		<input type="hidden"  name="pageNum"  value="${pageNum}">
            <table border=1  align=center  width=800  height=400>
                <tr>
                    <th>작성자</th>
                    <td><input type=text  name="userId"   value=" ${community.userId}"  readonly></td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type=text  name="commSub"  required value=" ${community.commSub } "></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols=100 rows=20  name="commText"   id="commText"  required>${community.commText} </textarea>
                        <br><br>
                    </td>
				</tr>
				<tr>
                    <th>첨부파일</th>
                    <td><input type=file   name="com_file1" ></td>
                </tr>
            </table>
            <div align="center">
            	<tr>
            		<td colspan=2  align=center>
                		<input type=submit  value="글 수정"  id="submitButton" class="btn" >
                		<input type="button" class="btn"   value="목록으로"  onclick="location.href='boardList.do' ">
           			</td>
           		</tr>
           	</div>
        </form>
  
</main>
<%@include file="../footer.jsp" %>
			
</body>
</html>

