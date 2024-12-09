package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MenuDao;
import com.example.demo.dto.Menu;

@Service
public class MenuService {
	
	private MenuDao menuDao;
	
	public MenuService(MenuDao menuDao) {
		this.menuDao = menuDao;
	}
	
	public Menu getMenuById(int menuId) {
		return menuDao.getMenuById(menuId);
	}
	
	public void updateQuantity(int menuId, int quantity) {
		menuDao.updateQuantity(menuId, quantity);
	}

	public Menu getTotalPriceByLoginedId(int loginedMemberId) {
		return menuDao.getTotalPriceByLoginedId(loginedMemberId);
	}

}