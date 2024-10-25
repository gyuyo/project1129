package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Member;

@Service
public class MemberService {
	private MemberDao memberDao;

	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void dojoin(String loginId, String loginPw, String name) {
		memberDao.dojoin(loginId, loginPw, name);
	}

	public Member loginIdDup(String loginId) {
		return memberDao.loginIdDup(loginId);
	}

	public int getLastInsertId() {
		return memberDao.getLastInsertId();
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

}
