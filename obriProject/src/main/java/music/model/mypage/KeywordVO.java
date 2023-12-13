package music.model.mypage;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class KeywordVO {
	// JobBoard데이터를 위함
 	private String jobplaceName;
	private String jobcdName;
	
	// prLike 데이터를 위함
	private String prcareerName;
	private String prmajorName;
	private String prlocName;
	private String prhashName;
	
	// msg 데이터를 위함
	private String userRCV;		// 사용자가 받은 메시지함
	private String userSND;		// 사용자가 보낸 메시지함
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startDate;	// 검색 시작 날짜
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endDate;	// 검색 끝 날짜
	
	private String keyInTxt;	// 내용 검색
	
	// 공통
	private Integer page;
	private Integer startNum;   
}
