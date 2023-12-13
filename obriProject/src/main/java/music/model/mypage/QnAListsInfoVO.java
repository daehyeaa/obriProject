package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class QnAListsInfoVO {
	// ROWNUM으로 생성한 번호
	private Integer qNo;	

	// qnaBoard
	private Integer qnaNo;	// 글 번호
	private String qnaSub;	// 제목
	private String qnaText;	// 내용
	private String qnaFile;	// 파일
	
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date qnaDate;	// 작성일

	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date qnaUpdate;	// 수정일
	
	private String qnaDelYn;	// 삭제 여부
	
	// 문의 답변 여부
	private String qnaCheckYn;
}
