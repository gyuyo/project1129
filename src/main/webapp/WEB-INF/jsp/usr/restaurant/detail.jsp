<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="${restaurant.getName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	$(document).ready(function() {
		if (${rq.getLoginedMemberId() != -1 }) {
			getLoginId();
		}
		getLikePoint();
	})
	
	const getLoginId = function() {
		$.ajax({
			url : '/usr/member/getLoginId',
			type : 'GET',
			dataType : 'text',
			success : function(data) {
				$('#loginedMemberLoginId').html(data);
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
	}
	
	let originalForm = null;
	let originalId = null;
	
	const replyModifyForm = function(i, body) {
		
		if (originalForm != null) {
			replyModifyCancle(originalId);
		}
		
		let replyForm = $('#' + i);
		
		originalForm = replyForm.html();
		originalId = i;
		
		let addHtml = `
			<form action="/usr/reply/doModify" method="post" onsubmit="replyForm_onSubmit(this); return false;">
				<input type="hidden" name="id" value="\${i}" />
				<input type="hidden" name="relId" value="${article.getId() }" />
				<div class="border-2 border-slate-200 rounded-xl px-4 mt-2">
					<div id="loginedMemberLoginId" class="mt-3 mb-2 font-semibold"></div>
					<textarea style="resize:none;" class="textarea textarea-bordered textarea-md  w-full" name="body">\${body }</textarea>
					<div class="flex justify-end mb-2">
						<button onclick="replyModifyCancle(\${i});" type="button" class="btn btn-active btn-sm mr-2">취소</button>
						<button class="btn btn-active btn-sm">수정</button>
					</div>
				</div>
			</form>`;
			
		replyForm.html(addHtml);
		getLoginId();
	}
	
	const replyModifyCancle = function(i) {
		let replyForm = $('#' + i);
		
		replyForm.html(originalForm);
		
		originalForm = null;
		originalId = null;
	}
	
	const clickLikePoint = async function() {
		
		let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid');
		
		await $.ajax({
			url : '/usr/likePoint/clickLikePoint',
			type : 'GET',
			data : {
				restaurantId : ${restaurant.getId() },
				likePointBtn : likePointBtn
			}
		})
		
		await getLikePoint();
	}
	
	const getLikePoint = function() {
		$.ajax({
			url : '/usr/likePoint/getLikePoint',
			type : 'GET',
			data : {
				restaurantId : ${restaurant.getId() }
			},
			dataType : 'json',
			success : function(data) {
				$('#likeCnt').html(data.data);
				
				if (data.success) {
					$('#likePointBtn').html(`<i class="fa-solid fa-heart"></i>`);
				} else {
					$('#likePointBtn').html(`<i class="fa-regular fa-heart"></i>`);
				}
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
	}
	
	const doAddCart = function(menuId) {
		
		$.ajax({
			url : '/usr/member/addCart',
			type : 'GET',
			data : {
				menuId : menuId
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					if (data.data == null) {
		                const messageDiv = document.getElementById('message');
		                messageDiv.classList.remove('hidden');
		
		                setTimeout(function() {
		                    messageDiv.classList.add('hidden');
		                }, 1500);
		                
		                $('#addCartButton-' + menuId).remove();

		                
					} else { 
						alert(data.resultMsg);
						return;
					}
	            }
				if (data.fail) {
					alert(data.resultMsg);
					return;
	            }
	        },
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
		
	}
	
	function changeQuantity(menuId, delta) {
	    var $quantityElement = $("#quantity-" + menuId);
		
	    console.log($quantityElement);
	    
	    var currentQuantity = parseInt($quantityElement.text());
	    var newQuantity = currentQuantity + delta;
		
	    console.log(currentQuantity);
	    console.log(newQuantity);
	    
	    if (newQuantity <= 0) {
	        var isConfirmed = confirm("메뉴를 취소하시겠습니까?");
	        if (isConfirmed) {
	            window.location.href = "/usr/member/menuDelete?menuId=" + menuId;
	        } else {
	            return; 
	        }
	    } else {
	        $quantityElement.text(newQuantity);
	        updateMenuQuantity(menuId, newQuantity);
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

</script>


<section class="mt-8 flex-1">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div class="mx-auto">
			<section class="container mx-auto mt-16 px-4">
			    <div class="text-center mb-8">
			        <h2 class="text-3xl font-bold text-gray-800">${restaurant.getName() }</h2>
			        <p class="text-lg text-gray-600">정통 한국의 맛을 자랑하는 레스토랑</p>
			    </div>
			    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
					<c:forEach var="menu" items="${menus }">
						<c:set var="chk" value="true" />
				        <div class="relative group w-full h-64 bg-white rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex flex-col justify-center items-center p-4">
				            <h4 class="text-lg font-semibold text-gray-800">${menu.getName() }</h4>
				            <p class="text-sm text-gray-600">${menu.getDescription() }</p>
				            <p class="text-xl font-semibold text-gray-800 mt-2">₩${menu.getPrice() }</p>
							<c:forEach var="shoppingCart" items="${shoppingCarts }">
								<c:if test="${chk}">
									<c:choose>
									<c:when test="${menu.getId() == shoppingCart.getMenuId() }">
										<c:set var="addCartBtn" value="0" />
										<c:set var="chk" value="false" />
									</c:when>
									<c:otherwise>
										<c:set var="addCartBtn" value="1" />
									</c:otherwise>
					            	</c:choose>
					            </c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${addCartBtn == 0}">
							    <div class="flex items-center space-x-4" id="quantity-buttons-${menu.getId()}">
									<button onclick="changeQuantity(${menu.getId()}, -1)" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">−</button>
										<div id="quantity-${menu.getId()}" class="text-lg font-semibold w-8 text-center">${menu.getQuantity()}</div>
									<button onclick="changeQuantity(${menu.getId()}, 1)" class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-gray-400">+</button>
								</div>
								</c:when>
								<c:otherwise>
						            <button onclick="doAddCart(${menu.getId()});" id="addCartButton-${menu.getId()}" class="mt-4 bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg w-full">
						            장바구니에 추가
						            </button>
								</c:otherwise>
							</c:choose>
				        </div>
					</c:forEach>
			    </div>
			    <div id="message" class="fixed bottom-0 left-0 right-0 bg-blue-500 text-white p-4 rounded-lg hidden text-center">
			        메뉴를 담았습니다.
			    </div>
			</section>
		</div>
		<div class="flex justify-around mt-8">
			<c:if test="${rq.getLoginedMemberId() == -1 }">
				<button class="btn btn-sm text-base" onclick="alert('로그인 후 이용가능합니다.')">
					<span id="likeCnt"></span>
					<span id="likePointBtn"></span>
				</button>
			</c:if>
			<c:if test="${rq.getLoginedMemberId() != -1 }">
				<button class="btn btn-sm text-base" onclick="clickLikePoint();">
					<span id="likeCnt"></span>
					<span id="likePointBtn"></span>
				</button>
			</c:if>
		</div>
		<div class="btns mx-auto my-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<script>
	const replyForm_onSubmit = function(form) {
		form.body.value = form.body.value.trim();
		
		if (form.body.value.length == 0) {
			alert('내용이 없는 댓글은 작성할 수 없습니다');
			form.body.focus();
			return;
		}
		
		form.submit();
	}
</script>

<section class="my-8">
	<div class="container mx-auto px-4 text-base w-9/12">
		<div class="text-lg">댓글</div>
		<c:forEach var="reply" items="${replies }">
			<div id="${reply.getId() }" class="py-2 border-b-2 border-slate-200 pl-20">
				<div class="flex justify-between items-center">
					<div class="font-semibold">${reply.getLoginId() }</div>
				    <c:if test="${rq.getLoginedMemberId() == reply.memberId }">
				    	<div class="dropdown mr-2">
						  <div tabindex="0" role="button" class="btn btn-sm btn-circle btn-ghost m-1">
						  	<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block h-5 w-5 stroke-current">
						      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path>
						    </svg>
						  </div>
						  <ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-24 p-2 shadow border border-black">
						    <li><button onclick="replyModifyForm(${reply.getId() }, '${reply.getBody() }');">수정</button></li>
						    <li><a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="/usr/reply/doDelete?id=${reply.getId() }&relId=${article.getId() }" >삭제</a></li>
						  </ul>
						</div>
				    </c:if>
				</div>
				<div class="text-lg my-1 ml-2">${reply.getForPrintBody() }</div>
				<div class="text-xs text-gray-400">${reply.getRegDate() }</div>
			</div>
		</c:forEach>
		
		<c:if test="${rq.getLoginedMemberId() != -1 }">
			<form action="/usr/reply/doWrite" method="post" onsubmit="replyForm_onSubmit(this); return false;">
				<input type="hidden" name="restaurantId" value="${restaurant.getId() }" />
				<div class="border-2 border-slate-200 rounded-xl px-4 mt-2">
					<div id="loginedMemberLoginId" class="mt-3 mb-2 font-semibold"></div>
					<textarea style="resize:none;" class="textarea textarea-bordered textarea-md w-full" name="body"></textarea>
					<div class="flex justify-end mb-2">
						<button class="btn btn-active btn-sm">작성</button>
					</div>
				</div>
			</form>
		</c:if>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>