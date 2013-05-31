<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title> :: <g:message code="user.profile.label" /></title>
		<jq:plugin name="validate"></jq:plugin>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#registerForm").validate({
					rules: {
						username: "required",
						confirm: {
							equalTo: "#password"
						},
						email: {
							required: true,
							email: true
						}
					},
					messages: {
						username: "<g:message code="user.username.error.required" />",
						confirm: "<g:message code="user.password.error.notmatch" />",
						email: "<g:message code="user.email.error.notvalid" />"
					}					
				});
			});				
		</script>		
	</head>
	<body>
		<h2><g:message code="user.profile.label" /></h2>
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="error" role="status">${flash.error}</div>
		</g:if>		
		<g:hasErrors bean="${userInstance}">
			<ul class="error errors" role="alert">
				<g:eachError bean="${userInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<sec:ifAllGranted roles="ROLE_FACEBOOK">
			<div id="facebook_user_profile">
				<div class="fieldcontain required">
					<g:message code="user.username.facebook.label" default="Username" />
					<op:username/>
				</div>										
				<span class="button warning" onclick="$.colorbox({inline: true, href: '#unsubscribe'})">
					<g:message code='user.unsubscribe.label' default='Unsubscribe' />
				</span>			
			</div>
		</sec:ifAllGranted>
		<sec:ifNotGranted roles="ROLE_FACEBOOK">
			<g:form action="update" name="registerForm" class="userForms">
				<div class="fieldcontain required">
					<label for="username">
						<g:message code="user.username.label" default="Username" />
					</label>
					<g:textField name="username" value="${userInstance?.username}" class="required registerInputs ${hasErrors(bean: userInstance, field: 'username', 'error')}"/>
				</div>
				
				<div class="fieldcontain required">
					<label for="email">
						<g:message code="user.email.label" default="Email" class="registerInputs"/>
					</label>
					<g:field type="email" name="email" value="${userInstance?.email}" class="registerInputs email required ${hasErrors(bean: userInstance, field: 'email', 'error')}"/>
				</div>			
				
				<div class="fieldcontain required">
					<label for="password">
						<g:message code="user.password.label" default="Password" />
					</label>
					<g:passwordField name="password" class="registerInputs ${hasErrors(bean: userInstance, field: 'password', 'error')}"/>
				</div>
				
				<div class="fieldcontain required">
					<label for="confirm">
						<g:message code="user.confirm.label" default="Repeat password" />
					</label>
					<g:passwordField name="confirm" class="registerInputs ${hasErrors(bean: userInstance, field: 'password', 'error')}" />
				</div>			
					
				<g:submitButton name="create" class="button" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				<span class="button warning" onclick="$.colorbox({inline: true, href: '#unsubscribe'})">
					<g:message code='user.unsubscribe.label' default='Unsubscribe' />
				</span>
			</g:form>
		</sec:ifNotGranted>
	<div style='display:none'>
		<div id='unsubscribe' style='padding:10px; background:#fff;'>
			<op:page code="unsubscribe" />
		</div>
	</div>	
	</body>
</html>
