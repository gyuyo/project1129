<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${board.getName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	const searchForm_onSubmit = function(form) {
		form.searchKey.value = form.searchKey.value.trim();
		
		if (form.searchKey.value.length == 0) {
			alert('검색어를 입력해주세요');
			form.searchKey.focus();
			return;
		}
		
		form.submit();
	}
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="w-9/12 mx-auto mb-2 pl-3 text-sm flex justify-between items-end">
			<div>총 : ${articlesCnt }개</div>
			<form>
				<input type="hidden" name="boardId" value="${board.getId() }" />
				<div class="flex text-black" >
					<select class="select select-bordered select-sm mr-2" name="searchType">
						<option value="title" <c:if test="${searchType == 'title' }">selected="selected"</c:if>>제목</option>
						<option value="body" <c:if test="${searchType == 'body' }">selected="selected"</c:if>>내용</option>
						<option value="title,body" <c:if test="${searchType == 'title,body' }">selected="selected"</c:if>>제목 + 내용</option>
					</select>
					
					<label class="input input-bordered input-sm flex items-center gap-2 w-60">
					  <input type="text" class="grow" name="searchKeyword" placeholder="검색어를 입력해주세요" maxlength="25" value="${searchKeyword }"/>
					  <svg
					    xmlns="http://www.w3.org/2000/svg"
					    viewBox="0 0 16 16"
					    fill="currentColor"
					    class="h-4 w-4 opacity-70">
					    <path
					      fill-rule="evenodd"
					      d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
					      clip-rule="evenodd" />
					  </svg>
					</label>
					
					<button class="hidden">검색</button>
				</div>
			</form>
		</div>
		<div class="table-box">
			<div class="w-9/12 mx-auto">
				<table class="table">
					<colgroup>
					<col width="60"/>
					<col />
					<col width="80"/>
					<col width="200"/>
					<col width="80"/>
					<col width="80"/>
					</colgroup>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>추천수</th>
					</tr>
					<c:forEach var="article" items="${articles }">
						<tr>
							<td>${article.getId() }</td>
							<td class="hover:underline"><a href="detail?id=${article.getId() }">${article.getTitle() }</a></td>
							<td>${article.getLoginId() }</td>
							<td>${article.getRegDate().substring(2,16) }</td>
							<td>${article.getViews() }</td>
							<td>${article.getLike() }</td>
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
			<c:set var="path" value="?boardId=${board.getId() }&searchType=${searchType }&searchKeyword=${searchKeyword }">
			
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