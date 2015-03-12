<%@ page import="org.mayfifteen.openplenary.Mandate" %>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="admin.mandate.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${mandateInstance?.name}" class="inp-form"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="admin.mandate.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${mandateInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="admin.mandate.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day" value="${mandateInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'published', 'error')} ">
	<label for="published">
		<g:message code="admin.meeting.published.label" default="Published" />		
	</label>
	<div class="formfield">
		<g:checkBox name="published" value="${mandateInstance?.published}" />
	</div>
</div>
