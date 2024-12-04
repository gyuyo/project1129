package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDao;
import com.example.demo.dto.Reply;

@Service
public class ReplyService {
	
	private ReplyDao replyDao;

	public ReplyService(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

	public void writeReply(int loginedMemberId, int restaurantId, String body) {
		replyDao.writeReply(loginedMemberId, restaurantId, body);
	}

	public List<Reply> getReplies(int restaurantId) {
		return replyDao.getReplies(restaurantId);
	}
	
	public void modifyReply(int id, String body) {
		replyDao.modifyReply(id, body);
	}

	public void deleteReply(int id) {
		replyDao.deleteReply(id);
	}

}
