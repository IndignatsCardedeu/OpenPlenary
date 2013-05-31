
<%@ page import="org.mayfifteen.openplenary.PartyProposal" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'partyVote.label', default: 'PartyVote')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-partyVote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-partyVote" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="partyVote.party.label" default="Party" /></th>
					
						<th><g:message code="partyVote.subject.label" default="Subject" /></th>
					
						<g:sortableColumn property="vote" title="${message(code: 'partyVote.vote.label', default: 'Vote')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${partyVoteInstanceList}" status="i" var="partyVoteInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${partyVoteInstance.id}">${fieldValue(bean: partyVoteInstance, field: "party")}</g:link></td>
					
						<td>${fieldValue(bean: partyVoteInstance, field: "subject")}</td>
					
						<td>${fieldValue(bean: partyVoteInstance, field: "vote")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${partyVoteInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
