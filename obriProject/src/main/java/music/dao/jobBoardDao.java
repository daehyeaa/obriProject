package music.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import music.model.jobBoardVO;

@Mapper
public interface jobBoardDao {

	public int insert(jobBoardVO jobboard);

	public void updateCount(int jobNo);
		
	public jobBoardVO getJobBoard(int jobNo);

	public void delete(int jobNo);

	public jobBoardVO select(int jobNo);

	public int jobInsert(jobBoardVO jobBoard);

	public int getJobTotal(jobBoardVO jobBoard);

	public int update(jobBoardVO jobBoard);

	public List<jobBoardVO> jobList(jobBoardVO jobBoard);
	
	
}
