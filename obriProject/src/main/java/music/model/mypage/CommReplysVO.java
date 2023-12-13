package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class CommReplysVO {
	private String id;
	private String keyword;
	private List<CommReplyInfoVO> commReplyInfoVOs;
	
	public CommReplysVO(List<CommReplyInfoVO> commReplyInfoVOs) {
		this.commReplyInfoVOs = commReplyInfoVOs;
	}
}
