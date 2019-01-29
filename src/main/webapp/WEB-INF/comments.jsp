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
	<div class="modal-content">
		<h5>All Comments</h5>
		<ul class="collection">
		<c:forEach items="${ allComments }" var="comment">
			<li class="collection-item">
				<h6><a href="/profile/${ comment.user.id }"><c:out value="${ comment.user.username }"/></a> - </h6>
				<p><c:out value="${ comment.comment }"/></p>
			</li>
		</c:forEach>
		</ul>
	</div>
	<div class="modal-footer">
		<a class="modal-close waves-effect waves-green btn-flat">Close</a>
	</div>
</body>
</html>