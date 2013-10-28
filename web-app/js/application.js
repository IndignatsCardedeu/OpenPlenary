/**
 *   OpenPlenary - Open your city council plenaries
 *   Copyright (C) 2013  Indignats de Cardedeu (indignatsdecardedeu@gmail.com)
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function addVote(data, sid){	
	if (data.code=="OK"){
		var block = ""
		if (data.vote==1) {
			block = "#thumbsUp_" + sid;
			$(block).addClass("up_on");
			$(block).removeClass("up");			
		}else {
			block = "#thumbsDown_" + sid;
			$(block).addClass("down_on");
			$(block).removeClass("down");				
		}
		
		var vote = parseInt($(block).html());
		$(block).html(vote+1);
		$("#voteText_" + sid).html(data.code)

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

$(document).ready(function(){
	$('.popup').click(function(event) {
	    var width  = 575,
	        height = 400,
	        left   = ($(window).width()  - width)  / 2,
	        top    = ($(window).height() - height) / 2,
	        url    = this.href,
	        opts   = 'status=1' +
	                 ',width='  + width  +
	                 ',height=' + height +
	                 ',top='    + top    +
	                 ',left='   + left;
	
	    window.open(url, 'Share', opts);
	
	    return false;
	});
});