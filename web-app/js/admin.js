var contextPath;

function displayPartyVotesDialog(subject){
	$( '.vote').val("");
	
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

$(document).ready(function() {
	$(".error").append('<div class="formfielderror"><div class="error-left"></div><div class="error-inner">Check this field</div></div>');
});