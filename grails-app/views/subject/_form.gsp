<%@ page import="org.mayfifteen.openplenary.Subject" %>

<div class="fieldcontain ${hasErrors(bean: subjectInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="admin.subject.name.label" default="Name" />
		
	</label>
	<div class="formfield">
		<g:textField name="name" value="${subjectInstance?.name}" class="long-inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: subjectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="admin.subject.description.label" default="Description" />
		
	</label>
	<div class="formfield">
		<ckeditor:editor name="description" height="400px" width="700px">
		${subjectInstance?.description}
		</ckeditor:editor>		
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: subjectInstance, field: 'agreements', 'error')} ">
	<label for="agreements">
		<g:message code="admin.subject.agreements.label" default="Agreements" />
		
	</label>
	<div class="formfield">
		<ckeditor:editor name="agreements" height="400px" width="700px">
		${subjectInstance?.agreements}
		</ckeditor:editor>		
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: subjectInstance, field: 'tags', 'error')} ">
	<label for="tags">
		<g:message code="admin.subject.tags.label" default="Tags" />		
	</label>
	<div class="formfield">
		<g:textField name="tags" value="${subjectInstance?.tags.join(',')}" class="inp-form"/>
	</div>
</div>



