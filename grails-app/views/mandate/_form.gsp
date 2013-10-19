<%@ page import="org.mayfifteen.openplenary.Mandate" %>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="mandate.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${mandateInstance?.name}" class="inp-form"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="mandate.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${mandateInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="mandate.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day" value="${mandateInstance?.endDate}"  />
</div>
