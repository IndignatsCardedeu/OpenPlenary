<div id="partyaffinityList" class="partyaffinity">
	<h2><g:message code="main.affinity.party"/></h2>
	<g:each in="${affinities}" var="item">
		<div class="affinity_block
			<g:if test="${item.partyId==partyId}">
				selected
			</g:if> 	
		">
		<g:if test="${multiple}">
			<g:remoteLink 
				controller="main" 
				action="partyAffinitiesGraph" 
				params="${[party: item.partyId, mandate: mandate.id]}" 				
				onLoaded="showPartyAffinityGraph(data, '#partyAffinities')"
			>
				<img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/>
			</g:remoteLink>
		</g:if>
		<g:else>
			<g:link controller="main" action="party" id="${item.partyId}" params="${[mandate: mandate.id]}"> 
				<img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/>
			</g:link>
		</g:else>
			${item.value}% 		
		</div>
	</g:each>
</div>
<gvisualization:lineCoreChart 
	title="${g.message([code: 'main.affinity.party.evolution'])}"
	elementId="partyaffs" 
	dynamicLoading="${true}"
	width="690" 
	height="400" 
	axisTitlesPosition="in"
	chartArea="${new Expando(width: '540', height: '80%', left:40)}"								
	vAxis="${new Expando(title: '%')}" 
	hAxis="${new Expando(title: 'Date')}" 
	series="${new Expando(affColors)}"
	columns="${affCols}" data="${affData}" 
/>	
<div id="partyaffs" class="graph"></div>