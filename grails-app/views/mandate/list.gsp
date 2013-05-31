
<%@ page import="org.mayfifteen.openplenary.Mandate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mandate.label', default: 'Mandate')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mandate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mandate" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="endDate" title="${message(code: 'mandate.endDate.label', default: 'End Date')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'mandate.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="startDate" title="${message(code: 'mandate.startDate.label', default: 'Start Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mandateInstanceList}" status="i" var="mandateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mandateInstance.id}">${fieldValue(bean: mandateInstance, field: "endDate")}</g:link></td>
					
						<td>${fieldValue(bean: mandateInstance, field: "name")}</td>
					
						<td><g:formatDate date="${mandateInstance.startDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mandateInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
