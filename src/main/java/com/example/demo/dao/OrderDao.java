package com.example.demo.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Order;

@Mapper
public interface OrderDao {
	
	@Insert("""
			INSERT INTO orderMenu
				SET orderId = #{orderId}
				, menuId = #{menuId}
			""")
	void doMenuOrder(int orderId, int menuId);
	
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
	
}