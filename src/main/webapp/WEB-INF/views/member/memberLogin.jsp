<%@page import="com.kh.icodi.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" />    
<main>
	<div class="login-container">
		<h1>LOGIN</h1>
		<form id="loginFrm" name="loginFrm"
			action="<%= request.getContextPath()%>/member/memberLogin" method="POST">
			<div class="loginForm">
				<div>
					<ul>
						<li class="old"><a href="<%=request.getContextPath()%>/">기존회원이신가요?</a></li>
						<li class="new"><a href="<%=request.getContextPath()%>/member/memberEnroll">회원가입</a></li>
					</ul>
					<input type="text" name="memberId" id="memberId" placeholder="아이디" value="<%= saveId != null ? saveId : "" %>"> 
					<input type="password" name="password" id="password" placeholder="비밀번호"> 
					<input type="submit" class="submitBtn" value="로그인"> 
					<input type="checkbox" name="saveId" id="saveId" <%= saveId != null ? "checked" : "" %>/> 
					<label for="saveId" >아이디저장</label>
				</div>
				<div class="link">
					<a href="<%= request.getContextPath()%>/member/memberIdFind" id="findId">아이디찾기</a> <span class="findBorderRight"></span>
					<a href="<%= request.getContextPath()%>/member/memberPwFind" id="findPw">비밀번호찾기</a>
				</div>
			</div>
		</form>
	</div>
</main>
<script>
//로그인 유효성
<% if(loginMember == null){ %>

	document.loginFrm.addEventListener('submit', (e) => {
		e.preventDefault();
		
		const memberIdVal = document.querySelector("#memberId").value;
		const passwordVal = document.querySelector("#password").value;
		
		if(!/^.{4,}$/.test(memberId.value)){
			alert("유효한 아이디를 입력해주세요.");
			memberId.select();
			return false;
		}
		if(!/^.{4,}$/.test(password.value)){
			alert("유효한 비밀번호를 입력해주세요.");
			password.select();
			return false;
		}
		
		$.ajax({
			url: '<%= request.getContextPath() %>/member/memberLogin',
			dataType: 'json',
			method: 'post',
			data : {
				memberId : memberId.value,
				password : password.value
			},
			success(response) {
				console.log(response, typeof response);
				const re = response['loginRe'];
				console.log(re, typeof re);
				if(re === 1) {
					window.location = document.referrer;
				}
				else {
					location.reload();
				}
			},
			error : console.log
			
		});
	});
<% } %>	


</script>
</body>
</html>