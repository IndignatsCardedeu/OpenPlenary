
<%@ page import="org.mayfifteen.openplenary.FAQ" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'FAQ.label', default: 'FAQ')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		</div>	
		<div id="page-content">	
			<div id="show-FAQ" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list FAQ">
				
					<g:if test="${FAQInstance?.question}">
					<li class="fieldcontain">
						<span id="question-label" class="property-label"><g:message code="FAQ.question.label" default="Question" /></span>
						
							<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${FAQInstance}" field="question"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${FAQInstance?.answer}">
					<li class="fieldcontain">
						<span id="answer-label" class="property-label"><g:message code="FAQ.answer.label" default="Answer" /></span>
						
							<span class="property-value" aria-labelledby="answer-label">${FAQInstance.answer}</span>
						
					</li>
					</g:if>
				
					<g:if test="${FAQInstance?.position}">
					<li class="fieldcontain">
						<span id="position-label" class="property-label"><g:message code="FAQ.position.label" default="Position" /></span>
						
							<span class="property-value" aria-labelledby="position-label"><g:fieldValue bean="${FAQInstance}" field="position"/></span>
						
					</li>
					</g:if>
					
					<g:if test="${FAQInstance?.language}">
					<li class="fieldcontain">
						<span id="position-label" class="property-label"><g:message code="FAQ.language.label" default="Language" /></span>
						
							<span class="property-value" aria-labelledby="language-label"><g:fieldValue bean="${FAQInstance}" field="language"/></span>
						
					</li>
					</g:if>					
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${FAQInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${FAQInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
