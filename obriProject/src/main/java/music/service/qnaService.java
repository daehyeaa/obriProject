package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.qnaDao;
import music.model.qnaVO;

@Service
public class qnaService {
	@Autowired
	qnaDao qnaDao;

	public int getQnaCount(qnaVO qnavo) throws Exception {
		System.out.println("서비스입니다");
		return qnaDao.getQnaCount(qnavo);
	}

	public List<Map<String, Object>> getQnaList(qnaVO qnavo)  throws Exception{
		System.out.println("서비스입니다");
		return qnaDao.getQnaList(qnavo);
	}

	public void deleteQna(int qnaNo) throws Exception {
		System.out.println("처리완료 서비스");
		qnaDao.deleteQna(qnaNo);
	}
	
	public void insertQna(qnaVO qna) throws Exception {
		System.out.println("문의사항 저장 서비스");
		qnaDao.insertNotice(qna);
	}

	public Map<String, Object> qna_view(int qnaNo) throws Exception {
		System.out.println("상세내용 보기 서비스");
		return qnaDao.getQnaView(qnaNo);
	}

	public Map<String, Object> getQnaFile(int qnaNo) throws Exception {
		System.out.println("문의사항 파일명 가져오기 서비스"); 
		return qnaDao.getQnaFile(qnaNo);
	}
	
	

}
