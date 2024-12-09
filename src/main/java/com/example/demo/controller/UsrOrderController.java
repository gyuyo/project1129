package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Order;
import com.example.demo.dto.OrderMenu;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.CustomerService;
import com.example.demo.service.OrderService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrOrderController {
	
	private OrderService orderService;
	private CustomerService customerService;
	
	public UsrOrderController(OrderService orderService, CustomerService customerService) {
		this.orderService = orderService;
		this.customerService = customerService;
	}
	
	@PostMapping("/usr/order/doOrder")
	@ResponseBody
	public String doOrder(HttpServletRequest req, Model model, String menus, String restaurantId) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		orderService.doOrderDelete(rq.getLoginedMemberId());
		
		String[] rtId = restaurantId.split(",");
		String[] mns = menus.split(",");
		
		for (String str : mns) {
			int menuId = Integer.parseInt(str);
			int quantity = customerService.getQuantityByMenuId(menuId);
			
			customerService.doMenuDelete(rq.getLoginedMemberId() ,menuId);
			orderService.doMenuOrder(rq.getLoginedMemberId() ,menuId, quantity);
		}
		
		orderService.doOrder(rq.getLoginedMemberId(),rtId[0]);
		
		return Util.jsReturn("주문이 접수되었습니다", String.format("/usr/order/orderPage?loginId=%d", rq.getLoginedMemberId()));
	}
	
	@PostMapping("/usr/order/doOrderCancel")
	@ResponseBody
	public String doOrderCancel(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		orderService.doOrderMenuDelete(rq.getLoginedMemberId());
		orderService.doOrderDelete(rq.getLoginedMemberId());
		
		return Util.jsReturn("주문이 취소되었습니다.", "/usr/home/main");
	}
	
	@GetMapping("/usr/order/orderPage")
	public String orderPage(Model model, HttpServletRequest req, int loginId) {
		
		Order order = orderService.getOrderStatus(loginId);
		int totalPrice = orderService.getTotalPriceByOrderId(loginId);
		List<OrderMenu> orderMenus = orderService.getOrderMenus(loginId);
		
		model.addAttribute("order", order);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("orderMenus", orderMenus);
		
		return "usr/order/orderPage";
	}
	
	@GetMapping("/usr/order/addOrderInfo")
	@ResponseBody
	public ResultData addOrderInfo(Model model, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Order order = orderService.getOrderByLoginedMemberId(rq.getLoginedMemberId());
		
		return ResultData.from("S-1", "오더 상태 확인", order);
	}
	
	@GetMapping("/usr/order/orderList")
	public String orderChk(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		List<Order> orders = orderService.gerOrderByOwnerId(rq.getLoginedMemberId());
		int orderMenuCnt = orderService.getOrderMenuCnt(rq.getLoginedMemberId());
		int orderTotalPrice = orderService.getOrderTotalPrice(rq.getLoginedMemberId());
		
		model.addAttribute("orders", orders);
		model.addAttribute("orderMenuCnt", orderMenuCnt);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		
		return "usr/order/orderList";
	}
	
	@GetMapping("/usr/order/orderDetail")
	public String orderDetail(HttpServletRequest req, Model model, int loginId) {
		
		Order order = orderService.getOrderStatus(loginId);
		int totalPrice = orderService.getTotalPriceByOrderId(loginId);
		List<OrderMenu> orderMenus = orderService.getOrderMenus(loginId);
		
		model.addAttribute("order", order);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("orderMenus", orderMenus);
		
		return "usr/order/orderDetail";
	}
}