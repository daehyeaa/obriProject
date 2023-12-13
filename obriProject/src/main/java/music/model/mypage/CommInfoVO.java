package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommInfoVO {
	// comBoard
    private Integer commNo;		// 게시글 번호
    private String userId;		// 글 작성자
    private String commSub;		// 제목
    private String commText;	// 내용
    private Integer commCount;	// 조회수
    
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private Date commUpdate;	// 수정일
    
    // comReply.commNo = comBoard.commNo
    private Integer replyCnt;		// 댓글수
    
    // comLike.commNo = comBoard.commNo
    private Integer likeCnt;		// 좋아요 수
}
