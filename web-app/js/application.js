if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function addVote(data, block){	
	if (data.code=="OK"){
		var vote = parseInt($(block).html());
		$(block).html(vote+1);

		if (data.vote==1){
			$(block).addClass("up_on");
			$(block).removeClass("up");
		}else{
			$(block).addClass("down_on");
			$(block).removeClass("down");			
		}
	}else{
		if (data.code!="error"){
			$("#notloggedin_title").html(data.title);
			$("#notloggedin_message_1").html(data.message1);
			$("#notloggedin_message_2").html(data.message2);
			$.colorbox({inline: true, href: "#notloggedin"});
		}
	}
}

function overlayArea(area){
	$t = $(area);

	$("#overlay").css({
	  opacity: 0.8,
	  top: $t.offset().top,
	  left: $t.offset().left,
	  width: $t.outerWidth(),
	  height: $t.outerHeight()
	});

	$("#img-load").css({
	  top:  ($t.height() / 2.5),
	  left: ($t.width() / 3)
	});

   $("#overlay").show();
	
}

function putComment(data){
	if ($("#subject_comments .user_comment").size()==0) $("#subject_comments p").remove();
	$("#comment").val("");
	$("#overlay").hide();
	$(data).hide().appendTo("#subject_comments").fadeIn(1000);	
}

function validateComment(){
	var comment = $("#comment").val().replace(/\s+/g, '');
	if (comment!="") overlayArea('#commentsForm');
	return (comment!="") 
}
