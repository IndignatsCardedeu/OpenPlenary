<%@ page import="org.mayfifteen.openplenary.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.content.edit" /></h1>
		</div>	
		<div id="page-content">
			<div id="edit-content" class="content scaffold-edit" role="main">
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
				<g:form method="post" >
					<g:hiddenField name="id" value="${contentInstance?.id}" />
					<g:hiddenField name="version" value="${contentInstance?.version}" />
					<g:render template="form"/>
					<g:actionSubmit class="save form-submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
