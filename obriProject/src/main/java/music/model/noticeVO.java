package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class noticeVO {
	private int notNo;
	private String adminId;
	private String notSub;
	private String notText;
	private int notRcount;
	private Date notDate;
	private Date notUpdate;
	private String notDelYn;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
