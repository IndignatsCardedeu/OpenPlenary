<h2><g:message code="main.affinity.party"/></h2>
<g:each in="${affinities}" var="item">
	<div class="affinity_block">
		<g:link controller="main" action="party" id="${item.partyId}"><img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/></g:link> 
		${item.value}% 
	</div>
</g:each>