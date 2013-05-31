
<%@ page import="org.mayfifteen.openplenary.Meeting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		</div>		
		<div id="page-content">		
			<div id="show-meeting" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>					
				</g:if>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no-off">1</div>
					<div class="step-light-left"><g:link controller="meeting" action="edit" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit"/></g:link></div>
					<div class="step-light-right">&nbsp;</div>
					<div class="step-no-off">2</div>
					<div class="step-light-left"><g:link controller="meeting" action="subjects" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit.subjects"/></g:link></div>
					<div class="step-light-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->				
				<ol class="property-list meeting">
				
					<g:if test="${meetingInstance?.name}">
					<li class="fieldcontain">
						<span id="name-label" class="property-label"><g:message code="admin.meeting.name.label" default="Name" /></span>
						
							<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${meetingInstance}" field="name"/></span>
						
					</li>
					</g:if>				
					
					<g:if test="${meetingInstance?.startDate}">
					<li class="fieldcontain">
						<span id="startDate-label" class="property-label"><g:message code="admin.meeting.startDate.label" default="Start Date" /></span>
						
							<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${meetingInstance?.startDate}" format="dd-MM-yyyy"/></span>
						
					</li>
					</g:if>					
				
					<g:if test="${meetingInstance?.endDate}">
					<li class="fieldcontain">
						<span id="endDate-label" class="property-label"><g:message code="admin.meeting.endDate.label" default="End Date" /></span>
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${meetingInstance?.endDate}" format="dd-MM-yyyy"/></span>
						
					</li>
					</g:if>
								
					<g:if test="${meetingInstance?.published}">
					<li class="fieldcontain">
						<span id="published-label" class="property-label"><g:message code="admin.meeting.published.label" default="Published" /></span>
						
							<span class="property-value" aria-labelledby="published-label"><g:formatBoolean boolean="${meetingInstance?.published}" /></span>
						
					</li>
					</g:if>
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${meetingInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${meetingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
