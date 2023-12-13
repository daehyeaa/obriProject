package music.model;

public class commLikeVO {

	private String commLikeNo;		
	private int commNo;				// 필요 foreign
	private String commLike;
	private String userId;			// 필요 primary
	
	public int getCommNo() {
		return commNo;
	}
	public void setCommNo(int commNo) {
		this.commNo = commNo;
	}
	public String getCommLikeNo() {
		return commLikeNo;
	}
	public void setCommLikeNo(String commLikeNo) {
		this.commLikeNo = commLikeNo;
	}
	public String getCommLike() {
		return commLike;
	}
	public void setCommLike(String commLike) {
		this.commLike = commLike;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}
	
	