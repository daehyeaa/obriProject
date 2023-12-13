package music.model.mypage;

import lombok.Data;

@Data
public class InfoCountVO {
	// user(회원) 별 횟수 데이터
    private String id;
    // statusAll
    // 전체 지원 현황
    private Integer applystatusAll;
    // 전체 구인 현황
    private Integer jobstatusAll;
    
    // likesCount
    // PR 글 좋아요 수
    private Integer prlikesCount;
    // 커뮤니티 글 좋아요 수
    private Integer commlikesCount;
    
    // 커뮤니티에 작성한 글 수
    private Integer commCountAll;
    
    // 받은 쪽지 수
    private Integer messagesCount;
    
    // 문의게시판에 작성한 글 수
    private Integer qnaCountAll;
	
	// lombok사용 시, getter & setter메소드 불필요함 => 어노테이션 사용
}