package music.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.util.HtmlUtils;

import music.model.mypage.MsgNotification;
import music.service.MsgNotificationService;

@Controller
public class MsgAlertController {
	
	@Autowired
	private MsgNotificationService notifService;
	
	@MessageMapping("/firstAlarmToNewUser")
	@SendTo("/topic/all")
	public MsgNotification getFirstAlarm() throws Exception {
		notifService.sendGlobalNotification();
		return new MsgNotification("환영합니다!</br>새로운 공고를 확인해보세요!");
	}
	
    @MessageMapping("/applicationalarm")
    @SendTo("/topic/application")
    public MsgNotification getApplicationAlarm() throws Exception {
    	notifService.sendGlobalNotification();
    	notifService.sendApplicationNotification();
        return new MsgNotification("새로운 지원자가 있어요!</br>지금 구인현황 페이지를 확인해보세요!");
    }
    
    @MessageMapping("/private-message")
    @SendToUser("/topic/private-messages")
    public MsgNotification getPrivateMessage(MsgNotification msgContent, @SessionAttribute("userId") String id) throws Exception {
    	notifService.sendPrivateNotification(id);
        return new MsgNotification(HtmlUtils.htmlEscape(
                "Sending private message to user " + id + " : " + msgContent.getMsgcontent()));
    }

}
