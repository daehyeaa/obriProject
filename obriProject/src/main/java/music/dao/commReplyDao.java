package music.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.commReplyVO;
import music.model.communityVO;

@Repository
public class commReplyDao {

	@Autowired
	private SqlSession replysession;

	public void commReInsert(commReplyVO commReply) {
		System.out.println("댓글 입력 dao");
		replysession.insert("commReplyns.replyInsert", commReply);
		
	}

	public List<communityVO> comReList(int commNo) {
		// TODO Auto-generated method stub
		System.out.println("댓글 목록 dao");
		return replysession.selectList("commReplyns.replyList", commNo);
	}

	public int getTotal(commReplyVO commReply) {
		// TODO Auto-generated method stub
		System.out.println("댓글갯수 dao");
		return replysession.selectOne("commReplyns.reCount",commReply);
	}

	public void comReDelete(int commReNo) {
		// TODO Auto-generated method stub
		System.out.println("댓글 삭제 dao");
		replysession.delete("commReplyns.replyDelete", commReNo);
		
	}

	public void replySecret(commReplyVO commReply) {
		// TODO Auto-generated method stub
		System.out.println("비밀댓글 dao");
		replysession.update("commReplyns.replySecret",commReply);
		
	}
}
