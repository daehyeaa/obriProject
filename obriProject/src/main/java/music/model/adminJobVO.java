package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class adminJobVO {
	private int jobNo;
	private String userId;
	private String jobCd;
	private String jobFin;
	private int jobSpace;
	private String jobAddress;
	private String jobPlace;
	private Date jobEndDate;
	private Date jobConcert;
	private String jobWriter;
	private String jobSub;
	private String jobText;
	private int jobRcount;
	private Date jobDate;
	private Date jobUpdate;
	private String jobDelYn;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
