
<%@ page import="org.mayfifteen.openplenary.Mandate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'mandate.label', default: 'Mandate')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.mandate.list" /></h1>
		</div>	
		<div id="page-content">
			<div id="list-meeting" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table id="product-table">
					<thead>
						<tr>
							<th class="table-header-check"></th>
						
							<g:sortableColumn property="name" title="${message(code: 'mandate.name.label', default: 'Name')}" class="table-header-repeat line-left"/>
						
							<g:sortableColumn property="startDate" title="${message(code: 'mandate.startDate.label', default: 'Start Date')}" class="table-header-repeat line-left"/>
						
							<g:sortableColumn property="endDate" title="${message(code: 'mandate.endDate.label', default: 'End Date')}" class="table-header-repeat line-left"/>
							
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>								
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${mandateInstanceList}" status="i" var="mandateInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}}">
							<td>${mandateInstance.id}</td>
						
							<td><g:link action="show" id="${mandateInstance.id}">${fieldValue(bean: mandateInstance, field: "name")}</g:link></td>
						
							<td><g:formatDate date="${mandateInstance.startDate}" /></td>
							
							<td><g:formatDate date="${mandateInstance.endDate}"/></td>
							
							<td class="options-width">
								<g:link controller="mandate" action="edit" id="${mandateInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="mandate" action="delete" id="${mandateInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>								
							</td>						
						</tr>
					</g:each>
					</tbody>
				</table>
				<g:link class="edit form-submit" controller="mandate" action="create"><g:message code="admin.mandate.create" /></g:link>
				
				<div id="paging-table" class="pagination">
					<g:paginate total="${mandateInstanceTotal}" next=" " prev=" " />						
				</div>
			</div>		
		</div>
	</body>
</html>
