
<%@ page import="org.mayfifteen.openplenary.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		</div>	
		<div id="page-content">	
			<div id="show-content" class="content scaffold-show" role="main">			
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list content">
				
					<g:if test="${contentInstance?.title}">
					<li class="fieldcontain">
						<span id="title-label" class="property-label"><g:message code="content.title.label" default="Title" /></span>
						
							<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${contentInstance}" field="title"/></span>
						
					</li>
					</g:if>				
				
					<g:if test="${contentInstance?.body}">
					<li class="fieldcontain">
						<span id="body-label" class="property-label"><g:message code="content.body.label" default="Body" /></span>
						
							<span class="property-value" aria-labelledby="body-label">${contentInstance.body}</span>
						
					</li>
					</g:if>
				
					<g:if test="${contentInstance?.keyname}">
					<li class="fieldcontain">
						<span id="keyname-label" class="property-label"><g:message code="content.keyname.label" default="Keyname" /></span>
						
							<span class="property-value" aria-labelledby="keyname-label"><g:fieldValue bean="${contentInstance}" field="keyname"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${contentInstance?.language}">
					<li class="fieldcontain">
						<span id="language-label" class="property-label"><g:message code="content.language.label" default="Language" /></span>
						
							<span class="property-value" aria-labelledby="language-label"><g:fieldValue bean="${contentInstance}" field="language"/></span>
						
					</li>
					</g:if>				
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${contentInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${contentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
