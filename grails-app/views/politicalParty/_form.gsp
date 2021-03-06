<%@ page import="org.mayfifteen.openplenary.PoliticalParty" %>

<div class="fieldcontain ${hasErrors(bean: partyInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="admin.party.name.label" default="Name" />
		
	</label>
	<div class="formfield">
		<g:textField name="name" value="${partyInstance?.name}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: partyInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="admin.party.description.label" default="Description" />
		
	</label>
	<div class="formfield">
		<g:textField name="description" value="${partyInstance?.description}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: partyInstance, field: 'color', 'error')} ">
	<label for="color">
		<g:message code="admin.party.color.label" default="Color" />
		
	</label>
	<div class="formfield">
		<g:textField name="color" value="${partyInstance?.color}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: partyInstance, field: 'logo', 'error')} ">
	<label for="logo">
		<g:message code="admin.party.logo.label" default="Logo" />		
	</label>
	<div class="formfield">
		<g:if test="${partyInstance?.logo}">
			<img src="${createLink(controller:'files', action:'logo', id: partyInstance.logo)}" />
		</g:if>	
		<input type="file" name="logoImageFile"/>	
	</div>
</div>

