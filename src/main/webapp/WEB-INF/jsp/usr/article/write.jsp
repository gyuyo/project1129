<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="글작성" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%@ include file="/WEB-INF/jsp/common/toastUiEditorLib.jsp"%>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<div class="table-box">
			<form action="doWrite" onsubmit="submitForm(this); return false;" method="post">
				<div class="w-9/12 mx-auto">
					<table class="table">
						<tr>
							<th>게시판</th>
							<td>
								<div class="flex">
									<div>
										<label class="flex items-center"> 	
											<input class="radio radio-sm bg-white" type="radio" name="boardId" value="1" />&nbsp; 공지사항
										</label>
									</div>
									<div>
										<label class="flex items-center ml-8"> 
											<input class="radio radio-sm bg-white" type="radio" name="boardId" value="2" checked />&nbsp; 자유게시판
										</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="title" class="bg-black" placeholder="제목을 입력해주세요" ></td>
						</tr>	
						<tr>
							<th>내용</th>
							<td>  
								<input type="hidden" name="body">
  								<div id="toast-ui-editor" class="bg-white"></div>
  							</td>
						</tr>
					</table>
				</div>
				<div class="btns w-9/12 mt-3 mx-auto text-sm flex justify-between">
					<button type="button" onclick="history.back();">뒤로가기</button>
					<button>글작성</button>
				</div>
			</form>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>