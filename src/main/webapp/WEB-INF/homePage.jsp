<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Roots</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="/materialize/css/materialize.min.css"  media="screen,projection"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link type="text/css" rel="stylesheet" href="/css/main.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
</head>
<body>
	<div id="wrapper">
		<div class="navbar-fixed">
			<nav class="black">
	    		<div class="nav-wrapper shorten">
	      			<a href="/" class="brand-logo center hide-on-med-and-down"><img class="logo" src="/logo/logo.png" />Roots</a>
	      			<a href="/" class="brand-logo left hide-on-large-only"><img class="logo" src="/logo/logo.png" />Roots</a>
	      			<ul class="right marg">
	      				<c:choose>
	      					<c:when test="${ currentUser == null }">
					        	<li><a href="/registration" class="btn waves-effect waves-light black white-font">Register<i class="material-icons right">person_add</i></a></li>
					        	<li><a href="/login" class="btn waves-effect waves-light amber darken-4 white-font">Login</a></li>
	      					</c:when>
	      					<c:otherwise>
	      						<li><a href="#newPost" class="btn waves-effect waves-light black modal-trigger white-font">New Post<i class="material-icons right">add</i></a></li>
			        			<li>
									<form id="logoutForm" method="POST" action="/logout">
				     					<button class="btn waves-effect waves-light amber darken-4 white-font" type="submit" name="action">Logout</button>
				 					</form>
				 				</li>
	      					</c:otherwise>
	      				</c:choose>
	      			</ul>
	    		</div>
	  		</nav>
		</div>
  		<!-- New Post Modal -->
		<div id="newPost" class="modal">
		    <div class="modal-content">
		      	<h5>New Post</h5>
		      	<div class="row">
			      	<form action="/post/newPost" method="POST" enctype="multipart/form-data" class="col s12">
			      		<div class="file-field input-field col s12">
			      			<div class="btn black">
				      			<span>File</span>
					      		<input type="file" name="image" id="image" required>
			      			</div>
				      		<div class="file-path-wrapper">
        						<input class="file-path validate" type="text" placeholder="Upload Image">
      						</div>
			      		</div>
						<div class="input-field col s12">
				      		<textarea name="caption" id="caption" class="materialize-textarea"></textarea>
				      		<label for="caption">Caption</label>
						</div>
			      		<button class="btn waves-effect waves-light black white-font" type="submit" name="action">Create Post</button>
			      	</form>
			     </div>
		    </div>
	  	</div>
  	</div>
<script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
<script type="text/javascript" src="/materialize/js/materialize.min.js"></script>
<script type="text/javascript" src="/js/main.js"></script>
</body>
</html>