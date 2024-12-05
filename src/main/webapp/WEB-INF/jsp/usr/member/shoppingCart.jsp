<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	
	$(document).ready(function() {
	    updateTotalPrice();
	});
	
	
	function changeQuantity(menuId, delta, unitPrice) {
	    var $quantityElement = $("#quantity-" + menuId);
	    var $priceElement = $("#price-" + menuId);
	
	    var currentQuantity = parseInt($quantityElement.text());
	    var newQuantity = currentQuantity + delta;
	
	    if (newQuantity <= 0) {
	        var isConfirmed = confirm("메뉴를 취소하시겠습니까?");
	        if (isConfirmed) {
	        	
	        	console.log(menuId);
	        	
	            window.location.href = "/usr/member/menuDelete?menuId=" + menuId;
	        } else {
	            return; 
	        }
	    } else {
	        $quantityElement.text(newQuantity);
	        $priceElement.text((unitPrice * newQuantity).toLocaleString());
	
	        updateMenuQuantity(menuId, newQuantity);
	
	        updateTotalPrice();
	    }
	}
	
	const updateMenuQuantity = function(menuId, newQuantity) {
	    $.ajax({
	        url: '/usr/menu/updateQuantity',
	        type: 'POST',
	        data: {
	            menuId: menuId,
	            quantity: newQuantity
	        },
	        dataType: 'json',
	    });
	}
	
	function updateTotalPrice() {
	    $.ajax({
	        url: '/usr/menu/getTotalPrice', 
	        type: 'GET',  
	        dataType: 'json',  
	        success: function(data) {
	        	$('#totalPrice').text('₩' + data.data.totalPrice.toLocaleString() + '원');
	        	$('#modalTotalPrice').text('₩' + data.data.totalPrice.toLocaleString() + '원');
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패:", status, error);
	        }
	    });
	}

	const orderForm_onSubmit = function(form) {
		form.body.value = form.body.value.trim();
		
		if (form.body.value.length == 0) {
			alert('내용이 없는 댓글은 작성할 수 없습니다');
			form.body.focus();
			return;
		}
		
		form.submit();
	}
	
	const paymentBtn = function() {
		console.log(123);
	    $("#orderModal").removeClass("hidden");
	}
	const cancelBtn = function() {
		console.log(123);
	    $("#orderModal").addClass("hidden");
	}
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div class="space-y-8">
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
		                <div class="flex space-x-2">
		                    <button onclick="changeQuantity(${menu.getMenuId()}, -1, ${menu.getPrice()})" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">−</button>
		                    <button onclick="changeQuantity(${menu.getMenuId()}, 1, ${menu.getPrice()})" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">+</button>
		                </div>
		            </div>
		        </div>
			</c:forEach>
    	</div>
    	<div class="w-9/12 mx-auto mt-6 flex justify-between items-center">
		    <p class="text-lg font-semibold text-[#4B4F54]">합계 금액</p>
		    <p id="totalPrice" class="text-lg font-semibold text-[#4B4F54]"></p>
		</div>
		
		<div class="w-9/12 mx-auto mt-6 flex justify-center">
		    <button onclick="paymentBtn();" class="px-6 py-2 bg-[#7EC8E3] text-white rounded-lg hover:bg-[#4FB8D5] transition-colors">
		        주문하기
		    </button>
		</div>
		
		<div id="orderModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50" onclick="cancelBtn()">
		    <div class="bg-white p-4 px-8 rounded-lg w-[40rem] max-h-[70vh] overflow-y-auto shadow-lg flex flex-col" onclick="event.stopPropagation();">
		        <div class="sticky top-0 bg-white p-2 shadow-lg">
		            <h2 class="text-center text-2xl font-bold mb-4">주문 내역</h2>
		        </div>
		
		        <div class="overflow-y-auto max-h-[50vh]">
		            <c:forEach var="menu" items="${menus}">
		                <div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${menu.getMenuId()}">
		                    <img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
		                    <div class="flex-1">
		                        <h2 class="text-xl font-semibold text-[#4B4F54]">${menu.getName()}</h2>
		                        <p class="text-gray-500 mb-2">${menu.getDescription()}.</p>
		                        <p class="font-bold text-[#4B4F54] mb-2">가격: <span id="price-${menu.getMenuId()}">${menu.getPrice() * menu.getQuantity()}</span>원</p>
		                    </div>
		                    <div class="flex flex-col items-center">
		                        <p class="text-lg font-semibold mb-2">수량: <span id="quantity-${menu.getMenuId()}">${menu.getQuantity()}</span></p>
		                    </div>
		                </div>
		            </c:forEach>
		        </div>
		
		        <div class="w-9/12 mx-auto mt-6 flex justify-between items-center">
		            <p class="text-lg font-semibold text-[#4B4F54]">합계 금액</p>
		            <p id="modalTotalPrice" class="text-lg font-semibold text-[#4B4F54]"></p>
		        </div>
		        <div class="flex justify-between mt-6">
		            <button id="confirmBtn" class="bg-green-500 text-white px-4 py-2 rounded-md">결제하기</button>
		            <button onclick="cancelBtn();" class="bg-red-500 text-white px-4 py-2 rounded-md">취소</button>
		        </div>
		    </div>
		</div>
		
		<div class="btns w-9/12 mx-auto mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>