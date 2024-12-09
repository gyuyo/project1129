package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.service.OwnerService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrOwnerController {
	private OwnerService ownerService;
	private MemberService memberService;

	public UsrOwnerController(OwnerService ownerService, MemberService memberService) {
		this.ownerService = ownerService;
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/owner/accessIdChk")
	@ResponseBody
	public ResultData accessIdChk(Model model, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		int accessIdChk = memberService.getaccessIdChk(rq.getLoginedMemberId());
		
		return ResultData.from("S-1", "로그인 권한 확인", accessIdChk);
	}
	
}
