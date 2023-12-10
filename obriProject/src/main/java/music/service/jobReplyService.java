package music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.jobReplyDao;
import music.model.jobReplyVO;

@Service
public class jobReplyService {
	
	@Autowired
	private jobReplyDao jrd;

	public List<jobReplyVO> list(int jobNo) {
		return jrd.list(jobNo);
	}

	public void insert(jobReplyVO rv) {
		jrd.insert(rv);
	}

	public void delete(jobReplyVO rv) {
		jrd.delete(rv);
	}

	public void update(jobReplyVO rv) {
		jrd.update(rv);
	}
	
	
	
	
}
