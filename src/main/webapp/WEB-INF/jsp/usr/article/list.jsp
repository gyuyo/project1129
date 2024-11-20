<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${board.getName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="w-9/12 mx-auto">
				<div>총 : ${articlesCnt }개</div>
			</div>
			<div class="w-9/12 mx-auto">
				<table class="table">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
					<c:forEach var="article" items="${articles }">
						<tr>
							<td>${article.getId() }</td>
							<td class="hover:underline"><a href="detail?id=${article.getId() }">${article.getTitle() }</a></td>
							<td>${article.getLoginId() }</td>
							<td>${article.getRegDate().substring(2,16) }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="w-9/12 mx-auto btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
			<c:if test="${rq.getLoginedMemberId() != -1 }">
				<div class="flex">
					<a href="/usr/article/write" class="p-5">글작성</a>
				</div>
			</c:if>
		</div>
	</div>
	<div class="flex justify-center mt-8">
		<div class="join">
			<c:set var="path" value="?boardId=${board.getId() }">
			
			</c:set>
			<c:if test="${from != 1 }">
				<a href="${path}&cPage=1" class="join-item btn btn-square bg-black text-white hover:bg-gray-800 border-0" type="radio">
					<i class="fa-solid fa-angles-left"></i></a>
				<a href="${path}&cPage=${from - 1 }" class="join-item btn btn-square bg-black text-white hover:bg-gray-800 border-0" type="radio">
					<i class="fa-solid fa-angle-left"></i></a>
			</c:if>
				<c:forEach var="i" begin="${from }" end="${end }">
					<a href="${path}&cPage=${i }" class="join-item btn btn-square text-white ${cPage == i ? 'hover:bg-indigo-900' : 'hover:bg-gray-800' } border-0 ${cPage == i ? 'bg-indigo-900' : 'bg-black' }" type="radio">${i }</a>
  				</c:forEach>
  			<c:if test="${end != totalPagesCnt }">
  				<a href="${path}&cPage=${end + 1 }" class="join-item btn btn-square bg-black text-white hover:bg-gray-800 border-0" type="radio"><i class="fa-solid fa-angle-right"></i></a>
  				<a href="${path}&cPage=${totalPagesCnt }" class="join-item btn btn-square bg-black text-white hover:bg-gray-800 border-0" type="radio"><i class="fa-solid fa-angles-right"></i></a>
  			</c:if>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>