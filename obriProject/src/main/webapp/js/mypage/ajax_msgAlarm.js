// 모달창에서 '보내기' 버튼 클릭 시
function messageSnd() {
  $("#sendMsgButton").on("click", function () {
    // 알림 메시지 데이터 형식
    var AlarmData = {
      myAlarm_senderUserId: sender,
      myAlarm_receiverUserId: receiver,
      myAlarm_content: sender + "님이 메시지를 보냈습니다.",
    };
    //스크랩 알림 DB저장
    $.ajax({
      type: "post",
      url: "/mentor/member/saveAlarm",
      data: JSON.stringify(AlarmData),
      contentType: "application/json; charset=utf-8",
      dataType: "text",
      success: function (data) {
        if (socket) {
          let socketMsg = "message," + sender + "," + receiver + "," + index;
          console.log("msgmsg : " + socketMsg);
          socket.send(socketMsg);
        }
      },
      error: function (err) {
        console.log(err);
      },
    });
  });
}
