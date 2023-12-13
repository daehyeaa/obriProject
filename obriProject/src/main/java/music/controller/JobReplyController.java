package music.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import music.model.jobBoardVO;
import music.model.jobReplyVO;
import music.service.jobBoardService;
import music.service.jobReplyService;

@Controller
public class JobReplyController {

	@Autowired
	private jobReplyService jrs;
	@Autowired
	private jobBoardService jbs;

//	@RequestMapping("/test.do")
//	public String test(Model model) {
//		System.out.println("테스트 들어옴");
//		jobBoardVO jobBoard = new jobBoardVO();
//		int jobNo = 2;
//		jobBoard.setJobNo(jobNo);
//		jobBoard = jbs.select(jobNo); // 조회
//		model.addAttribute("jobBoard", jobBoard);
//		return "job/job_board_view";
//	}
	
	// 댓글 목록
	@RequestMapping("/rlist/jobNo/{jobNo}/let.do")
	public String rlist(@PathVariable int jobNo, Model model) {
		System.out.println("구인 게시판 번호: " +jobNo);
//		jobBoardVO jobBoard = jbs.select(jobNo);
		List<jobReplyVO> rlist = jrs.list(jobNo);
		model.addAttribute("rlist", rlist);
		//model.addAttribute("jobBoard", jobBoard);
		System.out.println("보낸다..");
		System.out.println("알리스트" + rlist);
		return "job/rlist";
	}

	// 댓글 저장
	@RequestMapping("/rInsert.do")
	public String rInsert(jobReplyVO rv, Model model) {
		System.out.println("댓글저장 들어옴");
		System.out.println(rv.getJobNo());
		System.out.println(rv.getUserId());
		jrs.insert(rv);
		return "redirect:rlist/jobNo/" + rv.getJobNo()+"/let.do";
	}

	// 댓글 삭제
	@RequestMapping("/reDelete.do")
	public String delete(jobReplyVO rv, Model model) {
		System.out.println("댓글 삭제 들어옴");
		System.out.println(rv.getJobNo());
		System.out.println(rv.getJobReNo());
		jrs.delete(rv);
		return "redirect:rlist/jobNo/" + rv.getJobNo()+"/let.do";
	}
	
	// 댓글 수정
	@RequestMapping("/reUpdate.do")
	public String reUpdate(jobReplyVO rv, Model model) {
		System.out.println("댓글 수정 들어옴");
		System.out.println("들어가지전 "+ rv.getJobNo());
		jrs.update(rv);
		System.out.println("잡 넘버  " + rv.getJobNo());
		return "redirect:rlist/jobNo/" + rv.getJobNo()+"/let.do";
	}
	
}
