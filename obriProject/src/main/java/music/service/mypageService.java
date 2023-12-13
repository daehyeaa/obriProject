package music.service;

import java.util.List;
import java.util.Map;

import music.model.mypage.CommReplysVO;
import music.model.mypage.CommsVO;
import music.model.mypage.InfoAllVO;
import music.model.mypage.KeywordVO;
import music.model.mypage.LikesListCommVO;
import music.model.mypage.LikesListPRVO;
import music.model.mypage.PagingJobManageVO;
import music.model.mypage.PagingMsgListVO;
import music.model.mypage.PagingPrListVO;
import music.model.mypage.PagingVO;
import music.model.mypage.PrBoardVO;
import music.model.mypage.QnAListsVO;
import music.model.mypage.StatusAllVO;
import music.model.mypage.StatusFinalVO;
import music.model.mypage.StatusWaitingVO;
import music.model.mypage.jobBoardVO;



// 서비스 인터페이스 설계
public interface mypageService {
	
	// 유저 관련 모든 정보 가져오는 메소드
	public InfoAllVO viewMyPage(String id);

	// 유저가 작성한 구인공고 정보 가져오는 메소드
	public List<jobBoardVO> viewMyBoard(String id, KeywordVO keywordVO);
	// 모든 유저가 작성한 구인공고 데이터 가져옴
	public List<jobBoardVO> viewAllJobDatas();
	// 모든 지역, 구분 데이터 가져옴
	public List<jobBoardVO> viewAllJobPlaces();
	public List<jobBoardVO> viewAllJobCDs();
	// 구인공고 가져오는 페이징 처리
	public PagingJobManageVO pagingViewBoard(KeywordVO keywordVO, String id);
	
// 페이지 처리
	public PagingVO paging(KeywordVO keywordVO, String id);


// 지원 현황 리스트 페이지(applyStatus)
	// 현재 전체 지원 현황
	public StatusAllVO viewAppAll(String id, String keyword);
	// 현재 지원 후 대기 현황
	public StatusWaitingVO viewAppWait(String id, String keyword);
	// 지원 완료(승인) 현황
	public StatusFinalVO viewAppFin(String id, String keyword);

// 커뮤니티 좋아요 현황 페이지
	// 커뮤니티 좋아요 한 글 리스트
	public List<LikesListCommVO> viewLikeListComm(String id);
	
// PR 좋아요 현황 관련
	// 좋아요 한 PR글 리스트
	public List<LikesListPRVO> viewLikeListPR(String id);
	
	// 모든 PR데이터 - 경력, 전공(포지션), 지역, 해시태그 데이터 가져옴
	public List<PrBoardVO> viewAllPrCareers();
	public List<PrBoardVO> viewAllPrMajors();
	public List<PrBoardVO> viewAllPrLocs();
	public List<PrBoardVO> viewAllPrHashes();
	
	// PR 좋아요 설정 - 페이지 처리
	public PagingPrListVO pagingViewPrLike(KeywordVO keywordVO, String id);
// 페이지 처리
	public PagingVO pagingPR(KeywordVO keywordVO, String id);
	
	
// 커뮤니티 작성 글 관리
	// 작성한 커뮤니티 글 리스트
	public CommsVO viewCommLists(String id, String keyword);
	// 커뮤니티 댓글 리스트
	public CommReplysVO viewCommReplyLists(String id, String keyword);

	
// 문의게시판 글 관리
	public QnAListsVO viewQnALists(String id, String keyword);
	
	
// 메시지 관련
	// 받은 메시지함 리스트
	public PagingMsgListVO pagingViewRcvMsg(KeywordVO keywordVO, String id);
	// 보낸 메시지함 리스트
	public PagingMsgListVO pagingViewSndMsg(KeywordVO keywordVO, String id);
	// 페이지 처리
	public PagingVO pagingBlk(Integer Setblock, KeywordVO keywordVO, String id);
	
	
	
	
// 삭제 관련
	// 선택한 쪽지 삭제
	public int delMsgNo(int msgNo);
	// 작성한 커뮤니티 글 삭제
	public int delCommNo(int commNo);
	// 작성한 커뮤니티 댓글 삭제
	public int delCommReNo(int commReNo);
	// 선택한 문의게시판 글 삭제
	public int delQnANo(int qnaNo);
	
	
	
//	public int deleteMyComms(String[] delCommNoArr);
//	public int deleteMsg(Map<String, Object> msgNo_array);
}
