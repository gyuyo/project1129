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
	public String doOrder(HttpServletRequest req,String menus, String restaurantId) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		String[] rtId = restaurantId.split(",");
		String[] mns = menus.split(",");
		
		orderService.doOrder(rq.getLoginedMemberId(),rtId[0]);
		
		for (String str : mns) {
			int lastOrderNum = orderService.getLastOrderNum();
			int menuId = Integer.parseInt(str);
			int quantity = customerService.getQuantityByMenuId(menuId);
			
			customerService.doMenuDelete(rq.getLoginedMemberId() ,menuId);
			orderService.doMenuOrder(rq.getLoginedMemberId() ,menuId, lastOrderNum, quantity);
		}
		
		return Util.jsReturn("주문이 접수되었습니다", String.format("/usr/order/orderPage?loginId=%d", rq.getLoginedMemberId()));
	}
	
	@GetMapping("/usr/order/doOrderAccept")
	@ResponseBody
	public String doOrderAccept(int orderNum) {
		
		orderService.doOrderAccept(orderNum, "요리 중");
		
		return Util.jsReturn("주문이 확인되었습니다.", String.format("/usr/order/orderDetail?orderNum=%d",orderNum));
	}
	
	@GetMapping("/usr/order/orderPage")
	public String orderPage(Model model) {
		
		int lastOrderNum = orderService.getLastOrderNum();
		
		int ownerId = orderService.getOwnerIdByOrderNum(lastOrderNum);
		Order order = orderService.getOrderStatus(lastOrderNum);
		int totalPrice = orderService.getTotalPriceByOrderNum(lastOrderNum);
		List<OrderMenu> orderMenus = orderService.getOrderMenus(lastOrderNum);
		
		model.addAttribute("ownerId", ownerId);
		model.addAttribute("order", order);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("orderMenus", orderMenus);
		
		return "usr/order/orderPage";
	}
	
	@GetMapping("/usr/order/updateOrder")
	@ResponseBody
	public ResultData<Order> updateOrder(int orderNum) {
		
		Order order = orderService.getOrderStatus(orderNum);
		
		if(order == null){
			return ResultData.from("S-1", "오더 없음");
		}
		
		return ResultData.from("S-1", "오더 상태 확인", order);
	}
	
	@GetMapping("/usr/order/addOrderInfo")
	@ResponseBody
	public ResultData<Order> addOrderInfo(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Order order = orderService.getOrderByLoginedMemberId(rq.getLoginedMemberId());
		
		if (order == null || "배달 완료".equals(order.getOrderStatus())) {
		    return ResultData.from("S-1", "오더 상태 확인");
		}
		
		return ResultData.from("S-1", "오더 상태 확인", order);
	}
	
	@GetMapping("/usr/order/orderList")
	public String orderList() {
		return "usr/order/orderList";
	}
	
	@GetMapping("/usr/order/getOrderList")
	@ResponseBody
	public ResultData<List<Order>> getOrderList(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		List<Order> orders = orderService.gerOrderByOwnerId(rq.getLoginedMemberId());
		
		return ResultData.from("S-1", "오더 상태 확인", orders);
	}
	
	@GetMapping("/usr/order/orderDetail")
	public String orderDetail(HttpServletRequest req, Model model, int orderNum) {
		Order order = orderService.getOrderStatus(orderNum);
		int totalPrice = orderService.getTotalPriceByOrderNum(orderNum);
		List<OrderMenu> orderMenus = orderService.getOrderMenus(orderNum);
//		List<Member> members = memberService.getRiders();
//		
		model.addAttribute("order", order);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("orderMenus", orderMenus);
//		model.addAttribute("members", members);
		
		return "usr/order/orderDetail";
	}
	
	@GetMapping("/usr/order/callRider")
	public String callRider(HttpServletRequest req, int orderNum) {
		
		orderService.doOrderAccept(orderNum, "픽업 대기중");
		
		return "usr/order/riderStatus";
	}
	
	@GetMapping("/usr/order/riderStatus")
	public String riderStatus() {
		return "usr/order/riderStatus";
	}

	@GetMapping("/usr/order/doOrderCancel")
	@ResponseBody
	public String doOrderCancel(int orderNum) {
		
		orderService.doOrderMenuDelete(orderNum);
		orderService.doOrderDelete(orderNum);
		
		return Util.jsReturn("주문이 취소되었습니다.", "/usr/home/main");
	}
}