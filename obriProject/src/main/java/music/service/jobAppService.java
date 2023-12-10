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
	private jobAppDao dao;

	public List<Map<String, Object>> selectAppList(jobAppVO app) { 
		return dao.selectAppList(app);
	}

	public int getAppTotal() {
		// TODO Auto-generated method stub
		return dao.getAppTotal();
	}

	public int updateApp(jobAppVO app) {
		return dao.updateApp(app);
	}

	public void updateCancelApp(jobAppVO app) {
		dao.updateCancelApp(app);
		
	}

	
}
