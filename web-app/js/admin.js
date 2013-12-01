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

var contextPath;

function displayPartyVotesDialog(subject){
	$('.vote').val("");
	
	$.get(contextPath + '/meeting/getSubjectPartyVotes/' + subject, function(data) {		
		for (i=0; i<data.length; i++){		
			if (data[i].voteUp!=0 || data[i].voteDown!=0 || data[i].abstention){
				$("#voteUp_" + data[i].partyId).val(data[i].voteUp);
				$("#voteDown_" + data[i].partyId).val(data[i].voteDown);
				$("#voteAbstention_" + data[i].partyId).val(data[i].abstention);
			}
		}
	});	
		
	$( '#subjectId').val(subject);
	$( '#votesform-dialog' ).dialog('open');	
}

function displaySubjectAttachmentsDialog(subject){	
	$("#attachmentlist tr").remove();
	$.get(contextPath + '/meeting/getSubjectAttachments/' + subject, function(data) {
		$("#attachmentlist").append(data);
	});
	$('#attachment_subject_id').val(subject);
	$( '#attachmentlist-dialog' ).dialog('open');
}

function attachmentDeleted(data){
	$("#attachment_" + data).remove();
	
	var count = 0;
	
	$("#attachmentlist tr").each(function() {
		  $(this).removeClass("alternate-row");
		  if (count % 2 != 0) $(this).addClass("alternate-row");
		  count++;
	});	
}

function attachmentSaved(data){
	  hideLoading();
	  if (data!="ERROR"){
		  $( "#attachmentform-dialog" ).dialog( "close" );		  
		  $(data).hide().appendTo("#attachmentlist").effect( "highlight", {}, 1000 );
		  if ($("#attachmentlist tr").length % 2 == 0){
			  $("#attachmentlist tr").last().addClass("alternate-row");  
		  }  	  
		  $("#attachmentlist tr").css('display', 'table-row');
	  }
}

function displaySubjectAttachmentsFormDialog(){
	$("#attachmentForm")[0].reset();
	$( '#attachmentform-dialog' ).dialog('open');
}

function setPartyVote(type, party){
	if ($("#vote" + type  + "_" + party).val()==""){
		$(".party_" + party).val(0);
		$("#vote" + type  + "_" + party).val($('#members_' + party).html());
	}
}

function partyVotesSaved(id){
	$( "#subject_" + id ).effect( "highlight", {}, 1000 );
	
}

function setRelevant(data, id){
	if (data!="ERROR"){
		$("#relevant_" + id).removeClass("icon-5-on");
		$("#relevant_" + id).removeClass("icon-5");
		if (data=="true") $("#relevant_" + id).addClass("icon-5-on");
		else $("#relevant_" + id).addClass("icon-5");
	}
}

function removeElement(object){
	$(object).fadeOut(500, function() { $(this).remove(); });
	//$(object).remove().effect( "highlight", {}, 1000 )	;
}

function openDialog(dialog){
	$( dialog ).dialog('open');
}

function addParty(id){
	if ($("#partyComp_" + id).length==0){
		$.get(contextPath + '/mandate/getParty/' + id, function(data) {		
			$(data).hide().appendTo("#party-composition-list").effect( "highlight", {}, 1000 )
		});				
	}else{
		$("#partyComp_" + id).effect( "highlight", {}, 1000 );
	}
	
	$("#partyselect-dialog").dialog("close");
}

function showLoading(){
	$("body").addClass("loading");
}

function hideLoading(){
	$("body").removeClass("loading");
}

$(document).ready(function() {
	$(".error").append('<div class="formfielderror"><div class="error-left"></div><div class="error-inner">Check this field</div></div>');
});