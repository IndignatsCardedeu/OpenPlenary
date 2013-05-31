<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>		
		<div id="messagebody">
			<h2><g:message code="user.signup.welcome.title" args="[grailsApplication.config.grails.openplenary.name]"/></h2>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>	
			<p><g:message code="user.signup.welcome.message.1"/> <g:link controller="login"><g:message code="user.signup.welcome.message.2"/></g:link> <g:message code="user.signup.welcome.message.3"/></p> 
		</div> 
	</body>
</html>