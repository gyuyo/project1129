<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 찾기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	const findLoginPw = async function() {
		let inputLoginId = $("input[name='loginId']");
		let inputEmail = $("input[name='email']");
		
		let inputLoginIdTrim = inputLoginId.val(inputLoginId.val().trim());
		let inputEmailTrim = inputEmail.val(inputEmail.val().trim());
		
		if (inputLoginIdTrim.val().length == 0) {
			alert('아이디를 입력해주세요');
			inputLoginId.focus();
			return;
		}
		
		if (inputEmailTrim.val().length == 0) {
			alert('이메일을 입력해주세요');
			inputEmail.focus();
			return;
		}

		$('#findBtn').prop('disabled', true);
		$('#loading').show();
		
		const rs = await doFindLoginPw(inputLoginIdTrim.val(), inputEmailTrim.val());

		if (rs) {
			alert(rs.resultMsg);
			$('#loading').hide();
			$('#findBtn').prop('disabled', false);
			if (rs.success) {
				location.replace("login");
			} else {
				inputLoginId.val('');
				inputEmail.val('');
				inputLoginId.focus();
			}
		}
	}
	
	const doFindLoginPw = function(loginId, email) {
		return $.ajax({
			url : '/usr/member/doFindLoginPw',
			type : 'GET',
			data : {
				loginId : loginId,
				email : email
			},
			dataType : 'json'
		})
	}
</script>

<section class="mt-8">
	<div class="container mx-auto">
		<div class="w-6/12 mx-auto">
			<table class="table table-lg">
				<tr>
					<th>아이디</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="loginId" /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="email" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="flex justify-center">
							<button id="findBtn" onclick="findLoginPw();" class="btn btn-active btn-wide">비밀번호 찾기</button>
							<div id="loading">
								<div class="spinner"></div>
								<p>작업을 처리 중입니다. 잠시만 기다려주세요...</p>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="mt-2 flex justify-end">
			<div>
				<a class="btn btn-active btn-sm" href="findLoginId">아이디 찾기</a>
				<a class="btn btn-active btn-sm mx-2" href="login">로그인</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>