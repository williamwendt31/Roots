/**
 * 
 */
$(document).ready(function() {
	$('.sidenav').sidenav();
	$('.modal').modal();
	
	$('.collapsible').collapsible();
	
	$('.sort').click(function() {
		let sort = $(this).attr('title');
		console.log(sort);
		$.get('/sort/' + sort, function(response) {
			$('#posts').html(response);
		});
	});
	
	$('.follow').click(function() {
		let userId = $(this).attr('title');
		$.get('/followers/' + userId, function(response) {
			$('#followersModal').html(response);
		});
	});
	
	$('.following').click(function() {
		let userId = $(this).attr('title');
		$.get('/following/' + userId, function(response) {
			$('#followingModal').html(response);
		});
	});
	
	$('.likedPosts').click(function() {
		let userId = $(this).attr('title');
		$.get('/likedPosts/' + userId, function(response) {
			$('#posts').html(response);
		});
	});
	
	$('.dislikedPosts').click(function() {
		let userId = $(this).attr('title');
		$.get('/dislikedPosts/' + userId, function(response) {
			$('#posts').html(response);
		});
	});
});