package com.example.demo.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Member;
import com.example.demo.dto.Menu;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MemberService {
	
	private MemberDao memberDao;
	private JavaMailSender javaMailSender;
	
	public MemberService(MemberDao memberDao, JavaMailSender javaMailSender) {
		this.memberDao = memberDao;
		this.javaMailSender = javaMailSender;
	}

	public void joinMember(int accessId, String loginId, String loginPw, String name, String email) {
		memberDao.joinMember(accessId, loginId, loginPw, name, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public int getLastInsertId() {
		return memberDao.getLastInsertId();
	}

	public void modifyPassword(int loginedMemberId, String loginPw) {
		memberDao.modifyPassword(loginedMemberId, loginPw);
	}
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}
	
	public void sendEmail(String to, String subject, String text) {
        MimeMessage message = javaMailSender.createMimeMessage();
        
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(text, true);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        
        javaMailSender.send(message);
    }
	
    public void sendPasswordRecoveryEmail(Member member, String tempPassword) {
        String subject = "임시 패스워드 발송";
        String text = "<html>"
                    + "<body>"
                    + "<h3>임시 패스워드 : " + tempPassword + "</h3>"
                    + "<a style='display:inline-block;padding:10px;border-radius:10px;border:5px solid black;font-size:4rem;color:inherit;text-decoration:none;' href='http://localhost:8080/usr/member/login' target='_blank'>로그인 하러가기</a>"
                    + "</body>"
                    + "</html>";
        sendEmail(member.getEmail(), subject, text);
    }

	public List<Member> getMembersById(int id) {
		return memberDao.getMembersById(id);
	}

	public int getaccessIdChk(int loginedMemberId) {
		return memberDao.getaccessIdChk(loginedMemberId);
	}

}