package music.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import music.model.mypage.AjaxRespVO;
import music.model.mypage.CommReplysVO;
import music.model.mypage.CommsVO;
import music.model.mypage.InfoAllVO;
import music.model.mypage.KeywordVO;
import music.model.mypage.LikesListCommVO;
import music.model.mypage.LikesListPRVO;
import music.model.mypage.PagingJobManageVO;
import music.model.mypage.PagingMsgListVO;
import music.model.mypage.PagingPrListVO;
import music.model.mypage.PrBoardVO;
import music.model.mypage.QnAListsVO;
import music.model.mypage.StatusAllVO;
import music.model.mypage.StatusFinalVO;
import music.model.mypage.StatusWaitingVO;
import music.model.mypage.jobBoardVO;
import music.service.mypageService;

@Controller
public class MypageController {
	
	// 서비스 인터페이스(마이페이지와 관련된 비즈니스 로직 처리)
	@Autowired
	private mypageService myService;
	// 세션에 데이터 저장하기 위해 사용
	@Autowired
	private HttpSession session;
	
// 마이페이지 메인(지원/구인)
	// 지원 현황 마이페이지 메인으로 이동
	@RequestMapping("mypage_Apply.do")
	public String mypageApply(@SessionAttribute("userId") String id, Model model) {	    
		InfoAllVO infoAllDto = myService.viewMyPage(id);
		model.addAttribute("infoAllDto", infoAllDto);

		return "mypage/mypage/mypage_Apply";
	}
	
	// 구인 현황 마이페이지 메인으로 이동
	@RequestMapping("mypage_JobBoard.do")
	public String mypageJob(@SessionAttribute("userId") String id, Model model, KeywordVO keywordVO) {
		// 구인 현황 데이터 가져오기 위함
		InfoAllVO infoAllDto = myService.viewMyPage(id);
		model.addAttribute("infoAllDto", infoAllDto);

		// 모든 Job데이터 - 지역, 구분 데이터 가져옴
		List<jobBoardVO> JobPlaces = myService.viewAllJobPlaces();
		model.addAttribute("JobPlaces", JobPlaces);
		List<jobBoardVO> JobCDs = myService.viewAllJobCDs();
		model.addAttribute("JobCDs", JobCDs);
		
		// 작성한 모든 구인공고 리스트 with 페이징 처리
		PagingJobManageVO pagingJobManageVO = myService.pagingViewBoard(keywordVO, id);
		model.addAttribute("pagingJobManageVO", pagingJobManageVO);

		return "mypage/mypage/mypage_JobBoard";
	}	
	
	
// 지원 페이지 관련
	// 모든 진행상태
	@RequestMapping("applyStatusAll.do")
	public String appStatsAll(@SessionAttribute("userId") String id, @RequestParam(required = false) String keyword, Model model) {
		StatusAllVO statusAllVO = myService.viewAppAll(id, keyword);
		model.addAttribute("statusAllVO", statusAllVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", statusAllVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/job/applyStatusAll";
	}
	
	// 진행상태 = 대기중
	@RequestMapping("applyStatus.do")
	public String appStats(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {
		StatusWaitingVO statusWaitingVO = myService.viewAppWait(id, keyword);
		model.addAttribute("statusWaitingVO", statusWaitingVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", statusWaitingVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/job/applyStatus";
	}
	
	// 진행상태 = 승인
	@RequestMapping("applyStatusFin.do")
	public String appStatsFin(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {		
		StatusFinalVO statusFinalVO = myService.viewAppFin(id, keyword);
		model.addAttribute("statusFinalVO", statusFinalVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", statusFinalVO.getKeyword());
		session.setAttribute("referer", referer);		
		
		return "mypage/job/applyStatusFin";
	}


// 구인 현황 관련
	// 모든 진행상태
	@RequestMapping("writeJobStatusAll.do")
	public String JobStatsAll(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {		
		StatusAllVO jobstatusAllVO = myService.viewAppAll(id, keyword);
		model.addAttribute("jobstatusAllVO", jobstatusAllVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", jobstatusAllVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/job/writeJobStatusAll";
	}
	
	// 진행상태 = 대기중
	@RequestMapping("writeJobStatus.do")
	public String JobappStats(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {		
		StatusWaitingVO jobstatusWaitingVO = myService.viewAppWait(id, keyword);
		model.addAttribute("jobstatusWaitingVO", jobstatusWaitingVO);
		System.out.println("jobstatusWaitingVO_id : "+jobstatusWaitingVO.getUserId());
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", jobstatusWaitingVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/job/writeJobStatus";
	}
	
	// 진행상태 = 승인
	@RequestMapping("writeJobStatusFin.do")
	public String JobappStatsFin(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {		
		StatusFinalVO jobstatusFinalVO = myService.viewAppFin(id, keyword);
		model.addAttribute("jobstatusFinalVO", jobstatusFinalVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", jobstatusFinalVO.getKeyword());
		session.setAttribute("referer", referer);		
		
		return "mypage/job/writeJobStatusFin";
	}
	
	
//	좋아요 관련
	// 커뮤니티 좋아요 한 글 리스트
	@RequestMapping("likeListsComm.do")
	public String likeListsComm(@SessionAttribute("userId") String id, Model model) {
		List<LikesListCommVO> likesListComm = myService.viewLikeListComm(id);
		model.addAttribute("likesListComm", likesListComm);
		
		return "mypage/like/likeListsComm";
	}
	
	
	// 좋아요 설정한 PR글 리스트
	@RequestMapping("likeListsPR.do")
	public String likeListsPR(@SessionAttribute("userId") String id, Model model, KeywordVO keywordVO) {	
		List<LikesListPRVO> likesListPR = myService.viewLikeListPR(id);
		model.addAttribute("likesListPR", likesListPR);
		
		// 모든 PR데이터 - 경력, 전공(포지션), 지역, 해시태그 데이터 가져옴
		List<PrBoardVO> PrCareers = myService.viewAllPrCareers();
		model.addAttribute("PrCareers", PrCareers);
		List<PrBoardVO> PrMajors = myService.viewAllPrMajors();
		model.addAttribute("PrMajors", PrMajors);
		List<PrBoardVO> PrLocs = myService.viewAllPrLocs();
		model.addAttribute("PrLocs", PrLocs);
		List<PrBoardVO> PrHashes = myService.viewAllPrHashes();
		model.addAttribute("PrHashes", PrHashes);
		
		// 페이징 처리
		PagingPrListVO pagingPrListVO = myService.pagingViewPrLike(keywordVO, id);
		model.addAttribute("pagingPrListVO", pagingPrListVO);
		
		return "mypage/like/likeListsPR";
	}
	
	
// ajax데이터 처리
	// parameter에 따라 재검색 후 데이터 반환
	@RequestMapping("api_likeListsPR.do")
	public @ResponseBody AjaxRespVO<PagingPrListVO> likeListsPRApi(@SessionAttribute("userId") String id, Model model, KeywordVO keywordVO) {	
		// 페이징 처리
		PagingPrListVO pagingPrListVO = myService.pagingViewPrLike(keywordVO, id);
		
		return new AjaxRespVO<PagingPrListVO>(1, "성공", pagingPrListVO);
	}	
	
	
// 커뮤니티 글 관리
	// 작성한 커뮤니티 글 리스트
	@RequestMapping("commWroteAll.do")
	public String commLists(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {
		CommsVO commsVO = myService.viewCommLists(id, keyword);
		model.addAttribute("commsVO", commsVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", commsVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/comm/commWroteAll";
	}
	
	// 작성한 커뮤니티 댓글 리스트
	@RequestMapping("commReplyWrote.do")
	public String commReplyLists(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {
		CommReplysVO commReplysVO = myService.viewCommReplyLists(id, keyword);
		model.addAttribute("commReplysVO", commReplysVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", commReplysVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/comm/commReplyWrote";
	}
	
	
// 문의게시판 관리
	// 작성한 qna글
	@RequestMapping("myQnALists.do")
	public String QnALists(@SessionAttribute("userId") String id, Model model, @RequestParam(required = false) String keyword) {
		QnAListsVO qnaListsVO = myService.viewQnALists(id, keyword);
		model.addAttribute("qnaListsVO", qnaListsVO);
		
		// keyword를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyword", qnaListsVO.getKeyword());
		session.setAttribute("referer", referer);
		
		return "mypage/mypage/myQnALists";
	}	
	
	
// 메시지 관리
	// 받은 메시지 함
	@RequestMapping("messagebox_rcv.do")
	public String MessageboxRcv(@SessionAttribute("userId") String id, Model model, KeywordVO keywordVO) {		
		// 메시지 리스트 with 페이징 처리
		PagingMsgListVO pagingMsgRcvListVO = myService.pagingViewRcvMsg(keywordVO, id);
		model.addAttribute("pagingMsgRcvListVO", pagingMsgRcvListVO);

		// KeyInTxt를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyInTxt", keywordVO.getKeyInTxt());
		session.setAttribute("referer", referer);
		
		return "mypage/message/messagebox_rcv";
	}		
	
	
	// 보낸 메시지 함
	@RequestMapping("messagebox_snd.do")
	public String MessageboxSnd(@SessionAttribute("userId") String id, Model model, KeywordVO keywordVO) {
		// 메시지 리스트 with 페이징 처리
		PagingMsgListVO pagingMsgSndListVO = myService.pagingViewSndMsg(keywordVO, id);
		model.addAttribute("pagingMsgSndListVO", pagingMsgSndListVO);

		// KeyInTxt를 세션에 저장 -> 다음 페이지에서 활용
		Map<String, Object> referer = new HashMap<String, Object>();
		referer.put("keyInTxt", keywordVO.getKeyInTxt());
		session.setAttribute("referer", referer);
		
		return "mypage/message/messagebox_snd";
	}
	
	
// 삭제 관련
	// 메시지 선택 삭제
	@RequestMapping(value="deleteSelectMsg.do", method=RequestMethod.DELETE)
	public AjaxRespVO<Integer> delSelectMsg(@RequestParam int msgNo) {
		int result = myService.delMsgNo(msgNo);
		
		if(result==1) {
			System.out.println("result :" + result);
			return new AjaxRespVO<Integer>(1, "success", result);
		} else {
			System.out.println("result :" + result);
			return new AjaxRespVO<Integer>(-1, "failure", result);
		}
	}
	
	// 작성한 커뮤니티 글 삭제
	@RequestMapping(value="deleteSelectComm.do", method=RequestMethod.DELETE)
	public AjaxRespVO<Integer> delSelectComm(@RequestParam int commNo) {
		int result = myService.delCommNo(commNo);
		
		if(result==1) {
			System.out.println("result :" + commNo + " 커뮤니티 글을 삭제하였습니다.");
			return new AjaxRespVO<Integer>(1, "success", result);
		} else {
			System.out.println("result :" + result);
			return new AjaxRespVO<Integer>(-1, "failure", result);
		}
	}
	
	// 작성한 커뮤니티 댓글 삭제
	@RequestMapping(value="deleteSelectReComm.do", method=RequestMethod.DELETE)
	public AjaxRespVO<Integer> delSelectReComm(@RequestParam int commReNo) {
		int result = myService.delCommReNo(commReNo);
		
		if(result==1) {
			System.out.println("result :" + commReNo + " 커뮤니티 댓글을 삭제하였습니다.");
			return new AjaxRespVO<Integer>(1, "success", result);
		} else {
			System.out.println("result :" + result);
			return new AjaxRespVO<Integer>(-1, "failure", result);
		}
	}
	
	// 작성한 문의게시판 글 삭제
	@RequestMapping(value="deleteQnA.do", method=RequestMethod.DELETE)
	public AjaxRespVO<Integer> delSelectQnA(@RequestParam int qnaNo) {
		int result = myService.delQnANo(qnaNo);
		
		if(result==1) {
			System.out.println("result :" + qnaNo + " 문의게시판 글을 삭제하였습니다.");
			return new AjaxRespVO<Integer>(1, "success", result);
		} else {
			System.out.println("result :" + result);
			return new AjaxRespVO<Integer>(-1, "failure", result);
		}
	}

	
//	// 작성한 커뮤니티 댓글 삭제
//	@RequestMapping("deleteReplyComm.do")
//	public String deleteReComm(@SessionAttribute("userId") String id, String commReNo, Model model) {
//		String[] delCommReNoArr = commReNo.split(",");
//		
//		int result = myService.deleteMyComReplys(delCommReNoArr);
//		
//		String msg = "";
//		if(result > 0) {
//			msg = commReNo + " 커뮤니티 댓글을 삭제하였습니다.";
//			model.addAttribute("msg", msg);
//		} else {
//			msg = "삭제할 항목을 선택해주세요.";
//			model.addAttribute("msg", msg);
//		}
//		return "mypage/comm/commReplyWrote";
//	}
	
	// 메시지 삭제
//	@RequestMapping("deleteRcvMsg.do")
//	public String deleteRcvMsg(@RequestParam(value = "msgNo") String msgNo) {
//		
//		// 쉼표로 구분된 문자열을 파싱하여 정수 배열로 변환
////		Integer[] msgNoArray = Arrays.stream(msgNo.split(","))
////									 .map(Integer::parseInt)
////									 .toArray(Integer[]::new);
//		
//		// Arrays의 private 정적 클래스인 ArrayList 리턴
//		List<Integer> delMList = Arrays.asList(msgNo);
//		System.out.println(delMList);
//		
//		// 삭제 메소드 실행
//		myService.deleteMsg(delMList);
//		
//		return "redirect:messagebox_rcv.do";
//	}
	
//	// 선택 삭제
//	@RequestMapping("delete_RcvMsg_select.do")
//	public String deleteRcvMsg(@SessionAttribute("userId") String id, @RequestParam(value = "msgNoArray") String[] msgNoArray) {
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("msgNo_array", msgNoArray);
//		
//		// 삭제 메소드 실행
//		int result = myService.deleteMsg(map);
//		
//		return "redirect:messagebox_rcv.do";
//	}
}
