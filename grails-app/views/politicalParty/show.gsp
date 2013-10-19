
<%@ page import="org.mayfifteen.openplenary.PoliticalParty" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'party.label', default: 'Party')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.parties.show" /></h1>
		</div>		
		<div id="page-content">	
			<div id="show-party" class="content scaffold-show" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list party">
				
					<g:if test="${partyInstance?.name}">
					<li class="fieldcontain">
						<span id="name-label" class="property-label"><g:message code="admin.party.name.label" default="Name" /></span>
						
							<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${partyInstance}" field="name"/></span>
						
					</li>
					</g:if>				
				
					<g:if test="${partyInstance?.description}">
					<li class="fieldcontain">
						<span id="description-label" class="property-label"><g:message code="admin.party.description.label" default="Description" /></span>
						
							<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${partyInstance}" field="description"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${partyInstance?.logo}">
					<li class="fieldcontain">
						<span id="logo-label" class="property-label"><g:message code="admin.party.logo.label" default="Logo" /></span>
						
							<span class="property-value" aria-labelledby="logo-label">
								<img src="${createLink(controller:'files', action:'logo', id: partyInstance.logo)}"/>
							</span>
						
					</li>
					</g:if>
				
				</ol>
				<g:form>
					<g:hiddenField name="id" value="${partyInstance?.id}" />
					<g:link class="edit form-submit" action="edit" id="${partyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
