<%@ page import="org.mayfifteen.openplenary.Meeting" %>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'name', 'error')}">
	<label for="name">
		<g:message code="admin.meeting.name.label" default="Name" />		
	</label>
	<div class="formfield">
		<g:textField name="name" value="${meetingInstance?.name}" class="long-inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'description', 'error')}">
	<label for="description">
		<g:message code="admin.meeting.description.label" default="Description" />		
	</label>
	<div class="formfield">
		<ckeditor:editor name="description" height="400px" width="700px">
		${meetingInstance?.description}
		</ckeditor:editor>	
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'mandate', 'error')}">
	<label for="description">
		<g:message code="admin.meeting.mandate.label" default="Mandate" />		
	</label>
	<div class="formfield">
		<g:select name="mandate.id" from="${org.mayfifteen.openplenary.Mandate.list()}" optionKey="id" optionValue="name" value="${meetingInstance?.mandate}" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="admin.meeting.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:datePicker name="startDate" precision="day"  value="${meetingInstance?.startDate}"  />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="admin.meeting.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:datePicker name="endDate" precision="day"  value="${meetingInstance?.endDate}" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'officialMinutesUrl', 'error')}">
	<label for="officialMinutesUrl">
		<g:message code="admin.meeting.officialMinutesUrl.label" default="Official Minutes URL" />		
	</label>
	<div class="formfield">
		<g:textField name="officialMinutesUrl" value="${meetingInstance?.officialMinutesUrl}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'officialAgendaUrl', 'error')}">
	<label for="officialAgendaUrl">
		<g:message code="admin.meeting.officialAgendaUrl.label" default="Official Agenda URL" />		
	</label>
	<div class="formfield">
		<g:textField name="officialAgendaUrl" value="${meetingInstance?.officialAgendaUrl}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: meetingInstance, field: 'published', 'error')} ">
	<label for="published">
		<g:message code="admin.meeting.published.label" default="Published" />		
	</label>
	<div class="formfield">
		<g:checkBox name="published" value="${meetingInstance?.published}" />
	</div>
</div>

