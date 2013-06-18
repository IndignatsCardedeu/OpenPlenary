<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title> :: <g:message code="main.menu.option.register" /></title>
		<jq:plugin name="ui"></jq:plugin>
		<jq:plugin name="validate"></jq:plugin>				
		<script type="text/javascript">
			$(document).ready(function(){
				$("#registerForm").validate({
					rules: {
						username: "required",
						password: "required",
						confirm: {
							required: true,
							equalTo: "#password"
						},
						email: {
							required: true,
							email: true
						}
					},
					messages: {
						terms: "Has de llegir i acceptar les condicions",
						username: "<g:message code="user.username.error.required" />",
						password: "<g:message code="user.password.error.required" />",
						confirm: {
							required: "<g:message code="user.password.rewrite" />",
							equalTo: "<g:message code="user.password.error.notmatch"/>"
						},
						email: "<g:message code="user.email.error.notvalid"/>"
					}					
				});

				$("#loginForm").validate({
					rules: {
						j_username: "required",
						j_password: "required"
					},
					messages: {
						j_username: "<g:message code="user.login.username.error.required"/>",
						j_password: "<g:message code="user.login.password.error.required"/>"
					}					
				});		

				$(".popup").colorbox({inline:true, width:"50%"});		
			});				
		</script>
	</head>
	<body>		
		<g:if test="${flash.message}">
			<div class="error" role="status">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="error" role="status">${flash.error}</div>
		</g:if>		
		<div id="login-area">
			<div id="login-providers">
				<h2>Accedeix amb...</h2>
				<div id="login-providers-list">
					<facebookAuth:connect />
				</div>
			</div>
			<div id="login-normal">
				<h2><g:message code="springSecurity.login.header"/></h2>
				<form action="${postUrl}" method="POST" id="loginForm" class="userForms">		
					<div class="fieldcontain required">
						<label for="username">
							<g:message code="springSecurity.login.username.label"/>
						</label>				
						<input type='text' class='text_ required' name='j_username' id='username' />
					</div>
					
					<div class="fieldcontain required">
						<label for="password">
							<g:message code="springSecurity.login.password.label"/>
						</label>
						<input type='password' class='text_ required' name='j_password' id='j_password' />
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
			</div>
		</div>
		<div id="register-area">
			<h2><g:message code="user.create.label" /></h2>
			<g:hasErrors bean="${userInstance}">
				<ul class="error errors" role="alert">
					<g:eachError bean="${userInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
			<g:form controller="webUser" action="register" name="registerForm" class="userForms">
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
					<g:passwordField name="password" value="${userInstance?.password}" class="required registerInputs ${hasErrors(bean: userInstance, field: 'password', 'error')}"/>
				</div>
				
				<div class="fieldcontain required">
					<label for="confirm">
						<g:message code="user.confirm.label" default="Repeat password" />
					</label>
					<g:passwordField name="confirm" class="registerInputs required ${hasErrors(bean: userInstance, field: 'password', 'error')}" />
				</div>			
				
				<div class="fieldcontain required">

					<a class="popup" style="font-size:10px;" href="#termsconditions">He llegit i accepto les condicions d'us</a>				
					<g:checkBox name="terms" class="registerInputs required" />
				</div>						
				
				<!-- Begin of captcha -->	

				<div class="fieldcontain required">
					<label for="captcha">
						<g:message code="user.captcha.text"  />
					</label>
					<g:textField name="captcha"/>					
				</div>				
					<div class="fieldcontain required">
						<img src="${createLink(controller: 'simpleCaptcha', action: 'captcha')}"/>
					</div>				
				<!-- End of captcha -->							
				<g:submitButton name="create" class="button" value="${message(code: 'user.register.label', default: 'Create')}" />
			</g:form>
		</div>
		<div style='display:none'>
			<div id='termsconditions' style='padding:10px; background:#fff;'>
				<op:page keyname="TERMS"/>
			</div>			
		</div>
	</body>
</html>
