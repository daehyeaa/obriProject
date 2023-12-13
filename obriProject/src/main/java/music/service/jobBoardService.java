package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.jobBoardDao;
import music.model.jobBoardVO;

@Service
public class jobBoardService {
	@Autowired
	private jobBoardDao jbd;

	public int getJobTotal(jobBoardVO jobboard) {
		return jbd.getJobTotal(jobboard);
	}

	public int jobInsert(jobBoardVO jobboard) {
		return jbd.jobInsert(jobboard);
	}

//	public List<jobBoardVO> rcount(jobBoardVO jobboard) {
//		return jbd.rcount(jobboard);
//	}

	public void updateCount(int jobNo) {
		jbd.updateCount(jobNo);
	}

	public jobBoardVO getJobboard(int jobNo) {
		return jbd.getJobboard(jobNo);
	}

	public Map<String, Object> selectJobMember(String userId) {
		return jbd.selectJobMember(userId);
	}

	public int update(jobBoardVO jobboard) {
		return jbd.update(jobboard);
	}

	public void delete(int jobNo) {
		jbd.delete(jobNo);
	}

	public List<Map<String, Object>> jobList(jobBoardVO jobboard) {
		return jbd.jobList(jobboard);
	}

	public int updateAppDone(int jobNo) {
		System.out.println("서비스 쪽에서"+jobNo);
		return jbd.updateAppDone(jobNo);
	}
}
