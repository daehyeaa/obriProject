package music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.mypageDao;
import music.model.mypage.CommInfoVO;
import music.model.mypage.CommReplyInfoVO;
import music.model.mypage.CommReplysVO;
import music.model.mypage.CommsVO;
import music.model.mypage.InfoAllVO;
import music.model.mypage.InfoCountVO;
import music.model.mypage.JobInfoVO;
import music.model.mypage.KeywordVO;
import music.model.mypage.LikesListCommVO;
import music.model.mypage.LikesListPRVO;
import music.model.mypage.PagingJobManageVO;
import music.model.mypage.PagingMsgListVO;
import music.model.mypage.PagingPrListVO;
import music.model.mypage.PagingVO;
import music.model.mypage.PrBoardVO;
import music.model.mypage.QnAListsInfoVO;
import music.model.mypage.QnAListsVO;
import music.model.mypage.StatusAllVO;
import music.model.mypage.StatusCountVO;
import music.model.mypage.StatusFinalInfoVO;
import music.model.mypage.StatusFinalVO;
import music.model.mypage.StatusInfoVO;
import music.model.mypage.StatusWaitingInfoVO;
import music.model.mypage.StatusWaitingVO;
import music.model.mypage.UserInfoVO;
import music.model.mypage.jobBoardVO;

// Service 구현 클래스 : 메소드를 명시하여, 데이터베이스와 상호작용 추상화
// mypageService클래스에서 설계한 메소드 오버라이드해서 구현
@Service
public class mypageSerciveImpl implements mypageService {

	// mapper클래스의 DAO클래스 사용
	@Autowired
	private mypageDao myDao;

	@Override
	// 현재 지원 현황
	public InfoAllVO viewMyPage(String id) {
		List<UserInfoVO> userInfos = myDao.findUser(id);
		List<InfoCountVO> infoCounts = myDao.findInfoCounts(id);
		List<JobInfoVO> recJobInfos = myDao.findrecJob(id);
		List<StatusCountVO> statCounts = myDao.findCounts(id);

		// 해당 객체에 담아서 모든 정보 반환
		InfoAllVO infoAllDto = new InfoAllVO();
		infoAllDto.setUserInfoVOs(userInfos);
		infoAllDto.setInfoCountVOs(infoCounts);
        infoAllDto.setJobInfoVOs(recJobInfos);
        infoAllDto.setStatusCountVOs(statCounts);

		return infoAllDto;
	}

	// 현재 구인 현황
	@Override
	public List<jobBoardVO> viewMyBoard(String id, KeywordVO keywordVO) {
		List<jobBoardVO> jobBoardVOs = myDao.findAllBoards(id, keywordVO);
		// 작성한 모든 구인공고 정보 반환
		return jobBoardVOs;
	}
	
	// 모든 유저 데이터 가져옴
	@Override
	public List<jobBoardVO> viewAllJobDatas() {
		List<jobBoardVO> alljobDatas = myDao.findAllJobDatas();
		
		return alljobDatas;
	}
	
	// 모든 지역, 구분 데이터 가져옴
	@Override
	public List<jobBoardVO> viewAllJobPlaces() {
		List<jobBoardVO> JobPlaces = myDao.findAllJobPlaces();
		return JobPlaces;
	}
	@Override
	public List<jobBoardVO> viewAllJobCDs() {
		List<jobBoardVO> JobCDs = myDao.findAllJobCDs();
		return JobCDs;
	}
	
	
	// 구인 현황 - 페이지 처리
	@Override
	public PagingJobManageVO pagingViewBoard(KeywordVO keywordVO, String id) {
		if(keywordVO.getPage() == null) {
			keywordVO.setPage(0);
		}
		// 변수 설정
		int startNum = keywordVO.getPage() * 6 + 1;
		keywordVO.setStartNum(startNum);

		PagingJobManageVO pagingJobManageVO = new PagingJobManageVO();
		pagingJobManageVO.setPagingVO(paging(keywordVO, id));
		pagingJobManageVO.setJobBoardVOs(myDao.findAllBoards(id, keywordVO));

		return pagingJobManageVO;
	}

// 페이지 처리
	@Override
	public PagingVO paging(KeywordVO keywordVO, String id) {
		PagingVO paging = myDao.paging(id, keywordVO);

		final int blockCount = 6;
		int currentPage = keywordVO.getPage();
		int currentBlock = keywordVO.getPage() / blockCount;
		int startPageNum = 1 + blockCount * currentBlock;	// 1-> 6-> 11
		int lastPageNum = 6 + blockCount * currentBlock;	// 5 -> 10 -> 15
		
		if(paging.getTotalPage() < lastPageNum) {
			lastPageNum = paging.getTotalPage();
		}
		
		paging.setBlockCount(blockCount);
		paging.setCurrentPage(currentPage);
		paging.setCurrentBlock(currentBlock);
		paging.setStartPageNum(startPageNum);
		paging.setLastPageNum(lastPageNum);	

		return paging;
	}
	

// 지원 현황 리스트 페이지(applyStatus)
	// 전체 지원 현황
	@Override
	public StatusAllVO viewAppAll(String id, String keyword) {
		List<StatusCountVO> statusCountVOs = myDao.findCounts(id);
		List<StatusInfoVO> statusInfoVOs = myDao.findAllStat(id, keyword);
		StatusAllVO statusAllVO = new StatusAllVO(statusCountVOs, statusInfoVOs);
		statusAllVO.setKeyword(keyword);
		statusAllVO.setUserId(id);
		
		return statusAllVO;
	}

	// 현재 지원 후 대기 현황
	@Override
	public StatusWaitingVO viewAppWait(String id, String keyword) {
		List<StatusCountVO> statusCountVOs = myDao.findCounts(id);
		List<StatusWaitingInfoVO> statusWaitingInfoVOs = myDao.findWaitingStat(id, keyword);
		StatusWaitingVO statusWaitingVO = new StatusWaitingVO(statusCountVOs, statusWaitingInfoVOs);
		statusWaitingVO.setKeyword(keyword);
		statusWaitingVO.setUserId(id);
		
		return statusWaitingVO;
	}
	
	// 지원 완료(승인) 현황
	@Override
	public StatusFinalVO viewAppFin(String id, String keyword) {
		List<StatusCountVO> statusCountVOs = myDao.findCounts(id);
		List<StatusFinalInfoVO> statusFinalInfoVOs = myDao.findFinStat(id, keyword);
		StatusFinalVO statusFinalVO = new StatusFinalVO(statusCountVOs, statusFinalInfoVOs);
		statusFinalVO.setKeyword(keyword);
		statusFinalVO.setUserId(id);
		
		return statusFinalVO;		
	}

	
	
// 커뮤티니 좋아요 관련
	// 커뮤니티에 좋아요 한 글 리스트
	@Override
	public List<LikesListCommVO> viewLikeListComm(String id) {
		List<LikesListCommVO> likeComm = myDao.findLikesComm(id);
		return likeComm;
	}

	
// PR 좋아요 현황 관련	
	// PR글 좋아요 설정한 리스트
	@Override
	public List<LikesListPRVO> viewLikeListPR(String id) {
		List<LikesListPRVO> likePR = myDao.findLikesPR(id);
		return likePR;
	}
	
	// PR게시판에 모든 유저들이 작성한 항목 데이터 리스트 - 경력, 전공(포지션), 지역, 해시태그
	@Override
	public List<PrBoardVO> viewAllPrCareers() {
		List<PrBoardVO> PRCareers = myDao.findAllPrCareers();
		return PRCareers;
	}
	@Override
	public List<PrBoardVO> viewAllPrMajors() {
		List<PrBoardVO> PRMajors = myDao.findAllPrMajors();
		return PRMajors;
	}
	@Override
	public List<PrBoardVO> viewAllPrLocs() {
		List<PrBoardVO> PRLocs = myDao.findAllPrLocs();
		return PRLocs;
	}
	@Override
	public List<PrBoardVO> viewAllPrHashes() {
		List<PrBoardVO> PRHashes = myDao.findAllPrHashes();
		return PRHashes;
	}
	
	// PR 좋아요 현황 - 페이지 처리
	@Override
	public PagingPrListVO pagingViewPrLike(KeywordVO keywordVO, String id) {
		if(keywordVO.getPage() == null) {
			keywordVO.setPage(0);
		}
		// 변수 설정
		int startNum = keywordVO.getPage() * 12 + 1;
		keywordVO.setStartNum(startNum);

		PagingPrListVO pagingPrListVO = new PagingPrListVO();
		pagingPrListVO.setPagingVO(pagingPR(keywordVO, id));
		pagingPrListVO.setLikesListPRVOs(myDao.findAllLikesPR(id, keywordVO));

		return pagingPrListVO;
	}

// 페이지 처리
	@Override
	public PagingVO pagingPR(KeywordVO keywordVO, String id) {
		PagingVO paging = myDao.pagingPR(id, keywordVO);

		final int blockCount = 12;
		int currentPage = keywordVO.getPage();
		int currentBlock = keywordVO.getPage() / blockCount;
		int startPageNum = 1 + blockCount * currentBlock;
		int lastPageNum = 12 + blockCount * currentBlock;	
		
		if(paging.getTotalPage() < lastPageNum) {
			lastPageNum = paging.getTotalPage();
		}
		
		paging.setBlockCount(blockCount);
		paging.setCurrentPage(currentPage);
		paging.setCurrentBlock(currentBlock);
		paging.setStartPageNum(startPageNum);
		paging.setLastPageNum(lastPageNum);	

		return paging;
	}	

	
// 커뮤니티 작성 글 관리
	// 작성한 커뮤니티 글 리스트
	@Override
	public CommsVO viewCommLists(String id, String keyword) {
		List<CommInfoVO> commInfoVOs = myDao.findCommList(id, keyword);
		CommsVO commsVO = new CommsVO(commInfoVOs);
		commsVO.setKeyword(keyword);
		commsVO.setId(id);
		return commsVO;
	}
	
	// 작성한 커뮤니티 댓글 리스트
	@Override
	public CommReplysVO viewCommReplyLists(String id, String keyword) {
		List<CommReplyInfoVO> commReplyInfoVOs = myDao.findCommReplyList(id, keyword);
		CommReplysVO commReplysVO = new CommReplysVO(commReplyInfoVOs);
		commReplysVO.setKeyword(keyword);
		commReplysVO.setId(id);
		return commReplysVO;
	}
	

// 문의게시판 글 관리
	@Override
	public QnAListsVO viewQnALists(String id, String keyword) {
		List<QnAListsInfoVO> qnaListsInfoVOs = myDao.findmyQnA(id, keyword);
		QnAListsVO qnaListsVO = new QnAListsVO(qnaListsInfoVOs);
		qnaListsVO.setKeyword(keyword);
		qnaListsVO.setId(id);
		
		return qnaListsVO;
	}
		
	
	
	
// 메시지 관련
	// 받은 메시지함 리스트
	@Override
	public PagingMsgListVO pagingViewRcvMsg(KeywordVO keywordVO, String id) {
		if(keywordVO.getPage() == null) {
			keywordVO.setPage(0);
		}
		
		// userId가 받은 메시지
		keywordVO.setUserRCV(id);
		keywordVO.setUserSND(null);
		
		// 변수 설정
		int startNum = keywordVO.getPage() * 8 + 1;
		keywordVO.setStartNum(startNum);

		PagingMsgListVO pagingMsgListVO = new PagingMsgListVO();
		pagingMsgListVO.setPagingVO(pagingBlk(8, keywordVO, id));
		pagingMsgListVO.setMessageInfoVOs(myDao.findAllMsgs(id, keywordVO));

		return pagingMsgListVO;
	}
	
	
	// 보낸 메시지함 리스트
	@Override
	public PagingMsgListVO pagingViewSndMsg(KeywordVO keywordVO, String id) {
		if(keywordVO.getPage() == null) {
			keywordVO.setPage(0);
		}
		
		// userId가 보낸 메시지
		keywordVO.setUserSND(id);
		keywordVO.setUserRCV(null);
		
		// 변수 설정
		int startNum = keywordVO.getPage() * 8 + 1;
		keywordVO.setStartNum(startNum);
		
		PagingMsgListVO pagingMsgListVO = new PagingMsgListVO();
		pagingMsgListVO.setPagingVO(pagingBlk(8, keywordVO, id));
		pagingMsgListVO.setMessageInfoVOs(myDao.findAllMsgs(id, keywordVO));
		
		return pagingMsgListVO;
	}

	
// 페이지 처리
	@Override
	public PagingVO pagingBlk(Integer Setblock, KeywordVO keywordVO, String id) {
		PagingVO paging = myDao.pagingM(keywordVO);

		final int blockCount = Setblock;
		int currentPage = keywordVO.getPage();
		int currentBlock = keywordVO.getPage() / blockCount;
		int startPageNum = 1 + blockCount * currentBlock;	// 1-> 6-> 11
		int lastPageNum = Setblock + blockCount * currentBlock;	// 5 -> 10 -> 15
		
		if(paging.getTotalPage() < lastPageNum) {
			lastPageNum = paging.getTotalPage();
		}
		
		paging.setBlockCount(blockCount);
		paging.setCurrentPage(currentPage);
		paging.setCurrentBlock(currentBlock);
		paging.setStartPageNum(startPageNum);
		paging.setLastPageNum(lastPageNum);	

		return paging;
	}	
	

	
// 삭제 관련
	// 작성한 커뮤니티 글 삭제
	public int delCommNo(int commNo) {
		System.out.println("커뮤니티 작성 글에서 선택한 항목 삭제 : "+commNo);
		return myDao.delMsgNo(commNo);		
	}
	
	// 작성한 커뮤니티 댓글 삭제
	public int delCommReNo(int commReNo) {
		System.out.println("커뮤니티 작성 댓글에서 선택한 항목 삭제 : "+commReNo);
		return myDao.delMsgNo(commReNo);		
	}
	
	// 선택 메시지 삭제
	@Override
	public int delMsgNo(int msgNo) {
		System.out.println("쪽지함에서 선택한 항목 삭제 : "+msgNo);
		return myDao.delMsgNo(msgNo);
	}	
	
	// 선택 문의사항 글 삭제
	@Override
	public int delQnANo(int qnaNo) {
		System.out.println("문의글에서 선택한 항목 삭제 : "+qnaNo);
		return myDao.delQnANo(qnaNo);		
	}
	
	
	
//	@Override
//	public int deleteMyComReplys(String[] delCommReNoArr) {
//		System.out.println(delCommReNoArr[0]);
//		
//		HashMap<String, Object> commReMap = new HashMap<String, Object>();
//		commReMap.put("commReMap", commReMap);
//		
//		return myDao.deleteMyComReplys(commReMap);
//	}
//	@Override
//	public int deleteMsg(Map<String, Object> msgNo_array) {
//		System.out.println("쪽지함에서 선택한 항목 삭제");
//		int result = 0;
//		// mapper의 메소드 실행
//		result = myDao.deleteMsg(msgNo_array);
//		return result;
//	}
}
