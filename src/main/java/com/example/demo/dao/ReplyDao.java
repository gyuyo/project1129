package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Reply;

@Mapper
public interface ReplyDao {
	
	@Insert("""
			INSERT INTO reply
				SET regDate = NOW()
					, updateDate = NOW()
					, memberId = #{loginedMemberId}
					, restaurantId = #{restaurantId}
					, `body` = #{body}
			""")
	public void writeReply(int loginedMemberId, int restaurantId, String body);
	
	@Select("""
			SELECT r.*, m.loginId
				FROM reply AS r
				INNER JOIN `member` AS m
				ON r.memberId = m.id
				WHERE restaurantId = #{restaurantId}
			""")
	public List<Reply> getReplies(int restaurantId);
	
	@Update("""
			UPDATE reply
				SET updatedate = NOW()
					, `body` = #{body}
					WHERE id = #{id}
			""")
	public void modifyReply(int id, String body);
	
	@Delete("""
			DELETE FROM reply
				WHERE id = #{id}
			""")
	public void deleteReply(int id);

}
