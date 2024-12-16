<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="배달현황" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	$(document).ready(function() {
		
		let socket = new SockJS('/ws-stomp');
   		let stompClient = Stomp.over(socket);
   		
	    stompClient.connect({}, function () {
	    	stompClient.subscribe('/sub/message', function (message) {
	    		
	    	});
	   	});
	})
	
// 	const orderStatusReload = function() {
// 	    $.ajax({
// 	        url: '/usr/order/updateOrder',
// 	        type: 'GET',
// 	        dataType : 'json',
// 			success : function(data) {
// 				$('#orderStatus').text(data.data.orderStatus);
// 				if(data.data.orderStatus != '대기 중') {
// 					$('#cancleBtn').text('주문 진행중')
// 	                   .prop('disabled', true)
// 				}
// 		    },
// 			error : function(xhr, status, error) {
// 				console.log(error);
// 			}
// 	    })
// 	}
	
</script>
	<div id="map" style="width:100%;height:400px;"></div>
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zd75it6zp1"></script>
		<script>
		var map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(36.352722549264534, 127.3797320189312),
		    zoom: 13
		});
		var marker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(36.352722549264534, 127.3797320189312),
		    map: map
		});
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
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>