<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="아이디 찾기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
	const findLoginId = async function() {
		let inputName = $("input[name='name']");
		let inputEmail = $("input[name='email']");
		
		let inputNameTrim = inputName.val(inputName.val().trim());
		let inputEmailTrim = inputEmail.val(inputEmail.val().trim());
		
		if (inputNameTrim.val().length == 0) {
			alert('이름을 입력해주세요');
			inputName.focus();
			return;
		}
		
		if (inputEmailTrim.val().length == 0) {
			alert('이메일을 입력해주세요');
			inputEmail.focus();
			return;
		}

		const rs = await doFindLoginId(inputNameTrim.val(), inputEmailTrim.val());

		if (rs) {
			alert(rs.resultMsg);
			if (rs.success) {
				location.replace("login");
			} else {
				inputName.val('');
				inputEmail.val('');
				inputName.focus();
			}
		}
	}
	
	const doFindLoginId = function(name, email) {
		return $.ajax({
			url : '/usr/member/doFindLoginId',
			type : 'GET',
			data : {
				name : name,
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
					<th>이름</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="name" /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="email" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="flex justify-center">
							<button onclick="findLoginId();" class="btn btn-active btn-wide">아이디 찾기</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="mt-2 flex justify-end">
			<div>
				<a class="btn btn-active btn-sm" href="findLoginPw">비밀번호 찾기</a>
				<a class="btn btn-active btn-sm mx-2" href="login">로그인</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>