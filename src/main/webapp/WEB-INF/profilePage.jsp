<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
<link type="text/css" rel="stylesheet" href="/css/profileStyle.css">
</head>
<body>
	<div id="wrapper">
	<%@include file="homePage.jsp"%>
		<div id="main" class="row shorten">
  			<div class="col s12 m5 l4 profile">
  				<div class="row">
  					<div class="col s8 offset-s2">
  						<h5 class="user"><c:out value="${ profileUser.username }"/></h5>
		  				<img src="${ profileUser.profilePicPath }" id="profilePagePic" class="pic">
		  				<c:if test="${ !currentUser.id.equals(profileUser.id) }">
		  					<c:choose>
		  					<c:when test="${ !currentUser.following.contains(profileUser) }">
		  					<a class="button waves-effect waves-light white" href="/follow/${ profileUser.id }">Follow <i class="material-icons right">person_add</i></a>
		  					</c:when>
		  					<c:otherwise>
		  					<a class="button">Already Following</a>
		  					</c:otherwise>
		  					</c:choose>
		  				</c:if>
		  				<ul class="collection col s12">
		  					<li class="collection-item"><a href="#followersModal" class="modal-trigger follow black-link" title="${ profileUser.id }">Followers <span class="badge"><c:out value="${ profileUser.followers.size() }"/></span></a></li>
		  					<li class="collection-item"><a href="#followingModal" class="modal-trigger following black-link" title="${ profileUser.id }">Following <span class="badge"><c:out value="${ profileUser.following.size() }"/></span></a></li>
		  					<li class="collection-item"><a href="#!" class="likedPosts black-link" title="${ profileUser.id }">Liked Posts <span class="badge"><c:out value="${ profileUser.likes.size() }"/></span></a></li>
		  					<li class="collection-item"><a href="#!" class="dislikedPosts black-link" title="${ profileUser.id }">Disliked Posts <span class="badge"><c:out value="${ profileUser.dislikes.size() }"/></span></a></li>
		  					<li class="collection-item">Posts <span class="badge"><c:out value="${ profileUser.posts.size() }"/></span></li>
		  				</ul>
  					</div>
  				</div>
  			</div>
  			<div class="col s12 m7 l4" id="posts">
  				<%@include file="allPosts.jsp" %>
  			</div>
  			<div class="col l4">
  			</div>
		</div>
	</div>
</body>
</html>