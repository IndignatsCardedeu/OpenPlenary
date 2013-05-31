
<%@ page import="org.mayfifteen.openplenary.Subject" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'subject.label', default: 'Subject')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.meetings.show.subjects" />: ${subjectInstance.meeting.name}</h1>
		</div>		
		<div id="page-content">
			<div id="show-subject" class="content scaffold-show" role="main">				
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no-off">1</div>
					<div class="step-light-left"><g:link controller="meeting" action="edit" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit"/></g:link></div>
					<div class="step-light-right">&nbsp;</div>
					<div class="step-no">2</div>
					<div class="step-dark-left"><g:link controller="meeting" action="subjects" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit.subjects"/></g:link></div>
					<div class="step-dark-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->				
				<ol class="property-list subject">
				
					<g:if test="${subjectInstance?.name}">
					<li class="fieldcontain">
						<span id="name-label" class="property-label"><g:message code="adminsubject.name.label" default="Name" /></span>
						
							<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${subjectInstance}" field="name"/></span>
						
					</li>
					</g:if>				
				
					<li class="fieldcontain">
						<span id="tags-label" class="property-label"><g:message code="admin.subject.tags.label" default="Tags" /></span>
						
							<span class="property-value" aria-labelledby="tags-label"><g:fieldValue bean="${subjectInstance}" field="tags"/></span>
						
					</li>											
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${subjectInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${subjectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
