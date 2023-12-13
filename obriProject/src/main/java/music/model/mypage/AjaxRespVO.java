package music.model.mypage;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AjaxRespVO<T> {
	private Integer code; // 1정상, -1실패
	private String msg; // 실패의 이유, 성공한 이유
	private T data; // 응답할 데이터
}
