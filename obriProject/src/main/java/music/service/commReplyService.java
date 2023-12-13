package music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.commReplyDao;
import music.model.commReplyVO;
import music.model.communityVO;

@Service
public class commReplyService {

	@Autowired
	private commReplyDao replydao;

	public void commReInsert(commReplyVO commReply) {
		System.out.println("댓글 입력 서비스");
		replydao.commReInsert(commReply);
	}

	public List<communityVO> comReList(int commNo) {
		// TODO Auto-generated method stub
			System.out.println("댓글 목록 서비스");
		return replydao.comReList(commNo);
	}

	public int getTotal(commReplyVO commReply) {
		// TODO Auto-generated method stub
		System.out.println("댓글 갯수 서비스");
		return replydao.getTotal(commReply);
	}

	public void comReDelete(int commReNo) {
		// TODO Auto-generated method stub
		System.out.println("댓글 삭제 서비스");
		replydao.comReDelete(commReNo);
		
	}

	public void replySecret(commReplyVO commReply) {
		// TODO Auto-generated method stub
		System.out.println("비밀댓글 서비스");
		replydao.replySecret(commReply);
		
	}
}
