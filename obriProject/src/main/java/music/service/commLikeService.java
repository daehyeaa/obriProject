package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.commLikeDao;
import music.model.commLikeVO;

@Service
public class commLikeService {

	@Autowired
	private commLikeDao dao;

	public List<commLikeVO> select(commLikeVO commlike) {
		System.out.println("좋아요 데이터 확인 서비스");
		return dao.select(commlike);
	}

	public int insert(commLikeVO commlike) {
		System.out.println("좋아요 입력 서비스");
		return dao.insert(commlike);
	}


	public int update(Map map) {
		// TODO Auto-generated method stub
		System.out.println("좋아요 변경 서비스");
		return dao.update(map);
	}

//	public int count(commLikeVO commVO) {
//		// TODO Auto-generated method stub
//		System.out.println("좋아요 갯수 조회 서비스");
//		return dao.count(commVO);
//	}
	
	
}
