<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="주문상세보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>

	$(document).ready(function() {
		test1();
		$('#acceptBtn').click(function(){
		    window.location.href = '/usr/order/doOrderAccept?orderId=' + ${order.getOrderMemberId()};
			test2();
		})
		
		let orderStatus = localStorage.getItem('orderStatus');
		let riderCall = localStorage.getItem('riderCall');
    
	    if (riderCall === '배달 출발') {
	        $('#orderStat').text("픽업 대기중");
	        $('#doRiderCall').text("배달 출발");
	    }
	    
		$('#doRiderCall').click(function(){
		let buttonText = $('#doRiderCall').text();
			
	    if (buttonText === "배달 출발") {
	        alert("배달이 시작되었습니다.");
// 	        window.location.href = '/usr/order/doRiderCall?orderId=' + ${order.getOrderMemberId()};
	    } else {
	    	$.ajax({
		        url: '/usr/order/riderCall',
		        type: 'GET',
		        data: {
		            orderId: ${order.getOrderMemberId()}
		        },
		        dataType: 'json',
		        success: function(data) {
	            	alert(data.resultMsg);
	            	$('#orderStat').text("픽업 대기중");
	            	$('#doRiderCall').text("배달 출발");
	            	localStorage.setItem('orderStat', '픽업 대기중');
	            	localStorage.setItem('riderCall', '배달 출발');
		        }
		   		});
			}
		})
		
	})
	
</script>
<section class="mt-8 flex-1 px-4">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
	    <div class="bg-blue-100 p-4 rounded-lg shadow-lg text-center mb-6">
	        <h3 class="text-2xl font-semibold text-gray-800">주문 상태</h3>
	        <p id="orderStat" class="text-xl text-gray-600 mt-2">${order.getOrderStatus() }</p>
	    </div>
	
	    <div class="bg-white p-6 rounded-lg shadow-lg">
	        <h4 class="text-xl font-semibold text-gray-800 mb-4">주문 내역</h4>
	        <div class="space-y-4">
	        	<c:forEach var="orderMenu" items="${orderMenus }">
					<div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${orderMenu.getMenuId()}">
						<img src="" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
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
	    	<c:if test="${order.orderStatus == '대기 중'}">
				<button id="acceptBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					주문 접수
				</button>
				<a href="/usr/order/doOrderCancel?orderId=${order.getOrderMemberId()}" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors shadow-md hover:shadow-lg text-center inline-block" onclick="return confirm('사유가 불분명한 취소는 불이익을 받을 수 있습니다. 주문을 취소하시겠습니까?');">
				    주문 취소
				</a>
			</c:if>
	    	<c:if test="${order.orderStatus == '요리 중'}">
				<button id="doRiderCall" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					라이더 호출
				</button>
			</c:if>
	    	<input class="input input-bordered" id="sender" type="hidden" value="${order.getOrderMemberId()}">
			<input class="input input-bordered" id="message" type="hidden" value="1">
		    <div id="order-notifications" class="mt-6"></div>
		</div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
