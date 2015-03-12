<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: <g:message code="main.menu.option.plenary" /></title>
	</head>
	<body>				
		<div id="meetings-box">
			<g:each in="${legislatures}" status="i" var="item">
				<div class="meeting meeting_item"> 
					<div class="meeting-name meeting">
			    		<span class="date">${item.name}</span>
			    		<g:link action="legislature" id="${item.id}">
			    			<g:message code="mandate.name"/> 
			    			<g:formatDate date="${item.startDate}" format="yyyy" /> /
			    			<g:formatDate date="${item.endDate}" format="yyyy" />
			    		</g:link>
		    		</div>
					 
		    	</div> 			
			</g:each>
			<div id="pagebrowser">
				<g:paginate total="${legislaturesTotal}" />
			</div>
		</div>
	</body>
</html>