package music.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import music.model.commLikeVO;
import music.service.commLikeService;
import music.service.communityService;

@Controller
public class commLikeController {

	@Autowired
	private communityService service;
	
	@Autowired
	private commLikeService likeService;
	
	// 커뮤니티 좋아요 버튼
	@RequestMapping("comLike.do")
	public String likeInsert(int commNo, String state , String pageNum, HttpSession session  ,Model model) {
	
		// 좋아요 선택 유무 구하기
				String userId = (String)session.getAttribute("userId");
				commLikeVO  commVO = new commLikeVO();
				commVO.setUserId(userId);
				commVO.setCommNo(commNo);	
				
				
//				System.out.println("state:"+ state);
//				Character state1 = state.charAt(0);				// String형을 char형으로 변환		
//				System.out.println("state1:"+ state1);

				commVO.setCommLike(state);					
				
				List<commLikeVO> list = likeService.select(commVO);	
				System.out.println("상세정보 list:"+list);
				int result = 0;
				
				Map map = new HashMap();		
				map.put("userId", userId);
				map.put("commNo", commNo);
				map.put("commLike", state);				
				
				 // 좋아요가 없는 경우 : insert SQL
				if(list.isEmpty() ) {     
					result = likeService.insert(commVO);
					System.out.println("insert result:"+ result);
					// 증가 sql
					//service.upLike(commNo);
					
				// 좋아요가 있는 경우 : update SQL
				}else {							 
					result = likeService.update(map);
					System.out.println("update result:"+ result);
					
				}
				// 상태값에 따라서 증가 감소 sql
				service.changeLike(commVO);
				
				
				model.addAttribute("result", result);
				model.addAttribute("commNo", commNo);
				model.addAttribute("pageNum", pageNum);		
		
//				String message = "";
//				String Like = "";
				
				// 추천 버튼 클릭 시 전달 받은 commNo(글 번호)와 id 값으로 추천 테이블에 데이터 존재 여부 확인
//				commLikeVO result = likeService.select(commlike);
//				System.out.println("result:"+result);
//				
//				if(result != null) {	// 이미 좋아요 이력이 존재하면
//					message = "좋아요를 취소하였습니다";
//					Like = "1";
//					
//					
//					likeService.delete(commlike);
//					// 커뮤니티 게시판 좋아요 감소
//					service.deleteLike(commlike.getCommNo());
//					
//				}else {					// 좋아요 이력이 존재하지 않으면
//					message = "좋아요를 눌렀습니다";
//					Like="0";
//					
//					
//					likeService.insert(commlike);
//					// 커뮤니티 게시판 좋아요 증가
//					service.updateLike(commlike.getCommNo());
//				}
//						
//				System.out.println("Like"+Like);
//				model.addAttribute("message", message);
//				model.addAttribute("result", result);
//				model.addAttribute("Like", Like);
				
				
				
				return "likeResult";
	}
	
	
	
}
