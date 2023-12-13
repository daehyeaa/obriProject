package music.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import music.model.commReplyVO;
import music.model.communityVO;
import music.service.commReplyService;
import music.service.communityService;

@Controller
public class commReplyController {

	@Autowired
	private commReplyService replyService;

	@Autowired
	private communityService service;

	// 댓글 입력
	@RequestMapping("commReInsert.do")
	public String comReInsert(commReplyVO  commReply,
												  HttpSession session, Model model) throws Exception{
		
		commReply.setCommReId((String)session.getAttribute("userId")); 
		System.out.println("댓글commReply:" + commReply);
		
		if(commReply.getCommSecret() == null) {
			commReply.setCommSecret("N");	
			System.out.println("commSecret:" + commReply.getCommSecret());
			
			// 일반 댓글 작성
			System.out.println("일반댓글 컨트롤러");
			replyService.commReInsert(commReply);
		}else {
			commReply.setCommSecret("Y");	
			System.out.println("commSecret:" + commReply.getCommSecret());
			
			// 비밀댓글 작성
			System.out.println("비밀댓글 컨트롤러");
			replyService.replySecret(commReply);
			
		}
		System.out.println("댓글 작성 컨트롤러");
		System.out.println("commReId:" + commReply.getCommReId());
		System.out.println("commNo:" + commReply.getCommNo());
		System.out.println("commReText:" + commReply.getCommReText());
		
		model.addAttribute("commReply", commReply);
		
		return "redirect:commReList.do?commNo=" + commReply.getCommNo();
	}

	// 댓글 목록
	@RequestMapping("commReList.do")
	public String reList(int commNo, commReplyVO  commReply,Model model) {
		System.out.println("댓글 목록 컨트롤러");
		System.out.println("commNo:"+ commNo);

		// 부모 테이블 상세정보 
		communityVO community = service.Content(commNo);
		System.out.println("community:" + community);

		// 댓글목록 구해오기
		List<communityVO> commReList = replyService.comReList(commNo);
		System.out.println("commReList:" + commReList);

		// 댓글 갯수
		int reTotal = replyService.getTotal(commReply); // 검색 (데이터 갯수)
		System.out.println("reTotal:" + reTotal);
		
		model.addAttribute("commReply", commReply);
		model.addAttribute("commReList", commReList);
		model.addAttribute("community", community);
		model.addAttribute("reTotal",reTotal);
		return "community/commReList";
	}
	
	// 댓글 삭제
			@RequestMapping("commReDelete.do")
			public String delete(commReplyVO  commReply, Model model) {
				System.out.println("댓글 삭제 컨트롤러");
				replyService.comReDelete(commReply.getCommReNo());
				return "redirect:commReList.do?commNo="+commReply.getCommNo();
			}
	
	
}
