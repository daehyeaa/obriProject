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
		<table>
			<tr align="center">
				<th>작성자</th>
				<th >내용</th>
				<th ></th>
				<th >댓글 작성일</th> 댓글 갯수 : ${reTotal }
			</tr>

			<c:forEach var="commReList" items="${commReList}">
				<c:if test="${commReList.commReDelYn  != 'Y' }">
				
					<c:if test="${commReList.commSecret  == 'Y'}">
						<tr>	
							<td colspan="4">
							<img src="images/secret.png"  width="25" height="25">비밀댓글입니다
							</td>
						</tr>
					</c:if>
<%-- 					<c:if test="${commReList.commSecret  == 'Y' && sessionScope.userId == commReList.commReId && sessionScope.userId == sessionScope.adminId }"> --%>
<!-- 							<tr>	 -->
<!-- 									작성자 -->
<%-- 									<td>${commReList.commReId}&nbsp;&nbsp;</td> --%>

<!-- 									내용 -->
<%-- 									<td id=" ${commReList.commReNo}">${commReList.commReText}&nbsp;&nbsp;</td> --%>

<!-- 									<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->

<!-- 									수정일 -->
<%-- 									<td><fmt:formatDate value="${commReList.commReDate}" --%>
<%-- 												pattern="MM. dd. HH:mm " /></td> --%>


<%-- 								<c:if test="${commReList.commReId == sessionScope.userId}"> --%>
<!-- 									<td> -->
<!-- 									버튼  -->
<!-- 									<input type="button" value="삭제" -->
<%-- 										onclick="del(${commReList.commReNo},${commReList.commNo})"> --%>
<!-- 									</td> -->
<%-- 								</c:if> --%>
<!-- 							</tr> -->
<%-- 					</c:if> --%>

				    <!-- 컨트롤에서 공유되는  -->												
					<c:if test="${commReList.commSecret != 'Y'}">
					<tr>
						<!-- 작성자 -->
						<td>${commReList.commReId}&nbsp;&nbsp;</td>

						<!-- 내용 -->
						<td id=" ${commReList.commReNo}">${commReList.commReText}&nbsp;&nbsp;</td>

						<td > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

						<!-- 수정일 -->
						<td><fmt:formatDate value="${commReList.commReDate}"
								pattern="MM. dd. HH:mm " /></td>


						<c:if test="${commReList.commReId == sessionScope.userId}">
							<td>
								<!-- 버튼 --> <input type="button" value="삭제"
								onclick="del(${commReList.commReNo},${commReList.commNo})">
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