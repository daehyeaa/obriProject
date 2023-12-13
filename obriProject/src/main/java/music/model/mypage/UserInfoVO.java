package music.model.mypage;

import lombok.Builder;
import lombok.Data;

@Data
//@Builder
public class UserInfoVO {
    private String userId;
    private String userPw;
    private String userName;
    private String userPhone;
    private String userEmail;
    
    // prBoard.prNo(프로필 수정을 위함
//    @Builder.Default
    private Integer prNo;
    
    // prBoard.prFile(첨부파일) 업로드한 이미지
    private String prFile;
    
    // member.userMajor과 prBoard.prMajor의 값을 비교해서 userPosition값 설정
    private String userPosition;
		
	// lombok사용 시, getter & setter메소드 불필요함 => 어노테이션 사용
}