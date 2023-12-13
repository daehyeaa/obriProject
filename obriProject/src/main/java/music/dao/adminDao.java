package music.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.adminCommVO;
import music.model.adminJobVO;
import music.model.adminMemberVO;
import music.model.adminPrVO;
import music.model.adminVO;

@Repository
public class adminDao {

	@Autowired
	private SqlSessionTemplate sst;
	
	// 로그인
	public adminVO checkAdmin(String id) throws Exception{
		System.out.println("dao입니다");
		return sst.selectOne("admin.logincheck", id);
	}

	public int getJobCount(adminJobVO jobvo) throws Exception {
		System.out.println("dao입니다");
		return sst.selectOne("admin.jobCount", jobvo);
	}

	public List<Map<String, Object>> getJobList(adminJobVO jobvo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("admin.jobList", jobvo);
	}

	public void deleteJob(Integer jobNo) throws Exception {
		System.out.println("구인글삭제dao");
		sst.update("admin.deleteJob",jobNo);
	}
	
	public Map<String, Object> getJobView(int jobNo) throws Exception {
		System.out.println("구인게시판상세정보보기dao");
		return sst.selectOne("admin.jobView",jobNo);
	}

	public int getPrCount(adminPrVO prvo) throws Exception {
		System.out.println("dao입니다");
		return sst.selectOne("admin.prCount", prvo);
	}
	
	public List<Map<String, Object>> getPrList(adminPrVO prvo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("admin.prList", prvo);
	}

	public void deletePr(Integer prNo) throws Exception {
		System.out.println("홍보글삭제dao");
		sst.update("admin.deletePr",prNo);
	}
	
	public Map<String, Object> getPrView(int prNo) throws Exception {
		System.out.println("홍보상세정보보기dao");
		return sst.selectOne("admin.prView",prNo);
	}
	
	public int getCommCount(adminCommVO commvo) throws Exception {
		System.out.println("dao입니다");
		return sst.selectOne("admin.commCount", commvo);
	}
	
	public List<Map<String, Object>> getCommList(adminCommVO commvo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("admin.commList", commvo);
	}

	public void deleteComm(Integer commNo) throws Exception  {
		System.out.println("커뮤니티글삭제dao");
		sst.update("admin.deleteComm",commNo);
	}

	public Map<String, Object> getCommView(int commNo) throws Exception {
		System.out.println("커뮤니티상세정보보기dao");
		return sst.selectOne("admin.commView",commNo);
	}

	public int getMemberCount(adminMemberVO membervo) throws Exception {
		System.out.println("dao입니다");
		return sst.selectOne("admin.memberCount", membervo);
	}

	public List<Map<String, Object>> getMemberList(adminMemberVO membervo) throws Exception{
		System.out.println("dao입니다");
		return sst.selectList("admin.memberList", membervo);
	}
	
	public Map<String, Object> getUserView(String userId) throws Exception {
		System.out.println("회원정보상세보기dao");
		return sst.selectOne("admin.userView", userId);
	}

	public void blockMember(String userId) {
		System.out.println("회원정보정지dao");
		sst.update("admin.blockMember",userId);
	}

	public void nonblockMember(String userId) {
		System.out.println("회원정보정지해제dao");
		sst.update("admin.nonblockMember",userId);
	}

	public void deleteMember(String userId) {
		System.out.println("회원정보삭제dao");
		sst.update("admin.deleteMember",userId);
	}
}
