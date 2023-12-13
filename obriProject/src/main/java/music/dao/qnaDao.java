package music.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.qnaVO;

@Repository
public class qnaDao {

	@Autowired
	private SqlSessionTemplate sst;
	
	public int getQnaCount(qnaVO qnavo) throws Exception {
		System.out.println("dao입니다");
		return sst.selectOne("qna.qnaCount", qnavo);
	}

	public List<Map<String, Object>> getQnaList(qnaVO qnavo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("qna.qnaList", qnavo);
	}

	public void deleteQna(Integer qnaNo) throws Exception {
		System.out.println("문의처리완료dao");
		sst.update("qna.deleteQna",qnaNo);
	}

	public void insertNotice(qnaVO qna) throws Exception {
		System.out.println("문의작성dao");
		sst.insert("qna.insertQna",qna);
	}

	public Map<String, Object> getQnaView(int qnaNo) throws Exception {
		System.out.println("문의상세정보보기dao");
		return sst.selectOne("qna.qnaView", qnaNo);
	}

	public Map<String, Object> getQnaFile(int qnaNo) throws Exception {
		System.out.println("문의사항첨부파일다운로드dao");
		return sst.selectOne("qna.qnaFile", qnaNo);
	}

}
