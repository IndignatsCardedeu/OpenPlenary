<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: ${party.description} (${party.name})</title>
		<g:javascript library="jquery" />
		<gvisualization:apiImport/>
	</head>
	<body>		
		<div id="meetings-box">
			<div class="meeting"> 
				<div class="party-name">
		    		<span class="image"><img src="${createLink(controller:'files', action:'logo', id: party.logo)}"/></span>
		    		${party.description}
		    		<span class="legisinfo">${mandate.name}</span>
	    		</div>
	    	</div> 		    	
	    	<div class="partyAffinities">
	    		<op:partyAffinitiesChart party="${party.id}" mandate="${mandate.id}"/>
	    	</div>
			<div class="info_block">
				<div class="party_info_block">
					<h2><g:message code="party.proposals.author"/></h2> 
					<g:message code="main.total"/>: ${totalProposals}
					<ul>
						<g:each in="${proposals}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>		
					<div class="last_meeting_footer">
						<g:link action="proposals" id="${party.id}" params="${[mandate: mandate.id]}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>							
				</div>
				<div class="party_info_block">
					<h2><g:message code="party.proposals.tags"/></h2>
					<op:tagCloud controller="tag" action="party" mandate="${mandate}" party="${party}" color="${[start: '#888', end: '#444']}" paramName="tag" size="${[start: 26, end: 40, unit: 'px']}"/>
				</div>					
			</div>
			<div class="info_block">				
				<div class="party_info_block">
					<h2><g:message code="party.proposals.voteUp"/></h2>
					<g:message code="main.total"/>: ${totalVoteUp}
					<ul>
						<g:each in="${voteUpList}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>	
					<div class="last_meeting_footer">
						<g:link action="agree" id="${party.id}" params="${[mandate: mandate.id]}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>															
				</div>		
				<div class="party_info_block">
					<h2><g:message code="party.proposals.voteDown"/></h2>
					<g:message code="main.total"/>: ${totalvoteDown}
					<ul>
						<g:each in="${voteDownList}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>
					<div class="last_meeting_footer">
						<g:link action="against" id="${party.id}" params="${[mandate: mandate.id]}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>											
				</div>										
			</div>	    	
	    </div>
	</body>
</html>		