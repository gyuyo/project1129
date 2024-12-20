package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Member;
import com.example.demo.dto.Order;
import com.example.demo.dto.Restaurant;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.OrderService;

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
		
		Restaurant restaurant = orderService.getAddressbyOrderNum(orderNum);
		int ownerId = orderService.getOwnerIdByOrderNum(orderNum);
		Order order = orderService.getOrderStatus(orderNum);
		Member member = orderService.getMemberAddressbyOrderNum(orderNum);
		
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("ownerId", ownerId);
		model.addAttribute("order", order);
		model.addAttribute("member", member);
		
		return "usr/rider/deliveryDetail";
	}
	
	@GetMapping("/usr/rider/doCallAccept")
	@ResponseBody
	public ResultData doCallAccept(HttpServletRequest req, int orderNum) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		orderService.doCallAccept(orderNum, rq.getLoginedMemberId(),"배달 준비중");
		
		return ResultData.from("S-1", "픽업 출발");
	}
	
	@GetMapping("/usr/rider/doDelivery")
	@ResponseBody
	public ResultData doDelivery(int orderNum) {
		
		orderService.doOrderAccept(orderNum, "배달 중");
		
		return ResultData.from("S-1", "배달 출발");
	}
	
	@GetMapping("/usr/rider/deliveryEnd")
	@ResponseBody
	public ResultData deliveryEnd(int orderNum) {
		
		orderService.doOrderAccept(orderNum, "배달 완료");
		
		return ResultData.from("S-1", "배달 중");
	}

}