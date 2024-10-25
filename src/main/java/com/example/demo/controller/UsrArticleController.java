package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.ResultData;
import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData<Article> doWrite(HttpSession session, String title, String body) {

		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (loginedMemberId == -1) {
			return ResultData.from("F-8", String.format("로그인 후 이용할 수 있는 기능입니다."));
		}

		if (Util.isEmpty(title)) {
			return ResultData.from("F-1", "제목은 필수입력란입니다.");
		}
		if (Util.isEmpty(body)) {
			return ResultData.from("F-2", "내용은 필수입력란입니다.");
		}

		articleService.writeArticle(loginedMemberId, title, body);

		int id = articleService.getLastInsertId();

		return ResultData.from("S-1", String.format("%d번 게시물을 작성했습니다", id), articleService.getArticleById(id));
	}

	@GetMapping("/usr/article/showList")
	@ResponseBody
	public ResultData<List<Article>> showList(HttpSession session) {

		List<Article> articles = articleService.getArticles();

		if (articles.size() == 0) {
			return ResultData.from("F-3", "게시물이 존재하지 않습니다.");
		}

		return ResultData.from("S-2", "게시글 목록을 불러왔습니다.", articles);
	}

	@GetMapping("/usr/article/detail")
	@ResponseBody
	public ResultData<Article> detail(int id) {

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-4", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id));
		}
		return ResultData.from("S-3", String.format("[ %d ]번 게시글을 불러왔습니다.", id), foundArticle);
	}

	@GetMapping("/usr/article/doModify")
	@ResponseBody
	public ResultData<Article> doModify(HttpSession session, int id, String title, String body) {

		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (loginedMemberId == -1) {
			return ResultData.from("F-8", String.format("로그인 후 이용할 수 있는 기능입니다."));
		}

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-4", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id));
		}

		if (foundArticle.getMemberId() != loginedMemberId) {
			return ResultData.from("F-9", "권한이 없습니다.");
		}

		articleService.setArticle(id, title, body);

		return ResultData.from("S-4", String.format("[ %d ]번글이 수정되었습니다.", id), articleService.getArticleById(id));
	}

	@GetMapping("/usr/article/remove")
	@ResponseBody
	public ResultData remove(HttpSession session, int id) {

		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (loginedMemberId == -1) {
			return ResultData.from("F-8", String.format("로그인 후 이용할 수 있는 기능입니다."));
		}

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-4", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id));
		}
		
		if (foundArticle.getMemberId() != loginedMemberId) {
			return ResultData.from("F-9", "권한이 없습니다.");
		}
		
		articleService.deleteArticle(id);

		return ResultData.from("S-5", String.format("[ %d ]번글이 정상적으로 삭제되었습니다.", id));
	}
}
