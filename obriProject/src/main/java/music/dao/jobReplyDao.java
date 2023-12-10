package music.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import music.model.jobReplyVO;

@Mapper
public interface jobReplyDao {

	List<jobReplyVO> list(int jobNo);

	void insert(jobReplyVO rv);

	void delete(jobReplyVO rv);

	void update(jobReplyVO rv);
	
}
