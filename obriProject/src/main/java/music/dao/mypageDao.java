package music.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

// Mapper클래스 사용
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import music.model.mypage.CommInfoVO;
import music.model.mypage.CommReplyInfoVO;
import music.model.mypage.InfoCountVO;
import music.model.mypage.JobInfoVO;
import music.model.mypage.KeywordVO;
import music.model.mypage.LikesListCommVO;
import music.model.mypage.LikesListPRVO;
import music.model.mypage.MessageInfoVO;
import music.model.mypage.PagingVO;
import music.model.mypage.PrBoardVO;
import music.model.mypage.QnAListsInfoVO;
import music.model.mypage.StatusCountVO;
import music.model.mypage.StatusFinalInfoVO;
import music.model.mypage.StatusInfoVO;
import music.model.mypage.StatusWaitingInfoVO;
import music.model.mypage.UserInfoVO;
import music.model.mypage.jobBoardVO;


// Mapper 인터페이스 작성
@Mapper
public interface mypageDao {

	// 유저 정보(이름, 이메일...) 출력을 위함
	public List<UserInfoVO> findUser(@Param("id") String id);
	
	// 유저 관련 횟수(count) 출력 위함
	public List<InfoCountVO> findInfoCounts(@Param("id") String id);
	
	// 공고 추천하기 위함
	public List<JobInfoVO> findrecJob(@Param("id") String id);
	
	// 지원현황 관련 횟수
	public List<StatusCountVO> findCounts(@Param("id") String id);
	
	
	
// 	구인 게시판 관련
	// 유저가 구인페이지에 작성한 내용을 가져옴
	public List<jobBoardVO> findAllBoards(@Param("id") String id, @Param("keywordVO") KeywordVO keywordVO); 	// 모든 구인 게시판 내용을 가져옴
    // 모든 유저가 작성한 데이터를 가져옴
	public List<jobBoardVO> findAllJobDatas();
	// 모든 jobBoard.jobPlace 데이터 가져옴
	public List<jobBoardVO> findAllJobPlaces();
	// 모든 jobBoard.jobCd 데이터 가져옴
	public List<jobBoardVO> findAllJobCDs();
	
	// 페이지 처리
	public PagingVO paging(@Param("id") String id, @Param("keywordVO")KeywordVO keywordVO);

	
    
// 구인 현황 상세페이지
	// 전체, 현재 진행중(상태=대기), 최종 승인(상태=승인)
	public List<StatusInfoVO> findAllStat(@Param("id") String id, @Param("keyword") String keyword);
	public List<StatusWaitingInfoVO> findWaitingStat(@Param("id") String id, @Param("keyword") String keyword);
	public List<StatusFinalInfoVO> findFinStat(@Param("id") String id, @Param("keyword") String keyword);

	

//  커뮤니티 좋아요 관련
	// 커뮤니티에 좋아요한 글 정보
	public List<LikesListCommVO> findLikesComm(@Param("id") String id);
	
	
	
// 	PR 좋아요 설정 관련
	// 유저가 PR페이지에 좋아요 한 내용을 가져옴
	public List<LikesListPRVO> findLikesPR(@Param("id") String id); 
	public List<LikesListPRVO> findAllLikesPR(@Param("id") String id, @Param("keywordVO")KeywordVO keywordVO);

    // 모든 유저가 작성한 데이터를 가져옴
	public List<LikesListPRVO> findLikesPR();

	// 모든 prBoard.prCareer 데이터 가져옴
	public List<PrBoardVO> findAllPrCareers();
	// 모든 prBoard.prMajor 데이터 가져옴
	public List<PrBoardVO> findAllPrMajors();
	// 모든 prBoard.prLoc 데이터 가져옴
	public List<PrBoardVO> findAllPrLocs();
	// 모든 prBoard.prHash 데이터 가져옴
	public List<PrBoardVO> findAllPrHashes();

	// 페이지 처리
	public PagingVO pagingPR(@Param("id") String id, @Param("keywordVO")KeywordVO keywordVO);
	
	
	
// 커뮤니티 글 관리
	// 작성한 커뮤니티 글 리스트
	public List<CommInfoVO> findCommList(@Param("id") String id, @Param("keyword") String keyword);	
	// 작성한 커뮤니티 댓글 리스트
	public List<CommReplyInfoVO> findCommReplyList(@Param("id") String id, @Param("keyword") String keyword);	

	
// 문의게시판 글 관리
	// 작성한 문의 글 리스트
	public List<QnAListsInfoVO> findmyQnA(@Param("id") String id, @Param("keyword") String keyword);
	
	
	
// 쪽지함 관리
	// 작성한 쪽지함 정보 리스트
	public List<MessageInfoVO> findAllMsgs(@Param("id") String id, @Param("keywordVO") KeywordVO keywordVO);
	// 페이지 처리
	public PagingVO pagingM(@Param("keywordVO")KeywordVO keywordVO);	
	
	
	
	
// 체크박스 선택 시, 삭제
	// 선택한 메시지 삭제
	public int delMsgNo(@Param("msgNo") int msgNo); 
	// 체크박스 여러개 선택 시, 커뮤니티 게시판 글 삭제
	public int delCommNo(@Param("commNo") int commNo); 
	// 체크박스 여러개 선택 시, 커뮤니티 댓글 삭제
	public int delCommReNo(@Param("commReNo") int commReNo); 
	// 선택한 문의 글 삭제
	public int delQnANo(@Param("qnaNo") int qnaNo);
	
	
//	public int deleteMyComReplys(HashMap<String, Object> delCommReNoArr);
//	public int deleteMsg(@Param("msgNoArray") Map<String, Object> msgNoArray);
	
	
	
// 쪽지 알림
	// 읽지 않은 받은 메시지 수 
	public String cntMgsAlert(@Param("id") String id);
}