package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.OrderDao;
import com.example.demo.dto.Order;
import com.example.demo.dto.OrderMenu;

@Service
public class OrderService {
	
	private OrderDao orderDao;
	
	public OrderService(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	public void doMenuOrder(int orderId, int menuId, int quantity) {
		orderDao.doMenuOrder(orderId, menuId, quantity);
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

	public void doOrderMenuDelete(int loginedMemberId) {
		orderDao.doOrderMenuDelete(loginedMemberId);
	}
	
	public List<OrderMenu> getOrderMenus(int loginedMemberId) {
		return orderDao.getOrderMenus(loginedMemberId);
	}

	public int getTotalPriceByOrderId(int loginedMemberId) {
		return orderDao.getTotalPriceByOrderId(loginedMemberId);
	}

	public Order getOrderByLoginedMemberId(int loginedMemberId) {
		return orderDao.getOrderByLoginedMemberId(loginedMemberId);
	}

	public List<Order> gerOrderByOwnerId(int loginedMemberId) {
		return orderDao.gerOrderByOwnerId(loginedMemberId);
	}

	public int getOrderMenuCnt(int loginedMemberId) {
		return orderDao.getOrderMenuCnt(loginedMemberId);
	}

	public int getOrderTotalPrice(int loginedMemberId) {
		return orderDao.getOrderTotalPrice(loginedMemberId);
	}
}