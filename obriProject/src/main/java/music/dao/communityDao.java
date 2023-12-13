package music.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.commLikeVO;
import music.model.communityVO;

@Repository
public class communityDao {

	@Autowired
	private SqlSession session;

	// 글작성
	public int insertBoard(communityVO community) {
		System.out.println("글작성 DAO");
		return session.insert("communityns.insertBoard", community);
	}

	public List<communityVO> list(communityVO community) {
		System.out.println("글목록 Dao");
		return session.selectList("communityns.listBoard", community);
	}

	public int getTotal(communityVO community) {
		System.out.println("글 갯수 Dao");
		return session.selectOne("communityns.getListCount", community);
	}

	public communityVO Content(int commNo) {
		System.out.println("상세정보 Dao");
		return session.selectOne("communityns.Content", commNo);
	}

	public void updateCount(int commNo) {
		System.out.println("조회수 증가 Dao");
		session.update("communityns.updateCount",commNo);
		
	}

	public int boardDelete(int commNo) {
		System.out.println("글삭제 Dao");
		return session.delete("communityns.deleteBoard", commNo);
		
	}

	public int boardUpdate(communityVO community) {
		System.out.println("글 수정 Dao");
		return session.update("communityns.updateBoard", community);
	}

	public int count(int commNo) {
		// TODO Auto-generated method stub
		return session.selectOne("communityns.likeCount", commNo);
	}

//	public void upLike(int commNo) {
//		// TODO Auto-generated method stub
//		System.out.println("최조 좋아요 증가 dao");
//		session.update("communityns.upLike", commNo);
//	}

	public void changeLike(commLikeVO commVO) {
		// TODO Auto-generated method stub
		System.out.println("상태값에 따른 좋아요 수 dao");
		session.update("communityns.changeLike",commVO);
		
	}

//	public int count(commLikeVO commVO) {
//		// TODO Auto-generated method stub
//		System.out.println("좋아요 글갯수 조회 Dad");
//		return session.selectOne("communityns.likeCnt", commVO);
//	}


	
	
//	public void updateLike(int commNo) {
//		System.out.println("커뮤니티 게시판 게시글 좋아요수 증가 Dao");
//		session.update("communityns.updateLike", commNo);
//	}
//
//	public void deleteLike(int commNo) {
//		// TODO Auto-generated method stub
//		System.out.println("커뮤니티 게시판 게시글 좋아요수 감소 Dao");
//		session.update("communityns.deleteLike", commNo);
//		
//	}


}
