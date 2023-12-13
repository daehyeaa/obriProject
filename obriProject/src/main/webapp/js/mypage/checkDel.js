function check_select() {
  // 'msgNo'라는 이름을 가진 모든 체크박스 가져오기
  var selChecks = document.getElementsByName("check_msgno");

  if (selChecks.length == 0) {
    alert("선택된 항목이 없습니다.");
    return;
  }

  // 선택된 값들을 저장할 배열 초기화
  var msgNo = [];

  // 선택된 체크박스를 찾기 위해 체크박스를 반복
  for (var i = 0; i < selChecks.length; i++) {
    if (selChecks[i].checked) {
      // 선택된 체크박스 값(msgNo)을 배열에 추가
      msgNo.push(selChecks[i].value);
    }
  }

  result = confirm("선택한 쪽지를 삭제하시겠습니까?");
  if (result == true) {
    location.href = "deleteRcvMsg.do?msgNo=" + msgNo.join(",");
  }
  return;
}


	// 선택 삭제
/* 	function check_selectDel(formId) {
		
		var chkNoForm = document.getElementById(formId);
		
		if (!chkNoForm) {
	        alert("폼을 찾을 수 없습니다.");
	        return;
	    }
		
		if($("input[name='check_msgno']:checked").length == 0 ){
			alert("선택된 항목이 없습니다.");
			return;
		}
		
 		var msgNoArray = [];
 		$("input[name='check_msgno']:checked").each(function() {
		      // 선택된 체크박스 값(msgNo)을 배열에 추가
		      msgNoArray.push($(this).val());
 		});
 		console.log("msgNoArray : " + msgNoArray);
 		
		if(confirm("정말 삭제하시겠습니까?")==false) {
			return;
		}
		
		// msgNoArray를 폼에 추가
		$("<input>").attr({
        type: "get",
        name: "msgNoArray",
        value: msgNoArray.join(",")
    	}).appendTo(chkNoForm);
		
		// 폼 제출
		chkNoForm.action="delete_RcvMsg_select.do";
		chkNoForm.submit();
	} */
	
	
		// 체크박스 하나 삭제
/* 	function selOneDel(msgNo) {
		if (confirm("선택한 쪽지를 삭제하시겠습니까?")== true) {
			location.href = "deleteRcvMsg.do?msgNo=" + msgNo;
		}
		return;		
	} */


// deleteBtnMsg" ID를 가진 요소를 클릭하면 check_select() 함수가 호출
$("#deleteBtnMsg").click(() => {
  check_select();
});



/* 	function check_selectDel() {
		// 'msgNo'라는 이름을 가진 모든 체크박스 가져오기
		var selChecks = document.getElementsByName("check_msgno");

		if (selChecks.length == 0) {
		    alert("선택된 항목이 없습니다.");
		    return;
		}

		// 선택된 값들을 저장할 배열 초기화
		var msgNo = [];

		// 선택된 체크박스를 찾기 위해 체크박스를 반복
		for (var i = 0; i < selChecks.length; i++) {
		    if (selChecks[i].checked) {
		      // 선택된 체크박스 값(msgNo)을 배열에 추가
		      msgNo.push(selChecks[i].value);
			}
		}

		if (confirm("선택한 쪽지를 삭제하시겠습니까?")== true) {
		    location.href = "deleteRcvMsg.do?msgNo=" + msgNo.join(",");
		}
		return;
	} */

//   selCheckLen = selCheck.length; //체크박스 전체수
//   if (selCheckLen == 1) {
//     //체크박스 전체 리스트 수가 1개 일때
//     document.myformMsgnoDel.check_msgno.checked = true;
//     check_one = document.myformMsgnoDel.check_msgno.value;
//     result = confirm("선택한 쪽지를 삭제하시겠습니까?");
//     if (result == true) {
//       location.href = "delete_select.jsp?code=<%=code%>&uids=" + check_one;
//     }
//     return;
//   }
//   for (var i = 0; i < document.Form1.ap_check.length; i++) {
//     if (document.Form1.ap_check[i].checked == true) break;
//   }
//   if (i == document.Form1.ap_check.length) {
//     alert("선택된 항목이 없습니다.");
//     return;
//   }
//   if (confirm("삭제하시겠습니까?")) {
//     check_select2();
//     return;
//   }
// }
