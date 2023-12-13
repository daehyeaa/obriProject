package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class adminCommVO {
	private int commNo;
	private String userId;
	private String commSub;
	private String commText;
	private int commCount;
	private String commFile;
	private Date commDate;
	private Date commUpdate;
	private String commDelYn;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
