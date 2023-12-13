package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class StatusFinalVO {
    private String keyword;
    private String userId;		// 지원자 id
    private List<StatusCountVO> statusCountVOs;
    private List<StatusFinalInfoVO> statusFinalInfoVOs;

    public StatusFinalVO(List<StatusCountVO> statusCountVOs, List<StatusFinalInfoVO> statusFinalInfoVOs) {
        this.statusCountVOs = statusCountVOs;
        this.statusFinalInfoVOs = statusFinalInfoVOs;
    }	
}
