<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="주문서" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	$(document).ready(function() {
		if ("${order.getOrderStatus()}".includes("배달")) {
			location.href = "/usr/order/riderStatus?orderNum=" + ${order.getId()}
		};
		
		orderStatusReload();
		let socket = new SockJS('/ws-stomp');
   		let stompClient = Stomp.over(socket);
   		let userId = ${rq.getLoginedMemberId()};
   		
	    stompClient.connect({}, function () {
	    	stompClient.subscribe(`/sub/user/\${userId}/queue/messages`, function (message) {
	    		if(message.body == 1) {
	    			orderStatusReload();
	    		} else {
	    			location.href = "/usr/order/riderStatus?orderNum=" + ${order.getId()};
	    		}
	    	});
	   	});
	    
	    $('#cancleBtn').click(function () {
			$.ajax({
	            url: '/usr/order/doOrderCancel', 
	            type: 'GET', 
	            data: {
	            	orderNum: ${order.getId() }
		        },
		        success : function(data) {
					test2();
					location.href = "/usr/home/main";
		        }
			})
		})
	    
	})
	
	const orderStatusReload = function() {
	    $.ajax({
	        url: '/usr/order/updateOrder',
	        type: 'GET',
	        data: {
	        	orderNum : ${order.getId() }
	        },
	        dataType : 'json',
			success : function(data) {
				$('#orderStatus').text(data.data.orderStatus);
				if(data.data.orderStatus != '대기 중') {
					$('#cancleBtn').text('주문 진행중')
	                   .prop('disabled', true)
				}
		    },
	    })
	}
</script>

<section class="mt-8 flex-1 px-4">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
	    <div class="bg-blue-100 p-4 rounded-lg shadow-lg text-center mb-6">
	        <h3 class="text-2xl font-semibold text-gray-800">주문 상태</h3>
	        <p id="orderStatus" class="text-xl text-gray-600 mt-2"></p>
	    </div>
	
	    <div class="bg-white p-6 rounded-lg shadow-lg">
	        <h4 class="text-xl font-semibold text-gray-800 mb-4">주문 내역</h4>
	        <div class="space-y-4">
	        	<c:forEach var="orderMenu" items="${orderMenus }">
					<div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${orderMenu.getMenuId()}">
						<img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
					    	<div class="flex-1">
					        	<p class="text-xl font-semibold text-[#4B4F54]">${orderMenu.getMenuName()}</p>
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
	        <div class="mt-8 flex justify-center">
	            <div class="relative group flex items-center space-x-4">
		        	<button id="cancleBtn" type="submit" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors"  onclick="return confirm('주문 접수 대기중 상태에서만 취소가 가능합니다. 주문을 취소하시겠습니까?');">
		            	주문 취소
		            </button>
		            <div class="absolute left-full ml-4 py-1 px-3 bg-white text-sm text-gray-600 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
		           		<i class="fa-solid fa-circle-info text-blue-500 mr-2"></i>
		            	<span>주문 접수 대기중 상태에서만 취소가 가능합니다.</span>
		        	</div>
	            </div>
	            <input class="input input-bordered" id="sender" type="hidden" value="${rq.getLoginedMemberId()}">
				<input class="input input-bordered" id="message" type="hidden" value="1">
				<input class="input input-bordered" id="recipientId" type="hidden" value="${ownerId }">
	        </div>
		</div>	
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>