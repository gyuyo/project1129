<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="w-9/12 mx-auto">
				<table class="table">
					<tr>
						<th>아이디</th>
						<td>${member.getLoginId() }</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>********</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${member.getName() }</td>
					</tr>
					<tr>
						<th>e-mail</th>
						<td>${member.getEmail() }</td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>${member.getRegDate().substring(2, 16) }</td>
					</tr>
					<tr>
						<th>회원정보수정일</th>
						<td>${member.getUpdateDate().substring(2, 16) }</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="btns w-9/12 mx-auto mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
			<div class="flex">
				<a href="/usr/member/checkPw" class="p-5">비밀번호변경</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>