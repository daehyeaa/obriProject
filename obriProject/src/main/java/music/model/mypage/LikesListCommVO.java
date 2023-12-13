package music.model.mypage;

import lombok.Data;

@Data
public class LikesListCommVO {
	// comLike.userId
	private String userId;		// 사용자 id
	
	private Integer commLikeNo;		// 좋아요 번호
	private Integer commNo;		// 좋아요 한 게시글 번호
	
	// 좋아요 한 커뮤니티 게시글(comLike.commNo = comBoard.commNo)
	private String writerId;	// 글 작성자 id
	private String commFile;		// 커뮤니티 첨부 파일
	private String commSub;		// 글 제목
	private String commText;	// 글 내용
	private String commLikestat;		// 좋아요 한 상태
	
	// 글 작성자 id -> 글 작성자 이름(comBoard.userId = member.userId)
	private String writerName;	// 글 작성자 명
	
	// 글 작성자 id -> 홍보게시판에 업로드한 프로필 사진(prBoard.userId = member.userId)
	private String prFile;	// 작성자 프로필 사진
	
}
