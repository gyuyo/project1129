package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Member;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMemberController {
	
	private MemberService memberService;
	
	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId, String loginPw, String loginPwChk, String name) {
		
		if (Util.isEmpty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.from("F-2", String.format("[ %s ] 은(는) 이미 사용중인 아이디입니다", loginId));
		}
		
		if (Util.isEmpty(loginPw)) {
			return ResultData.from("F-3", "비밀번호를 입력해주세요");
		}
		if (Util.isEmpty(name)) {
			return ResultData.from("F-4", "이름을 입력해주세요");
		}
		
		if (loginPw.equals(loginPwChk) == false) {
			return ResultData.from("F-5", "비밀번호가 일치하지 않습니다");
		}
		
		memberService.joinMember(loginId, loginPw, name);
		
		int id = memberService.getLastInsertId();
		
		return ResultData.from("S-1", String.format("[ %s ] 님이 가입되었습니다", loginId), memberService.getMemberById(id));
	}
	
	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}
	
	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Util.jsReturn(String.format("[ %s ] 은(는) 존재하지 않는 아이디입니다", loginId), null);
		}
		
		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.jsReturn("비밀번호를 확인해주세요", null);
		}
		
		rq.login(member.getId());
		
		return Util.jsReturn(String.format("%s님 환영합니다~", member.getName()), "/");
	}
	
	@GetMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		rq.logout();
		
		return Util.jsReturn("정상적으로 로그아웃 되었습니다", "/");
	}
}