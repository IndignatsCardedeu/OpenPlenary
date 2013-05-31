<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div id="messagebody">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:message code="user.created.check.email.message" />				
		</div> 
	</body>
</html>