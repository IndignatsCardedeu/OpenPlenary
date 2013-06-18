<%@ page import="org.mayfifteen.openplenary.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.content.create" /></h1>
		</div>
		<div id="page-content">
		<div id="create-content" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${contentInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${contentInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<g:render template="form"/>
				<g:submitButton name="create" class="save form-submit" value="${message(code: 'default.button.create.label', default: 'Create')}" />				
			</g:form>
		</div>
		</div>
	</body>
</html>
