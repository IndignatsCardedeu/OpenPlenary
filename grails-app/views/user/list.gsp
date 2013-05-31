
<%@ page import="org.mayfifteen.openplenary.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.users.list" /></h1>
		</div>	
		<div id="page-content">	
			<div id="list-user" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table id="product-table">
					<thead>
						<tr>
							<th class="table-header-check"></th>
						
							<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" class="table-header-repeat line-left"/>
												
							<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" class="table-header-repeat line-left"/>
						
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>	
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${userInstanceList}" status="i" var="userInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
						
							<td></td>	
						
							<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
											
							<td>${fieldValue(bean: userInstance, field: "email")}</td>
						
							<td class="options-width">
								<g:link controller="user" action="edit" id="${userInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="user" action="delete" id="${userInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
							</td>	
						
						</tr>
					</g:each>
					</tbody>
				</table>
				
				<g:link class="edit form-submit" controller="user" action="create"><g:message code="admin.users.create" /></g:link>
										
				<div id="paging-table" class="pagination">
					<g:paginate total="${userInstanceTotal}" next=" " prev=" " />						
				</div>

			</div>
		</div>
	</body>
</html>
