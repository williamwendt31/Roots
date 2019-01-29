/**
 * 
 */
$(document).ready(function() {
	$('.modal').modal();
	$('.see').click(function() {
		let postId = $(this).attr('title');
		console.log(postId);
		$.get("/post/" + postId + "/allComments", function(response) {
			$('#see-comments').html(response);
		});
	});
	
	$('.card').on('click', '.clickable', function(event) {
		let postId = $(this).attr('post');
		let action = $(this).attr('action');
		$(this).removeClass('clickable').addClass('gold-font');
		var t = $(this);
		$.get('/post/' + postId + '/' + action, function(response) {
			let output = "<i class='material-icons left'>";
			if (t.attr('action') === 'like') {
				output += "thumb_up</i>";		
			} else {
				output += "thumb_down</i>";	
			}
			output += response;
			t.html(output);
		});
	});
});
