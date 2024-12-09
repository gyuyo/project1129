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
	        	<c:forEach var="orderMenu" items="${orderMenus }">
					<div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${orderMenu.getMenuId()}">
						<img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
					    	<div class="flex-1">
					        	<p class="text-xl font-semibold text-[#4B4F54]">${orderMenu.getName()}</p>
					            <p class="font-bold text-[#4B4F54] mb-2">가격: <span id="price-${orderMenu.getMenuId()}">${orderMenu.getPrice() * orderMenu.getQuantity()}</span>원</p>
					        </div>
					        <div class="flex flex-col items-center">
					    	<p class="text-lg font-semibold mb-2">수량: <span id="quantity-${orderMenu.getMenuId()}">${orderMenu.getQuantity() }</span></p>
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
		            <div class="relative group flex items-center space-x-4">
		                <button type="submit" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors"  onclick="return confirm('주문 접수 대기중 상태에서만 취소가 가능합니다. 주문을 취소하시겠습니까?');">
		                    주문 접수
		                </button>
		                <button type="submit" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors"  onclick="return confirm('주문 접수 대기중 상태에서만 취소가 가능합니다. 주문을 취소하시겠습니까?');">
		                    주문 취소
		                </button>
		            </div>
		        </div>
		    </form>
		</div>	
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>