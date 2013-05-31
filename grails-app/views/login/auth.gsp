<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="springSecurity.login.title"/></title>
	</head>
	<body>
		<h2><g:message code="springSecurity.login.header"/></h2>
		<g:if test="${flash.message}">
			<div class="error" role="status">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="error" role="status">${flash.error}</div>
		</g:if>		
		<form action="${postUrl}" method="POST" id="loginForm" class="userForms">		
			<div class="fieldcontain">
				<label for="username">
					<g:message code="springSecurity.login.username.label"/>
				</label>				
				<input type='text' class='text_' name='j_username' id='username'/>
			</div>
			
			<div class="fieldcontain required">
				<label for="password">
					<g:message code="springSecurity.login.password.label"/>
				</label>
				<input type='password' class='text_' name='j_password' id='password'/>
			</div>
			
			<div class="fieldcontain required">	
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>				
			</div>			
					
			<input type='submit' id="submit" class="button" value='${message(code: "springSecurity.login.button")}'/>					
		</form>
		<script type='text/javascript'>
			<!--
			(function() {
				document.forms['loginForm'].elements['j_username'].focus();
			})();
			// -->
		</script>
	</body>
</html>