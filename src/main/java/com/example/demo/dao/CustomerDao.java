package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Menu;
import com.example.demo.dto.ShoppingCart;

@Mapper
public interface CustomerDao {
	
	@Select("""
			SELECT *
				FROM shoppingCart AS s
				INNER JOIN menu AS m
				ON s.menuId = m.id
				WHERE s.memberId = #{memberId}
			""")
	List<ShoppingCart> getSctByLoginedMemberId(int memberId);
	
	@Insert("""
			INSERT INTO shoppingCart
				SET memberId = #{loginedMemberId}
					, menuId = #{menuId}
			""")
	void addCart(int loginedMemberId, int menuId);

	@Select("""
			SELECT *
				FROM shoppingCart AS s
				INNER JOIN menu AS m
				ON s.menuId = m.id
				WHERE s.memberId = #{loginedMemberId}
			""")
	List<Menu> getMenuByLoginedMemberId(int loginedMemberId);
	
	@Select("""
			SELECT quantity
				FROM shoppingCart
				WHERE menuId = #{menuId}
			""")
	int getQuantityByMenuId(int menuId);
	
	@Delete("""
			DELETE FROM shoppingCart
				WHERE menuId = #{menuId}
				AND memberId = #{memberId}
			""")
	void doMenuDelete(int memberId, int menuId);
}