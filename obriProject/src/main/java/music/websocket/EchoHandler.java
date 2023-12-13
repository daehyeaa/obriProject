package music.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mysql.cj.util.StringUtils;

import music.model.memberVO;

@Repository
public class EchoHandler extends TextWebSocketHandler{

	// WebSocket 세션과 사용자 이름을 매핑(누가 세션에 접속했는지 추적) -1:1
	Map<String, WebSocketSession> userSessionMap = new HashMap<String, WebSocketSession>();
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	
	// 웹 소켓 연결이 종료되고 나서 서버단에서 실행해야할 일들을 정의
	@Override    
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed "+session+", "+status);
		
		userSessionMap.remove(session.getId());
		sessions.remove(session);
	}
	
	// 웹소켓 연결 직후에 처리
	@Override  	  
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//연결된 세션들을 보관
		sessions.add(session);
		
		String senderId = getId(session);
		System.out.println(">>>>>>>>>"+senderId);
		userSessionMap.put(senderId, session);
	}
	
	// 웹소켓 email 가져오기
	private String getEmail(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		memberVO loginUser = (memberVO)httpSession.get("memberVO");
		
		if(loginUser == null) {
			return session.getId();
		} else {
			return loginUser.getUserEmail();
		}
	}
	
	// 세션 로그인 사용자 Id 가져옴
	private String getId (WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
	    String userId = (String)httpSession.get("userId"); 
	    if(userId == null)
	    	return session.getId();
	    else
	    	return userId;
	}	
	
	
	// 웹소켓 연결후 서버단(소켓)으로 메세지가 도착했을때 해주어야할 일들을 정의
	@Override    
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// message.getPayload()함수 : 메시지에 담긴 텍스트값을 얻을 수 있음
		System.out.println(session.getId()+"가 보낸 메시지: "+message.getPayload());
		
		// protocol: cmd, 댓글작성자, 게시글작성자, index (reply,user2,user1,234)
		String msg = message.getPayload();
		if(!StringUtils.isNullOrEmpty(msg)) {
			String[] strs = msg.split(",");
			
			// 메시지가 유효하고 길이가 5(strs.length == 5)인 경우
			if(strs != null) {
				String cmd = strs[0];  			// 명령어 유형
	            String sender = strs[1];  		// 발신인/댓글 작성자
	            String receiver = strs[2];  	// 수신인/해당 글 작성자
	            String index = strs[3];  		// 메시지/게시글 번호
	            
	            // 알림 받는 유저가 로그인 중인 경우
	            WebSocketSession boardWriterSession = userSessionMap.get(receiver);
	            
	            // cmd = reply : 댓글인 경우
	            if("reply".equals(cmd) && boardWriterSession != null) {
	            	TextMessage tmpMsg = new TextMessage(sender + "님이 " + 
                            "<a type='external' href='job_board_view.do?jobNo="+index+"&pageNum=1'>" 
	            			+ index + "</a> 번 구인 게시글에 댓글을 남겼습니다.");
	            	boardWriterSession.sendMessage(tmpMsg);
	            
	            // cmd = message : 쪽지를 보낸 경우
	            } else if("message".equals(cmd) && boardWriterSession != null) {
	                TextMessage tmpMsg = new TextMessage(sender + "님이 " +
                            "<a type='external' href='messagebox_rcv.do?msgNo="+index+"'>" 
	                		+ receiver  + "</a>님에게 쪽지를 보냈습니다.");
	                boardWriterSession.sendMessage(tmpMsg);	            	
	            }
			}
		}
	}
}
