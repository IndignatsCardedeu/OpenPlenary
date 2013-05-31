<%@ page import="org.mayfifteen.openplenary.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'browser', 'error')} ">
	<label for="browser">
		<g:message code="comment.browser.label" default="Browser" />
		
	</label>
	<g:textField name="browser" value="${commentInstance?.browser}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'comment', 'error')} ">
	<label for="comment">
		<g:message code="comment.comment.label" default="Comment" />
		
	</label>
	<g:textField name="comment" value="${commentInstance?.comment}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'ip', 'error')} ">
	<label for="ip">
		<g:message code="comment.ip.label" default="Ip" />
		
	</label>
	<g:textField name="ip" value="${commentInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'subject', 'error')} required">
	<label for="subject">
		<g:message code="comment.subject.label" default="Subject" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject" name="subject.id" from="${org.mayfifteen.openplenary.Subject.list()}" optionKey="id" required="" value="${commentInstance?.subject?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="comment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${org.mayfifteen.openplenary.User.list()}" optionKey="id" required="" value="${commentInstance?.user?.id}" class="many-to-one"/>
</div>

