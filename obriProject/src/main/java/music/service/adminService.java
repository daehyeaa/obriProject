package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.cj.protocol.a.BinaryRowFactory;

import music.dao.adminDao;
import music.model.adminCommVO;
import music.model.adminJobVO;
import music.model.adminMemberVO;
import music.model.adminPrVO;
import music.model.adminVO;

@Service
public class adminService {

	@Autowired
	private adminDao adminDao;

	public adminVO adminCheck(String id) throws Exception{
		System.out.println("서비스입니다");
		return adminDao.checkAdmin(id);
	}

	public int getJobCount(adminJobVO jobvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getJobCount(jobvo);
	}

	public List<Map<String, Object>> getJobList(adminJobVO jobvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getJobList(jobvo);
	}
	
	public void deleteJob(int jobNo) throws Exception {
		System.out.println("구인게시판 글삭제 서비스");
		adminDao.deleteJob(jobNo);
	}
	
	public Map<String, Object> job_view(int jobNo) throws Exception {
		System.out.println("구인게시판 글읽기 서비스");
		return adminDao.getJobView(jobNo);
	}

	public int getPrCount(adminPrVO prvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getPrCount(prvo);
	}

	public List<Map<String, Object>> getPrList(adminPrVO prvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getPrList(prvo);
	}
	
	public void deletePr(int prNo) throws Exception {
		System.out.println("홍보 글삭제 서비스");
		adminDao.deletePr(prNo);
	}
	
	public Map<String, Object> pr_view(int prNo) throws Exception {
		System.out.println("구인게시판 글읽기 서비스");
		return adminDao.getPrView(prNo);
	}

	public int getCommCount(adminCommVO commvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getCommCount(commvo);
	}

	public List<Map<String, Object>> getJobList(adminCommVO commvo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getCommList(commvo);
	}

	public void deleteComm(int commNo) throws Exception {
		System.out.println("커뮤니티 글삭제 서비스");
		adminDao.deleteComm(commNo);
	}
	
	public Map<String, Object> comm_view(int commNo) throws Exception {
		System.out.println("구인게시판 글읽기 서비스");
		return adminDao.getCommView(commNo);
	}

	public int getMemberCount(adminMemberVO membervo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getMemberCount(membervo);
	}
	
	public List<Map<String, Object>> getMemberList(adminMemberVO membervo) throws Exception {
		System.out.println("서비스입니다");
		return adminDao.getMemberList(membervo);
	}

	public Map<String, Object> admin_user_view(String userId) throws Exception {
		System.out.println("회원정보 상세페이지");
		return adminDao.getUserView(userId);
	}

	public void blockMember(String userId) throws Exception {
		System.out.println("회원정보 정지 서비스");
		adminDao.blockMember(userId);
	}

	public void nonblockMember(String userId) throws Exception {
		System.out.println("회원정보 정지해제 서비스");
		adminDao.nonblockMember(userId);
	}

	public void deleteMember(String userId) throws Exception {
		System.out.println("회원정보 삭제 서비스");
		adminDao.deleteMember(userId);
	}
	

}
