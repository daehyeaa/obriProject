package music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import music.dao.jobBoardDao;
import music.model.jobBoardVO;

@Service
public class jobBoardService {
	
	@Autowired
	private jobBoardDao dao;

	public int insert(jobBoardVO jobBoard) {
		return dao.insert(jobBoard);
	}

	public void updateCount(int jobNo) {
		dao.updateCount(jobNo);
	}

	public jobBoardVO getJobBoard(int jobNo) {
		return dao.getJobBoard(jobNo);
	}

	public void delete(int jobNo) {
		dao.delete(jobNo);
	}

	public jobBoardVO select(int jobNo) {
		return dao.select(jobNo);
	}

	public int jobInsert(jobBoardVO jobBoard) {
		return dao.jobInsert(jobBoard);
	}

	public int getJobTotal(jobBoardVO jobBoard) {
		return dao.getJobTotal(jobBoard);
	}

	public List<jobBoardVO> jobList(jobBoardVO jobBoard) {
		return dao.jobList(jobBoard);
	}

	public int update(jobBoardVO jobBoard) {
		return dao.update(jobBoard);
	}

}
