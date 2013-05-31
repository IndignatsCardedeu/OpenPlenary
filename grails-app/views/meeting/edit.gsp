<%@ page import="org.mayfifteen.openplenary.Meeting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
		</div>		
		<div id="page-content">
			<div id="edit-meeting" class="content scaffold-edit" role="main">				
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${meetingInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${meetingInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no">1</div>
					<div class="step-dark-left"><g:link controller="meeting" action="edit" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit"/></g:link></div>
					<div class="step-dark-right">&nbsp;</div>
					<div class="step-no-off">2</div>
					<div class="step-light-left"><g:link controller="meeting" action="subjects" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit.subjects"/></g:link></div>
					<div class="step-light-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->				
				<g:form method="post" >
					<g:hiddenField name="id" value="${meetingInstance?.id}" />
					<g:hiddenField name="version" value="${meetingInstance?.version}" />
					<g:render template="form"/>
					<g:actionSubmit class="save form-submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
