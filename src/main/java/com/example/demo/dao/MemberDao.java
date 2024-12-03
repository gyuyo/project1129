package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Member;

@Mapper
public interface MemberDao {

	@Insert("""
			INSERT INTO `member`
				SET regDate = NOW()
					, updateDate = NOW()
					, accessId = #{accessId}
					, loginId = #{loginId}
					, loginPw = #{loginPw}
					, name = #{name}
					, email = #{email}
			""")
	void joinMember(int accessId, String loginId, String loginPw, String name, String email);

	@Select("""
			SELECT *
				FROM `member`
				WHERE loginId = #{loginId}
			""")
	Member getMemberByLoginId(String loginId);

	@Select("""
			SELECT *
				FROM `member`
				WHERE id = #{id}
			""")
	Member getMemberById(int id);

	@Select("""
			SELECT LAST_INSERT_ID();
			""")
	int getLastInsertId();
	
	@Update("""
			UPDATE `member`
				SET updateDate = NOW()
					, loginPw = #{loginPw}
				WHERE id = #{loginedMemberId}
			""")
	void modifyPassword(int loginedMemberId, String loginPw);
	
	@Select("""
			SELECT *
				FROM `member`
				WHERE `name` = #{name}
				AND email = #{email}
			""")
	Member getMemberByNameAndEmail(String name, String email);
	
	@Select("""
			SELECT *
				FROM reply AS r
				INNER JOIN article AS a
				ON a.id = r.relId
				INNER JOIN `member`AS m
				ON r.memberId = m.id
				WHERE a.id = #{id}
			""")
	List<Member> getMembersById(int id);
	
}