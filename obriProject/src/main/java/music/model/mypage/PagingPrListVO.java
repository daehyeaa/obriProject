package music.model.mypage;

import java.util.List;

import lombok.Data;

@Data
public class PagingPrListVO {
    private List<LikesListPRVO> likesListPRVOs;
    private PagingVO pagingVO;

}
