
<%@ page import="org.mayfifteen.openplenary.Mandate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'mandate.label', default: 'Mandate')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.mandate.show" /></h1>
		</div>		
		<div id="page-content">		
			<div id="show-mandate" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list mandate">
				
					<g:if test="${mandateInstance?.name}">
					<li class="fieldcontain">
						<span id="name-label" class="property-label"><g:message code="mandate.name.label" default="Name" /></span>
						
							<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${mandateInstance}" field="name"/></span>
						
					</li>
					</g:if>				
				
					<g:if test="${mandateInstance?.startDate}">
					<li class="fieldcontain">
						<span id="startDate-label" class="property-label"><g:message code="mandate.startDate.label" default="Start Date" /></span>
						
							<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${mandateInstance?.startDate}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${mandateInstance?.endDate}">
					<li class="fieldcontain">
						<span id="endDate-label" class="property-label"><g:message code="mandate.endDate.label" default="End Date" /></span>
						
							<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${mandateInstance?.endDate}" /></span>
						
					</li>
					</g:if>
					
					<g:if test="${mandateInstance?.composition}">
					<li class="fieldcontain">
						<span id="composition-label" class="property-label"><g:message code="mandate.composition.label" default="Composition" /></span>
						
							<g:each in="${mandateInstance.composition}" var="c">
								<div class="party-composition">
									<img src="${createLink(controller:'files', action:'logo', id: c.party.logo)}" title="${c.party.name}" alt="${c.party.name}"/> (${c.members})
								</div> 
							</g:each>
						
					</li>
					</g:if>						
									
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${mandateInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${mandateInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
