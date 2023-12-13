package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class adminVO {
	private String adminId;
	private String adminPw;
	private String adminName;
	private Date adminDate;
	private Date adminUpdate;
	private String adminDelYn;
}