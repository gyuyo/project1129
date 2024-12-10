package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Menu;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.MenuService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMenuController {
	
	private MenuService menuService;

	public UsrMenuController(MenuService menuService) {
		this.menuService = menuService;
	}
	
	@PostMapping("/usr/menu/updateQuantity")
	@ResponseBody
	public ResultData updateQuantity(int menuId, int quantity) {
		menuService.updateQuantity(menuId, quantity);
		
		return ResultData.from("S-1", "수량을 수정하였습니다.");
	}
	
	@GetMapping("/usr/menu/modifyMenu")
	public String modifyMenu(Model model, int menuId) {
		Menu menu = menuService.getMenuById(menuId);
		
		model.addAttribute("menu", menu);
		
		return "/usr/restaurant/modifyMenu";
	}
	
	@GetMapping("/usr/menu/doModifyMenu")
	@ResponseBody
	public String doModifyMenu(Model model, int menuId, String menuName, String menuDescription, int menuPrice, int readyTime) {
		
		menuService.doModifyMenu(menuId, menuName, menuDescription, menuPrice, readyTime);
		
		return Util.jsReturn("메뉴를 수정하였습니다.", "/usr/restaurant/manageShop");
	}
	
	@GetMapping("/usr/menu/getTotalPrice")
	@ResponseBody
	public ResultData getTotalPrice(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Menu menu = menuService.getTotalPriceByLoginedId(rq.getLoginedMemberId());
		
		return ResultData.from("S-1", "합계 금액",menu);
	}
	
	
}