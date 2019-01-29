<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Roots</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="homePage.jsp"%>
		<div id="main" class="row shorten">
  			<div class="col s12 l4 side">
  				<div class="row">
  					<div class="col s12">
  						<div class="mid">
	  						<ul class="collection">
		  						<c:if test="${ currentUser != null }">
		  						<li class="collection-item avatar">
			  						<a href="#!" data-target="slide-out" class="sidenav-trigger"><img src="${ currentUser.profilePicPath }" class="profile-pic circle"></a>
			  							<p><a href="#!" data-target="slide-out" class="sidenav-trigger username"><c:out value="${ currentUser.username }"/></a></p>
		  								<p class="username"><c:out value="${ currentUser.numberOfFollowers }" /> Followers</p>
		  						</li>
		  						</c:if>
		  						<li class="collection-item btn-flat it"><a href="/" class="black-link"><i class="material-icons left">home</i>Home</a></li>
	  							<li class="collection-item sort btn-flat it" title="popular"><i class="material-icons left">grade</i>Most Popular</li>
	  							<li class="collection-item sort btn-flat it" title="recent"><i class="material-icons left">access_time</i>Most Recent</li>
	  						</ul>  						
  						</div>
  					</div>
				</div>
  			</div>
  			<div class="col s12 m8 l4 side" id="posts">
  				<%@include file="allPosts.jsp"%>
  			</div>
  			<div class="col hide-on-med-and-down l4 rside">
  				<h5>Most Popular People</h5>
  				<ul class="collection">
  					<c:forEach items="${ popularUsers }" var="user">
  						<li class="collection-item avatar">
  							<img src="${ user.profilePicPath }" class="circle users-pic">
  							<p><a href="/profile/${ user.id }" class="black-link"><c:out value="${ user.username }" /></a></p>
  							<p><c:out value="${ user.numberOfFollowers }" /> Followers</p>
  						</li>
  					</c:forEach>
  				</ul>
  			</div>
  		</div>
	</div>
	<ul id="slide-out" class="sidenav">
	    <li><div class="user-view">
	      <div class="background">
	        <img src="${ currentUser.backgroundPicPath }">
	      </div>
	      <a><img class="circle" src="${ currentUser.profilePicPath }"></a>
	      <a><span class="white-text name"><c:out value="${ currentUser.username }"/></span></a>
	      <a><span class="white-text email"><c:out value="${ currentUser.email }"/></span></a>
	    </div></li>
	    <li><a href="/profile/${ currentUser.id }" class="waves-effect">Profile Page</a></li>
	    <li><a href="#followersModal" title="${ currentUser.id }" class="waves-effect modal-trigger follow">Followers <span class="badge"><c:out value="${ currentUser.followers.size() }"/></span></a></li>
	    <li><a href="#followingModal" title="${ currentUser.id }" class="waves-effect modal-trigger following">Following <span class="badge"><c:out value="${ currentUser.following.size() }"/></span></a></li>
	    <li><div class="divider"></div></li>
	    <li><a href="#changeProfilePic" class="waves-effect modal-trigger">Change Profile Picture</a></li>
	    <li><a href="/changePassword" class="waves-effect">Change Password</a></li>
	    <li><div class="divider"></div></li>
	    <li><a href="#deleteAccount" class="waves-effect modal-trigger">Delete Account</a>
	</ul>
</body>
</html>