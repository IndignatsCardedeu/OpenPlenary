<div id="partyselect-dialog" title="Basic dialog">
	<g:each in="${parties}" var="item" status="i">
		<div class="party-composition partyselect" onclick="addParty(${item.id});">
			<img src="${createLink(controller:'files', action:'logo', id: item.logo)}" title="${item.name}" alt="${item.name}"/>
		</div> 	
	</g:each>
</div>