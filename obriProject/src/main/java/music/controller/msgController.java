package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import music.model.msgVO;
import music.service.msgService;

@Controller
public class msgController {
	
	@Autowired
	private msgService msgService;

	
	@RequestMapping("msgInsert.do")
	@ResponseBody
	public int msgInsert(@RequestBody msgVO msg, Model model, HttpSession session, HttpServletRequest request) {
		
		System.out.println("채팅 insert 시작");
		
		String userId = (String)session.getAttribute("userId");
		msg.setUserId(userId);
		
		System.out.println("msg값들이 들어 갔는지 확인");
		System.out.println(msg);
		System.out.println("쪽지내용"+msg.getMsgText());
		System.out.println("보낸사람ID"+msg.getUserId());
		System.out.println("받는사람ID"+msg.getRecvId());
		
		int result = 0;
		result = msgService.insertMsg(msg);
		
		return result;
	}
	
}
