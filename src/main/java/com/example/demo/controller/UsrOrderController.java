package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Menu;
import com.example.demo.dto.Order;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.service.MenuService;
import com.example.demo.service.OrderService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;

@Controller
public class UsrOrderController {
	
	private OrderService orderService;
	private MemberService memberService;
	private MenuService menuService;
	
	public UsrOrderController(OrderService orderService, MemberService memberService, MenuService menuService) {
		this.orderService = orderService;
		this.memberService = memberService;
		this.menuService = menuService;
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
//			memberService.doMenuDelete(menuId);
			orderService.doMenuOrder(rq.getLoginedMemberId() ,menuId);
		}
		
		orderService.doOrder(rq.getLoginedMemberId(),rtId[0]);
		
		return Util.jsReturn("주문이 접수되었습니다", String.format("/usr/member/orderPage?id=%d", rq.getLoginedMemberId()));
	}
	
	@PostMapping("/usr/order/doOrderCancel")
	@ResponseBody
	public String doOrderCancel(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		memberService.doMenuDelete(rq.getLoginedMemberId());
		orderService.doOrderDelete(rq.getLoginedMemberId());
		
		return Util.jsReturn("주문이 취소되었습니다.", "/usr/home/main");
	}
	
	@GetMapping("/usr/member/orderPage")
	public String orderPage(Model model, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Order order = orderService.getOrderStatus(rq.getLoginedMemberId());
		List<Menu> menus = memberService.getMenuByLoignedMemberId(rq.getLoginedMemberId());
		Menu totalPrice = menuService.getTotalPrice(rq.getLoginedMemberId());
		
		model.addAttribute("order", order);
		model.addAttribute("menus", menus);
		model.addAttribute("totalPrice", totalPrice);
		
		return "usr/member/orderPage";
	}
	
}