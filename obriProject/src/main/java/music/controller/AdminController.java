package music.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import music.model.adminCommVO;
import music.model.adminJobVO;
import music.model.adminMemberVO;
import music.model.adminPrVO;
import music.model.adminVO;
import music.model.noticeVO;
import music.model.qnaVO;
import music.service.adminPagingPgm;
import music.service.adminService;
import music.service.noticeService;
import music.service.qnaService;

@Controller
public class AdminController {

	@Autowired
	private adminService adService;
	@Autowired
	private noticeService notService;
	@Autowired
	private qnaService qnaService;

	// 관리자 로그인
	@RequestMapping(value = "admin_login.do")
	public String admin_login() {
		System.out.println("현재경로:로그인페이지");
		return "admin/adminLogin";
	}

	// 로그인 인증
	@RequestMapping(value = "admin_login_ok.do", method = RequestMethod.POST)
	public String admin_login_ok(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session,
			Model model) throws Exception {
		System.out.println("현재경로:" + id);

		int result = 0;
		adminVO m = adService.adminCheck(id);
		System.out.println("m:" + m);

		if (m == null) { // 아이디가 틀릴때
			result = 1;
			model.addAttribute("result", result);
			return "admin/loginResult";
		} else {
			if (m.getAdminPw().equals(pw)) {
				session.setAttribute("adminId", id);
				return "redirect:admin_notice.do";

			} else { // 비밀번호가 틀릴때
				result = 2;
				model.addAttribute("result", result);
				return "admin/loginResult";
			}
		}
	}

	// 관리자 로그아웃
	@RequestMapping(value = "admin_logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "admin/adminLogout";
	}

	// 공지사항 페이지
	@RequestMapping(value = "admin_notice.do")
	public String admin_notice(String pageNum, noticeVO notvo, Model model) throws Exception {
		System.out.println("현재경로:공지사항페이지");

		List<Map<String, Object>> noticelist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = notService.getNoticeCount(notvo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		notvo.setStartRow(startRow);
		notvo.setEndRow(endRow);

		noticelist = notService.getNoticeList(notvo); // DAO클래스에 시작 행과 끝 행 전달
		System.out.println("noticelist" + noticelist);

		int no = total - startRow + 1;

		model.addAttribute("noticelist", noticelist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", notvo.getSearch());
		model.addAttribute("keyword", notvo.getKeyword());
		return "admin/adminNotice";
	}

	// 공지사항 글작성
	@RequestMapping(value = "notice_write.do")
	public String notice_write() {
		System.out.println("현재경로:공지사항 글쓰기");
		return "admin/adminNoticeWrite";
	}

	@RequestMapping(value = "notice_write_ok.do", method = RequestMethod.POST)
	public String notice_write_ok(@ModelAttribute noticeVO notice) throws Exception {
		notService.insertNotice(notice);

		return "redirect:/admin_notice.do";
	}

	// 공지사항 글삭제
	@RequestMapping(value = "notice_delete.do")
	public String notice_delete(@RequestParam("notNo") int notNo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:공지사항삭제");
		notService.deleteNotice(notNo);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminNoticeDel";
	}

	// 공지사항 글 선택 삭제
	@RequestMapping(value = "notice_delete_selected.do")
	public String notice_delete_selected(
			@RequestParam(value = "selectedNotList", required = false) List<Integer> selectedNotList) throws Exception {
		if (selectedNotList != null && !selectedNotList.isEmpty()) {
			for (Integer notNo : selectedNotList) {
				// 여기에서 서비스를 호출하여 해당 공지사항을 삭제하는 로직을 구현
				notService.deleteNotice(notNo);
			}
		}
		return "redirect:admin_notice.do";
	}

	// 공지사항 글읽기
	@RequestMapping(value = "admin_notice_read.do")
	public String admin_notice_read(@RequestParam("notNo") int notNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) notService.notice_view(notNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("notNo", notNo);

		if (state.equals("cont")) { // 내용보기
			// String notText = noticeVO.getnotText().replace("\n","<br>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			// model.addAttribute("board_cont", board_cont);

			return "admin/adminNoticeView";
		} else if (state.equals("edit")) { // 수정폼
			return "admin/adminNoticeEdit";
		}
		return null;
	}

	// 공지사항 일반 페이지
	@RequestMapping(value = "notice_list.do")
	public String notice_list(String pageNum, noticeVO notvo, Model model) throws Exception {
		System.out.println("현재경로:공지사항페이지");

		List<Map<String, Object>> noticelist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = notService.getNoticeCount(notvo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		notvo.setStartRow(startRow);
		notvo.setEndRow(endRow);

		noticelist = notService.getNoticeList(notvo); // DAO클래스에 시작 행과 끝 행 전달
		System.out.println("noticelist" + noticelist);

		int no = total - startRow + 1;

		model.addAttribute("noticelist", noticelist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", notvo.getSearch());
		model.addAttribute("keyword", notvo.getKeyword());
		return "admin/noticeList";
	}

	// 공지사항 일반 글읽기
	@RequestMapping(value = "notice_read.do")
	public String notice_read(@RequestParam("notNo") int notNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		if (state.equals("cont")) { // 내용보기
			notService.hit(notNo); // 조회수 증가
		}

//		noticeVO notview = notService.notice_view(notNo);

		Map<String, Object> map = (Map<String, Object>) notService.notice_view(notNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("notNo", notNo);

		if (state.equals("cont")) { // 내용보기
			return "admin/noticeView";
		}
		return null;
	}

	// 공지사항 글수정
	@RequestMapping(value = "notice_edit.do")
	public String notice_edit(@ModelAttribute noticeVO vo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:공지사항수정");
		notService.updateNotice(vo);
		model.addAttribute("pageNum", pageNum);

		return "redirect:notice_read.do?notNo=" + vo.getNotNo() + "&pageNum=" + pageNum + "&state=cont";
	}

	// 문의 게시판
	@RequestMapping(value = "admin_qna.do")
	public String admin_qna(String pageNum, qnaVO qnavo, Model model) throws Exception {
		System.out.println("현재경로:문의");

		List<Map<String, Object>> qnalist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = qnaService.getQnaCount(qnavo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		qnavo.setStartRow(startRow);
		qnavo.setEndRow(endRow);

		qnalist = qnaService.getQnaList(qnavo);
		System.out.println("qnalist" + qnalist);

		int no = total - startRow + 1;

		model.addAttribute("qnalist", qnalist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", qnavo.getSearch());
		model.addAttribute("keyword", qnavo.getKeyword());

		return "admin/adminQna";
	}

	// 문의게시판 처리완료
	@RequestMapping(value = "qna_delete.do")
	public String qna_delete(@RequestParam("qnaNo") int qnaNo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:문의사항처리완료");
		qnaService.deleteQna(qnaNo);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminQnaDel";
	}

	@RequestMapping(value = "qna_delete_selected.do")
	public String qna_delete_selected(
			@RequestParam(value = "selectedQnaList", required = false) List<Integer> selectedQnaList) throws Exception {
		if (selectedQnaList != null && !selectedQnaList.isEmpty()) {
			for (Integer qnaNo : selectedQnaList) {
				// 여기에서 서비스를 호출하여 해당 공지사항을 삭제하는 로직을 구현
				qnaService.deleteQna(qnaNo);
			}
		}
		return "redirect:admin_qna.do";
	}

	// 문의사항 글읽기
	@RequestMapping(value = "qna_read.do")
	public String qna_read(@RequestParam("qnaNo") int qnaNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) qnaService.qna_view(qnaNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("qnaNo", qnaNo);

		if (state.equals("cont")) { // 내용보기
			return "admin/adminQnaView";
		}
		return null;
	}

	// 첨부파일 다운로드
	@RequestMapping(value = "downloadFile.do", method = RequestMethod.GET)
	public void downloadFile(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("qnaNo") int qnaNo) {
		try {
			Map<String, Object> fileMap = (Map<String, Object>) qnaService.getQnaFile(qnaNo);
			String fileName = (String) fileMap.get("QNAFILE");
			String filePath = request.getRealPath("upload") + File.separator + fileName;

			File file = new File(filePath);
			FileInputStream fileInputStream = new FileInputStream(file);

			// 응답 헤더 설정
			response.setContentType("application/octet-stream");
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

			// 파일 출력 스트림
			OutputStream outputStream = response.getOutputStream();

			// 파일 복사
			byte[] buffer = new byte[4096];
			int bytesRead = -1;
			while ((bytesRead = fileInputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}

			// 자원 해제
			fileInputStream.close();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 문의사항 글작성
	@RequestMapping(value = "qna_form.do")
	public String qna_write() {
		System.out.println("현재경로:문의 글쓰기");
		return "admin/qnaWriteForm";
	}

	@RequestMapping(value = "qna_write_ok.do", method = RequestMethod.POST)
	public String qna_write_ok(@RequestParam("formFile") MultipartFile mf, @ModelAttribute qnaVO qna,
			HttpServletRequest request, @SessionAttribute("userId") String userId, Model model) throws Exception {
		System.out.println("현재경로:문의 글쓰기등록");

		if (userId != null && !userId.isEmpty()) {
			qna.setUserId(userId);
			qnaService.insertQna(qna);
			return "redirect:qna_form.do";
		} else if (userId == null && userId.isEmpty()) {
			model.addAttribute("error", "로그인 후에 이용해주세요.");
			return "redirect:login.do";
		}

		String filename = mf.getOriginalFilename(); // 첨부파일명
		int size = (int) mf.getSize();

		String path = request.getRealPath("upload");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("Path=" + path);
		int result = 0;

		String file[] = new String[2];

		String newfilename = "";
		if (filename != "") {
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자

			if (size > 100000) { // 100KB
				result = 1;
				model.addAttribute("result", result);

				return "admin/qnaUploadResult";

			} else if (!file[1].equals("jpg") && !file[1].equals("jpeg") && !file[1].equals("gif")
					&& !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "admin/qnaUploadResult";
			}
		}

		if (size > 0) { // 첨부파일이 전송된 경우

			mf.transferTo(new File(path + "/" + newfilename));
		}

		qna.setQnaFile(newfilename);
		qnaService.insertQna(qna);

		return "admin/qnaOk";
	}

	// 회원 목록
	@RequestMapping(value = "admin_memberlist.do")
	public String admin_memberlist(String pageNum, adminMemberVO membervo, Model model) throws Exception {
		System.out.println("현재경로:회원목록");

		List<Map<String, Object>> memberlist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = adService.getMemberCount(membervo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		membervo.setStartRow(startRow);
		membervo.setEndRow(endRow);

		memberlist = adService.getMemberList(membervo);
		System.out.println("memberlist" + memberlist);

		int no = total - startRow + 1;

		model.addAttribute("memberlist", memberlist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", membervo.getSearch());
		model.addAttribute("keyword", membervo.getKeyword());

		return "admin/adminMemberList";
	}

	// 회원 상세정보
	@RequestMapping(value = "admin_user_view.do")
	public String admin_user_view(@RequestParam("userId") String userId, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) adService.admin_user_view(userId);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("userId", userId);

		if (state.equals("cont")) { // 내용보기
			// String notText = noticeVO.getnotText().replace("\n","<br>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			// model.addAttribute("board_cont", board_cont);

			return "admin/adminMemberView";
		}
		return null;
	}

	// 회원 정지
	@RequestMapping(value = "admin_member_block.do")
	public String admin_member_block(@RequestParam("userId") String userId, @RequestParam("pageNum") int pageNum,
			Model model) throws Exception {
		System.out.println("현재경로:구인게시판삭제");
		adService.blockMember(userId);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminMemberUpdate";
	}

	// 회원 정지 해제
	@RequestMapping(value = "admin_member_nonblock.do")
	public String admin_member_nonblock(@RequestParam("userId") String userId, @RequestParam("pageNum") int pageNum,
			Model model) throws Exception {
		System.out.println("현재경로:구인게시판삭제");
		adService.nonblockMember(userId);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminMemberUpdate";
	}

	// 회원 탈퇴
	@RequestMapping(value = "admin_member_delete.do")
	public String admin_member_delete(@RequestParam("userId") String userId, @RequestParam("pageNum") int pageNum,
			Model model) throws Exception {
		System.out.println("현재경로:구인게시판삭제");
		adService.deleteMember(userId);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminMemberUpdate";
	}

	// 구인게시판
	@RequestMapping(value = "admin_job.do")
	public String admin_job(String pageNum, adminJobVO jobvo, Model model) throws Exception {
		System.out.println("현재경로:구인");

		List<Map<String, Object>> joblist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = adService.getJobCount(jobvo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		jobvo.setStartRow(startRow);
		jobvo.setEndRow(endRow);

		joblist = adService.getJobList(jobvo);
		System.out.println("joblist" + joblist);

		int no = total - startRow + 1;

		model.addAttribute("joblist", joblist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", jobvo.getSearch());
		model.addAttribute("keyword", jobvo.getKeyword());

		return "admin/adminJob";
	}

	// 구인게시판 삭제
	@RequestMapping(value = "admin_job_delete.do")
	public String job_delete(@RequestParam("jobNo") int jobNo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:구인게시판삭제");
		adService.deleteJob(jobNo);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminJobDel";
	}

	@RequestMapping(value = "admin_job_delete_selected.do")
	public String job_delete_selected(
			@RequestParam(value = "selectedJobList", required = false) List<Integer> selectedJobList) throws Exception {
		if (selectedJobList != null && !selectedJobList.isEmpty()) {
			for (Integer jobNo : selectedJobList) {
				// 여기에서 서비스를 호출하여 해당 공지사항을 삭제하는 로직을 구현
				adService.deleteJob(jobNo);
			}
		}
		return "redirect:admin_job.do";
	}

	// 구인게시판 글읽기
	@RequestMapping(value = "admin_job_read.do")
	public String job_read(@RequestParam("jobNo") int jobNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) adService.job_view(jobNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("jobNo", jobNo);

		if (state.equals("cont")) { // 내용보기
			// String notText = noticeVO.getnotText().replace("\n","<br>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			// model.addAttribute("board_cont", board_cont);

			return "admin/adminJobView";
		}
		return null;
	}

	// 홍보게시판
	@RequestMapping(value = "admin_pr.do")
	public String admin_pr(String pageNum, adminPrVO prvo, Model model) throws Exception {
		System.out.println("현재경로:홍보");

		List<Map<String, Object>> prlist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = adService.getPrCount(prvo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		prvo.setStartRow(startRow);
		prvo.setEndRow(endRow);

		prlist = adService.getPrList(prvo);
		System.out.println("prlist" + prlist);

		int no = total - startRow + 1;

		model.addAttribute("prlist", prlist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", prvo.getSearch());
		model.addAttribute("keyword", prvo.getKeyword());

		return "admin/adminPr";
	}

	// 홍보게시판 삭제
	@RequestMapping(value = "admin_pr_delete.do")
	public String pr_delete(@RequestParam("prNo") int prNo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:홍보삭제");
		adService.deletePr(prNo);
		model.addAttribute("pageNum", pageNum);
		return "admin/prDel";
	}

	@RequestMapping(value = "admin_pr_delete_selected.do")
	public String pr_delete_selected(
			@RequestParam(value = "selectedPrList", required = false) List<Integer> selectedPrList) throws Exception {
		if (selectedPrList != null && !selectedPrList.isEmpty()) {
			for (Integer prNo : selectedPrList) {
				// 여기에서 서비스를 호출하여 해당 공지사항을 삭제하는 로직을 구현
				adService.deletePr(prNo);
			}
		}
		return "redirect:admin_job.do";
	}

	// 홍보게시판 글읽기
	@RequestMapping(value = "admin_pr_read.do")
	public String pr_read(@RequestParam("prNo") int prNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) adService.pr_view(prNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("prNo", prNo);

		if (state.equals("cont")) { // 내용보기
			// String notText = noticeVO.getnotText().replace("\n","<br>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			// model.addAttribute("board_cont", board_cont);

			return "admin/adminPrView";
		}
		return null;
	}

	// 커뮤니티게시판
	@RequestMapping(value = "admin_comm.do")
	public String admin_comm(String pageNum, adminCommVO commvo, Model model) throws Exception {
		System.out.println("현재경로:커뮤니티");

		List<Map<String, Object>> commlist = new ArrayList<Map<String, Object>>();

		int limit = 10; // 화면에 출력할 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		} // pageNum이 없을경우 1로 설정

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = adService.getCommCount(commvo);

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + 10 - 1;

		adminPagingPgm pp = new adminPagingPgm(total, limit, currentPage);
		commvo.setStartRow(startRow);
		commvo.setEndRow(endRow);

		commlist = adService.getJobList(commvo);
		System.out.println("commlist" + commlist);

		int no = total - startRow + 1;

		model.addAttribute("commlist", commlist);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", commvo.getSearch());
		model.addAttribute("keyword", commvo.getKeyword());

		return "admin/adminComm";
	}

	// 커뮤니티 삭제
	@RequestMapping(value = "admin_comm_delete.do")
	public String comm_delete(@RequestParam("commNo") int commNo, @RequestParam("pageNum") int pageNum, Model model)
			throws Exception {
		System.out.println("현재경로:커뮤니티삭제");
		adService.deleteComm(commNo);
		model.addAttribute("pageNum", pageNum);
		return "admin/adminCommDel";
	}

	@RequestMapping(value = "admin_comm_delete_selected.do")
	public String comm_delete_selected(
			@RequestParam(value = "selectedCommList", required = false) List<Integer> selectedCommList)
			throws Exception {
		if (selectedCommList != null && !selectedCommList.isEmpty()) {
			for (Integer commNo : selectedCommList) {
				// 여기에서 서비스를 호출하여 해당 공지사항을 삭제하는 로직을 구현
				adService.deleteJob(commNo);
			}
		}
		return "redirect:admin_job.do";
	}

	// 커뮤니티 글읽기
	@RequestMapping(value = "admin_comm_read.do")
	public String comm_read(@RequestParam("commNo") int commNo, @RequestParam("pageNum") String pageNum,
			@RequestParam("state") String state, Model model) throws Exception {

		Map<String, Object> map = (Map<String, Object>) adService.comm_view(commNo);

		model.addAttribute("map", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("commNo", commNo);

		if (state.equals("cont")) { // 내용보기
			// String notText = noticeVO.getnotText().replace("\n","<br>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			// model.addAttribute("board_cont", board_cont);

			return "admin/adminCommView";
		}
		return null;
	}

}
//