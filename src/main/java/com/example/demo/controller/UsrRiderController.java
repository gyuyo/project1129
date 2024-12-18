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
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrRiderController {
	
	private OrderService orderService;
	
	public UsrRiderController(OrderService orderService) {
		this.orderService = orderService;
	}
	
	@GetMapping("/usr/rider/callList")
	public String callList() {
		return "usr/rider/callList";
	}
	
	@GetMapping("/usr/rider/getCallList")
	@ResponseBody
	public ResultData<List<Order>> getCallList(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		List<Order> orders = orderService.gerOrderByRiderId(rq.getLoginedMemberId());
		
		model.addAttribute("orders", orders);
		
		return ResultData.from("S-1", "오더 상태 확인", orders);
	}
	
	@GetMapping("/usr/rider/deliveryDetail")
	public String deliveryDetail(Model model, int orderNum) {
		
		int ownerId = orderService.getOwnerIdByOrderNum(orderNum);
		Order order = orderService.getOrderStatus(orderNum);
		
		model.addAttribute("ownerId", ownerId);
		model.addAttribute("order", order);
		
		return "usr/rider/deliveryDetail";
	}
	
	@GetMapping("/usr/rider/doCallAccept")
	@ResponseBody
	public String doCallAccept(HttpServletRequest req, int orderNum) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		orderService.doCallAccept(orderNum, rq.getLoginedMemberId(),"배달 준비중");
		
		return Util.jsReturn("배달 콜을 접수하였습니다.", String.format("/usr/rider/deliveryDetail?orderNum=%d",orderNum));
	}
	
	@GetMapping("/usr/rider/doDelivery")
	@ResponseBody
	public String doDelivery(int orderNum) {
		
		orderService.doOrderAccept(orderNum, "배달 중");
		
		return Util.jsReturn("배달이 시작되었습니다.", String.format("/usr/rider/deliveryDetail?orderNum=%d",orderNum));
	}
	
	@GetMapping("/usr/rider/deliveryEnd")
	@ResponseBody
	public String deliveryEnd(int orderNum) {
		
		orderService.doOrderAccept(orderNum, "배달 완료");
		
		return Util.jsReturn("배달이 완료되었습니다.", "/usr/home/main");
	}

}