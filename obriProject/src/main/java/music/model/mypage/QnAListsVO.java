package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class QnAListsVO {
	private String id;
	private String keyword;
	private List<QnAListsInfoVO> qnaListsInfoVOs;
	
	public QnAListsVO(List<QnAListsInfoVO> qnaListsInfoVOs) {
		this.qnaListsInfoVOs = qnaListsInfoVOs;
	}
}
