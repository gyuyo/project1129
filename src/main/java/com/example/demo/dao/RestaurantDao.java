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
					, IFNULL(SUM(l.point), 0) AS `like`
				FROM Restaurant AS r
				INNER JOIN `member` AS m
				ON r.ownerId = m.id
				LEFT JOIN likePoint AS l
				ON l.restaurantId = r.id
				WHERE cgId = #{cgId}
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchType == 'name'">
							AND r.name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
					</choose>
				</if>
				GROUP BY r.id
				ORDER BY r.id DESC
				LIMIT #{limitFrom}, 10
			</script>
			""")
	List<Restaurant> getRestaurantsbyKgId(int cgId, int limitFrom, String searchType, String searchKeyword);
	
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
				WHERE restaurantId = #{getMenusByRestauranId}
			""")
	List<Menu> getMenusByRestauranId(int getMenusByRestauranId);
	
	@Select("""
			SELECT *
				FROM restaurant
				WHERE ownerId = #{loginedMemberId}
			""")
	Restaurant getRestaurantByOwnerId(int loginedMemberId);
}