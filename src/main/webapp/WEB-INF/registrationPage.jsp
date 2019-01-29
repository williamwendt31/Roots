<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration Page</title>
<link rel="stylesheet" type="text/css" href="/css/registrationStyle.css" />
</head>
<body>
	<div id="wrapper">
		<%@include file="homePage.jsp"%>
		<div id="main-content" class="row">
			<div class="col s12 m6 offset-m3 l4 offset-l4">
			    <h5>Register!</h5>
			    <p class="errors"><form:errors path="user.*"/></p>
			    <p class="errors"><c:out value="${ error }"/></p>
			    <div class="row">
				    <form:form method="POST" action="/registration" modelAttribute="user">
				        <div class="input-field col s12">
				            <form:input id="username" path="username"/>
				            <form:label path="username">Username</form:label>
				        </div>
				       <div class="input-field col s12">
				            <form:input id="email" path="email"/>
				            <form:label path="email">Email</form:label>
				       </div>
				       <div class="input-field col s12">
				            <form:password id="password" path="password"/>
				            <form:label path="password">Password</form:label>
				       </div>
				        <div class="input-field col s12">
				            <form:password id="passwordConf" path="passwordConf"/>
				            <form:label path="passwordConf">Password Confirmation</form:label>
				       </div>
				        <button class="btn waves-effect waves-light amber darken-4" type="submit" name="action">Register!
		    				<i class="material-icons right">border_color</i>
		  				</button>
				    </form:form>
			    </div>
			</div>
		</div>
	</div>
</body>
</html>