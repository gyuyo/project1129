package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.RestaurantDao;
import com.example.demo.dto.Category;
import com.example.demo.dto.Menu;
import com.example.demo.dto.Restaurant;

@Service
public class RestaurantService {

	private RestaurantDao restaurantDao;

	public RestaurantService(RestaurantDao restaurantDao) {
		this.restaurantDao = restaurantDao;
	}

	public List<Restaurant> getRestaurantsbyKgId(int cgId, int limitFrom, String searchType, String searchKeyword) {
		return restaurantDao.getRestaurantsbyKgId(cgId, limitFrom, searchType, searchKeyword);
	}

	public int getRestauransCnt(int cgId, String searchType, String searchKeyword) {
		return restaurantDao.getRestauransCnt(cgId, searchType, searchKeyword);
	}

	public Category getCategoryById(int cgId) {
		return restaurantDao.getCategoryById(cgId);
	}

	public Restaurant getRestauranById(int id) {
		return restaurantDao.getRestauranById(id);
	}

	public List<Menu> getMenusByRestauranId(int getMenusByRestauranId) {
		return restaurantDao.getMenusByRestauranId(getMenusByRestauranId);
	}

	public Restaurant getRestaurantByOwnerId(int loginedMemberId) {
		return restaurantDao.getRestaurantByOwnerId(loginedMemberId);
	}

}