<%@ page import="org.mayfifteen.openplenary.Comment" %>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'comment', 'error')} ">
	<label for="comment">
		<g:message code="admin.comment.comment.label" default="Comment" />
		
	</label>
	<g:textArea style="width: 400px;height:100px;" name="comment" value="${commentInstance?.comment}" />
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'subject', 'error')} required">
	<label for="subject">
		<g:message code="admin.comment.subject.label" default="Subject" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject" name="subject.id" from="${org.mayfifteen.openplenary.Subject.list()}" optionKey="id" required="" value="${commentInstance?.subject?.id}"  class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="admin.comment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${org.mayfifteen.openplenary.User.list()}" optionKey="id" optionValue="username" required="" value="${commentInstance?.user?.id}" class="many-to-one"/>
</div>

