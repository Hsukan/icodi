<%@page import="com.kh.icodi.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
%>
    <!doctype html>
    <html lang="en">
    <head>
    	<meta charset="UTF-8" />
    	<title>Document</title>
    </head>
    <body>
<section id=enroll-container>
		<h2>비밀번호 변경</h2>
		<form 
			name="passwordUpdateFrm" 
			action="<%=request.getContextPath()%>/member/memberPasswordUpdate" 
			method="post" >
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="oldPassword" id="oldPassword" required></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="newPassword" id="newPassword" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>	
						<input type="password" id="newPasswordCheck" required><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit"  value="변경" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
		</form>
	</section>
	<script>
	/**
	 * 비밀번호 일치여부 검사
	 */
	 document.querySelector("#newPasswordCheck").onblur = (e) => {
			const password = document.querySelector("#newPassword");
			const passwordCheck = e.target;
			if(password.value !== passwordCheck.value){
				alert("비밀번호가 일치하지 않습니다.");
				password.select();
			}
		};
		
		document.passwordUpdateFrm.onsubmit = () => {
			const oldPassword = document.querySelector("#oldPassword");
			const newPassword = document.querySelector("#newPassword");
			const re = /^[a-zA-z0-9!@#$%^&*()]{4,}$/;
			if(!re.test(oldPassword.value)){
				alert("비밀번호는 영문자/숫자/!@#$%^&*()로 최소 4글자이상이어야 합니다.");
				oldPassword.select();
				return false;
			}
			if(!re.test(newPassword.value)){
				alert("새 비밀번호는 영문자/숫자/!@#$%^&*()로 최소 4글자이상이어야 합니다.");
				newPassword.select();
				return false;
			}
			
			const newPasswordCheck = document.querySelector("#newPasswordCheck");
			if(newPassword.value !== newPasswordCheck.value){
				alert("비밀번호가 일치하지 않습니다.");
				newPassword.select();
				return false;
			}
		};
	
	</script>
	</body>
    </html>