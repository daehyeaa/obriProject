package music.model;

import java.util.Date;

public class communityVO {

	private int commNo;
	private String userId;
	private String commSub;
	private String commText;
	private int commCount;
	private String commFile;
	private Date commDate;
	private Date commUpdate;
	private String commDelYn;

	// page
	private int startRow;
	private int endRow;

	// 검색
	private String search;
	private String keyword;

	// 좋아요 수
	private int likeCnt;

	// 최신순,조회순,좋아요순 정렬
	private String sort;

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getCommNo() {
		return commNo;
	}

	public void setCommNo(int commNo) {
		this.commNo = commNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommSub() {
		return commSub;
	}

	public void setCommSub(String commSub) {
		this.commSub = commSub;
	}

	public String getCommText() {
		return commText;
	}

	public void setCommText(String commText) {
		this.commText = commText;
	}

	public int getCommCount() {
		return commCount;
	}

	public void setCommCount(int commCount) {
		this.commCount = commCount;
	}

	public String getCommFile() {
		return commFile;
	}

	public void setCommFile(String commFile) {
		this.commFile = commFile;
	}

	public Date getCommDate() {
		return commDate;
	}

	public void setCommDate(Date commDate) {
		this.commDate = commDate;
	}

	public Date getCommUpdate() {
		return commUpdate;
	}

	public void setCommUpdate(Date commUpdate) {
		this.commUpdate = commUpdate;
	}

	public String getCommDelYn() {
		return commDelYn;
	}

	public void setCommDelYn(String commDelYn) {
		this.commDelYn = commDelYn;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

}
