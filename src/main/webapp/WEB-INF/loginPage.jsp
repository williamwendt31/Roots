<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>Login Page</title>
<link type="text/css" rel="stylesheet" href="/css/loginStyle.css">
</head>
<body>
	<div>
		<%@include file="homePage.jsp"%>
		<div class="row" id="main-content">
			<div class="col s12 m6 offset-m3 l4 offset-l4">
			   <h5>Login!</h5>
			   <c:if test="${errorMessage != null}">
			       <p class="errors"><c:out value="${errorMessage}"/></p>
			   </c:if>
			   <div class="row">
				   <form method="POST" action="/login">
				       <div class="input-field col s12">
				           <input type="text" id="username" name="username" required>
				           <label for="username">Username</label>
				       </div>
				       <div class="input-field col s12">
				           <input type="password" id="password" name="password" required>
				           <label for="password">Password</label>
				       </div>
				       <button class="btn waves-effect waves-light amber darken-4" type="submit" name="action">Login</button>
					  	<a href="/forgotPassword" class="btn waves-effect waves-dark black forgot white-font">Forgot Password?</a>
				  	</form>
			  	</div>
			
			</div>
		</div>
  	</div>
</body>
</html>