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
				ORDER BY id DESC
				limit 1
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
			SELECT ownerID
			FROM restaurant AS r
			INNER JOIN menu AS m
			ON r.id = m.restaurantId
			INNER JOIN shoppingCart AS s
			ON m.id = s.menuId
			WHERE s.memberId = #{loginedMemberId}
			LIMIT 1
			""")
	int getOwnerIdByLoginedMemberId(int loginedMemberId);
	
	@Select("""
			SELECT ownerID
			FROM restaurant AS r
			INNER JOIN `order` AS o
			ON r.id = o.restaurantId
			WHERE o.orderMemberId = #{orderId}
			LIMIT 1
			""")
	int getOwnerIdByOrderId(int orderId);
	
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
				ORDER BY id DESC 
				LIMIT 1
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
				GROUP BY o.id
				ORDER BY o.id DESC
			""")
	List<Order> gerOrderByOwnerId(int loginedMemberId);
	
	@Update("""
			UPDATE `order`
				SET orderStatus = #{orderStatus}
				WHERE orderMemberId = #{orderId}
			""")
	void doOrderAccept(int orderId, String orderStatus);
	
	@Select("""
			SELECT *, SUM(om.quantity) AS quantity, SUM(m.price * om.quantity) AS totalPrice
				FROM orderMenu AS om
				INNER JOIN menu AS m
				ON om.menuId = m.id
				INNER JOIN `order` AS o
				ON om.orderId = o.orderMemberId
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				WHERE (o.riderMemberId = -1 AND o.orderStatus = '픽업 대기중')
				OR (o.riderMemberId = 3)
				GROUP BY o.id
				ORDER BY o.id DESC
			""")
	List<Order> gerOrderByRiderId(int loginedMemberId);
	
	@Update("""
			UPDATE `order`
				SET orderStatus = #{orderStatus},
					riderMemberId = #{loginedMemberId}
				WHERE orderMemberId = #{orderId}
			""")
	void doCallAccept(int orderId, int loginedMemberId, String orderStatus);
	
}