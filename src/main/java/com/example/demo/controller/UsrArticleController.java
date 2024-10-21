package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrArticleController {

	List<Article> articles;
	int lastArticleId;

	public UsrArticleController() {
		this.articles = new ArrayList<>();
		this.lastArticleId = 0;
	}

	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public Article doWrite(String title, String body) {
		lastArticleId++;
		Article article = new Article(lastArticleId, title, body);
		articles.add(article);
		return article;
	}

	@GetMapping("/usr/article/showList")
	@ResponseBody
	public List<Article> showList() {
		return articles;
	}

	@GetMapping("/usr/article/detail")
	@ResponseBody
	public Object detail(int id) {

		List<Article> printArticles = new ArrayList<>();
		
		
		for (Article article : articles) {
			if (article.getId() == id) {
				printArticles.add(article);
			}
		}
		if (printArticles.size() == 0) {
			return "게시글이 존재하지 않습니다.";
		}
		return printArticles;
	}
}
