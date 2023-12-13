package music.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import music.model.commLikeVO;
import music.model.communityVO;
import music.service.PagingPgm;
import music.service.commLikeService;
import music.service.commReplyService;
import music.service.communityService;

@Controller
public class communityController {

	@Autowired
	private communityService service;

	@Autowired
	private commLikeService likeService;

	@Autowired
	private commReplyService replyService;

	// 글작성 폼
	@RequestMapping("boardForm.do")
	public String boardform() {
		System.out.println("글작성폼 컨트롤러");
		return "community/boardForm";
	}

	// 글 작성
	@RequestMapping("boardWrite.do")
	public String boardwrite(@RequestParam("com_file1")  MultipartFile mf, 
											    communityVO community,
											    HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("userId:"+ community.getUserId());
		

		String filename = mf.getOriginalFilename(); // 첨부파일명
		int size = (int) mf.getSize(); // 첨부파일의 크기 (단위:Byte)

		String path = request.getRealPath("upload");
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("Path=" + path);

		int result = 0;
		String newfilename = "";

		if (size > 0) { // 첨부파일이 전송된 경우

			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			if (size > 1000000) { // 1MB
				result = 2;
				model.addAttribute("result", result);

				return "community/uploadResult";

			} else if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".gif")
					&& !extension.equals(".png")) {

				result = 3;
				model.addAttribute("result", result);

				return "community/uploadResult";
			}
		}

		if (size > 0) { // 첨부파일이 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
		}

		community.setCommFile(newfilename);
		result = service.insertBoard(community);

		model.addAttribute("result", result);

		return "community/insertResult";
	}

//	// 글 목록
	@RequestMapping("boardList.do") // 전체 목록, 검색 목록
	public String list(String pageNum, communityVO community,  Model model) {
		System.out.println("글목록 컨트롤러");

		// 정렬 값(sort)이 없는 경우(초기 실행)
		if (community.getSort() == null) {
			community.setSort("recent");
		}
		String sort = community.getSort();

		final int rowPerPage = 10; // 화면에 출력할 데이터 갯수
		// 초기 페이지 값 1
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		// int total = bs.getTotal();
		int total = service.getTotal(community); // 검색 (데이터 갯수)
		System.out.println("total:" + total);

		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		community.setStartRow(startRow);
		community.setEndRow(endRow);

		int no = total - startRow + 1; // 화면 출력 번호
		List<communityVO> list = service.list(community);
		System.out.println("list:" + list);

		// 현재 날짜 구하기
//		LocalDate now = LocalDate.now();
//		System.out.println("now:"+ now);
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
//		
//		String today =now.format(formatter);
//		System.out.println("today:"+today);
//		model.addAttribute("today", today);
		
		// 좋아요 갯수
		int likeCnt = service.count(community.getCommNo());
		System.out.println("likeCnt:" + likeCnt);

		model.addAttribute("likeCnt", likeCnt);

		model.addAttribute("sort", sort);

		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);

		// 검색
		model.addAttribute("search", community.getSearch());
		model.addAttribute("keyword", community.getKeyword());

		return "community/boardList";
	}

	// 상세정보 + 조회수
	@RequestMapping("boardContent.do")
	public String boardContent(int commNo, String pageNum, HttpServletRequest request, Model model) {

		System.out.println("commNo:" + commNo);
		System.out.println("상세페이지:" + pageNum);

		HttpSession idsession = request.getSession();

		communityVO community = service.Content(commNo); // 상세 정보 구하기
		System.out.println("상세정보 조회 컨트롤러");

		// 좋아요 선택 유무 구하기
		String userId = (String) idsession.getAttribute("userId");

		commLikeVO commVO = new commLikeVO();
		commVO.setUserId(userId);
		commVO.setCommNo(commNo);

		System.out.println("세션에서 가져온 ID:" + userId);

		if (userId != null && !userId.equals("")) {
			List<commLikeVO> list = likeService.select(commVO);
			System.out.println("상세정보 list:" + list);

			if (!list.isEmpty()) {
				System.out.println("상세정보list가 null:" + list);
				commLikeVO commLike = list.get(0);
				System.out.println("list 0번방 : " + commLike);
				System.out.println("list 0번방 commLike : " + commLike.getCommLike());
				String state = String.valueOf(commLike.getCommLike()); // char --> String형으로 변환

				model.addAttribute("state", state);
				model.addAttribute("commLike", commLike);
			}
		}

		service.updateCount(commNo); // 조회수 1증가
		System.out.println("조회수 증가 컨트롤러");

		
		// 좋아요 갯수
		int likeCnt = service.count(commNo);
		System.out.println("likeCnt:" + likeCnt);
		
		model.addAttribute("likeCnt", likeCnt);

		String Content = community.getCommText().replace("\n", "<br>");

		model.addAttribute("community", community);
		model.addAttribute("Content", Content);
		model.addAttribute("pageNum", pageNum);

		return "community/boardContent";
	}

	// 글삭제
	@RequestMapping("boardDelete.do")
	public String boardDelete(int commNo, String pageNum, Model model) {
		System.out.println("글삭제 컨트롤러");

		communityVO community = service.Content(commNo);
		int result = service.boardDelete(commNo);

		model.addAttribute("result", result);
		model.addAttribute("community", community);
		model.addAttribute("pageNum", pageNum);

		return "community/deleteResult";
	}

	// 수정 폼
	@RequestMapping("boardUpdateForm.do")
	public String boardUpdateForm(int commNo, String pageNum, Model model) {
		System.out.println("글 수정폼 컨트롤러");
		communityVO community = service.Content(commNo); // 상세 정보 구하기

		model.addAttribute("community", community);
		model.addAttribute("pageNum", pageNum);

		return "community/boardUpdateForm";
	}

	// 글 수정
	@RequestMapping("boardUpdate.do")
	public String boardupdate(@RequestParam("com_file1") MultipartFile mf, communityVO community, String pageNum,
			HttpServletRequest request, Model model) throws Exception {
		System.out.println("글 수정 컨트롤러");

		System.out.println("글번호:" + community.getCommNo());
		System.out.println("제목:" + community.getCommSub());
		System.out.println("내용:" + community.getCommText());

		// 필요한 변수 생성
		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();
		System.out.println("filename: " + filename);
		System.out.println("size: " + size);

		String path = request.getRealPath("upload");
		System.out.println("path: " + path);

		int result = 0;
		String newfilename = "";

		if (size > 0) { // 첨부파일이 전송된 경우

			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension); // .jpg

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			if (size > 1000000) { // 1MB
				result = 2;
				model.addAttribute("result", result);

				return "community/uploadResult";

			} else if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".gif")
					&& !extension.equals(".png")) {

				result = 3;
				model.addAttribute("result", result);

				return "community/uploadResult";
			}
		}

		if (size > 0) { // 첨부파일이 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
		}

		communityVO cv = service.Content(community.getCommNo());

		if (size > 0) { // 첨부파일이 수정된 경우
			community.setCommFile(newfilename);
		} else {
			community.setCommFile(cv.getCommFile());
		}

		int updateResult = service.boardUpdate(community); // update SQL문 실행
		if (updateResult == 1)
			System.out.println("수정성공");

		model.addAttribute("commNo", community.getCommNo());
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("result", updateResult);

		return "community/updateResult";
	}

}
