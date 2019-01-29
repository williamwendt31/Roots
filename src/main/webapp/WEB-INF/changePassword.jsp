<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<%@ page isErrorPage="true" %> 
</head>
<body>
	<%@include file="homePage.jsp"%>
	<div id="main">
		<div class="row">
			<div class="col s12 m6 offset-m3 l4 offset-l4">
				<form action="/changePassword" method="POST">
					<h5>Change Password</h5>
					<p class="errors"><c:out value="${ error }"/></p>
					<input type="hidden" name="_method" value="PUT">
					<div class="input-field col s12">
						<input type="password" name="oldPassword" id="oldPassword" required>
						<label for="oldPassword">Old Password</label>
					</div>
					<div class="input-field col s12">
						<input type="password" name="newPassword" id="newPassword" required>
						<label for="newPassword">New Password</label>
					</div>
					<div class="input-field col s12">
						<input type="password" name="newPasswordConf" id="newPasswordConf" required>
						<label for="newPasswordConf">New Password Confirmation</label>
					</div>
					<button class="btn waves-effect waves-light amber darken-4">Change Password</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>