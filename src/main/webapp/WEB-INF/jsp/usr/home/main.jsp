<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="flex-1">
	<c:if test="${member.getAccessId() == 1 || rq.getLoginedMemberId() == -1 }">
		<section class="container mx-auto grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8 mt-16 px-4">
			<div class="relative group w-full h-80 rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
			    <img src="https://img.freepik.com/free-vector/flat-design-korean-food-illustration_23-2149285208.jpg?t=st=1734086496~exp=1734090096~hmac=53d34cae946e466986b0b6878b647276231d0a506e9287126a3d342c6d51685a&w=1380" alt="한식" class="absolute inset-0 w-full h-full object-cover z-0">
			    
			    <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300 z-10">
			        <div class="text-center text-white">
			            <h3 class="text-xl font-semibold">한식</h3>
			            <div class="mt-4">
			                <a href="/usr/restaurant/list?cgId=1" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">
			                    주문하기
			                </a>
			            </div>
			        </div>
			    </div>
			</div>
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#D18B82] to-[#C17F6C] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <img src="https://as1.ftcdn.net/v2/jpg/03/56/90/88/1000_F_356908884_G2qET0JjuDile7g93ZpcewouqfI7ys54.jpg" alt="중식" class="absolute inset-0 w-full h-full object-cover z-0">
		        
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">중식</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=2" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#A4B9C8] to-[#93AAB9] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <img src="https://img.freepik.com/premium-vector/spagetti-steak-close-up-desk-background-with-some-leaves-props_1639-16522.jpg" alt="양식" class="absolute inset-0 w-full h-full object-cover z-0">
		        
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">양식</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=3" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#A1B8A9] to-[#A0B2A0] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <img src="https://img.lovepik.com/png/20231018/Attractive-Japanese-food-sashimi-mustard-a-fish-fillet-side-dishes_254691_wh860.png" alt="일식" class="absolute inset-0 w-full h-full object-cover z-0">
		        
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">일식</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=4" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#D5A67A] to-[#D1A07B] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <img src="https://as1.ftcdn.net/v2/jpg/03/56/90/94/1000_F_356909435_jmpC3up9t35vwVleYNnbyxAok2oqzIuZ.jpg" alt="분식" class="absolute inset-0 w-full h-full object-cover z-0">
		        
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">분식</h3>
		                <div class="mt-4">
		                	<a href="/usr/restaurant/list?cgId=5" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#E0A87F] to-[#E87A5C] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <img src="https://img.freepik.com/free-vector/cute-fast-food-dessert-cartoon-vector-icon-illustration-fast-food-icon-isolated-flat-vector_138676-10428.jpg" alt="패스트푸드" class="absolute inset-0 w-full h-full object-cover z-0">
		        	
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">패스트푸드</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=6" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
	</c:if>
	<c:if test="${member.getAccessId() == 2}">
		<section class="flex flex-col md:flex-row mt-8 justify-center space-y-8 md:space-y-0 md:space-x-8 px-8">
		    <div class="relative group w-full md:w-1/2 h-80 bg-gradient-to-b from-[#4B7BB1] to-[#3A6F98] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">새 업장 등록하기</h3>
		            <p class="text-sm">새로운 업장을 등록하여 더 많은 고객을 만나보세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/register" class="bg-[#FF7F50] text-white py-2 px-4 rounded-lg m-2 cursor-pointer">새 업장 등록</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full md:w-1/2 h-80 bg-gradient-to-b from-[#32CD32] to-[#2C8A2C] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">내 업장 관리하기</h3>
		            <p class="text-sm">기존 업장을 관리하고 서비스를 개선하세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/manageShop" class="bg-[#FF7F50] text-white py-2 px-4 rounded-lg m-2 cursor-pointer">내 업장 관리</a>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
	</c:if>
	<c:if test="${member.getAccessId() == 3}">
		<section class="flex justify-center mt-8 px-8">
		    <div class="relative group w-full md:w-1/2 h-80 bg-gradient-to-b from-[#FFD700] to-[#FF8C00] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">주문 접수 활성화</h3>
		            <p class="text-sm">주문을 접수하여 서비스 준비를 시작하세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <button class="bg-[#FF7F50] text-white py-2 px-4 rounded-lg m-2 cursor-pointer" onclick="alert('주문 접수가 활성화되었습니다.')">주문 접수 활성화</button>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
	</c:if>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>