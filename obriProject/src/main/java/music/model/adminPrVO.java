package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class adminPrVO {
	private int prNo;
	private String userId;
	private String prSub;
	private String prText;
	private int prRcount;
	private String prMajor;
	private String prLoc;
	private String prCareer;
	private String prVideo;
	private String prFile;
	private String prHash;
	private Date prDate;
	private Date prUpdate;
	private String prDelYn;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
