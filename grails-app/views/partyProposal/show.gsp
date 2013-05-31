
<%@ page import="org.mayfifteen.openplenary.PartyProposal" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'partyVote.label', default: 'PartyVote')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-partyVote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-partyVote" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list partyVote">
			
				<g:if test="${partyVoteInstance?.party}">
				<li class="fieldcontain">
					<span id="party-label" class="property-label"><g:message code="partyVote.party.label" default="Party" /></span>
					
						<span class="property-value" aria-labelledby="party-label"><g:link controller="politicalParty" action="show" id="${partyVoteInstance?.party?.id}">${partyVoteInstance?.party?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${partyVoteInstance?.subject}">
				<li class="fieldcontain">
					<span id="subject-label" class="property-label"><g:message code="partyVote.subject.label" default="Subject" /></span>
					
						<span class="property-value" aria-labelledby="subject-label"><g:link controller="subject" action="show" id="${partyVoteInstance?.subject?.id}">${partyVoteInstance?.subject?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${partyVoteInstance?.vote}">
				<li class="fieldcontain">
					<span id="vote-label" class="property-label"><g:message code="partyVote.vote.label" default="Vote" /></span>
					
						<span class="property-value" aria-labelledby="vote-label"><g:fieldValue bean="${partyVoteInstance}" field="vote"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${partyVoteInstance?.id}" />
					<g:link class="edit" action="edit" id="${partyVoteInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
