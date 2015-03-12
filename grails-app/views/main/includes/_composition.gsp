<h2><g:message code="mandate.composition"/></h2>
<g:each in="${parties}" var="item">
	<div class="affinity_block">
 		<g:link controller="main" action="party" id="${item.party.id}" params="${[mandate: mandate.id]}"><img src="${createLink(controller:'files', action:'logo', id: item.party.logo)}" alt="${item.party.name}" title="${item.party.name}"/></g:link> 
		${item.members} 
	</div>
</g:each>