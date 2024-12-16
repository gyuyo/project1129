<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="주문현황" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	$(document).ready(function() {
		callListReload();
		
		let socket = new SockJS('/ws-stomp');
   		let stompClient = Stomp.over(socket);
   		
	    stompClient.connect({}, function () {
	    	stompClient.subscribe('/sub/message', function (message) {
				callListReload();
	            });
	        });
 	});
	
	const callListReload = function() {
	    $.ajax({
	        url: '/usr/rider/getCallList',
	        type: 'GET',
	        dataType : 'json',
			success : function(data) {
				
				console.log(data.data);
	        	var callListBody = $('#callListBody');
	        	callListBody.empty();
	            var waitingCount = 0;
	            
				for (let i = 0; i < data.data.length; i++) {
	                var order = data.data[i];
	               	if(order.orderStatus.trim() === "픽업 대기중") {
	               		waitingCount++;
	               	}
	                var orderRow = `
	                    <tr>
	                        <td>${i + 1}</td>
	                        <td class="hover:underline"><a href="deliveryDetail?orderId=\${order.orderMemberId}">대전광역시</a></td>
	                        <td>\${order.orderMemberId}</td>
	                        <td>\${order.quantity}</td>
	                        <td>\${order.totalPrice}</td>
	                        <td>\${order.orderStatus}</td> 
	                    </tr>
	                `;
	                callListBody.append(orderRow); 
					 };
				$('#waitingCount').text(`\${waitingCount}`);
				
				if (waitingCount > 0) {
	                $('#waitingCount').removeClass('hidden');
	            } else {
	                $('#waitingCount').addClass('hidden');
	            }
			},
	    })
	}
	
</script>
<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
		    <div class="w-9/12 mx-auto">
		        <table class="table">
		            <colgroup>
		                <col width="60"/>
		                <col />
		                <col width="100"/>
		                <col width="100"/>
		                <col width="120"/>
		                <col width="120"/>
		            </colgroup>
		            <tr>
		                <th>번호</th>
		                <th>주소</th>
		                <th>매장이름</th>
		                <th>메뉴수</th>
		                <th>합계금액</th>
		                <th>주문 상태</th>
		            </tr>
		            <tbody id="callListBody">
		            </tbody>
		        </table>
		        <div id="waitingCountContainer" class="absolute top-6 right-40 z-50">
				    <span id="waitingCount" class="hidden bg-red-500 text-white text-lg font-bold py-1.5 px-3 rounded-full min-w-[35px] h-[35px] flex items-center justify-center border-2 border-white">
				        0
				    </span>
				</div>
		    </div>
		</div>
		<div class="w-9/12 mx-auto btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
	<div class="flex justify-center mt-8">
		<div class="join">
			
			<c:set var="path" value="?cgId=${category.getId() }" />
			<c:if test="${from != 1 }">
				<a href="${path}&cPage=1" class="join-item btn btn-square" type="radio">
					<i class="fa-solid fa-angles-left"></i></a>
				<a href="${path}&cPage=${from - 1 }" class="join-item btn btn-square" type="radio">
					<i class="fa-solid fa-angle-left"></i></a>
			</c:if>
				<c:forEach var="i" begin="${from }" end="${end }">
					<a class="join-item btn btn-square ${cPage == i ? 'btn-active' : '' }" href="${path }&cPage=${i }">${i }</a>
  				</c:forEach>
  			<c:if test="${end != totalPagesCnt }">
  				<a href="${path}&cPage=${end + 1 }" class="join-item btn btn-square" type="radio"><i class="fa-solid fa-angle-right"></i></a>
  				<a href="${path}&cPage=${totalPagesCnt }" class="join-item btn btn-square" type="radio"><i class="fa-solid fa-angles-right"></i></a>
  			</c:if>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>