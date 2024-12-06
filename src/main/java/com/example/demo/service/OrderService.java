package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.LikePointDao;
import com.example.demo.dao.OrderDao;
import com.example.demo.dto.LikePoint;
import com.example.demo.dto.Order;

@Service
public class OrderService {
	
	private OrderDao orderDao;
	
	public OrderService(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	public void doMenuOrder(int orderId, int menuId) {
		orderDao.doMenuOrder(orderId, menuId);
	}

	public void doOrder(int orderMemberId, String restaurantId) {
		orderDao.doOrder(orderMemberId, restaurantId);
	}

	public Order getOrderStatus(int loginedMemberId) {
		return orderDao.getOrderStatus(loginedMemberId);
	}

	public void doOrderDelete(int loginedMemberId) {
		orderDao.doOrderDelete(loginedMemberId);
	}
	
}