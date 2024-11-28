<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="게시글수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%@ include file="/WEB-INF/jsp/common/toastUiEditorLib.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<form action="doModify" onsubmit="submitForm(this); return false;" method="post">
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
							<td><input type="text" name="title" class="bg-black" placeholder="제목을 입력해주세요" value="${article.getTitle() }"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td>  
								<input type="hidden" name="body">
  								<div id="toast-ui-editor" class="bg-white">
  									<script>${article.getBody() }</script>
  								</div>
  							</td>
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