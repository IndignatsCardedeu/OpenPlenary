<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: ${mandate.name}</title>
		<g:javascript library="jquery" />
		<gvisualization:apiImport/> 
	</head>
	<body>		
		<div id="meetings-box">
			<div class="meeting sessions">     		
		    	<g:message code="mandate.name"/> ${mandate.name}
	    	</div> 	
	    	<div class="affinities">
				<op:composition mandate="${params.id}"/>	  
	    	</div>
	    	
	    	<div id="partyAffinities" style="height:470px">
	    		<op:partyAffinitiesChart mandate="${params.id}" multiple="true"/>
	    	</div>	    		
	    	
			<div class="info_block">
				<div class="party_info_block">
					<h2><g:message code="main.menu.option.plenary"/></h2>
					<ul>
						<g:each in="${meetings}" status="index" var="meeting">
							<li><g:link controller="main" action="session" id="${meeting.id}">${meeting.name}</g:link></li>
						</g:each>
					</ul>		
					<div class="last_meeting_footer">
						<g:link controller="main" action="sessions" id="${mandate.id}" class="button"><g:message code="main.viewAll"/></g:link>
					</div>							
				</div>
				<div class="party_info_block">
					<h2><g:message code="main.tagcloud"/></h2>
					<op:tagCloud controller="tag" action="index" mandate="${mandate}" color="${[start: '#888', end: '#444']}" paramName="tag" size="${[start: 26, end: 40, unit: 'px']}"/>
				</div>					
			</div>	    	  	
	    </div>
	</body>
</html>		