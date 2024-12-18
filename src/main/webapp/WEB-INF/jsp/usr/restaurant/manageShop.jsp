<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="내 가게보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div class="mx-auto">
			<section class="container mx-auto mt-16 px-4">
			    <div class="text-center mb-8">
			        <h2 class="text-3xl font-bold text-gray-800">${restaurant.getName() }</h2>
			        <p class="text-lg text-gray-600">정통 한국의 맛을 자랑하는 레스토랑</p>
			    </div>
			    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
					<c:forEach var="menu" items="${menus }">
						<c:set var="chk" value="true" />
				        <div class="relative group w-full h-64 bg-white rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex flex-col justify-center items-center p-4">
				            <h4 class="text-lg font-semibold text-gray-800">${menu.getMenuName() }</h4>
				            <p class="text-sm text-gray-600">${menu.getDescription() }</p>
				            <p class="text-xl font-semibold text-gray-800 mt-2">₩${menu.getPrice() }</p>
							<a href="/usr/menu/modifyMenu?menuId=${menu.getId() }" class="mt-4 bg-gradient-to-b from-[#A3D9A5] to-[#6CCF6A] text-white py-3 px-6 rounded-lg w-full text-center flex justify-center items-center shadow-lg transform transition duration-200 hover:scale-105 hover:shadow-xl">
						        메뉴수정하기
						    </a>
					    </div>
					</c:forEach>
			    </div>
			</section>
		</div>
		<div class="flex justify-around mt-8">
			<button class="btn btn-sm text-base" onclick="clickLikePoint();">
				<span id="likeCnt"></span>
				<span id="likePointBtn"></span>
			</button>
		</div>
		<div class="btns mx-auto my-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<section class="my-8">
	<div class="container mx-auto px-4 text-base w-9/12">
		<div class="text-lg">댓글</div>
		<c:forEach var="reply" items="${replies }">
			<div id="${reply.getId() }" class="py-2 border-b-2 border-slate-200 pl-20">
				<div class="flex justify-between items-center">
					<div class="font-semibold">${reply.getLoginId() }</div>
				    <c:if test="${rq.getLoginedMemberId() == reply.memberId }">
				    	<div class="dropdown mr-2">
						  <div tabindex="0" role="button" class="btn btn-sm btn-circle btn-ghost m-1">
						  	<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block h-5 w-5 stroke-current">
						      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path>
						    </svg>
						  </div>
						</div>
				    </c:if>
				</div>
				<div class="text-lg my-1 ml-2">${reply.getForPrintBody() }</div>
				<div class="text-xs text-gray-400">${reply.getRegDate() }</div>
			</div>
		</c:forEach>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>