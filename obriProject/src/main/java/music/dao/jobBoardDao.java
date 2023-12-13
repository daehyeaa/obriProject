package music.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import music.model.jobBoardVO;

@Mapper
public interface jobBoardDao {
	
	public int getJobTotal(jobBoardVO jobboard);

	public int jobInsert(jobBoardVO jobboard);

	public void updateCount(int jobNo);

	public jobBoardVO getJobboard(int jobNo);

	public Map<String, Object> selectJobMember(String userId);

	public int update(jobBoardVO jobboard);

	public void delete(int jobNo);
	
	public List<Map<String, Object>> jobList(jobBoardVO jobboard) ;

	public int updateAppDone(int jobNo);
	
}
