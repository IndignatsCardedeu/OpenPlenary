<%@ page import="org.mayfifteen.openplenary.Mandate" %>



<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'composition', 'error')} ">
	<label for="composition">
		<g:message code="mandate.composition.label" default="Composition" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${mandateInstance?.composition?}" var="c">
    <li><g:link controller="mandateComposition" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="mandateComposition" action="create" params="['mandate.id': mandateInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'mandateComposition.label', default: 'MandateComposition')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="mandate.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${mandateInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="mandate.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${mandateInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mandateInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="mandate.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${mandateInstance?.startDate}"  />
</div>

