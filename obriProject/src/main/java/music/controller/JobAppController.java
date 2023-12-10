package music.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import music.model.jobAppVO;
import music.model.jobReplyVO;
import music.service.PagingPgm;
import music.service.jobAppService;
import music.service.jobBoardService;
import music.service.jobReplyService;

@Controller
public class JobAppController {

	@Autowired
	private jobBoardService jbs;
	
	@Autowired
	private jobAppService jas;

	// 신청 리스트 목록
	
	@RequestMapping("jobAppList.do")
	@ResponseBody
	public Map<String,Object> rlist(@RequestParam(value = "pageNum", defaultValue="1") String pageNum, jobAppVO app ,Model model) {
		
		System.out.println("신청 리스트 들어옴");
		
		System.out.println("페이지넘" + pageNum);
		System.out.println("잡넘"+app.getJobNo());
		System.out.println("앱넘"+app.getAppNo());
		
		final int rowPerPage = 15; // 한 화면에서 출력하고자 하는 리스트의 갯수를 정하는 변수
		
		int currentPage = Integer.parseInt(pageNum);
		
		int total = jas.getAppTotal(); // 전체 신청자 수 조회
		System.out.println("토탈"+total);
		
		int startRow = (currentPage -1) * rowPerPage +1; // 해당 화면에서 출력될 리스트이 처음 숫자
		int endRow = startRow + rowPerPage -1 ; // 해당 화면에서 출력될 리스트의 마지막 숫자
		
		app.setStartRow(startRow);
		app.setEndRow(endRow);
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		List<Map<String,Object>> appList = jas.selectAppList(app);
		
		System.out.println("보낸다..");
		System.out.println("앱리스트" + appList);
		System.out.println("피피" + pp);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("appList", appList);
		map.put("pp", pp);
		
		// 실제는 job_board_view에 보이는데 .load로 부르기때문에 따로 appList에서 리스트를 작성한다.
		return map;
	}
	
	// 구인 확정 
	@RequestMapping("confirmApp.do")
	@ResponseBody
	public int confirmApp(jobAppVO app) {
		
		System.out.println("구인확정 들어옴");
		
		int result = 0;
		
		result = jas.updateApp(app);
		System.out.println("결과값"+ result);
		
		return result;
	}
	
	// 구인 확정 취소
	@RequestMapping("confirmAppCancel.do")
	@ResponseBody
	public void confirmAppCancel(jobAppVO app) {
		
		System.out.println("구인확정 취소 들어옴");
		
		jas.updateCancelApp(app);
		
		
	}
}
