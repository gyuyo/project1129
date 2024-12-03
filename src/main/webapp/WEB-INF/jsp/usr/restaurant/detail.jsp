<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${foodKg.getKgName() }" />

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
				        <div class="relative group w-full h-64 bg-white rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex flex-col justify-center items-center p-4">
				            <h4 class="text-lg font-semibold text-gray-800">${menu.getName() }</h4>
				            <p class="text-sm text-gray-600">${menu.getDescription() }</p>
				            <p class="text-xl font-semibold text-gray-800 mt-2">₩${menu.getPrice() }</p>
				            <button class="mt-4 bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg w-full add-to-cart" data-item="${menu.getName() }">장바구니에 추가</button>
				        </div>
					</c:forEach>
			    </div>
			</section>
		</div>
		<div class="flex justify-around">
			<c:if test="${rq.getLoginedMemberId() == -1 }">
				<button class="btn btn-sm text-base" onclick="alert('로그인 후 이용가능합니다.')">
					<span id="likeCnt"></span>
					<span id="likePointBtn"></span>
				</button>
			</c:if>
			<c:if test="${rq.getLoginedMemberId() != -1 }">
				<button class="btn btn-sm text-base" onclick="clickLikePoint();">
					<span id="likeCnt"></span>
					<span id="likePointBtn"></span>
				</button>
			</c:if>
		</div>
		<div class="btns mx-auto my-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
			<c:if test="${rq.getLoginedMemberId() == article.getMemberId() }">
				<div class="flex">
					<a href="modify?id=${article.getId() }" class="p-5">수정</a>
					<a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="doDelete?id=${article.getId() }&boardId=${article.boardId() }">삭제</a>
				</div>
			</c:if>
		</div>
	</div>
</section>

<!-- </script> -->

<!-- <section class="mt-8"> -->
<!-- 	<div class="container mx-auto border-b-2  w-9/12 border-slate-200"> -->
<!-- 		<div class="mx-auto"> -->
<!-- 			<table class="table table-lg"> -->
<!-- 				<tr> -->
<!-- 					<th>번호</th> -->
<%-- 					<td>${article.getId() }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>작성일</th> -->
<%-- 					<td>${article.getRegDate().substring(2, 16) }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>수정일</th> -->
<%-- 					<td>${article.getUpdateDate().substring(2, 16) }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>작성자</th> -->
<%-- 					<td>${article.getLoginId() }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>제목</th> -->
<%-- 					<td>${article.getTitle() }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>내용</th> -->
<%-- 					<td>${article.getForPrintBody() }</td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>조회수</th> -->
<%-- 					<td>${article.getViews() }</td> --%>
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</div> -->
<!-- 		<div class="flex justify-around"> -->
<%-- 			<c:if test="${rq.getLoginedMemberId() == -1 }"> --%>
<!-- 				<button class="btn btn-sm text-base" onclick="alert('로그인 후 이용가능합니다.')"> -->
<!-- 					<span id="likeCnt"></span> -->
<!-- 					<span id="likePointBtn"></span> -->
<!-- 				</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rq.getLoginedMemberId() != -1 }"> --%>
<!-- 				<button class="btn btn-sm text-base" onclick="clickLikePoint();"> -->
<!-- 					<span id="likeCnt"></span> -->
<!-- 					<span id="likePointBtn"></span> -->
<!-- 				</button> -->
<%-- 			</c:if> --%>
<!-- 		</div> -->
<!-- 		<div class="btns mx-auto my-3 text-sm flex justify-between"> -->
<!-- 			<button onclick="history.back();">뒤로가기</button> -->
<%-- 			<c:if test="${rq.getLoginedMemberId() == article.getMemberId() }"> --%>
<!-- 				<div class="flex"> -->
<%-- 					<a href="modify?id=${article.getId() }" class="p-5">수정</a> --%>
<%-- 					<a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="doDelete?id=${article.getId() }&boardId=${article.boardId() }">삭제</a> --%>
<!-- 				</div> -->
<%-- 			</c:if> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </section> -->


<!-- <section class="my-8"> -->
<!-- 	<div class="container mx-auto px-4 text-base w-9/12"> -->
<!-- 		<div class="text-lg">댓글</div> -->
		
<%-- 		<c:forEach var="reply" items="${replies }"> --%>
<%-- 			<div id="${reply.getId() }" class="py-2 border-b-2 border-slate-200 pl-20"> --%>
<!-- 				<div class="flex justify-between items-center"> -->
<%-- 					<div class="font-semibold">${reply.getLoginId() }</div> --%>
<%-- 				    <c:if test="${rq.getLoginedMemberId() == reply.memberId }"> --%>
<!-- 				    	<div class="dropdown mr-2"> -->
<!-- 						  <div tabindex="0" role="button" class="btn btn-sm btn-circle btn-ghost m-1"> -->
<!-- 						  	<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block h-5 w-5 stroke-current"> -->
<!-- 						      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path> -->
<!-- 						    </svg> -->
<!-- 						  </div> -->
<!-- 						  <ul tabindex="0" class="dropdown-content menu bg-base-100 bg-black rounded-box z-[1] w-24 p-2 shadow border border-white"> -->
<%-- 						    <li><button onclick="replyModifyForm(${reply.getId() }, '${reply.getBody() }');">수정</button></li> --%>
<%-- 						    <li><a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="/usr/reply/doDelete?id=${reply.getId() }&relId=${article.getId() }" >삭제</a></li> --%>
<!-- 						  </ul> -->
<!-- 						</div> -->
<%-- 				    </c:if> --%>
<!-- 				</div> -->
<%-- 				<div class="text-lg my-1 ml-2">${reply.getForPrintBody() }</div> --%>
<%-- 				<div class="text-xs text-gray-400">${reply.getRegDate() }</div> --%>
<!-- 			</div> -->
<%-- 		</c:forEach> --%>
		
<%-- 		<c:if test="${rq.getLoginedMemberId() != -1 }"> --%>
<!-- 			<form action="/usr/reply/doWrite" method="post" onsubmit="replyForm_onSubmit(this); return false;"> -->
<!-- 				<input type="hidden" name="relTypeCode" value="article" /> -->
<%-- 				<input type="hidden" name="relId" value="${article.getId() }" /> --%>
<!-- 				<div class="border-2 border-slate-200 rounded-xl px-4 mt-2"> -->
<!-- 					<div id="loginedMemberLoginId" class="mt-3 mb-2 font-semibold"></div> -->
<!-- 					<textarea style="resize:none;" class="textarea textarea-bordered textarea-md w-full bg-black border border-white" name="body"></textarea> -->
<!-- 					<div class="flex justify-end mb-2"> -->
<!-- 						<button class="btn btn-active btn-sm">작성</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</form> -->
<%-- 		</c:if> --%>
<!-- 	</div> -->
<!-- </section> -->

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>