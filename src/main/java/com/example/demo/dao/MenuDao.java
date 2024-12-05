package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Menu;
import com.example.demo.dto.ShoppingCart;

@Mapper
public interface MenuDao {

	@Select("""
			SELECT *
				FROM menu
				WHERE id = #{menuId}
			""")
	Menu getMenuById(int menuId);
	
	@Select("""
			SELECT *
				FROM shoppingCart AS s
				INNER JOIN menu AS m
				ON s.menuId = m.id
				WHERE s.memberId = #{memberId}
			""")
	List<ShoppingCart> getSctByLoginedMemberId(int memberId);
	
	@Update("""
			UPDATE menu
				SET quantity = #{quantity}
				WHERE id = #{menuId}
			""")
	void updateQuantity(int menuId, int quantity);
	
	@Select("""
			SELECT SUM(price * quantity) AS totalPrice
				FROM shoppingCart AS s
				INNER JOIN menu AS m
				ON s.menuId = m.id
				WHERE s.memberId = #{loginedMemberId}
			""")
	Menu getTotalPrice(int loginedMemberId);

}