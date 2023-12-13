package music.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import music.model.jobAppVO;

@Mapper
public interface jobAppDao {


	public List<Map<String, Object>> selectAppList(jobAppVO jobapp);

	public int getAllTotal(jobAppVO jobapp);

	public int updateApp(jobAppVO jobapp);

	public void updateCancelApp(jobAppVO jobapp);

	public int insertApply(jobAppVO jobapp);

//	public int updateApply(jobAppVO jobapp);

	public int getAppTotal();
	
	
}
