package music.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import music.model.jobBoardVO;
import music.service.jobBoardService;
import music.service.PagingPgm;

@Controller
public class JobBoardController {
	@Autowired
	private jobBoardService jbs;

	// 글목록
	@RequestMapping("joblist.do")
	public String list(String pageNum, jobBoardVO jobboard, @RequestParam(value = "jobListSel", required = false) String jobListSel , Model model) {
		
		System.out.println("분류:"+ jobListSel);
		
		final int rowPerPage = 10; // 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int total = 0;

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호

		total = jbs.getJobTotal(jobboard); // 검색
		System.out.println("total:" + total);

		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		jobboard.setStartRow(startRow);
		jobboard.setEndRow(endRow);
//		 List<jobBoardVO> list = jbs.list(startRow, endRow);
		int no = total - startRow + 1;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = jbs.jobList(jobboard);
		System.out.println("list:" + list);
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		model.addAttribute("pageNum", pageNum);		
		// 검색
		model.addAttribute("search", jobboard.getSearch());
		model.addAttribute("keyword", jobboard.getKeyword());
		
		// 정렬
		model.addAttribute("jobListSel", jobboard.getJobListSel());
		
		System.out.println("no"+ no);
		System.out.println("pp"+ pp);
		System.out.println("pageNum"+ pageNum);
		
		return "job/joblist";
	}

	// 글작성 폼
	@RequestMapping("job_board_write.do")
	public String jobinsertform() {
		System.out.println("in");
		return "job/job_board_write";
	}

	// 글작성
	@RequestMapping("write_ok.do")
	public String job_write_ok(jobBoardVO jobboard,HttpServletRequest request,String jobEndDate1,String jobConcert1,Model model) {
		jobboard.setJobEndDate(Date.valueOf(jobEndDate1));
		jobboard.setJobConcert(Date.valueOf(jobConcert1));
		HttpSession session = request.getSession();
		session.setAttribute("userId", "skt1");
		String userId = (String)session.getAttribute("userId");
		System.out.println("섹션아이디받음"+ userId);
		
		Map<String, Object> map = (Map<String, Object>)jbs.selectJobMember(userId);
		
	   String userName = (String)map.get("USERNAME");
	    
	    //jobBoardVO jobboard = new jobBoardVO(); 
		System.out.println("map받음"+ map.get("USERNAME"));
		
		System.out.println("jobboard:"+jobboard.getJobEndDate());
		System.out.println("jobboard:"+jobboard.getJobConcert());
		System.out.println("jobboard:"+jobboard.toString());
		jobboard.setUserId(userId); // 세션에 있는
		System.out.println("넣은값 확인 " + jobboard.getUserId());
		System.out.println("jobboard확인:"+jobboard);
		int result = jbs.jobInsert(jobboard);
		if (result == 1)
			System.out.println("글작성 성공");

		model.addAttribute("result", result);
		model.addAttribute("map", map);
		return "redirect:joblist.do";
	}
	
	//상세페이지
	@RequestMapping("job_board_view.do")
	public String job_board_view(int jobNo, String pageNum, String state, Model model, HttpSession session) throws Exception {
		
		session.setAttribute("userId", "itkorea");
		String userId = (String) session.getAttribute("userId");
		
		if(state.equals("cont")) {
			jbs.updateCount(jobNo); 	// 조회수 1증가
		}
		
	jobBoardVO jobboard = jbs.getJobboard(jobNo);	// 상세정보 구하기
	
	System.out.println("상세정보구하기 성공");
	model.addAttribute("jobboard", jobboard);
	model.addAttribute("pageNum", pageNum);
	System.out.println("지도주소값받기:"+ jobboard.getJobAddress());
	
	int result = 0;
	jobBoardVO db = jbs.getJobboard(jobboard.getJobNo());
	
	double[] coordinates = new double[2];
	try {
        // Google Geocoding API 키를 설정합니다.
        String apiKey = "AIzaSyDEM3FEmY5ecJzAkXH9TDRAs1MaXpSWtME";

        // Geocoding API 호출을 위한 URL을 생성합니다.
        String encodedAddress = URLEncoder.encode(jobboard.getJobAddress(), "UTF-8");
        String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodedAddress + "&key=" + apiKey;

        // HTTP 요청을 수행하고 응답을 받습니다.
        String jsonResponse = sendHttpRequest(apiUrl);

        // JSON 데이터를 파싱하여 위도와 경도를 추출합니다.
        coordinates = parseJsonResponse(jsonResponse);

        // 결과 출력
        System.out.println("입력한 주소의 위도: " + coordinates[0]);
        System.out.println("입력한 주소의 경도: " + coordinates[1]);

    } catch (IOException e) {
        e.printStackTrace();
    }
	
	model.addAttribute("jobboard", jobboard);
	model.addAttribute("jobAddress", jobboard.getJobAddress());
	model.addAttribute("lat", coordinates[0]);
	model.addAttribute("lng", coordinates[1]);
	
	if (state.equals("cont")) {				// 내용보기
		// String board_cont = board.getBoard_content().replace("\n","<br>");
		// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
		// model.addAttribute("board_cont", board_cont);
		
		return "job/job_board_view";					
	} else if (state.equals("edit")) {		// 수정폼
		return "job/job_board_edit";
	}
	
	return null;
}
	@RequestMapping("edit_ok.do")
	public String edit_ok(@RequestParam(name="jobFin1", defaultValue = "N") String job[],
						  jobBoardVO jobboard, String pageNum,
						  String jobEndDate2,String jobConcert2, Model model) {
		
//			if(job != null) {
//				for(String j : job) {
//					System.out.println(j);
//				}
//			}else {
//				System.out.println("jobFin값 전달 실패");
//			}		
		
			jobboard.setJobFin(job[0]);		
			
		    int result = 0;
		    int appResult = 0;
		    
//		    String[] job = request.getParameterValues("jobFin1");
//		    String job = request.getParameter("jobFin1");
//		    System.out.println("jobFin:"+job[0]);
//		    System.out.println("jobFin:"+jobboard.getJobFin());
		    
//		    System.out.println("jobFin2:"+ Arrays.toString(job));
		    
			jobboard.setJobEndDate(Date.valueOf(jobEndDate2));
			jobboard.setJobConcert(Date.valueOf(jobConcert2));
			result = jbs.update(jobboard);
			
			System.out.println("jobCd:"+jobboard.getJobCd());
			
			if("Y".equals(jobboard.getJobFin())) {
				System.out.println("업데이트문 들어옴");
				System.out.println("번호 "+jobboard.getJobNo());
				//jobboard.setJobFin("Y");
				appResult = jbs.updateAppDone(jobboard.getJobNo());
				System.out.println("앱리설트"+appResult);
			}
			
			
			if(result == 1) System.out.println("수정성공");
	
		model.addAttribute("jobNo", jobboard.getJobNo());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "job/job_edit_ok"; 
	}
	
	@RequestMapping("job_board_del.do")
	public String job_board_del(int jobNo, String pageNum, Model model) {
        
		System.out.println("jobNo:"+jobNo);
		jbs.delete(jobNo);
        
//        model.addAttribute("pageNum", pageNum);
        
        return "redirect:joblist.do?pageNum="+pageNum;
	}

	private static String sendHttpRequest(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            StringBuilder response = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            return response.toString();
        } finally {
            connection.disconnect();
        }
    }

    private static double[] parseJsonResponse(String jsonResponse) {
        JSONObject jsonObject = new JSONObject(jsonResponse);

        if ("OK".equals(jsonObject.getString("status"))) {
            JSONArray results = jsonObject.getJSONArray("results");
            if (results.length() > 0) {
                JSONObject location = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
                double latitude = location.getDouble("lat");
                double longitude = location.getDouble("lng");

                return new double[]{latitude, longitude};
            }
        }

        // 실패하거나 결과가 없는 경우 기본값 반환
        return new double[]{0.0, 0.0};
    }
}
