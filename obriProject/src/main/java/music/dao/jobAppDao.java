package music.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import music.model.jobAppVO;

@Mapper
public interface jobAppDao {


	public List<Map<String, Object>> selectAppList(jobAppVO app);

	public int getAppTotal();

	public int updateApp(jobAppVO app);

	public void updateCancelApp(jobAppVO app);
	
	
}
