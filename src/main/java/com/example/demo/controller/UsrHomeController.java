package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.Member;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrHomeController {
	
	private MemberService memberService;

	public UsrHomeController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/home/main")
	public String showMain(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		
		model.addAttribute("member", member);
		
		return "usr/home/main";
	}
	
	@GetMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
}