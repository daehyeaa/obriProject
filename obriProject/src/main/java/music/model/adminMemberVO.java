package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class adminMemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String userPhone;
	private String userEmail;
	private String userMajor;
	private String userGru;
	private Date userDate;
	private Date userUpdate;
	private String userDelYn;
	private String mailAuth;
	private String mailKey;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
