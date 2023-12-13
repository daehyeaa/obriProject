package music.model.mypage;

import lombok.Data;

@Data
public class StatusCountVO {
	// user(id)에 대한 공고 지원/모집의 현황을 count해서 가져옴
    private String id;
    
    // 지원 현황
    // 전체 현황(지원상태 무관)
    private Integer appstatusAll;
    // 지원 완료(대기중)
    private Integer appstatusCont;
    // 컨택됨(승인)
    private Integer appstatusFin;
    
    // 구인 현황
    // 전체 현황(지원상태 무관)
    private Integer jobstatusAll;
    // 구인(진행중) 현황
    private Integer jobstatusCont;
    // 구인(컨택완료=승인) 현황
    private Integer jobstatusFin;
}
