package music.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.noticeVO;

@Repository
public class noticeDao {

	@Autowired
	private SqlSessionTemplate sst;

	public int getNoticeCount(noticeVO notvo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectOne("notice.noticeCount", notvo);
	}

	public List<Map<String, Object>> getNoticeList(noticeVO notvo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("notice.noticeList", notvo);
	}

	public Object getHit(int notNo) throws Exception{
		System.out.println("조회수증가dao");
		return sst.update("notice.hit",notNo);
	}

	public Map<String, Object> getNotView(int notNo) throws Exception{
		System.out.println("상세정보보기dao");
		return sst.selectOne("notice.notView",notNo);
	}

	public void insertNotice(noticeVO notice) throws Exception{
		System.out.println("공지사항글쓰기dao");
		sst.insert("notice.insertNotice", notice);
	}

	public void deleteNotice(int notNo) throws Exception{
		System.out.println("공지사항글삭제dao");
		sst.update("notice.deleteNotice", notNo);
	}

	public void updateNotice(noticeVO vo) {
		System.out.println("공지사항글수정dao");
		sst.update("notice.updateNotice", vo);
	}


}
