package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Menu;
import com.example.demo.dto.Order;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.dto.ShoppingCart;
import com.example.demo.service.CustomerService;
import com.example.demo.service.MenuService;
import com.example.demo.service.OrderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCustomerController {
	
	private MenuService menuService;
	private OrderService orderService;
	private CustomerService customerService;

	public UsrCustomerController(MenuService menuService, CustomerService customerService, OrderService orderService) {
		this.menuService = menuService;
		this.customerService = customerService;
		this.orderService = orderService;
	}
	
	@GetMapping("/usr/customer/addCart")
	@ResponseBody
	public ResultData addCart(HttpServletRequest req, int menuId) {

		Menu menu = menuService.getMenuById(menuId);

		Rq rq = (Rq) req.getAttribute("rq");
		
		if(rq.getLoginedMemberId() == -1) {
			return ResultData.from("F-2", "로그인 후 이용할 수 있습니다.");
		}
		
	    Order order = orderService.getOrderStatus(rq.getLoginedMemberId());
		
		System.out.println(order);
		
		if(order != null && !order.getOrderStatus().equals("배달 완료")) {
			return ResultData.from("F-2", "주문이 진행중입니다.");
		}
		
		List<ShoppingCart> shoppingCarts = customerService.getSctByLoginedMemberId(rq.getLoginedMemberId());

		if (shoppingCarts != null) {
			for (ShoppingCart shoppingCart : shoppingCarts) {
				if (shoppingCart.getRestaurantId() != menu.getRestaurantId()) {
					return ResultData.from("F-1", "같은 식당의 메뉴만 담을 수 있습니다.");
				} else if (shoppingCart.getMenuId() == menu.getId()) {
					return ResultData.from("S-2", "이미 담은 메뉴", menu);
				}
			}
		}

		customerService.addCart(rq.getLoginedMemberId(), menuId);

		return ResultData.from("S-1", "메뉴를 담았습니다.");
	}

	@GetMapping("/usr/customer/shoppingCart")
	public String shoppingCart(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Menu> menus = customerService.getMenuByLoginedMemberId(rq.getLoginedMemberId());
		int ownerId = 0; 
		if(menus.size() > 0) {
			ownerId = orderService.getOwnerIdByLoginedMemberId(rq.getLoginedMemberId());
		}
		
		model.addAttribute("menus", menus);
		model.addAttribute("ownerId", ownerId);

		return "usr/customer/shoppingCart";
	}

	@GetMapping("/usr/customer/menuDelete")
	public String menuDelete(HttpServletRequest req, Model model, int menuId, Integer restaurantId) {
		Rq rq = (Rq) req.getAttribute("rq");

		customerService.doMenuDelete(rq.getLoginedMemberId(), menuId);

		List<Menu> menus = customerService.getMenuByLoginedMemberId(rq.getLoginedMemberId());
		
		if (restaurantId != null) {
			return String.format("redirect:/usr/restaurant/detail?id=%d", restaurantId);
		}
		model.addAttribute("menus", menus);
		
		return "usr/customer/shoppingCart";
	}

	
}