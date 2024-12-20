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
	
</script>
	

<section class="mt-8 flex-1 px-4">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div id="map" class="h-96" tabindex="0"></div>
		<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zd75it6zp1"></script>
			<script>
			var map = new naver.maps.Map('map', {
			    center: new naver.maps.LatLng(${restaurant.getLatitude() }, ${restaurant.getLongitude() }),
			    zoom: 15
			});
			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(${restaurant.getLatitude() }, ${restaurant.getLongitude() }),
			    map: map
			});
			</script>
	    <div class="bg-blue-100 p-4 rounded-lg shadow-lg text-center mb-6">
	        <h3 class="text-2xl font-semibold text-gray-800">${order.getOrderStatus() }</h3>
	    </div>
	
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>