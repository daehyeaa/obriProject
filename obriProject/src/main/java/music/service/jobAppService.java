package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.jobAppDao;
import music.model.jobAppVO;

@Service
public class jobAppService {
	
	@Autowired
	private jobAppDao jad;

	public List<Map<String, Object>> selectAppList(jobAppVO jobapp) { 
		return jad.selectAppList(jobapp);
	}

	public int getAllTotal(jobAppVO jobapp) {
		return jad.getAllTotal(jobapp);
	}

	public int updateApp(jobAppVO jobapp) {
		return jad.updateApp(jobapp);
	}

	public void updateCancelApp(jobAppVO jobapp) {
		jad.updateCancelApp(jobapp);
		
	}

	public int insertApply(jobAppVO jobapp) {
		return jad.insertApply(jobapp);
	}

//	public int updateApply(jobAppVO jobapp) {
//		return jad.updateApply(jobapp);
//	}

	public int getAppTotal() {
		return jad.getAppTotal();
	}

	
}