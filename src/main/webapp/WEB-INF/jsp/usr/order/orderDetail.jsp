<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="주문상세보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>

	$(document).ready(function() {
		if ("${order.getOrderStatus()}".includes("배달")) {
			location.href = "/usr/order/riderStatus?orderNum=" + ${order.getId()}
		};
		
		let socket = new SockJS('/ws-stomp');
   		let stompClient = Stomp.over(socket);
   		let userId = ${rq.getLoginedMemberId()};
   		
	    stompClient.connect({}, function () {
	    	stompClient.subscribe(`/sub/user/\${userId}/queue/messages`, function (message) {
                test2();
	    		location.href = "/usr/order/riderStatus?orderNum=" + ${order.getId()}
	    	});
	   	});
	    
		$('#acceptBtn').click(function () {
			$.ajax({
	            url: '/usr/order/doOrderAccept', 
	            type: 'GET', 
	            data: {
	            	orderNum: ${order.getId()}
		        },
		        success : function() {
					test2();
					location.href = "/usr/order/orderDetail?orderNum=" + ${order.getId()};
		        }
			})
		})
		
		$('#doRiderCall').click(function(){
			alert("라이더를 호출합니다.");
			$.ajax({
	            url: '/usr/order/callRider', 
	            type: 'GET', 
	            data: {
	            	orderNum: ${order.getId()}
		        },
		        success : function() {
					test2();
					location.href = "/usr/order/orderDetail?orderNum=" + ${order.getId()};
		        }
			})
		})
	})
	
</script>
<section class="mt-8 flex-1 px-4">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
	    <div class="bg-blue-100 p-4 rounded-lg shadow-lg text-center mb-6">
	        <h3 class="text-2xl font-semibold text-gray-800">주문 상태</h3>
	        <p id="orderStatus" class="text-xl text-gray-600 mt-2">${order.getOrderStatus() }</p>
	    </div>
	
	    <div class="bg-white p-6 rounded-lg shadow-lg">
	        <h4 class="text-xl font-semibold text-gray-800 mb-4">주문 내역</h4>
	        <div class="space-y-4">
	        	<c:forEach var="orderMenu" items="${orderMenus }">
					<div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${orderMenu.getMenuId()}">
						<img src="" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
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
	    	<c:if test="${order.orderStatus == '대기 중'}">
				<c:set var="rc" value="${order.getOrderMemberId()}" />
				<c:set var="ms" value="1" />
				<button id="acceptBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					주문 접수
				</button>
				<a href="/usr/order/doOrderCancel?orderNum=${order.getId()}" class="bg-red-500 text-white py-2 px-6 rounded-lg hover:bg-red-600 transition-colors shadow-md hover:shadow-lg text-center inline-block" onclick="return confirm('사유가 불분명한 취소는 불이익을 받을 수 있습니다. 주문을 취소하시겠습니까?');">
				    주문 취소
				</a>
			</c:if>
	    	<c:if test="${order.orderStatus == '요리 중'}">
				<button id="doRiderCall" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					<c:set var="rc" value="3" />
					<c:set var="ms" value="2" />
					라이더 호출
				</button>
			</c:if>
			<c:if test="${order.orderStatus == '픽업 대기중'}">
				<c:set var="rc" value="${order.getOrderMemberId()}" />
				<c:set var="ms" value="2" />
			</c:if>
	    	<input class="input input-bordered" id="sender" type="hidden" value="${rq.getLoginedMemberId()}">
			<input class="input input-bordered" id="message" type="hidden" value="${ms}">
			<input class="input input-bordered" id="recipientId" type="hidden" value="${rc}">
		    <div id="order-notifications" class="mt-6"></div>
		</div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
