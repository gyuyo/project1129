package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Order;
import com.example.demo.dto.OrderMenu;

@Mapper
public interface OrderDao {
	
	@Insert("""
			INSERT INTO orderMenu
				SET orderId = #{orderId}
				, menuId = #{menuId}
				, quantity = #{quantity}
			""")
	void doMenuOrder(int orderId, int menuId, int quantity);
	
	@Insert("""
			INSERT INTO `order`
				SET orderMemberId = #{orderMemberId}
				, restaurantId = #{restaurantId}
			""")
	void doOrder(int orderMemberId, String restaurantId);
	
	@Select("""
			SELECT *
				FROM `order`
				WHERE orderMemberId = #{loginedMemberId}
			""")
	Order getOrderStatus(int loginedMemberId);
	
	@Delete("""
			DELETE FROM `order`
				WHERE orderMemberId = #{loginedMemberId} 
			""")
	void doOrderDelete(int loginedMemberId);
	
	@Select("""
			SELECT * 
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE orderId = #{loginedMemberId}
			""")
	List<OrderMenu> getOrderMenus(int loginedMemberId);
	
	@Select("""
			SELECT SUM(quantity * price) AS totalPrice
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE orderId = #{loginedMemberId}
			""")
	int getTotalPriceByOrderId(int loginedMemberId);
	
	@Select("""
			SELECT *
				FROM `order`
				WHERE orderMemberId	= #{loginedMemberId}
			""")
	Order getOrderByLoginedMemberId(int loginedMemberId);
	
	@Delete("""
			DELETE FROM orderMenu
				WHERE orderId = #{loginedMemberId} 
			""")
	void doOrderMenuDelete(int loginedMemberId);
	
	@Select("""
			SELECT *
				FROM `order` AS o
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				WHERE r.memberId = #{loginedMemberId}
			""")
	List<Order> gerOrderByOwnerId(int loginedMemberId);
	
	@Select("""
			SELECT SUM(om.quantity)
				FROM `order` AS o
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				INNER JOIN orderMenu AS om
				ON o.id = om.orderId
				WHERE r.memberId = #{loginedMemberId}
			""")
	int getOrderMenuCnt(int loginedMemberId);
	
	@Select("""
			SELECT SUM(quantity * price)
				FROM `order` AS o
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				INNER JOIN orderMenu AS om
				ON o.id = om.orderId
				INNER JOIN menu AS m
				ON om.menuId = m.id
				WHERE r.memberId = #{loginedMemberId}
			""")
	int getOrderTotalPrice(int loginedMemberId);
	
}