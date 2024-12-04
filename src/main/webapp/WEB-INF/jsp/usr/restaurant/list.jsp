<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${category.getCgName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	const searchForm_onSubmit = function(form) {
		form.searchKeyword.value = form.searchKeyword.value.trim();
		
		if (form.searchKeyword.value.length == 0) {
			alert('검색어를 입력해주세요');
			form.searchKeyword.focus();
			return;
		}
		
		form.submit();
	}
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="w-9/12 mx-auto mb-2 pl-3 text-sm flex justify-between items-end">
			<div>총 : ${restaurantsCnt }개</div>
			<form onsubmit="searchForm_onSubmit(this); return false;">
				<input type="hidden" name="cgId" value="${category.getId() }" />
				<div class="flex text-black" >
					<select class="select select-bordered select-sm mr-2" name="searchType">
						<option value="name" <c:if test="${searchType == 'name' }">selected="selected"</c:if>>업체명</option>
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
					<col width="100"/>
					<col width="120"/>
					</colgroup>
					<tr>
						<th>번호</th>
						<th>업체명</th>
						<th>업주명</th>
						<th>배달팁</th>
						<th>예상시간</th>
						<th>추천수</th>
					</tr>
					<c:forEach var="restaurant" items="${restaurants }">
						<tr>
							<td>${restaurant.getId() }</td>
							<td class="hover:underline"><a href="detail?id=${restaurant.getId() }">${restaurant.getName() }</a></td>
							<td>${restaurant.getLoginId() }</td>
							<td>2000원</td>
							<td>40분</td>
							<td>${restaurant.getLike() }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="w-9/12 mx-auto btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
	<div class="flex justify-center mt-8">
		<div class="join">
			
			<c:set var="path" value="?cgId=${category.getId() }&searchType=${searchType }&searchKeyword=${searchKeyword }">
			</c:set>
			<c:if test="${from != 1 }">
				<a href="${path}&cPage=1" class="join-item btn btn-square" type="radio">
					<i class="fa-solid fa-angles-left"></i></a>
				<a href="${path}&cPage=${from - 1 }" class="join-item btn btn-square" type="radio">
					<i class="fa-solid fa-angle-left"></i></a>
			</c:if>
				<c:forEach var="i" begin="${from }" end="${end }">
					<a class="join-item btn btn-square ${cPage == i ? 'btn-active' : '' }" href="${path }&cPage=${i }">${i }</a>
  				</c:forEach>
  			<c:if test="${end != totalPagesCnt }">
  				<a href="${path}&cPage=${end + 1 }" class="join-item btn btn-square" type="radio"><i class="fa-solid fa-angle-right"></i></a>
  				<a href="${path}&cPage=${totalPagesCnt }" class="join-item btn btn-square" type="radio"><i class="fa-solid fa-angles-right"></i></a>
  			</c:if>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>