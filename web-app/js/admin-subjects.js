$(document).ready(function() {
	$( "#votesform-dialog" ).dialog({
		autoOpen: false,					 
		 modal: true,
		 width: 340,
		 buttons: {
			 "Save": function() {				 
				$("#partyVoteForm").submit();
			 	$( this ).dialog( "close" );
			  },
		 	  Cancel: function() {
		 		$( this ).dialog( "close" );
			}
		 }					 					
	});

	$( "#attachmentform-dialog" ).dialog({
		autoOpen: false,					 
		 modal: true,
		 width: 420,
		 buttons: {
			  "Save": function(){
				  showLoading();
				  
				  var options = { 
			            success: attachmentSaved, 
			            error  : hideLoading
			          }; 	
						
				  $("#attachmentForm").ajaxSubmit(options);				  
			  },						 
		 	  Cancel: function() {
	 		    $( this ).dialog( "close" );
			  }
		 }					 					
	});		

	$( "#attachmentlist-dialog" ).dialog({
		autoOpen: false,					 
		 modal: true,
		 width: 500,
		 height: 310,
		 buttons: {
			  "Add": function(){
				  displaySubjectAttachmentsFormDialog();  
			  },
		 	  Cancel: function() {
	 		    $( this ).dialog( "close" );
			  }
		 }					 					
	});		
	
	$('#attachmentForm').ajaxForm();
	
});