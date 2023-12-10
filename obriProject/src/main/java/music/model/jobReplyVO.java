package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class jobReplyVO {
	private int jobReNo;
	private String jobNo;
	private String userId;
	private String jobReText;
	private int jobReRef;
	private int jobReRel;
	private Date jobReDate;
	private Date jobReUpdate;
	private String jobReDelYn;
}
