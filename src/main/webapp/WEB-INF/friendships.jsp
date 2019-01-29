<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/friendshipsStyle.css" />
</head>
<body>
	<div class="modal-content">
		<c:choose>
			<c:when test="${ followers == true }">
				<h5>Followers</h5>
			</c:when>
			<c:otherwise>
				<h5>Following</h5>
			</c:otherwise>
		</c:choose>
		<ul class="collection">
			<c:choose>
				<c:when test="${ followers == true }">
					<c:forEach items="${ allFriends }" var="friendship">
						<li class="collection-item">
							<a href="/profile/${ friendship.user.id }"><img src="${ friendship.user.profilePicPath }" class="profile-pic circle responsive-img z-depth-2"><span class="users"><c:out value="${ friendship.user.username }"/></span></a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ allFriends }" var="friendship">
						<li class="collection-item">
							<a href="/profile/${ friendship.friend.id }"><img src="${ friendship.friend.profilePicPath }" class="profile-pic circle responsive-img z-depth-2"><span class="users"><c:out value="${ friendship.friend.username }"/></span></a>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<div class="modal-footer">
		<a class="modal-close waves-effect waves-green btn-flat">Close</a>
	</div>
</body>
</html>