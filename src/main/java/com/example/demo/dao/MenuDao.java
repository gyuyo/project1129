package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Menu;

@Mapper
public interface MenuDao {

	@Select("""
			SELECT *
				FROM menu
				WHERE id = #{menuId}
			""")
	Menu getMenuById(int menuId);
	
	@Update("""
			UPDATE shoppingCart
				SET quantity = #{quantity}
				WHERE menuId = #{menuId}
			""")
	void updateQuantity(int menuId, int quantity);
	
	@Select("""
			SELECT IFNULL(SUM(price * quantity),0) AS totalPrice
				FROM shoppingCart AS s
				INNER JOIN menu AS m
				ON s.menuId = m.id
				WHERE s.memberId = #{loginedMemberId}
			""")
	Menu getTotalPriceByLoginedId(int loginedMemberId);
	
	@Update("""
			UPDATE menu
				SET menuName = #{menuName}
					, `description` = #{menuDescription}
					, price = #{menuPrice}
					, readyTime = #{readyTime}
					WHERE id = #{menuId}  
			""")
	void doModifyMenu(int menuId, String menuName, String menuDescription, int menuPrice, int readyTime);

}