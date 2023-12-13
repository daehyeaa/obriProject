package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class PagingMsgListVO {
    private List<MessageInfoVO> messageInfoVOs;
    private PagingVO pagingVO;
}
