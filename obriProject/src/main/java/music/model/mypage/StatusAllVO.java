package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class StatusAllVO {
    private String keyword;
    private String userId;		// 지원자 id
    private List<StatusCountVO> statusCountVOs;
    private List<StatusInfoVO> statusInfoVOs;

    public StatusAllVO(List<StatusCountVO> statusCountVOs, List<StatusInfoVO> statusInfoVOs) {
        this.statusCountVOs = statusCountVOs;
        this.statusInfoVOs = statusInfoVOs;
    }	
}
