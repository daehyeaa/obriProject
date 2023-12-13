package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class jobReplyVO {
	private int jobReNo;
	private int jobNo;
	private String userId;
	private String jobReText;
	private int jobReRef;
	private int jobReLev;	
	private Date jobReDate;
	private Date jobReUpdate;
	private String jobReDelYn;
	
}
