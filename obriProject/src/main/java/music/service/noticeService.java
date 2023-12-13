package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.noticeDao;
import music.model.noticeVO;

@Service
public class noticeService {
	@Autowired
	noticeDao noticeDao;
	
	public int getNoticeCount(noticeVO notvo) throws Exception{
		System.out.println("서비스입니다");
		return noticeDao.getNoticeCount(notvo);
	}

	public List<Map<String, Object>> getNoticeList(noticeVO notvo) throws Exception{
		System.out.println("서비스입니다");
		return noticeDao.getNoticeList(notvo);
	}

	public void hit(int notNo) throws Exception{
		System.out.println("조회수 증가 서비스");
		noticeDao.getHit(notNo);
	}

	public Map<String, Object> notice_view(int notNo) throws Exception{
		System.out.println("상세내용 보기 서비스");
//		noticeVO notice = noticeDao.getNotView(notNo);
		return noticeDao.getNotView(notNo);
	}

	public void insertNotice(noticeVO notice) throws Exception {
		System.out.println("공지사항 글쓰기 저장 서비스");
		noticeDao.insertNotice(notice);
		
	}

	public void updateNotice(noticeVO vo) throws Exception {
		System.out.println("공지사항 글수정 서비스");
		noticeDao.updateNotice(vo);
		
	}
	
	public void deleteNotice(int notNo) throws Exception {
		System.out.println("공지사항 글삭제 서비스");
	    noticeDao.deleteNotice(notNo);
	}



}
