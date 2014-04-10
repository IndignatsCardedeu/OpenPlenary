<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: ${party.description} (${party.name})</title>
		<g:javascript library="jquery" />
	</head>
	<body>		
		<div id="meetings-box">
			<div class="meeting"> 
				<div class="party-name">
		    		<span class="image"><img src="${createLink(controller:'files', action:'logo', id: party.logo)}"/></span>
		    		${party.description}
	    		</div>
	    	</div> 	
	    	<div class="affinities">
	    		<h2><g:message code="main.acceptance.party"/></h2>
	    		<g:each in="${acceptance}" var="item">
	    			<div class="affinity_block
	    				<g:if test="${item.partyId==party.id}">
	    					selected
	    				</g:if> 
	    			">
	    				<g:link controller="main" action="party" id="${item.partyId}"><img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/></g:link> 
	    				${item.value}% 
	    			</div>
	    		</g:each>
	    	</div>	    	
	    	<div class="affinities">
	    		<h2><g:message code="main.affinity.party"/></h2>
	    		<g:each in="${affinities}" var="item">
	    			<div class="affinity_block">
	    				<g:link controller="main" action="party" id="${item.partyId}"><img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/></g:link> 
	    				${item.value}% 
	    			</div>
	    		</g:each>
	    	</div>
			<div class="info_block">
				<div class="party_info_block">
					<h2><g:message code="party.proposals.author"/></h2>
					<ul>
						<g:each in="${proposals}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>		
					<div class="last_meeting_footer">
						<g:link action="proposals" id="${party.id}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>							
				</div>
				<div class="party_info_block">
					<h2><g:message code="party.proposals.tags"/></h2>
					<tc:tagCloud tags="${tags}" controller="tag" action="party" paramName="tag" />		
				</div>					
			</div>
			<div class="info_block">				
				<div class="party_info_block">
					<h2><g:message code="party.proposals.voteUp"/></h2>
					<ul>
						<g:each in="${voteUpList}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>	
					<div class="last_meeting_footer">
						<g:link action="agree" id="${party.id}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>															
				</div>		
				<div class="party_info_block">
					<h2><g:message code="party.proposals.voteDown"/></h2>
					<ul>
						<g:each in="${voteDownList}" status="index" var="proposal">
							<li><g:link controller="main" action="point" id="${proposal.subject.id}">${proposal.subject.name}</g:link></li>
						</g:each>
					</ul>
					<div class="last_meeting_footer">
						<g:link action="against" id="${party.id}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>											
				</div>										
			</div>	    	
	    </div>
	</body>
</html>		