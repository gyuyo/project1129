package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.ResultData;
import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;

@Controller
public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData doWrite(String title, String body) {
		
		if(Util.isEmpty(title)) {
			return ResultData.from("F-1", "제목은 필수입력란입니다.");
		}
		if(Util.isEmpty(body)) {
			return ResultData.from("F-2", "내용은 필수입력란입니다.");
		}
		
		articleService.writeArticle(title, body);
		int id = articleService.getLastInsertId();

		Article article = articleService.getArticleById(id);

		return ResultData.from("S-1", "게시글이 작성되었습니다.", article);
	}

	@GetMapping("/usr/article/showList")
	@ResponseBody
	public ResultData showList() {
		return ResultData.from("S-2", "게시글 목록을 불러왔습니다.", articleService.getArticles());
	}

	@GetMapping("/usr/article/detail")
	@ResponseBody
	public ResultData detail(int id) {

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-3", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id), articleService.getArticles());
		}
		return ResultData.from("S-3", String.format("[ %d ]번 게시글을 불러왔습니다.", id), foundArticle);
	}

	@GetMapping("/usr/article/doModify")
	@ResponseBody
	public ResultData doModify(int id, String title, String body) {

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-3", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id), articleService.getArticles());
		}

		articleService.setArticle(id, title, body);

		return ResultData.from("S-4", String.format("[ %d ]번글이 수정되었습니다.", id));
	}

	@GetMapping("/usr/article/remove")
	@ResponseBody
	public ResultData remove(int id) {

		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return ResultData.from("F-3", String.format("[ %d ]번 게시글이 존재하지 않습니다.", id), articleService.getArticles());
		}

		articleService.deleteArticle(id);

		return ResultData.from("S-5", String.format("[ %d ]번글이 정상적으로 삭제되었습니다.", id));
	}
}
