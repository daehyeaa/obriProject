package music.model.mypage;

import lombok.Data;

@Data
public class LikesListPRVO {
	// ROWNUM으로 재 정의한 좋아요 한 리스트 번호
	private Integer likeno;
	
	// prLike.userId
	private String userId;		// 사용자 id
	
	private Integer prLikeNo;		// 좋아요 번호
	private Integer prNo;		// 좋아요 한 게시글 번호
	private String prLikestat;		// 좋아요 한 상태	
	
	// 좋아요 한 PR 게시글(prBoard.prNo = prLike.prNo)
	private String prwriterId;	// 글 작성자 id
	private String prFile;		// 첨부 파일
	private String prSub;		// 글 제목
	private String prText;	// 글 내용
	private String prCareer;	// 작성자 경력사항
	private String prMajor;	// 작성자 전공

}
