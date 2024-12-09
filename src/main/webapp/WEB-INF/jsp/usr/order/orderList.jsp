<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="주문내역" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="w-9/12 mx-auto mb-2 pl-3 text-sm flex justify-between items-end">
			<div>총 : ${restaurantsCnt }개</div>
		</div>
		<div class="table-box">
			<div class="w-9/12 mx-auto">
				<table class="table">
					<colgroup>
					<col width="60"/>
					<col />
					<col width="100"/>
					<col width="120"/>
					</colgroup>
					<tr>
						<th>번호</th>
						<th>주소</th>
						<th>메뉴수</th>
						<th>합계금액</th>
					</tr>
					<c:forEach var="order" items="${orders }" varStatus="status">
						<tr>
							<td>${status.index + 1}</td>
							<td class="hover:underline"><a href="orderDetail?loginId=${order.getOrderMemberId() }">대전광역시</a></td>
							<td>${orderMenuCnt }</td>
							<td>${orderTotalPrice }</td>
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