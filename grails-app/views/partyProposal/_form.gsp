<%@ page import="org.mayfifteen.openplenary.PartyProposal" %>



<div class="fieldcontain ${hasErrors(bean: partyVoteInstance, field: 'party', 'error')} required">
	<label for="party">
		<g:message code="partyVote.party.label" default="Party" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="party" name="party.id" from="${org.mayfifteen.openplenary.Party.list()}" optionKey="id" required="" value="${partyVoteInstance?.party?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: partyVoteInstance, field: 'subject', 'error')} required">
	<label for="subject">
		<g:message code="partyVote.subject.label" default="Subject" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject" name="subject.id" from="${org.mayfifteen.openplenary.Subject.list()}" optionKey="id" required="" value="${partyVoteInstance?.subject?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: partyVoteInstance, field: 'vote', 'error')} required">
	<label for="vote">
		<g:message code="partyVote.vote.label" default="Vote" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vote" type="number" value="${partyVoteInstance.vote}" required=""/>
</div>

