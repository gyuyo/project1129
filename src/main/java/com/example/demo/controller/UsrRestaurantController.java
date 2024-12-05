package com.example.demo.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Category;
import com.example.demo.dto.Menu;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Restaurant;
import com.example.demo.dto.Rq;
import com.example.demo.dto.ShoppingCart;
import com.example.demo.service.MenuService;
import com.example.demo.service.ReplyService;
import com.example.demo.service.RestaurantService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrRestaurantController {
	private RestaurantService restaurantService;
	private ReplyService replyService;
	private MenuService menuService;
	
	
	public UsrRestaurantController(RestaurantService restaurantService, ReplyService replyService, MenuService menuService) {
		this.restaurantService = restaurantService;
		this.replyService = replyService;
		this.menuService = menuService;
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
	public String list(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		List<Menu> menus = restaurantService.getMenusByRestauranId(id);
		List<Reply> replies = replyService.getRepliesByRestauranId(id);
		Restaurant restaurant = restaurantService.getRestauranById(id);
		List<ShoppingCart> shoppingCarts = menuService.getSctByLoginedMemberId(rq.getLoginedMemberId());
		
		Collections.reverse(replies);
		
		model.addAttribute("menus", menus);
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("replies", replies);
		model.addAttribute("shoppingCarts", shoppingCarts);
		
		return "usr/restaurant/detail";
	}
}
