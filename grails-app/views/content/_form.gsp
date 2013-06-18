<%@ page import="org.mayfifteen.openplenary.Content" %>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="admin.content.title.label" default="Title" />		
	</label>
	<div class="formfield">
		<g:textField name="title" value="${contentInstance?.title}" class="long-inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'body', 'error')} ">
	<label for="body">
		<g:message code="admin.content.body.label" default="Body" />		
	</label>
	<div class="formfield">
		<ckeditor:editor name="body" height="400px" width="700px">
			${contentInstance?.body}
		</ckeditor:editor>	
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'keyname', 'error')} required">
	<label for="keyname">
		<g:message code="admin.content.keyname.label" default="Keyname" />		
	</label>
	<div class="formfield">
		<g:textField name="keyname" value="${contentInstance?.keyname}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'language', 'error')} required">
	<label for="language">
		<g:message code="admin.content.language.label" default="Language" />		
	</label>
	<div class="formfield">
		<g:textField name="language" value="${contentInstance?.language}" class="inp-form"/>
	</div>
</div>


