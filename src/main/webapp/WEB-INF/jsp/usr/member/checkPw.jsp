<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호확인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	const checkPwForm_onSubmit = async function(form) {
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		let member = await getMemberById();
		
		if (member.data.loginPw != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.loginPw.focus();
			return;
		}
		
		form.submit();
	}
	
	const getMemberById = function() {
		return $.ajax({
			url : '/usr/member/getMemberById',
			type : 'GET',
			dataType : 'json'
		})
	}
</script>
	
<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<form action="doCheckPw" method="post"
			onsubmit="checkPwForm_onSubmit(this); return false;">
			<div class="login-table w-9/12 mx-auto">
				<table class="table table-lg mx-auto">
					<tr>
						<td><input class="grow none" type="hidden" name="id" /> <label
							class="input input-bordered flex items-center gap-2 bg-black">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
									fill="currentColor" class="h-4 w-4 opacity-70">
							    <path fill-rule="evenodd"
										d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z"
										clip-rule="evenodd" />
							  </svg><input id="pw" class="grow" type="text" name="loginPw"
								placeholder="비밀번호를 입력해주세요" />
						</label></td>
					</tr>
					<tr>
						<td>
							<div class="flex justify-center">
								<button id="checkPwBtn" onclick="checkPwBtn_onClick();"
									class="btn btn-active btn-wide">확인</button>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div class="btns w-9/12 mt-3 mx-auto text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>