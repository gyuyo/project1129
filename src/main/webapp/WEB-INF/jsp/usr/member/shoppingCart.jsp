<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	
let menuItems = [];

    function changeQuantity(menuId, delta, unitPrice) {
        var quantityElement = document.getElementById("quantity-" + menuId);
        var priceElement = document.getElementById("price-" + menuId);
        
        var currentQuantity = parseInt(quantityElement.textContent);
        var newQuantity = currentQuantity + delta;
        
        if (newQuantity <= 0) {
            var isConfirmed = confirm("메뉴를 취소하시겠습니까?");
            if (isConfirmed) {
                window.location.href = "/usr/member/menuDelete?menuId=" + menuId;
            } else {
                return;
            }
        } else {
            quantityElement.textContent = newQuantity;
            priceElement.textContent = (unitPrice * newQuantity).toLocaleString();
            updateTotalPrice();
        }
    }
    
    function updateTotalPrice() {
        let total = 0;
        // 모든 메뉴 항목에 대해 합계 계산
        document.querySelectorAll('.flex').forEach(function(menuDiv) {
            const menuId = menuDiv.querySelector('input[type="hidden"]').value;
            const unitPrice = parseInt(menuDiv.querySelector('.font-bold').textContent.replace('원', '').replace(',', ''));
            const quantity = parseInt(menuDiv.querySelector(`#quantity-${menuId}`).textContent);
            total += unitPrice * quantity;
        });

        // totalPrice 요소에 합계 금액 표시
        document.getElementById("totalPrice").textContent = "₩" + total.toLocaleString();
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
	
	$(function() {
		$('#paymentBtn').click(function() {
			$('#modalLayer-bg').show();
			$('#modalLayer').show();
		})
		
		$('#closeBtn').click(function() {
			$('#modalLayer-bg').hide();
			$('#modalLayer').hide();
		})
		
		$('#modalLayer-bg').click(function() {
			$('#modalLayer-bg').hide();
			$('#modalLayer').hide();
		})
	})
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div class="space-y-8">
	        <c:forEach var="menu" items="${menus }">
		        <div class="flex items-center bg-white p-6 rounded-lg shadow-lg" id="menu-${menu.getId()}">
		            <img src="https://via.placeholder.com/150" alt="Menu Image" class="w-24 h-24 object-cover rounded-lg mr-6">
		            
		            <div class="flex-1">
		                <h2 class="text-xl font-semibold text-[#4B4F54]">${menu.getName()}</h2>
		                <p class="text-gray-500 mb-2">${menu.getDescription()}.</p>
		                <p class="font-bold text-[#4B4F54] mb-2">가격: <span id="price-${menu.getId()}">${menu.getPrice()}</span>원</p>
		            </div>
		
		            <div class="flex flex-col items-center">
		                <p class="text-lg font-semibold mb-2">수량: <span id="quantity-${menu.getId()}">1</span></p>
		                <div class="flex space-x-2">
		                    <button onclick="changeQuantity(${menu.getId()}, -1, ${menu.getPrice()})" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">−</button>
		                    <button onclick="changeQuantity(${menu.getId()}, 1, ${menu.getPrice()})" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">+</button>
		                </div>
		            </div>
		        </div>
			</c:forEach>
    	</div>
    	<div class="w-9/12 mx-auto mt-6 flex justify-between items-center">
		    <p class="text-lg font-semibold text-[#4B4F54]">합계 금액</p>
		    <p id="totalPrice" class="text-lg font-semibold text-[#4B4F54]">₩0</p>
		</div>
		<div class="w-9/12 mx-auto mt-6 flex justify-center">
			<button id="paymentBtn" class="px-6 py-2 bg-[#7EC8E3] text-white rounded-lg hover:bg-[#4FB8D5] transition-colors">주문하기</button>
		</div>
    	<div id="modalLayer-bg" class="fixed top-0 left-0 right-0 bottom-0 bg-black bg-opacity-50 hidden"></div>
		<div id="modalLayer" class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-6 rounded-lg shadow-lg w-96 hidden">
			<div id="orderItems"></div>
			<div id="totalPrice"></div>
			<button id="closeBtn" class="mt-4 bg-gray-300 text-black py-2 px-4 rounded-lg">CLOSE</button>
		</div>
		<div class="btns w-9/12 mx-auto mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>