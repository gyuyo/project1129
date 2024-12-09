<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${category.getCgName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="w-9/12 mx-auto">
				<table class="table">
					<colgroup>
					<col width="60"/>
					<col />
					<col width="100"/>
					<col width="120"/>
					<col width="80"/>
					<col width="80"/>
					</colgroup>
					<tr>
						<th>번호</th>
						<th>업체명</th>
						<th>배달팁</th>
						<th>예상시간</th>
						<th>추천수</th>
						<th>주문수</th>
					</tr>
					<c:forEach var="restaurant" items="${restaurants }">
						<tr>
							<td>${restaurant.getId() }</td>
							<td class="hover:underline"><a href="detail?id=${restaurant.getId() }">${restaurant.getName() }</a></td>
							<td>2000원</td>
							<td>40분</td>
							<td>${restaurant.getLike() }</td>
							<td>${restaurant.getOrderCount() }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="w-9/12 mx-auto btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>