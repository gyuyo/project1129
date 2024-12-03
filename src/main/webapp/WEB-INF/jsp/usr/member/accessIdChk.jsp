<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="권한확인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="flex mt-8 justify-center flex-1">
    <form action="join" method="POST" class="inline-block mx-8">
    	<input type="hidden" name="accessId" value="1" />
        <button type="submit" class="artboard phone-1 inline-block border border-black rounded-2xl bg-gradient-to-b from-[#FF7F50] to-white flex justify-center items-center text-center font-bold text-xl p-6">
            사용자용
        </button>
    </form>

    <form action="join" method="POST" class="inline-block mx-8">
    	<input type="hidden" name="accessId" value="2" />
        <button type="submit" class="artboard phone-1 inline-block border border-black rounded-2xl bg-gradient-to-b from-[#32CD32] to-white flex justify-center items-center text-center font-bold text-xl p-6">
            업주용
        </button>
    </form>

    <form action="join" method="POST" class="inline-block mx-8">
    	<input type="hidden" name="accessId" value="3" />
        <button type="submit" class="artboard phone-1 inline-block border border-black rounded-2xl bg-gradient-to-b from-[#00BFFF] to-white flex justify-center items-center text-center font-bold text-xl p-6">
            라이더용
        </button>
    </form>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>