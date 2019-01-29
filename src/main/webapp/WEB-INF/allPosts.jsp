<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
</head>
<body>
	<c:forEach items="${ allPosts }" var="post">  				
		<div class="row">
			<div class="col s12">
	     		<div class="card long">
		        	<div class="card-image">
		          		<img src="${ post.imagePath }" class="resize">
		        	</div>
		        	<div class="card-content">
		        		<p><a href="/profile/${ post.creator.id }" class="black-link"><c:out value="${ post.creator.username }" /></a> - <c:out value="${ post.caption }"/></p>
		        	</div>
			        <div class="card-action">
			        	<!-- spring security takes care of non-users trying to access any of these by url -->
			        	<c:choose>
			        		<c:when test="${ post.likes.contains(currentUser) || currentUser == null }">
			        			<button class="waves-effect waves-light btn-small btn-flat white gold-font"><i class="material-icons left">thumb_up</i> <c:out value="${ post.numLikes }"/></button>
			        		</c:when>
			        		<c:otherwise>
					        	<button class="waves-effect waves-light btn-small btn-flat white black-link clickable" post="${ post.id }" action="like"><i class="material-icons left">thumb_up</i> <c:out value="${ post.numLikes }"/></button>
			        		</c:otherwise>
			        	</c:choose>
			        	<c:choose>
			        		<c:when test="${ post.dislikes.contains(currentUser) || currentUser == null}">
			        			<button class="waves-effect waves-light btn-small btn-flat white gold-font"><i class="material-icons left">thumb_down</i> <c:out value="${ post.numDislikes }"/></button>
			        		</c:when>
			        		<c:otherwise>
					        	<button class="waves-effect waves-light btn-small btn-flat white black-link clickable" post="${ post.id }" action="dislike"><i class="material-icons left">thumb_down</i> <c:out value="${ post.numDislikes }"/></button> 
			        		</c:otherwise>
			        	</c:choose>
			        	<a href="#see-comments" class="btn-flat modal-trigger see black-link" title="${ post.id }">See Comments</a>
			        	<a href="#modal${ post.id }" class="btn-flat black comm modal-trigger white-font">Comment</a>
			        </div>
	     		</div>
			</div>
			
			<!--  posting comment modal -->
			<div id="modal${ post.id }" class="modal">
				<div class="modal-content">
					<div class="row">
						<h5>Post a Comment</h5>
						<form action="/post/${ post.id }/newComment" method="POST" class="col s12">
							<div class="input-field col s12">
								<textarea id="comment" name="comment" class="materialize-textarea"></textarea>
								<label for="comment">Comment</label>
							</div>
							<button class="btn waves-effect waves-light black" type="submit" name="action">Post Comment</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
  			
 	<!-- changing profile pic -->
   	<div class="modal" id="changeProfilePic">
		<div class="modal-content">
			<div class="row">
				<form action="/changeProfilePic" method="POST" enctype="multipart/form-data" class="col s12">
					<input type="hidden" name="_method" value="PUT">
					<h5>Change Profile Picture</h5>
					<div class="file-field input-field col s12">
		      			<div class="btn black">
			      			<span>File</span>
				      		<input type="file" name="image" id="image" required>
		      			</div>
			      		<div class="file-path-wrapper">
       						<input class="file-path validate" type="text" placeholder="Upload an Image">
     					</div>
		      		</div>
		      		<button class="btn waves-effect waves-light amber darken-4">Update Profile</button>
				</form>
			</div>
		</div>
	</div>
		
	<!--  deleting account modal -->
	<div class="modal" id="deleteAccount">
		<div class="modal-content">
			<h5>Are you sure want to delete your account?</h5>
		</div>
		<div class="modal-footer">
			<a href="/" class="btn-flat">NO</a>
			<form action="/deleteAccount" method="POST">
				<input type="hidden" name="_method" value="DELETE">
				<button class="btn waves-effect waves-light red darken-4">YES</button>
			</form>
		</div>
	</div>
	
	<!--  followers modal -->
	<div class="modal" id="followersModal"></div>
	
	<!--  following modal -->
	<div class="modal" id="followingModal"></div>
	
	<!--  view comments modal -->
	<div id="see-comments" class="modal modal-fixed-footer"></div>
<script type="text/javascript" src="/js/post.js"></script>
</body>
</html>