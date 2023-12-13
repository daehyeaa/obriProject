package music.model.mypage;

import lombok.Data;

@Data
public class PrBoardVO {
	// 모든 PrBoard에 작성된 데이터 가져옴 -> 옵션 사용
	private String prCareer;
	private String prMajor;
	private String prLoc;
	private String prHash ;
}
