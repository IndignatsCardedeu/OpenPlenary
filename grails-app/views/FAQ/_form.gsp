<%@ page import="org.mayfifteen.openplenary.FAQ" %>



<div class="fieldcontain ${hasErrors(bean: FAQInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="admin.faq.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:textField name="question" value="${FAQInstance?.question}" class="long-inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: FAQInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="admin.faq.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<ckeditor:editor name="answer" height="400px" width="700px">
		${FAQInstance?.answer}
		</ckeditor:editor>		
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: FAQInstance, field: 'position', 'error')} required">
	<label for="position">
		<g:message code="admin.faq.position.label" default="Position" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:field name="position" type="number" value="${FAQInstance.position}" class="inp-form"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: FAQInstance, field: 'language', 'error')} required">
	<label for="language">
		<g:message code="admin.faq.language.label" default="Language" />
		<span class="required-indicator">*</span>
	</label>
	<div class="formfield">
		<g:textField name="language" value="${FAQInstance.language}" class="inp-form"/>
	</div>
</div>

