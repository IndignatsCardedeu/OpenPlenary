
<%@ page import="org.mayfifteen.openplenary.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.comment.list" /></h1>
		</div>	
		<div id="page-content">	
			<div id="list-content" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table id="product-table">
					<thead>
						<tr>
						
							<th class="table-header-check"></th>
						
							<g:sortableColumn property="comment" title="${message(code: 'admin.comment.comment.label', default: 'Comment')}" class="table-header-repeat line-left"/>
						
							<th class="table-header-repeat line-left"><a><g:message code="admin.comment.user.label" default="User"/></a></th>
							
							<g:sortableColumn property="dateCreated" title="${message(code: 'admin.comment.dateCreated.label', default: 'Date Created')}" class="table-header-repeat line-left"/>							
							
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>								
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${commentInstanceList}" status="i" var="commentInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">							
						
							<td><g:link action="show" id="${commentInstance.id}">${fieldValue(bean: commentInstance, field: "id")}</g:link></td>
						
							<td>${fieldValue(bean: commentInstance, field: "comment")}</td>
						
							<td>${fieldValue(bean: commentInstance, field: "user.username")}</td>
							
							<td><g:formatDate date="${commentInstance.dateCreated}" format="dd-MM-yyyy" /></td>							
							
							<td class="options-width">
								<g:link controller="comment" action="edit" id="${commentInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="comment" action="delete" id="${commentInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
							</td>									
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<g:link class="edit form-submit" controller="comment" action="create"><g:message code="admin.comment.create" /></g:link>
				
				<div id="paging-table" class="pagination">
					<g:paginate total="${commentInstanceTotal}" next=" " prev=" " />						
				</div>
			</div>
		</div>
	</body>
</html>
