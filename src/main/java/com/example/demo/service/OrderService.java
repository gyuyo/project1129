package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.OrderDao;
import com.example.demo.dto.Member;
import com.example.demo.dto.Order;
import com.example.demo.dto.OrderMenu;
import com.example.demo.dto.Restaurant;

@Service
public class OrderService {
	
	private OrderDao orderDao;
	
	public OrderService(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	public void doMenuOrder(int orderId, int menuId, int lastOrderNum, int quantity) {
		orderDao.doMenuOrder(orderId, menuId, lastOrderNum, quantity);
	}

	public void doOrder(int orderMemberId, String restaurantId) {
		orderDao.doOrder(orderMemberId, restaurantId);
	}

	public Order getOrderByOrderId(int orderMemberId) {
		return orderDao.getOrderByOrderId(orderMemberId);
	}
	
	public Order getOrderStatus(int orderNum) {
		return orderDao.getOrderStatus(orderNum);
	}

	public void doOrderDelete(int orderNum) {
		orderDao.doOrderDelete(orderNum);
	}

	public void doOrderMenuDelete(int orderNum) {
		orderDao.doOrderMenuDelete(orderNum);
	}
	
	public List<OrderMenu> getOrderMenus(int orderNum) {
		return orderDao.getOrderMenus(orderNum);
	}

	public int getOwnerIdByLoginedMemberId(int loginedMemberId) {
		return orderDao.getOwnerIdByLoginedMemberId(loginedMemberId);
	}
	public int getTotalPriceByOrderNum(int orderNum) {
		return orderDao.getTotalPriceByOrderNum(orderNum);
	}

	public Order getOrderByLoginedMemberId(int loginedMemberId) {
		return orderDao.getOrderByLoginedMemberId(loginedMemberId);
	}

	public List<Order> gerOrderByOwnerId(int loginedMemberId) {
		return orderDao.gerOrderByOwnerId(loginedMemberId);
	}

	public void doOrderAccept(int orderNum, String orderStatus) {
		orderDao.doOrderAccept(orderNum, orderStatus);
	}

	public List<Order> gerOrderByRiderId(int loginedMemberId) {
		return orderDao.gerOrderByRiderId(loginedMemberId);
	}

	public int getOwnerIdByOrderNum(int orderNum) {
		return orderDao.getOwnerIdByOrderNum(orderNum);
	}

	public void doCallAccept(int orderNum, int loginedMemberId, String orderStatus) {
		orderDao.doCallAccept(orderNum, loginedMemberId, orderStatus);
	}

	public int getLastOrderNum() {
		return orderDao.getLastOrderNum();
	}

	public Restaurant getAddressbyOrderNum(int orderNum) {
		return orderDao.getAddressbyOrderNum(orderNum);
	}

	public Member getMemberAddressbyOrderNum(int orderNum) {
		return orderDao.getMemberAddressbyOrderNum(orderNum);
	}
}