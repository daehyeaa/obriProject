package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class JobInfoVO {
	// 수동적으로 설정한 no컬럼
	private Integer no;  
	
    private Integer jobNo;  // 게시글 번호
    private String userId;

    private String jobSub;	// 제목
    private String jobText;	// 내용
    
    // date타입은 어노테이션으로 패턴 설정 가능
    @DateTimeFormat(pattern="yyyy-mm-dd")
    private Date jobConcert;	// 공연일
    
    private String jobAddress;	// 지역
    
    // member.userId = JobBoard.userId인 회원의 이름
    private String userName;	// 작성자 명
    
    private String jobCd;	// 모집분야(jobCd)
    
//    private Blob photo;			// 모집분야(jobCd)별 대표사진
}
