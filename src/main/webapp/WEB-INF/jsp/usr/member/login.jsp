<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>

	const loginForm_onSubmit = function(form); {
		form.loginId.value = form.loginId.value.trim(); 
		form.loginPw.value = form.loginPw.value.trim(); 
		
		if(form.loginId.value.length == 0) {
			alter('아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}
		if(form.loginPw.value.length == 0) {
			alter('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}
		form.submit();
	}
	
</script>

<section class="mt-8 flex-1">
	<div class="container mx-auto">
		<form onsubmit="loginForm_onSubmit(this); return false;" action="doLogin" method="post">
			<div class="table-box">
				<table>
					<thead>
						<tr>
							<th>아이디</th>
							<th><input type="text" name="loginId" placeholder="아이디를 입력해주세요" class="bg-black" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>비밀번호</td>
							<td><input type="text" name="loginPw" placeholder="비밀번호를 입력해주세요"class="bg-black" /></td>
						</tr>
						<tr>
							<td colspan="2"><button>로그인</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<div class="btns mt-3 text-sm flex justify-between">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>