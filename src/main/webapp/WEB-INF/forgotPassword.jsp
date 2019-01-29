<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retrieve Password</title>
<link rel="stylesheet" type="text/css" href="/css/forgotPassword.css" />
</head>
<body>
	<%@include file="homePage.jsp"%>
	<div id="wrapper">
		<div id="main" class="shorten">
			<div class="row">
				<div class="col s12 m6 offset-m3 l4 offset-l4">
					<p><c:out value="${ message }"/></p>
					<form action="/forgotPassword" method="POST">
						<div class="input-field col s12">
							<input type="email" name="email" id="email" validate>
							<label for="email">Email</label>
						</div>
						<button class="btn waves-effect waves-light black" type="submit" name="action">Retrieve Password</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>