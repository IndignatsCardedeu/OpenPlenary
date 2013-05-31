
<%@ page import="org.mayfifteen.openplenary.Meeting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">		
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
			});
		</script>			
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.meetings.edit.subjects" />: ${meetingInstance.name}</h1>
		</div>	
		<div id="page-content">
			<div id="list-meeting" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no-off">1</div>
					<div class="step-light-left"><g:link controller="meeting" action="edit" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit"/></g:link></div>
					<div class="step-light-right">&nbsp;</div>
					<div class="step-no">2</div>
					<div class="step-dark-left"><g:link controller="meeting" action="subjects" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit.subjects"/></g:link></div>
					<div class="step-dark-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->				
				<table id="product-table">
					<thead>
						<tr>
							<th class="table-header-check"></th>
							
							<th class="table-header-repeat line-left"><a><g:message code="admin.subject.name.label" default="Name" /></a></th>
						
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>						
						</tr>
					</thead>
					<tbody>
					<g:each in="${meetingInstance.subjects}" status="i" var="subject">
						<tr id="subject_${subject.id}" class="${(i % 2) == 0 ? '' : 'alternate-row'}">
						
							<td>${subject.id}</td>						
						
							<td><g:link controller="subject" action="show" id="${subject.id}">${fieldValue(bean: subject, field: "name")}</g:link></td>
							
							<td class="options-width">
								<g:link controller="subject" action="edit" id="${subject.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<a href="#" title="${g.message(code:'admin.meetings.edit.partyVotes')}" onclick="displayPartyVotesDialog(${subject.id});return false;" class="icon-3 info-tooltip"></a>								
								<g:link  controller="subject" action="delete" id="${subject.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
								<g:remoteLink controller="subject" action="relevant" id="${subject.id}" title="Destacat" class="								
									${(subject.relevant) ? 'icon-5-on': 'icon-5'}
									info-tooltip"
									elementId="relevant_${subject.id}"
									onSuccess="setRelevant(data,'${subject.id}')">
								</g:remoteLink>
							</td>						
						</tr>
					</g:each>
					</tbody>
				</table>

				<g:link class="edit form-submit" controller="subject" action="create" id="${meetingInstance?.id}"><g:message code="admin.meeting.subject.button.create.label" default="Add New Subject" /></g:link>

			</div>		
		</div>
		<div id="votesform-dialog" title="Basic dialog">
			<g:formRemote 
				name="partyVoteForm" 
				url="[controller: 'meeting', action:'saveSubjectPartyVotes']"
				onSuccess="partyVotesSaved(data)"
			>
				<input type="hidden" name="subject.id" id="subjectId" />
				<table id="partyvotes-table">
					<thead>
						<tr>
							<th></th>
							<th><img src="${resource(dir: 'images/admin', file: 'voteup.png')}"/></th>
							<th><img src="${resource(dir: 'images/admin', file: 'votedown.png')}"/></th>
							<th><img src="${resource(dir: 'images/admin', file: 'abstention.png')}"/></th>
							<th><img src="${resource(dir: 'images/admin', file: 'members.png')}"/></th>
						</tr>
					</thead>
					<tbody>				
					<g:each in="${meetingInstance.mandate.composition}" var="item" status="i">
						<tr>
							<td>
								<input type="hidden" name="party.id" value="${item.party.id}" />
								<img src="${resource(dir: 'images/parties')}/${item.party.logo}"/>
							</td>
							<td><input type="text" value="" name="voteUp" id="voteUp_${item.party.id}" class="vote party_${item.party.id}" onclick="setPartyVote('Up', ${item.party.id});"/></td>
							<td><input type="text" value="" name="voteDown" id="voteDown_${item.party.id}" class="vote party_${item.party.id}" onclick="setPartyVote('Down', ${item.party.id});"/></td>
							<td><input type="text" value="" name="abstention" id="voteAbstention_${item.party.id}" class="vote party_${item.party.id}" onclick="setPartyVote('Abstention', ${item.party.id});"/></td>
							<td id="members_${item.party.id}">${item.members}</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</g:formRemote>
		</div>						
	</body>
</html>
