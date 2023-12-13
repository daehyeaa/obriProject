package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class qnaVO {
	private int qnaNo;
	private String userId;
	private String qnaSub;
	private String qnaText;
	private String qnaFile;
	private Date qnaDate;
	private Date qnaUpdate;
	private String qnaDelYn;
	
	private String search;
	private String keyword;
	
	private int startRow; 			// 시작 행
	private int endRow;				// 마지막 행
}
