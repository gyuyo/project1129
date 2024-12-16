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

	public Order getOrderStatus(int orderId) {
		return orderDao.getOrderStatus(orderId);
	}

	public void doOrderDelete(int orderId) {
		orderDao.doOrderDelete(orderId);
	}

	public void doOrderMenuDelete(int orderId) {
		orderDao.doOrderMenuDelete(orderId);
	}
	
	public List<OrderMenu> getOrderMenus(int orderId) {
		return orderDao.getOrderMenus(orderId);
	}

	public int getOwnerIdByLoginedMemberId(int loginedMemberId) {
		return orderDao.getOwnerIdByLoginedMemberId(loginedMemberId);
	}
	public int getTotalPriceByOrderId(int orderId) {
		return orderDao.getTotalPriceByOrderId(orderId);
	}

	public Order getOrderByLoginedMemberId(int loginedMemberId) {
		return orderDao.getOrderByLoginedMemberId(loginedMemberId);
	}

	public List<Order> gerOrderByOwnerId(int loginedMemberId) {
		return orderDao.gerOrderByOwnerId(loginedMemberId);
	}

	public void doOrderAccept(int orderId, String orderStatus) {
		orderDao.doOrderAccept(orderId, orderStatus);
	}

	public List<Order> gerOrderByRiderId(int loginedMemberId) {
		return orderDao.gerOrderByRiderId(loginedMemberId);
	}

	public int getOwnerIdByOrderId(int orderId) {
		return orderDao.getOwnerIdByOrderId(orderId);
	}

	public void doCallAccept(int orderId, int loginedMemberId, String orderStatus) {
		orderDao.doCallAccept(orderId, loginedMemberId, orderStatus);
	}
}