package music.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.commLikeVO;

@Repository
public class commLikeDao {

	@Autowired
	private SqlSession likesession;
	
	public List<commLikeVO> select(commLikeVO commlike) {
		System.out.println("좋아요 데이터 확인 dao");
		List<commLikeVO> list =  likesession.selectList("commlikens.select", commlike) ;
		return  list;
	}

	public int insert(commLikeVO commlike) {
		System.out.println("좋아요 입력 dao");
		return   likesession.insert("commlikens.insert", commlike);
	}


	public int update(Map map) {
		// TODO Auto-generated method stub
		System.out.println("좋아요 변경 dao");
		return likesession.update("commlikens.update",map);
	}

//	public int count(commLikeVO commVO) {
//		// TODO Auto-generated method stub
//		System.out.println("좋아요 갯수 조회 dao");
//		return likesession.selectOne("commlikens.likeCnt",commVO);
//	}

}
