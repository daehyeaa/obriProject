package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class StatusWaitingVO {
    private String keyword;
    private String userId;		// 지원자 id
    private List<StatusCountVO> statusCountVOs;
    private List<StatusWaitingInfoVO> statusWaitingInfoVOs;
    
    public StatusWaitingVO(List<StatusCountVO> statusCountVOs, List<StatusWaitingInfoVO> statusWaitingInfoVOs) {
    	this.statusCountVOs = statusCountVOs;
    	this.statusWaitingInfoVOs = statusWaitingInfoVOs;
    }
}
