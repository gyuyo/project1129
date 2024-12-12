package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
				WHERE orderMemberId = #{orderId}
			""")
	Order getOrderStatus(int orderId);
	
	@Delete("""
			DELETE FROM `order`
				WHERE orderMemberId = #{orderId} 
			""")
	void doOrderDelete(int orderId);
	
	@Select("""
			SELECT * 
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE orderId = #{orderId}
			""")
	List<OrderMenu> getOrderMenus(int orderId);
	
	@Select("""
			SELECT IFNULL(SUM(quantity * price),0) AS totalPrice
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE o.orderId = #{orderId}
			""")
	int getTotalPriceByOrderId(int orderId);
	
	@Select("""
			SELECT *
				FROM `order`
				WHERE orderMemberId	= #{loginedMemberId}
			""")
	Order getOrderByLoginedMemberId(int loginedMemberId);
	
	@Delete("""
			DELETE FROM orderMenu
				WHERE orderId = #{orderId} 
			""")
	void doOrderMenuDelete(int orderId);
	
	@Select("""
			SELECT * , SUM(om.quantity) AS quantity, SUM(m.price * om.quantity) AS totalPrice
				FROM orderMenu AS om
				INNER JOIN menu AS m
				ON om.menuId = m.id
				INNER JOIN `order` AS o
				ON om.orderId = o.orderMemberId
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				WHERE r.ownerId = #{loginedMemberId}
				GROUP BY o.orderMemberId
			""")
	List<Order> gerOrderByOwnerId(int loginedMemberId);
	
	@Update("""
			UPDATE `order`
				SET orderStatus = #{orderStatus}
				WHERE orderMemberId = #{orderId}
			""")
	void doOrderAccept(int orderId, String orderStatus);
	
}