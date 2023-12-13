package music.model;

import lombok.Data;

@Data
public class jobAppVO {
	private int appNo;	
	private int jobNo;	
	private String userId;	
	private String appCheck;	
	private String appName;	
	private String appDone;
	private String appDelYn;
	
	// page
	private int startRow;
	private int endRow;
}
