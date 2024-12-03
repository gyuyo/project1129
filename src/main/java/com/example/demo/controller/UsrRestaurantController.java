package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Category;
import com.example.demo.dto.Menu;
import com.example.demo.dto.Restaurant;
import com.example.demo.service.RestaurantService;

@Controller
public class UsrRestaurantController {
	private RestaurantService restaurantService;

	public UsrRestaurantController(RestaurantService restaurantService) {
		this.restaurantService = restaurantService;
	}

	@GetMapping("/usr/restaurant/list")
	public String list(Model model, int cgId, @RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "title") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Category category = restaurantService.getCategoryById(cgId);

		int limitFrom = (cPage - 1) * 10;

		List<Restaurant> restaurants = restaurantService.getRestaurantsbyKgId(cgId, limitFrom, searchType, searchKeyword);
		int restaurantsCnt = restaurantService.getRestauransCnt(cgId, searchType, searchKeyword);

		int totalPagesCnt = (int) Math.ceil((double) restaurantsCnt / 10);

		int from = ((cPage - 1) / 10) * 10 + 1;
		int end = (((cPage - 1) / 10) + 1) * 10;

		if (end > totalPagesCnt) {
			end = totalPagesCnt;
		}

		model.addAttribute("restaurants", restaurants);
		model.addAttribute("category", category);
		model.addAttribute("restaurantsCnt", restaurantsCnt);
		model.addAttribute("totalPagesCnt", totalPagesCnt);
		model.addAttribute("from", from);
		model.addAttribute("end", end);
		model.addAttribute("cPage", cPage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

		return "usr/restaurant/list";
	}

	@GetMapping("/usr/restaurant/detail")
	public String list(Model model, int id) {
		
		List<Menu> menus = restaurantService.getMenusById(id);
		
		Restaurant restaurant = restaurantService.getRestauranById(id);

		model.addAttribute("menus", menus);
		model.addAttribute("restaurant", restaurant);

		return "usr/restaurant/detail";
	}
}
