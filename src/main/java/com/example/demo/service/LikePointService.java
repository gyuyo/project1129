package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.LikePointDao;
import com.example.demo.dto.LikePoint;

@Service
public class LikePointService {
	
	private LikePointDao likePointDao;
	
	public LikePointService(LikePointDao likePointDao) {
		this.likePointDao = likePointDao;
	}

	public void insertLikePoint(int loginedMemberId, int restaurantId) {
		likePointDao.insertLikePoint(loginedMemberId, restaurantId);
	}

	public LikePoint getLikePoint(int loginedMemberId, int restaurantId) {
		return likePointDao.getLikePoint(loginedMemberId, restaurantId);
	}

	public void deleteLikePoint(int loginedMemberId, int restaurantId) {
		likePointDao.deleteLikePoint(loginedMemberId, restaurantId);
	}

	public int getLikePointCnt(int restaurantId) {
		return likePointDao.getLikePointCnt(restaurantId);
	}
}