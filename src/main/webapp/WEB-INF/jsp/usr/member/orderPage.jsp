<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="mt-8 flex-1 px-4">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
	    <div class="bg-blue-100 p-4 rounded-lg shadow-lg text-center mb-6">
	        <h3 class="text-2xl font-semibold text-gray-800">주문 상태</h3>
	        <p class="text-xl text-gray-600 mt-2">${order.getOrderStatus()}</p>
	    </div>
	
	    <div class="bg-white p-6 rounded-lg shadow-lg">
	        <h4 class="text-xl font-semibold text-gray-800 mb-4">주문 내역</h4>
	        <div class="space-y-4">
	        	<c:forEach var="menu" items="${menus }">
					<div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${menu.getMenuId()}">
						<img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
					    	<div class="flex-1">
					        	<a href="/usr/restaurant/detail?id=${menu.getRestaurantId() }" class="text-xl font-semibold text-[#4B4F54]">${menu.getName()}</a>
					            <p class="text-gray-500 mb-2">${menu.getDescription()}.</p>
					            <p class="font-bold text-[#4B4F54] mb-2">가격: <span id="price-${menu.getMenuId()}">${menu.getPrice() * menu.getQuantity()}</span>원</p>
					        </div>
					        <div class="flex flex-col items-center">
					    	<p class="text-lg font-semibold mb-2">수량: <span id="quantity-${menu.getMenuId()}">${menu.getQuantity() }</span></p>
						</div>
					</div>
				</c:forEach>
	     	</div>
	    </div>
	    <div class="bg-gray-100 p-4 rounded-lg shadow-lg mt-6">
	    	<div class="flex justify-between items-center">
	        <h5 class="text-lg font-semibold text-gray-800 mb-2">합계 금액</h5>
	        <p class="text-2xl font-bold text-gray-800">₩${totalPrice }</p>
		    </div>
	    </div>
	    <div class="mt-8 text-center">
		    <form action="/usr/order/doOrderCancel" method="post">
		        <div class="mt-8 flex justify-center">
		            <div class="relative group flex items-center space-x-4"> <!-- flex로 버튼과 메시지 한 줄에 배치, space-x-4로 간격 추가 -->
		                <!-- 주문 취소 버튼 -->
		                <button type="submit" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors">
		                    주문 취소
		                </button>
		
		                <!-- 주문 취소 메시지 (기본으로 숨기고 호버 시 나타남) -->
		                <div class="absolute left-full ml-4 py-1 px-3 bg-white text-sm text-gray-600 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
		                    <i class="fa-solid fa-circle-info text-blue-500 mr-2"></i>
		                    <span>주문 접수 대기중 상태에서만 취소가 가능합니다.</span>
		                </div>
		            </div>
		        </div>
		    </form>
		</div>	
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>