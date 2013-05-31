
<%@ page import="org.mayfifteen.openplenary.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-comment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="browser" title="${message(code: 'comment.browser.label', default: 'Browser')}" />
					
						<g:sortableColumn property="comment" title="${message(code: 'comment.comment.label', default: 'Comment')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'comment.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="ip" title="${message(code: 'comment.ip.label', default: 'Ip')}" />
					
						<th><g:message code="comment.subject.label" default="Subject" /></th>
					
						<th><g:message code="comment.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${commentInstanceList}" status="i" var="commentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${commentInstance.id}">${fieldValue(bean: commentInstance, field: "browser")}</g:link></td>
					
						<td>${fieldValue(bean: commentInstance, field: "comment")}</td>
					
						<td><g:formatDate date="${commentInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: commentInstance, field: "ip")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "subject")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${commentInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
