<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="배달현황" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	$(document).ready(function() {
		test1();
		
		$('#dvAcceptBtn').click(function () {
		    location.href = '/usr/rider/doCallAccept?orderNum=' + ${order.getId()};
			test2();
		})
		$('#dvStartBtn').click(function () {
		    location.href = '/usr/rider/doDelivery?orderNum=' + ${order.getId()};
			test2();
		})
		$('#dvEndBtn').click(function () {
		    location.href = '/usr/rider/deliveryEnd?orderNum=' + ${order.getId()};
			test2();
		})
	});
	
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
	        <h3 class="text-2xl font-semibold text-gray-800">${order.getOrderStatus() }</h3>
	    </div>
	
	    <div class="mt-8 text-center">
			<c:if test="${order.orderStatus == '픽업 대기중'}">
				<c:set var="sd" value="${ownerId } " />
				<button id="dvAcceptBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달콜 접수
				</button>
			</c:if>
			<c:if test="${order.orderStatus == '배달 준비중'}">
				<c:set var="sd" value="${order.getOrderMemberId()} " />
				<button id="dvStartBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달 출발
				</button>
			</c:if>
	    	<c:if test="${order.orderStatus == '배달 중'}">
				<c:set var="sd" value="${order.getOrderMemberId()} " />
				<button id="dvEndBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달 완료
				</button>
			</c:if>
	    	<input class="input input-bordered" id="sender" type="hidden" value="${sd }">
			<input class="input input-bordered" id="message" type="hidden" value="1">
		    <div id="order-notifications" class="mt-6"></div>
		</div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>