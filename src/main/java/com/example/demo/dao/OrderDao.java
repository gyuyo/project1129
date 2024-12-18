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
				, orderNum = #{lastOrderNum}
				, quantity = #{quantity}
			""")
	void doMenuOrder(int orderId, int menuId, int lastOrderNum, int quantity);
	
	@Insert("""
			INSERT INTO `order`
				SET orderMemberId = #{orderMemberId}
				, restaurantId = #{restaurantId}
			""")
	void doOrder(int orderMemberId, String restaurantId);
	
	@Select("""
			SELECT id
				FROM `order`
				ORDER BY id DESC
				LIMIT 1
			""")
	int getLastOrderNum();
	
	@Select("""
			SELECT *
				FROM `order`
				WHERE id = #{orderNum}
				ORDER BY id DESC
			""")
	Order getOrderStatus(int orderNum);
	
	@Delete("""
			DELETE FROM `order`
				WHERE id = #{orderNum} 
			""")
	void doOrderDelete(int orderId);
	
	@Select("""
			SELECT * 
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE o.orderNum = #{orderNum}
			""")
	List<OrderMenu> getOrderMenus(int orderNum);
	

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
			WHERE o.id = #{orderNum}
			LIMIT 1
			""")
	int getOwnerIdByOrderNum(int orderNum);
	
	@Select("""
			SELECT IFNULL(SUM(quantity * price),0) AS totalPrice
				FROM orderMenu AS o
				INNER JOIN menu AS m
				ON o.menuId = m.id
				WHERE o.orderNum = #{orderNum}
			""")
	int getTotalPriceByOrderNum(int orderNum);
	
	@Select("""
			SELECT *
				FROM `order`
				WHERE orderMemberId	= #{loginedMemberId}
				ORDER BY id DESC 
				LIMIT 1
			""")
	Order getOrderByLoginedMemberId(int orderNum);
	
	@Delete("""
			DELETE FROM orderMenu
				WHERE orderNum = #{orderNum} 
			""")
	void doOrderMenuDelete(int orderNum);
	
	@Select("""
			SELECT *, SUM(m.price * om.quantity) AS totalPrice
				FROM orderMenu AS om
				INNER JOIN menu AS m
				ON om.menuId = m.id
				INNER JOIN `order` AS o
				ON om.orderNUm = o.id
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
				WHERE id = #{orderNum}
			""")
	void doOrderAccept(int orderNum, String orderStatus);
	
	@Select("""
			SELECT *, SUM(m.price * om.quantity) AS totalPrice
				FROM orderMenu AS om
				INNER JOIN menu AS m
				ON om.menuId = m.id
				INNER JOIN `order` AS o
				ON om.orderNUm = o.id
				INNER JOIN restaurant AS r
				ON o.restaurantId = r.id
				WHERE (o.riderMemberId = -1 AND o.orderStatus = '픽업 대기중')
				OR (o.riderMemberId = #{loginedMemberId})
				GROUP BY o.id
				ORDER BY o.id DESC
			""")
	List<Order> gerOrderByRiderId(int loginedMemberId);
	
	@Update("""
			UPDATE `order`
				SET orderStatus = #{orderStatus},
					riderMemberId = #{loginedMemberId}
				WHERE id = #{orderNum}
			""")
	void doCallAccept(int orderNum, int loginedMemberId, String orderStatus);

}