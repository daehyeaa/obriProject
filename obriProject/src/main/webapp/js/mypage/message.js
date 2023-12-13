	// 전체 선택
	function toggleAllCheckboxes() {
		var selectAllCheckbox = document.getElementById("selectAll");
		var msgNoCheckboxes = document.getElementsByName("check_msgno");
		
		for (var i = 0; i < msgNoCheckboxes.length; i++) {
			msgNoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}
	
	
 	// 다중 선택 삭제
	function check_selectDel() {
		if($("input[name='check_msgno']:checked").length == 0 ){
			alert("선택된 항목이 없습니다.");
			return;
		}
		
		if(confirm("정말 삭제하시겠습니까?")==false) {
			return;
		}
		
		// 선택한 msgNo 저장해 둘 배열 선언
		var msgNoArray = new Array();
 		$("input[name='check_msgno']:checked").each(function() {
		      // 선택된 체크박스 값(msgNo)을 배열에 추가
		      msgNoArray.push($(this).val());
		});
		console.log("msgNoArray : " + msgNoArray);
		
		var deleteCount = 0; // 삭제된 항목 수
        // 삭제 요청이 완료될 때마다 호출되는 함수
        function onDeleteComplete() {
            deleteCount++;

            // 모든 삭제 요청이 완료되면 페이지 리로드
            if (deleteCount === msgNoArray.length) {
            	console.log("deleteCount : " + deleteCount);
            	alert("선택 항목 삭제 성공!");
            	location.reload();
            }
        }		
		
		// 반복문으로 삭제 진행
		for(var i = 0; i < msgNoArray.length; i++) {
			$.ajax({
				type: "DELETE",
				url: "deleteSelectMsg.do?msgNo=" + msgNoArray[i],
				success: function(result) {
		            if (result.code == 1) {
		                // 삭제 성공
		            } else if(result.code == -1) {
						alert("항목 선택 삭제 실패");
		            }
				},
				error:function(e){
		    		// alert("data error : "+e);
		    	},
				complete: onDeleteComplete // AJAX 요청이 완료되면 호출될 콜백 함수
			});
		}
	}