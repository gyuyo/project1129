<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="장바구니" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	
	$(document).ready(function() {
	    updateTotalPrice();
	    test1();
	    
		$('#confirmBtn').click(function () {
			let restaurantId = $('#restaurantId').val();
			let menus = $('input[name="menus"]').map(function() {
		        return $(this).val();
		    }).get();
			
			$.ajax({
	            url: '/usr/order/doOrder', 
	            type: 'POST', 
	            data: {
	            	restaurantId: restaurantId,
	            	menus: menus
		        },
		        success : function(data) {
					test2();
					location.href = "/usr/order/orderPage";
		        }
			})
		})
	});
	
	async function changeQuantity(menuId, delta, unitPrice) {
	    var $quantityElement = $("#quantity-" + menuId);
	    var $priceElement = $("#price-" + menuId);
		
	    var currentQuantity = parseInt($quantityElement.text());
	    var newQuantity = currentQuantity + delta;
	    
	    if (newQuantity <= 0) {
	        var isConfirmed = confirm("메뉴를 취소하시겠습니까?");
	        if (isConfirmed) {
	            location.href = "/usr/customer/menuDelete?menuId=" + menuId;
	        } else {
	            return; 
	        }
	    } else {
	        $quantityElement.text(newQuantity);
	        $priceElement.text((unitPrice * newQuantity));
	        
	        await updateMenuQuantity(menuId, newQuantity);
	
	        await updateTotalPrice();
	    }
	}
	
	const updateMenuQuantity = function(menuId, newQuantity) {
	    return $.ajax({
	        url: '/usr/menu/updateQuantity',
	        type: 'POST',
	        data: {
	            menuId: menuId,
	            quantity: newQuantity
	        },
	        dataType: 'json'
	    });
	}
	
	function updateTotalPrice() {
		return $.ajax({
	        url: '/usr/menu/getTotalPrice', 
	        type: 'GET',  
	        dataType: 'json',  
	        success: function(data) {
					        	
	        	$('#totalPrice').text('₩' + data.data.totalPrice + '원');
	        	$('#modalTotalPrice').text('₩' + data.data.totalPrice + '원');
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패:", status, error);
	        }
	    });
	}
	
	const paymentBtn = function() {
	    $("#orderModal").removeClass("hidden");
	}
	const cancelBtn = function() {
	    $("#orderModal").addClass("hidden");
	}
	
</script>

<section class="mt-8 flex-1">
	<c:choose>	
		<c:when test="${menus.size() > 0 }">
			<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
				<div class="space-y-8">
			        <c:forEach var="menu" items="${menus }">
				        <div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${menu.getMenuId()}">
				            <img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
				            
				            <div class="flex-1">
				                <a href="/usr/restaurant/detail?id=${menu.getRestaurantId() }" class="text-xl font-semibold text-[#4B4F54]">${menu.getMenuName()}</a>
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
				            	<c:set var="addCartBtn" value="0" />
				                <div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${menu.getMenuId()}">
				                    <img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
				                    <div class="flex-1">
				                        <h2 class="text-xl font-semibold text-[#4B4F54]">${menu.getMenuName()}</h2>
				                        <p class="text-gray-500 mb-2">${menu.getDescription()}.</p>
				                        <p class="font-bold text-[#4B4F54] mb-2">가격: <span id="price-${menu.getMenuId()}">${menu.getPrice() * menu.getQuantity()}</span>원</p>
				                    </div>
				                    <div class="flex flex-col items-center">
				                        <p class="text-lg font-semibold mb-2">수량: <span id="quantity-${menu.getMenuId()}">${menu.getQuantity()}</span></p>
				                    </div>
				                    <input type="hidden" name="restaurantId" id="restaurantId" value="${menu.getRestaurantId() }">
				                    <input type="hidden" name="menus" id="menus" value="${menu.getMenuId()}">
				                </div>
				            </c:forEach>
				        </div>
			
				        <div class="w-9/12 mx-auto mt-6 flex justify-between items-center">
				            <p class="text-lg font-semibold text-[#4B4F54]">합계 금액</p>
				            <p id="modalTotalPrice" class="text-lg font-semibold text-[#4B4F54]"></p>
				        </div>
				        <div>
							<input class="input input-bordered" id="sender" type="hidden" value="${ownerId }">
							<input class="input input-bordered" id="message" type="hidden" value="주문이 접수되었습니다.">
						</div>
				        
				        <div class="flex justify-between mt-6">
				            <button id="confirmBtn" class="bg-green-500 text-white px-4 py-2 rounded-md">주문하기</button>
				            <button type="button" onclick="cancelBtn();" class="bg-red-500 text-white px-4 py-2 rounded-md">취소</button>
				        </div>
				    </div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<section class="mt-8 flex-1 flex flex-col justify-center items-center min-h-[60vh]">
			    <div class="text-center">
			        <p class="text-2xl font-semibold text-gray-700 mb-4">장바구니가 비었습니다.</p>
			        <a href="/usr/home/main" class="px-6 py-2 bg-[#7EC8E3] text-white rounded-lg hover:bg-[#4FB8D5]">
			            담으러 가기
			        </a>
			    </div>
			</section>
		</c:otherwise>
	</c:choose>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>