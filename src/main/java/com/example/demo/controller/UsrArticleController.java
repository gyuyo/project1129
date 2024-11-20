package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.Board;
import com.example.demo.dto.Rq;
import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	@GetMapping("/usr/article/write")
	public String write() {
		
		return "usr/article/write";
	}
	
	@PostMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int boardId, String title, String body) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);
		
		int id = articleService.getLastInsertId();

		return Util.jsReturn(String.format("%d번 게시물을 작성했습니다", id), String.format("detail?id=%d", id));
	}

	@GetMapping("/usr/article/list")
	public String showList(Model model, int boardId, @RequestParam(defaultValue = "1") int cPage) {
		
		Board board = articleService.getBoardById(boardId);
		
		int limitFrom = (cPage - 1) * 10;
		
		List<Article> articles = articleService.getArticles(boardId, limitFrom);
		int articlesCnt = articleService.getArticlesCnt(boardId);
		
		int totalPagesCnt = (int) Math.ceil((double) articlesCnt / 10);
		
		int from = ((cPage - 1) / 10) * 10 + 1;
		int end =(((cPage - 1) / 10) + 1) * 10;
		
		if(end > totalPagesCnt) {
			end = totalPagesCnt;
		}
		
		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("totalPagesCnt", totalPagesCnt);
		model.addAttribute("from", from);
		model.addAttribute("end", end);
		model.addAttribute("cPage", cPage);

		return "usr/article/list";
	}

	@GetMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {

		Article article = articleService.getArticleById(id);

		model.addAttribute("article", article);

		return "usr/article/detail";
	}

	@GetMapping("/usr/article/modify")
	public String modify(Model model, int id) {
		
		Article article = articleService.getArticleById(id);
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}

	@PostMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(Model model, int id, String title, String body) {
		
		Article article = articleService.getArticleById(id);

		model.addAttribute("article", article);

		articleService.modifyArticle(id, title, body);

		return Util.jsReturn(String.format("%d번 게시물을 수정했습니다", id), String.format("detail?id=%d", id));
	}

	@GetMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpSession session, int id) {

		articleService.deleteArticle(id);

		return Util.jsReturn(String.format("%d번 게시물을 삭제했습니다", id), "list");
	}
}