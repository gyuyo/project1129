<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메뉴 수정하기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto border-b-2  w-9/12 border-slate-200">
		<div class="container mx-auto p-6">
	    <div class="max-w-2xl mx-auto bg-white p-8 rounded-xl shadow-md">
	        <h2 class="text-2xl font-semibold text-gray-800 mb-6">메뉴 수정</h2>
	        
	        <form action="/usr/menu/doModifyMenu">
	            <div class="mb-4">
	            	<input type="hidden" name="menuId" value="${menu.getId() }" />
	                <label for="menuName" class="block text-gray-700 font-medium">메뉴 이름</label>
	                <input 
	                    type="text" 
	                    id="menuName" 
	                    name="menuName" 
	                    value="${menu.getMenuName()}"
	                    class="mt-2 p-3 w-full border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
	                    required
	                >
	            </div>
	
	            <div class="mb-4">
	                <label for="menuDescription" class="block text-gray-700 font-medium">메뉴 설명</label>
	                <textarea 
	                    id="menuDescription" 
	                    name="menuDescription" 
	                    rows="4" 
	                    class="mt-2 p-3 w-full border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
	                    required
	                >${menu.getDescription()}</textarea>
	            </div>
	
	            <div class="mb-4">
	                <label for="menuPrice" class="block text-gray-700 font-medium">메뉴 가격</label>
	                <input 
	                    type="number" 
	                    id="menuPrice" 
	                    name="menuPrice" 
	                    value="${menu.getPrice()}"
	                    class="mt-2 p-3 w-full border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
	                    required
	                    min="0"
	                >
	            </div>
	
	            <div class="mb-4">
	                <label for="prepTime" class="block text-gray-700 font-medium">준비 시간 (분)</label>
	                <input 
	                    type="number" 
	                    id="readyTime" 
	                    name="readyTime" 
	                    value="${menu.getReadyTime()}"
	                    class="mt-2 p-3 w-full border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
	                    required
	                    min="1"
	                >
	            </div>
	
	            <div class="mt-6">
	                <button type="submit" class="w-full py-3 bg-gradient-to-b from-[#A3D9A5] to-[#6CCF6A] text-white font-semibold rounded-lg shadow-lg transform transition duration-200 hover:scale-105 hover:shadow-xl">
	                    수정 완료
	                </button>
	            </div>
	        </form>
	    </div>
	</div>
	</div>
</section>


<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>