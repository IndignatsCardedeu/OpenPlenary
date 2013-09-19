<%@ page import="org.mayfifteen.openplenary.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:textField name="username" value="${userInstance?.username}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:textField name="password" value="${userInstance?.password}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
	</label>
	<div class="formfield">
		<g:if test="${grailsApplication.config.grails.openplenary.encodeEmail}">
			<g:field type="email" name="email" class="registerInputs email ${hasErrors(bean: userInstance, field: 'email', 'error')}"/>
			<p><g:message code="user.emailEncoded.label" /></p>	
		</g:if>
		<g:else>
			<g:field type="email" name="email" value="${userInstance?.email}" class="registerInputs email required ${hasErrors(bean: userInstance, field: 'email', 'error')}"/>
		</g:else>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<div class="formfield">
		<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<div class="formfield">
		<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'avatar', 'error')} ">
	<label for="avatar">
		<g:message code="user.avatar.label" default="Avatar" />
		
	</label>
	<div class="formfield">
		<g:textField name="avatar" value="${userInstance?.avatar}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<div class="formfield">
		<g:checkBox name="enabled" value="${userInstance?.enabled}" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastLogin', 'error')} required">
	<label for="lastLogin">
		<g:message code="user.lastLogin.label" default="Last Login" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:datePicker name="lastLogin" precision="day"  value="${userInstance?.lastLogin}"  />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<div class="formfield">
		<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
	</div>
</div>

