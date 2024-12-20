<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="배달현황" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<div id="map" style="width:100%;height:400px;"></div>
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zd75it6zp1"></script>

<script>
	var addrLatitude = ${restaurant.getLatitude() }
	var addrLongitude = ${restaurant.getLongitude() }

	$(document).ready(function() {
		test1();
		
		$('#dvAcceptBtn').click(function () {
			$.ajax({
	            url: '/usr/rider/doCallAccept', 
	            type: 'GET',
	            data: {
	            	orderNum: ${order.getId()}
		        },
		        success : function() {
					test2();
					location.href = "/usr/rider/deliveryDetail?orderNum=" + ${order.getId()};
		        }
			})
		});
		
		$('#dvStartBtn').click(function () {
			
			addrLatitude = ${member.getLatitude() }
			addrLongitude = ${member.getLongitude() }
			
			$.ajax({
	            url: '/usr/rider/doDelivery', 
	            type: 'GET',
	            data: {
	            	orderNum: ${order.getId()}
		        },
		        success : function() {
					test2();
					location.href = "/usr/rider/deliveryDetail?orderNum=" + ${order.getId()};
		        }
			})
		});
		$('#dvEndBtn').click(function () {
			$.ajax({
	            url: '/usr/rider/deliveryEnd', 
	            type: 'GET',
	            data: {
	            	orderNum: ${order.getId()}
		        },
		        success : function() {
					test2();
					location.href = "/usr/home/main";
		        }
			})
		})
	});
	
	console.log(addrLatitude);
	console.log(addrLongitude);
	
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(addrLatitude, addrLongitude),
	    zoom: 15
	});
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(addrLatitude, addrLongitude),
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
				<c:set var="rc" value="${ownerId}" />
				<button id="dvAcceptBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달콜 접수
				</button>
			</c:if>
			<c:if test="${order.orderStatus == '배달 준비중'}">
				<c:set var="rc" value="${order.getOrderMemberId()}" />
				<button id="dvStartBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달 출발
				</button>
			</c:if>
	    	<c:if test="${order.orderStatus == '배달 중'}">
				<c:set var="rc" value="${order.getOrderMemberId()}" />
				<button id="dvEndBtn" class="bg-green-500 text-white py-2 px-6 rounded-lg hover:bg-green-600 transition-colors shadow-md hover:shadow-lg mb-4 mr-4 text-center inline-block">
					배달 완료
				</button>
			</c:if>
	    	<input class="input input-bordered" id="sender" type="hidden" value="${rq.getLoginedMemberId()}">
			<input class="input input-bordered" id="message" type="hidden" value="1">
			<input class="input input-bordered" id="recipientId" type="hidden" value="${rc}">
		    <div id="order-notifications" class="mt-6"></div>
		</div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>