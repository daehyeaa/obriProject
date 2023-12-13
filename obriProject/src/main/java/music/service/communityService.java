package music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import music.dao.communityDao;
import music.model.commLikeVO;
import music.model.communityVO;

@Service
public class communityService {

	@Autowired
	private communityDao dao;

	// 글 작성
	public int insertBoard(communityVO community) {
		System.out.println("글 작성 서비스");
		return dao.insertBoard(community);
	}


	public List<communityVO> list(communityVO community) {
		System.out.println("글 목록 서비스");
		return dao.list(community);
	//	return bd.list(startRow, endRow);
	}
	
	public int getTotal(communityVO community) {
		System.out.println("글 갯수 서비스");
		return dao.getTotal(community);
	}


	public communityVO Content(int commNo) {
		System.out.println("상세정보 서비스");
		return dao.Content(commNo) ;
	}


	public void updateCount(int commNo) {
		System.out.println("조회수 증가 서비스");
		dao.updateCount(commNo);
	}


	public int boardDelete(int commNo) {
		System.out.println("글삭제 서비스");
		return dao.boardDelete(commNo);
	}


	public int boardUpdate(communityVO community) {
		// TODO Auto-generated method stub
		System.out.println("글 수정 서비스");
		return dao.boardUpdate(community);
	}


	public int count(int commNo) {
		// TODO Auto-generated method stub
		return dao.count(commNo);
	}


//	public void upLike(int commNo) {
//		// TODO Auto-generated method stub
//		System.out.println("최초 좋아요 수 증가");
//		dao.upLike(commNo);
//		
//	}


	public void changeLike(commLikeVO commVO) {
		// TODO Auto-generated method stub
		System.out.println("상태값에 따른 좋아요수 변경");
		dao.changeLike(commVO);
		
	}


//	public int count(commLikeVO commVO) {
//		// TODO Auto-generated method stub
//		System.out.println("좋아요 갯수 조회 서비스");
//		return dao.count(commVO);
//	}


	
//	public void updateLike(int commNo) {
//		System.out.println("커뮤니티 게시판 게시글 좋아요수 증가 서비스");
//		dao.updateLike(commNo);
//		
//	}
//
//
//	public void deleteLike(int commNo) {
//		System.out.println("커뮤니티 게시판 게시글 좋아요수 감소");
//		// TODO Auto-generated method stub
//		dao.deleteLike(commNo);
//		
//	}



		
	}
