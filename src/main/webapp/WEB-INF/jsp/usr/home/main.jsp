<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="flex-1">
	<c:if test="${member.getAccessId() == 1 || rq.getLoginedMemberId() == -1 }">
		<section class="container mx-auto grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8 mt-16 px-4">
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#D3B897] to-[#B8A182] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">한식</h3>
		            <p class="text-sm">정통 한국의 맛을 경험하세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=1" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#D18B82] to-[#C17F6C] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">중식</h3>
		            <p class="text-sm">다양한 중화요리의 맛을 즐기세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=2" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#A4B9C8] to-[#93AAB9] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">양식</h3>
		            <p class="text-sm">이탈리안, 프렌치 등 고급스러운 양식을 경험해보세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=3" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#A1B8A9] to-[#A0B2A0] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">일식</h3>
		            <p class="text-sm">정통 일본 요리를 맛보세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                    <a href="/usr/restaurant/list?cgId=4" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#D5A67A] to-[#D1A07B] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">분식</h3>
		            <p class="text-sm">맛있는 떡볶이, 순대, 튀김을 즐기세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
		                <div class="mt-4">
		                	<a href="/usr/restaurant/list?cgId=5" class="bg-gradient-to-b from-[#6EC1E4] to-[#4A9EC3] text-white py-2 px-4 rounded-lg m-2 inline-block text-center">주문하기</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <div class="relative group w-full h-80 bg-gradient-to-b from-[#E0A87F] to-[#E87A5C] rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:scale-105 flex justify-center items-center">
		        <div class="text-center text-white z-10 opacity-100 group-hover:opacity-0 transition-opacity duration-300">
		            <h3 class="text-xl font-semibold">패스트푸드</h3>
		            <p class="text-sm">햄버거, 피자 등 빠르고 맛있는 음식을 즐기세요!</p>
		        </div>
		        <div class="absolute inset-0 bg-black bg-opacity-50 flex justify-center items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
		            <div class="text-center text-white">
		                <h3 class="text-xl font-semibold">서비스</h3>
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