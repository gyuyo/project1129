<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html data-theme="light">
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<!-- 테일윈드CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- daisy UI -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css" />
<!-- JQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
<!-- WebSocket사용을 위한 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- common css -->
<link rel="stylesheet" href="/resource/common.css" />

</head>
<body class="header min-h-screen flex flex-col bg-[#F5F5DC]">
    <div class="bg-gradient-to-br from-[#FF7F50] to-[#FF6347] text-white py-4 shadow-md">
	    <nav class="max-w-screen-xl mx-auto flex justify-between items-center">
	        <ul class="flex space-x-8 items-center">
	            <li><a href="/" class="text-white font-semibold px-4 py-2 rounded-lg transition-all hover:text-[#FFD700]">홈</a></li>
	        </ul>
	        <ul class="flex space-x-8 items-center">
	            <c:if test="${rq.getLoginedMemberId() == -1 }">
	                <li class="flex items-center min-h-[40px]">
	                    <div data-tip="LOGIN">
	                        <a href="${pageContext.request.contextPath}/usr/member/login">
	                            <button class="text-white hover:text-[#FFD700] px-4 py-2">로그인</button>
	                        </a>
	                    </div>
	                </li>
	                <li class="flex items-center min-h-[40px]">
	                    <div data-tip="JOIN">
	                        <a href="${pageContext.request.contextPath}/usr/member/accessIdChk">
	                            <button class="btn bg-[#FF4500] text-white hover:bg-[#FF6347] hover:shadow-xl border-0 rounded-lg px-5 py-2 transition-all">
	                                회원가입
	                            </button>
	                        </a>
	                    </div>
	                </li>
	            </c:if>
	            <c:if test="${rq.getLoginedMemberId() != -1 }">
	                <script>
	                $(document).ready(function() {
	                    orderInfo();
	                    accessIdChk();
	                    let socket = new SockJS('/ws-stomp');
	                    let stompClient = Stomp.over(socket);
	                    
	                    function test1() {
	                        stompClient.connect({}, function () {});
	                    }
	                    
	                    function test2() {
	                        let sender = $('#sender').val();
	                        let content = $('#message').val();
	                        stompClient.send('/pub/messages', {}, JSON.stringify({
	                            sender: sender,
	                            content: content
	                        }));
	                    }
	                    window.test1 = test1;
	                    window.test2 = test2;
	                });
	                
	                function orderInfo() {
	                    $.ajax({
	                        url: '/usr/order/addOrderInfo', 
	                        type: 'GET',  
	                        dataType: 'json',  
	                        success: function(data) {
	                            if(data.data != null){
	                                $("#orderInfo").removeClass("hidden");
	                            }
	                        },
	                        error: function(xhr, status, error) {
	                            console.error("AJAX 요청 실패:", status, error);
	                        }
	                    });
	                }
	                
	                function accessIdChk() {
	                    $.ajax({
	                        url: '/usr/member/accessIdNumChk', 
	                        type: 'GET',  
	                        dataType: 'json',  
	                        success: function(data) {
	                        	
	                            if(data.data == 2){
	                                $("#shoppingCartBtn").addClass("hidden");
	                                $("#riderChkBtn").addClass("hidden");
	                                $("#orderChkBtn").removeClass("hidden");
	                            } else if(data.data == 3){
	                                $("#shoppingCartBtn").addClass("hidden");
	                                $("#orderChkBtn").addClass("hidden");
	                                $("#riderChkBtn").removeClass("hidden");
	                            } else {
	                                $("#orderChkBtn").addClass("hidden");
	                                $("#riderChkBtn").addClass("hidden");
	                                $("#shoppingCartBtn").removeClass("hidden");
	                            }
	                        },
	                        error: function(xhr, status, error) {
	                            console.error("AJAX 요청 실패:", status, error);
	                        }
	                    });
	                }
	                </script>
	                <li id="orderInfo" class="hidden flex items-center min-h-[40px]">
	                    <div data-tip="ORDER INFO">
	                        <a href="${pageContext.request.contextPath}/usr/order/orderPage?loginId=${rq.getLoginedMemberId() }">
	                            <button class="text-white hover:text-[#FFD700] px-4 py-2"><i class="fa-solid fa-jet-fighter"></i></button>
	                        </a>
	                    </div>
	                </li>
	                <li id="orderChkBtn" class="flex items-center min-h-[40px]">
	                    <div data-tip="ORDER CHK">
	                        <a href="${pageContext.request.contextPath}/usr/order/orderList">
	                            <button class="text-white hover:text-[#FFD700] px-4 py-2"><i class="fa-solid fa-clipboard-check"></i></button>
	                        </a>
	                    </div>
	                </li>
	                <li id="riderChkBtn" class="flex items-center min-h-[40px]">
	                    <div data-tip="RIDER CHK">
	                        <a href="${pageContext.request.contextPath}/usr/rider/callList">
	                            <button class="text-white hover:text-[#FFD700] px-4 py-2"><i class="fa-solid fa-motorcycle"></i></button>
	                        </a>
	                    </div>
	                </li>
	                <li id="shoppingCartBtn" class="flex items-center min-h-[40px]">
	                    <div data-tip="SHOPPING CART">
	                        <a href="${pageContext.request.contextPath}/usr/customer/shoppingCart">
	                            <button class="text-white hover:text-[#FFD700] px-4 py-2"><i class="fa-solid fa-cart-shopping"></i></button>
	                        </a>
	                    </div>
	                </li>
	                <li class="flex items-center min-h-[40px]">
	                    <details class="dropdown">
	                        <summary class="btn m-1 bg-[#FF7F50] hover:bg-[#FF6347] text-white px-4 py-2 rounded-lg">
	                            <i class="fa-solid fa-gear"></i>
	                        </summary>
	                        <ul class="menu dropdown-content rounded-box z-[1] w-52 p-2 shadow bg-gradient-to-br from-[#FF7F50] to-[#FF6347]">
	                            <li><a href="${pageContext.request.contextPath}/usr/member/myPage">내 정보 보기</a></li>
	                            <li><a href="${pageContext.request.contextPath}/usr/member/doLogout">로그아웃</a></li>
	                        </ul>
	                    </details>
	                </li>
	            </c:if>
	        </ul>
	    </nav>
	</div>
