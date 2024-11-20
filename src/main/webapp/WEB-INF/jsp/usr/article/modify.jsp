<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	const modifyForm_onSubmit = function(form) {
		form.title.value = form.title.value.trim(); 
		form.body.value = form.body.value.trim(); 
		
		if(form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}
		if(form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return;
		}
		form.submit();
	}
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<form action="doModify" onsubmit="modifyForm_onSubmit(this); return false;" method="post">
				<div class="w-9/12 mx-auto">
					<table class="table">
						<tr>
							<th>번호</th>
							<td><input type="hidden" name="id" value="${article.getId() }">${article.getId() }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${article.getLoginId() }</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><textarea name="title" rows="2" cols="50" class="bg-black" placeholder="제목"></textarea></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="body" rows="2" cols="50" class="bg-black" placeholder="내용"></textarea></td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${article.getRegDate().substring(2, 16) }</td>
						</tr>
						<tr>
							<th>수정일</th>
							<td>${article.getUpdateDate().substring(2, 16) }</td>
						</tr>
					</table>
				</div>
				<div class="btns w-9/12 mt-3 mx-auto text-sm flex justify-between">
					<button type="button" onclick="history.back();">뒤로가기</button>
					<button>수정</button>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>