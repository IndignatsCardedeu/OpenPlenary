<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: <g:message code="main.menu.option.plenary" /></title>
	</head>
	<body>				
		<div id="meetings-box">
			<g:each in="${meetings}" status="i" var="meeting">
				<div class="meeting meeting_item"> 
					<div class="meeting-name meeting">
			    		<span class="date"><g:formatDate date="${meeting.startDate}" format="dd-MM" /></span>
			    		<g:link action="session" id="${meeting.id}" >${meeting.name}</g:link>
		    		</div>
					 
		    	</div> 			
			</g:each>
			<div id="pagebrowser">
				<g:paginate total="${meetingsTotal}" />
			</div>
		</div>
	</body>
</html>