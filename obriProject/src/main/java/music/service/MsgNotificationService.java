package music.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import music.model.mypage.MsgNotification;

@Service
public class MsgNotificationService {
	
	private SimpMessagingTemplate msgTemplt;
	
	@Autowired
	public MsgNotificationService(SimpMessagingTemplate msgTemplt) {
		this.msgTemplt = msgTemplt;
	}
	
	// 새 유저 메시지
	public void sendGlobalNotification() {
		MsgNotification pushMsg = new MsgNotification("Global Notification");
		msgTemplt.convertAndSend("/topic/global-notifications", pushMsg);
	}
	
	// 새로운 지원자 메시지
	public void sendApplicationNotification() {
		MsgNotification pushMsg = new MsgNotification("Application Notification");
		msgTemplt.convertAndSend("/topic/application-notifications", pushMsg);
	}
	
	// 개인 메시지
	public void sendPrivateNotification(String id) {
		MsgNotification pushMsg = new MsgNotification("Private Notification");
		msgTemplt.convertAndSendToUser(id, "/topic/private-notifications", pushMsg);
	}

}
