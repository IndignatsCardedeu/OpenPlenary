
<%@ page import="org.mayfifteen.openplenary.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		</div>	
		<div id="page-content">	
			<div id="show-comment" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list comment">
							
					<g:if test="${commentInstance?.comment}">
					<li class="fieldcontain">
						<span id="comment-label" class="property-label"><g:message code="comment.comment.label" default="Comment" /></span>
						
							<span class="property-value" aria-labelledby="comment-label"><g:fieldValue bean="${commentInstance}" field="comment"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${commentInstance?.dateCreated}">
					<li class="fieldcontain">
						<span id="dateCreated-label" class="property-label"><g:message code="comment.dateCreated.label" default="Date Created" /></span>
						
							<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${commentInstance?.dateCreated}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${commentInstance?.subject}">
					<li class="fieldcontain">
						<span id="subject-label" class="property-label"><g:message code="comment.subject.label" default="Subject" /></span>
						
							<span class="property-value" aria-labelledby="subject-label"><g:link controller="subject" action="show" id="${commentInstance?.subject?.id}">${commentInstance?.subject?.name}</g:link></span>
						
					</li>
					</g:if>
				
					<g:if test="${commentInstance?.user}">
					<li class="fieldcontain">
						<span id="user-label" class="property-label"><g:message code="comment.user.label" default="User" /></span>
						
							<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${commentInstance?.user?.id}">${commentInstance?.user?.username}</g:link></span>
						
					</li>
					</g:if>
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${commentInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${commentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
