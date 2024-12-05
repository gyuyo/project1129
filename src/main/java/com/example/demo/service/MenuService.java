package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MenuDao;
import com.example.demo.dto.Menu;
import com.example.demo.dto.ShoppingCart;

@Service
public class MenuService {
	
	private MenuDao menuDao;
	
	public MenuService(MenuDao menuDao) {
		this.menuDao = menuDao;
	}
	
	public Menu getMenuById(int menuId) {
		return menuDao.getMenuById(menuId);
	}
	
	public List<ShoppingCart> getSctByLoginedMemberId(int memberId) {
		return menuDao.getSctByLoginedMemberId(memberId);
	}
	
	public void updateQuantity(int menuId, int quantity) {
		menuDao.updateQuantity(menuId, quantity);
	}

	public Menu getTotalPrice(int loginedMemberId) {
		return menuDao.getTotalPrice(loginedMemberId);
	}

}