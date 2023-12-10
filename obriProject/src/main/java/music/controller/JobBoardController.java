package music.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import music.model.jobBoardVO;
import music.service.jobBoardService;
import music.service.PagingPgm;

@Controller
public class JobBoardController {
	
	@Autowired
	private jobBoardService jbs;
	
	@RequestMapping("joblist.do")
	public String list(String pageNum, jobBoardVO jobBoard, Model model) {
		final int rowPerpage = 10;
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int total = 0;
		
		int currentpage = Integer.parseInt(pageNum);
		
		total = jbs.getJobTotal(jobBoard);
		
		int startRow = (currentpage - 1) * rowPerpage + 1;
		int endRow = startRow + rowPerpage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerpage, currentpage);
		jobBoard.setStartRow(startRow);
		jobBoard.setEndRow(endRow);
//		 List<jobBoardVO> list = jbs.list(startRow, endRow);
		int no = total - startRow + 1;
		
		List<jobBoardVO> list = jbs.jobList(jobBoard);
		System.out.println("total:"+ total);
		System.out.println("list:"+ list);
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		
		model.addAttribute("search", jobBoard.getSearch());
		model.addAttribute("keyword", jobBoard.getKeyword());
		return "job/joblist";
	}	
	
	@RequestMapping("job_board_write.do")
	public String jobBoardWrite() {	
		System.out.println("in");
	return "job/job_board_write";
	}
	
	@RequestMapping("write_ok.do")
	public String board_write_ok(jobBoardVO jobBoard, Model model){
		
		int result = jbs.insert(jobBoard);
		System.out.println("result:"+ result);
		
		model.addAttribute("result", result);
		
		return "job/job_write_ok";
	}
	
	@RequestMapping("job_board_view.do")
	public String board_view(int jobNo, String pageNum, Model model) {
		
		jbs.updateCount(jobNo);
		jobBoardVO jobBoard = jbs.getJobBoard(jobNo);
//		String text = jobBoard.getJobText().replace("\n", "<br>");
		
		model.addAttribute("jobBoard", jobBoard);
//		model.addAttribute("view", text);
		model.addAttribute("pageNum", pageNum);
		
		return "job/job_board_view";
	}
	
	@RequestMapping("job_board_edit.do")
	public String job_board_edit(int jobNo, String pageNum, Model model) {
		jobBoardVO jobBoard = jbs.getJobBoard(jobNo);
		model.addAttribute("jobBoard", jobBoard);
		model.addAttribute("pageNum", pageNum);
		
		return "job/job_board_edit";		
	}
	
	@RequestMapping("edit_ok.do")
	public String edit_ok(jobBoardVO jobBoard, String pageNum, Model model) {
		int result = jbs.update(jobBoard);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "job/job_edit_ok";
	}
	
	@RequestMapping("job_board_del.do")
	public String job_board_del(jobBoardVO jobBoard, String pageNum, Model model) {
        int result = 0;
        	jbs.getJobBoard(jobBoard.getJobNo());        	
        	jbs.delete(jobBoard.getJobNo());

        model.addAttribute("result", result);
        model.addAttribute("pageNum", pageNum);
        
        return "job/joblist";
	}
	
	// 주소 입력하는 화면
	@RequestMapping("findMap.do")
	public String findMap() {
		return "job/findCoordinate";
	}
	
	// 주소 입력 받아서 처리하는 곳
	@RequestMapping("findCoordinate.do")
	public String findCoordinate(@RequestParam String address, Model model) {
		System.out.println("지도찾기들어옴");
		
		double[] coordinates = new double[2];
		try {
            // Google Geocoding API 키를 설정합니다.
            String apiKey = "AIzaSyDEM3FEmY5ecJzAkXH9TDRAs1MaXpSWtME";

            // Geocoding API 호출을 위한 URL을 생성합니다.
            String encodedAddress = URLEncoder.encode(address, "UTF-8");
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
		    
		model.addAttribute("address", address);
		model.addAttribute("lat", coordinates[0]);
		model.addAttribute("lng", coordinates[1]);
		
//		return "job/result";
		return "job/kakaoResult";
		
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
