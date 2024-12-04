package com.example.demo.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.LikePoint;

@Mapper
public interface LikePointDao {

	@Insert("""
			INSERT INTO likePoint
				SET memberId = #{loginedMemberId}
					, restaurantId = #{restaurantId}
			""")
	void insertLikePoint(int loginedMemberId, int restaurantId);

	@Select("""
			SELECT *
				FROM likePoint
				WHERE memberId = #{loginedMemberId}
				AND restaurantId = #{restaurantId}
			""")
	LikePoint getLikePoint(int loginedMemberId, int restaurantId);

	@Delete("""
			DELETE FROM likePoint
				WHERE memberId = #{loginedMemberId}
				AND restaurantId = #{restaurantId}
			""")
	void deleteLikePoint(int loginedMemberId, int restaurantId);

	@Select("""
			SELECT IFNULL(SUM(point), 0)
				FROM likePoint
				WHERE restaurantId = #{restaurantId}
			""")
	int getLikePointCnt(int restaurantId);
}