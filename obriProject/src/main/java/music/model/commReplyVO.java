package music.model;

import java.util.Date;

public class commReplyVO {

	private int commReNo; /* 댓글번호 */
	private int commNo;/* 게시글번호 */
	private String commReId;/* ID */
	private String commReText; /* 내용 */
	private int commReRef;/* ref */
	private int commReReL; /* 댓글레벨 */
	private Date commReDate; /* 작성일 */
	private Date commReUpdate;/* 수정일 */
	private String commReDelYn;/* 삭제여부 */
	
	// 비밀댓글
	private String commSecret;
	
	public String getCommSecret() {
		return commSecret;
	}
	public void setCommSecret(String commSecret) {
		this.commSecret = commSecret;
	}
	public int getCommReNo() {
		return commReNo;
	}
	public void setCommReNo(int commReNo) {
		this.commReNo = commReNo;
	}
	public int getCommNo() {
		return commNo;
	}
	public void setCommNo(int commNo) {
		this.commNo = commNo;
	}
	public String getCommReId() {
		return commReId;
	}
	public void setCommReId(String commReId) {
		this.commReId = commReId;
	}
	public String getCommReText() {
		return commReText;
	}
	public void setCommReText(String commReText) {
		this.commReText = commReText;
	}
	public int getCommReRef() {
		return commReRef;
	}
	public void setCommReRef(int commReRef) {
		this.commReRef = commReRef;
	}
	public int getCommReReL() {
		return commReReL;
	}
	public void setCommReReL(int commReReL) {
		this.commReReL = commReReL;
	}
	public Date getCommReDate() {
		return commReDate;
	}
	public void setCommReDate(Date commReDate) {
		this.commReDate = commReDate;
	}
	public Date getCommReUpdate() {
		return commReUpdate;
	}
	public void setCommReUpdate(Date commReUpdate) {
		this.commReUpdate = commReUpdate;
	}
	public String getCommReDelYn() {
		return commReDelYn;
	}
	public void setCommReDelYn(String commReDelYn) {
		this.commReDelYn = commReDelYn;
	}

}
