package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommReplyInfoVO {
	// comReply
    private Integer commReNo;		// 댓글 번호
    private String commReId;		// 댓글 작성자	
    private String commReText;	// 댓글 내용
    
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private Date commReUpdate;	// 댓글 수정일
    
    private String commReDelYn;	// 댓글 삭제 여부
    
    // comReply.commNo = comBoard.commNo
    private String commSub;		// 댓글 단 글의 제목
    // count(*)
    private Integer commreplyCnt;	// 댓글 단 글의 댓글 수
}
