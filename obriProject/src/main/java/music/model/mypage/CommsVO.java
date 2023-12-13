package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class CommsVO {
	private String id;
	private String keyword;
	private List<CommInfoVO> commInfoVOs;
	
	public CommsVO(List<CommInfoVO> commInfoVOs) {
		this.commInfoVOs = commInfoVOs;
	}

}
