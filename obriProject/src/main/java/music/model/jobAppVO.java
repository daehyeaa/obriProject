package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class jobAppVO {
	private int appNo;
	private int jobNo;
	private String userId;
	private String appCheck;
	private String appName;
	private String appDoen;
	private String appDelYn;
	
	// page
	private int startRow;
	private int endRow;

	
}