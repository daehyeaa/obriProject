package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MessageInfoVO {
	// 설정한 메시지 번호
//	private Integer rcvmNo;
//	private Integer sndmNo;
	private Integer mNo;
	
	// 메시지 정보 가져옴
	// user가 보낸 메시지 총 개수
	private Integer totalSndMsg;
	
	// user가 받은 메시지 총 개수
	private Integer totalRcvMsg;
	
	// user가 받은 메시지 중 읽지 않은 메시지 개수
	private Integer totalUncheckMsg;
	
	private Integer msgNo;
	private String sendUserId;	// 보낸 사람 id
	private String rcvUserId;	// 받은 사람 id
	private String msgContents;
	private Integer isRcv;	// 받은 메시지(T, 1) <-> 받은 메시지 삭제(F, 0)
	private Integer isSnd;	// 보낸 메시지(T, 1) <-> 보낸 메시지 삭제됨(F, 0)
	private Integer isCheck;	// 읽음 표시(T, 읽음) <-> 읽지 않음(F, 읽지 않음)
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date msgDate;	// 메시지 작성일(보낸 일자)
	
	private Boolean isMsgDel;	// 메시지 삭제 여부
}
