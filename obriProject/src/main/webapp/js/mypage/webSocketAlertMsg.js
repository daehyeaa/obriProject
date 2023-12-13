var socket = null;

$(document).ready(function () {
  // WebSocket 연결 함수 호출
  connectWs();
});

function connectWs() {
  // SockJS를 사용하여 WebSocket 연결
  sock = new SockJS("/echo");
  //sock = new SockJS('/replyEcho');
  socket = sock;

  // 이벤트 리스너(커넥션이 연결되었을 경우에 서버 호출됨)
  sock.onopen = function () {
    console.log("웹소켓 연결 info: connection opened.");
  };

  // 메시지 보냈을 경우 호출
  sock.onmessage = function (evt) {
    var data = evt.data;
    console.log("ReceivMessage : " + data + "\n");

    // Ajax를 사용하여 서버에 알림 카운트 요청
    $.ajax({
      url: "countAlarm.do",
      type: "POST",
      dataType: "text",
      success: function (data) {
        if (data == "0") {
          // 알림이 없는 경우
        } else {
          // 알림이 있는 경우, 화면에 알림 카운트 표시
          $("#alarmCountSpan").addClass("bell-badge-danger bell-badge");
          $("#alarmCountSpan").text(data);
        }
      },
      error: function (err) {
        alert("에러 발생 :" + err);
      },
    });

    // 모달 알림
    var toastTop = app.toast.create({
      text: "알림 : " + data + "\n",
      position: "top",
      closeButton: true,
    });
    toastTop.open();
  };

  // 서버가 끊긴 경우 호출
  sock.onclose = function () {
    console.log("connect close");
    /* setTimeout(function(){conntectWs();} , 1000); */
  };

  // 에러 발생한 경우 호출
  sock.onerror = function (err) {
    console.log("Errors : ", err);
  };
}
