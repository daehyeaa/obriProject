<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 글 삭제 confirm 창 띄우기 -->
<script>
	
	function del(commReNo, commNo) {
		if(confirm("댓글을 삭제 하시겠습니까?") == true){
			alert("댓글이 삭제 되었습니다");
		var formData = "commReNo=" + commReNo + "&commNo=" + commNo;
		$.post("commReDelete.do", formData, function(data) {
			$('#commReList').html(data);				
	});
		}else{
			alert("취소되었습니다");
			return false;
		}
			
	}
</script>


<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form>
		<table >
			<tr align="center">
				<td></td>
				<th>작성자</th>
				<th >내용</th>
				<th ></th>
				<th >댓글 작성일</th> 댓글 갯수 : ${reTotal}
			</tr>
	
			<c:forEach var="commReList" items="${commReList}">
				<c:if test="${commReList.commReDelYn  != 'Y'}">
				
				<!-- 1.비로그인 상태 -->
				<!--  sessionScope.userId != commReList.commReId && sessionScope.userId !=sessionScope.adminId && -->
					<c:if test="${commReList.commSecret  == 'Y' &&  empty sessionScope.userId}">
						<tr>	
							<td colspan="4">
									<img src="images/secret.png"  width="25" height="25">비밀댓글입니다
							</td>
						</tr>
					</c:if>
					
					<!--2. 로그인(작성자 or 관리자)  -->
  					<c:if test="${commReList.commSecret  == 'Y' &&  sessionScope.userId == commReList.commReId  &&  !empty sessionScope.userId}"> 
							<tr>	 
									<td><img src="images/secret.png"  width="20" height="20"></td>
									<td>${commReList.commReId}&nbsp;&nbsp;</td> 
									<td id=" ${commReList.commReNo}">${commReList.commReText}&nbsp;&nbsp;</td>
									<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td><fmt:formatDate value="${commReList.commReDate}"  	pattern="MM. dd. HH:mm " /></td> 

									<c:if test="${commReList.commReId == sessionScope.userId}"> 
										<td>
											<input type="button" value="삭제"  onclick="del(${commReList.commReNo},${commReList.commNo})"> 
										</td> 
 									</c:if> 
							</tr> 
 					</c:if> 

					<!-- 3.로그인(작성자, 관리자가 아닌 경우) -->
					<c:if test="${commReList.commSecret  == 'Y'  &&  sessionScope.userId  != commReList.commReId &&  !empty sessionScope.userId}">
						<tr>	
							<td colspan="4">
									<img src="images/secret.png"  width="25" height="25">비밀댓글입니다
							</td>
						</tr>
					</c:if>
					
					<!-- 4. 비밀글이 아닌경우 -->										
					<c:if test="${commReList.commSecret != 'Y'}">
					<tr>
						<td></td>
						<td>${commReList.commReId}&nbsp;&nbsp;</td><!-- 작성자 -->
						<td id=" ${commReList.commReNo}">${commReList.commReText}&nbsp;&nbsp;</td><!-- 내용 -->
						<td > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><fmt:formatDate value="${commReList.commReDate}"    pattern="MM. dd. HH:mm " /></td><!-- 수정일 -->

						<c:if test="${commReList.commReId == sessionScope.userId}">
							<td>
								<!-- 버튼 --> <input type="button" value="삭제" 	onclick="del(${commReList.commReNo},${commReList.commNo})">
							</td>
						</c:if>
						
					</tr>					
				</c:if>
				
 			</c:if> 
			</c:forEach>
		</table>
	</form>
</body>
</html>