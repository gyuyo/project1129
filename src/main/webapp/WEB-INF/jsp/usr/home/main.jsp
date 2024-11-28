<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	$(document).ready(function() {
		
	})
</script>


<section class="mt-8 flex-1">
	<div class="container w-9/12 mx-auto">
		<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
			Perspiciatis laudantium quod expedita quae tenetur maxime modi
			commodi non esse minus nostrum voluptates necessitatibus ipsum
			reprehenderit architecto recusandae eligendi mollitia tempore.</div>
		<div>안녕하세요</div>
		<br />
		<div class="main-thumbnail-img inline-block border border-white rounded-xl">
			<img src="https://picsum.photos/id/202/500/280" class="rounded-xl">
		</div>
		<div>
			<div></div>
			<div></div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>