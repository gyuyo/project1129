<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="상세보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="overflow-x-auto">
				<table class="table">
					<tr>
						<th>번호</th>
						<td>${article.getId() }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.getLoginId() }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.getTitle() }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.getBody() }</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${article.getRegDate().substring(2, 16) }</td>
					</tr>
					<tr>
						<th>수정일</th>
						<td>${article.getUpdateDate().substring(2, 16) }</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
			<c:if test="${rq.getLoginedMemberId() == article.getMemberId() }">
				<div class="flex">
					<a href="/usr/article/modify?id=${article.getId() }" class="p-5">수정</a>
					<a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false; "
						href="doDelete?id=${article.getId() }" class="p-5  ml-2">삭제</a>
				</div>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>