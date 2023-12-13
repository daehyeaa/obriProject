package music.service;

import lombok.Data;

@Data
public class adminPagingPgm {
	private int listcount;			// 데이터 갯수
	private int limit;				// 화면에 출력할 데이터 갯수
	private int pagePerBlk = 10;    // 블럭당 페이지 갯수 (1개의 블럭당 10개의 페이지)
	private int currentPage;		// 현재 페이지 번호
	private int startPage;			// 각 블럭의 시작 페이지
	private int endPage;            // 각 블럭의 끝 페이지
	private int pageCount;			// 총 페이지 수

	public adminPagingPgm(int listcount, int limit, int currentPage) {
		this.listcount = listcount;
		this.limit = limit;
		this.currentPage = currentPage;
		
		pageCount = (int) Math.ceil((double) listcount / limit);
		startPage = currentPage - (currentPage - 1) % pagePerBlk;	// 1,  11, 21...
		endPage = startPage + pagePerBlk - 1;						// 10, 20, 30...
		if (endPage > pageCount)
			endPage = pageCount;
	}
}
