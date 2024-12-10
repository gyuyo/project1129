package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.CustomerDao;
import com.example.demo.dto.Menu;
import com.example.demo.dto.ShoppingCart;

@Service
public class CustomerService {
	private CustomerDao customerDao;
	
	public CustomerService(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}
	
	public List<ShoppingCart> getSctByLoginedMemberId(int memberId) {
		return customerDao.getSctByLoginedMemberId(memberId);
	}

	public void addCart(int loginedMemberId, int menuId) {
		customerDao.addCart(loginedMemberId, menuId);
	}

	public List<Menu> getMenuByLoginedMemberId(int loginedMemberId) {
		return customerDao.getMenuByLoginedMemberId(loginedMemberId);
	}

	public int getQuantityByMenuId(int menuId) {
		return customerDao.getQuantityByMenuId(menuId);
	}
	
	public void doMenuDelete(int memberId, int menuId) {
		customerDao.doMenuDelete(memberId, menuId);
	}

	public int getOwnerIdByLoginedMemberId(int loginedMemberId) {
		return customerDao.getOwnerIdByLoginedMemberId(loginedMemberId);
	}
}