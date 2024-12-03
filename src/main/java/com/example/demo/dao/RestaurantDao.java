package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Category;
import com.example.demo.dto.Menu;
import com.example.demo.dto.Restaurant;

@Mapper
public interface RestaurantDao {
	
	@Select("""
			<script>
			SELECT r.*
					, m.loginId
				FROM Restaurant AS r
				INNER JOIN `member` AS m
				ON r.memberId = m.id
				WHERE cgId = #{cgId}
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchType == 'name'">
							AND r.name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
					</choose>
				</if>
				ORDER BY r.id DESC
				LIMIT #{limitFrom}, 10
			</script>
			""")
	List<Restaurant> getRestaurantsbyKgId(int cgId, int limitFrom, String searchType, String searchKeyword);
	
//				SELECT a.*
//					, m.loginId
//					, IFNULL(SUM(l.point), 0) AS `like`
//				FROM article AS a
//				INNER JOIN `member` AS m
//				ON a.memberId = m.id
//				LEFT JOIN likePoint AS l
//				ON l.relTypeCode = 'article'
//				GROUP BY a.id
//				
//				

	@Select("""
			<script>
			SELECT COUNT(id)
				FROM Restaurant
				WHERE cgId = #{cgId}
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchType == 'name'">
							AND `name` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
					</choose>
				</if>
			</script>
			""")
	int getRestauransCnt(int cgId, String searchType, String searchKeyword);

	
	@Select("""
			SELECT * 
				FROM Category
				WHERE id = #{cgId}
			""")
	Category getCategoryById(int cgId);
	
	@Select("""
			SELECT * 
				FROM Restaurant
				WHERE id = #{id}
			""")
	Restaurant getRestauranById(int id);
	
	@Select("""
			SELECT * 
				FROM menu
				WHERE restaurantId = #{id}
			""")
	List<Menu> getMenusById(int id);
}