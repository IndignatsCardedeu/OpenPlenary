
<%@ page import="org.mayfifteen.openplenary.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.users.show" args="[entityName]" /></h1>
		</div>		
		<div id="page-content">		
			<div id="show-user" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list user">
				
					<g:if test="${userInstance?.username}">
					<li class="fieldcontain">
						<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
						
							<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
						
					</li>
					</g:if>
						
					<g:if test="${userInstance?.email}">
					<li class="fieldcontain">
						<span id="email-label" class="property-label"><g:message code="user.email.label" default="Email" /></span>
						
							<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.accountExpired}">
					<li class="fieldcontain">
						<span id="accountExpired-label" class="property-label"><g:message code="user.accountExpired.label" default="Account Expired" /></span>
						
							<span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.accountLocked}">
					<li class="fieldcontain">
						<span id="accountLocked-label" class="property-label"><g:message code="user.accountLocked.label" default="Account Locked" /></span>
						
							<span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.avatar}">
					<li class="fieldcontain">
						<span id="avatar-label" class="property-label"><g:message code="user.avatar.label" default="Avatar" /></span>
						
							<span class="property-value" aria-labelledby="avatar-label"><g:fieldValue bean="${userInstance}" field="avatar"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.enabled}">
					<li class="fieldcontain">
						<span id="enabled-label" class="property-label"><g:message code="user.enabled.label" default="Enabled" /></span>
						
							<span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${userInstance?.enabled}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.lastLogin}">
					<li class="fieldcontain">
						<span id="lastLogin-label" class="property-label"><g:message code="user.lastLogin.label" default="Last Login" /></span>
						
							<span class="property-value" aria-labelledby="lastLogin-label"><g:formatDate date="${userInstance?.lastLogin}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${userInstance?.passwordExpired}">
					<li class="fieldcontain">
						<span id="passwordExpired-label" class="property-label"><g:message code="user.passwordExpired.label" default="Password Expired" /></span>
						
							<span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></span>
						
					</li>
					</g:if>
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${userInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />				
				</g:form>
			</div>
		</div>
	</body>
</html>
