package music.model.mypage;

import java.util.List;

import lombok.Data;

// 여러 종류 정보를 포함하여, 한번에 정보를 전송하기 위한 DTO객체
@Data
public class InfoAllVO {
	
	// 회원 기본 정보
	private List<UserInfoVO> userInfoVOs;
	// 회원 관련 count(*)정보
	private List<InfoCountVO> infoCountVOs;
	// 추천공고 보여주기 위함
	private List<JobInfoVO> jobInfoVOs;
	// 회원이 지원/모집한 공고 count(*) 정보
	private List<StatusCountVO> statusCountVOs;
}
