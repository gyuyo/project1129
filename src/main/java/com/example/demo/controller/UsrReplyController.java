package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Rq;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;



@Controller
public class UsrReplyController {
	
	private ReplyService replyService;
	
	public UsrReplyController(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@PostMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int restaurantId, String body) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		replyService.writeReply(rq.getLoginedMemberId(), restaurantId, body);
		
		return Util.jsReturn("댓글 작성을 완료했습니다", String.format("../restaurant/detail?id=%d", restaurantId));
	}
	
	@PostMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(int id, int restaurantId, String body) {
		
		replyService.modifyReply(id, body);
		
		return Util.jsReturn(String.format("%d번 댓글을 수정했습니다", id), String.format("../restaurant/detail?id=%d", restaurantId));
	}

	@GetMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(int id, int restaurantId) {
		
		replyService.deleteReply(id);
		
		return Util.jsReturn(String.format("%d번 댓글을 삭제했습니다", id), String.format("../restaurant/detail?id=%d", restaurantId));
	}
	
}