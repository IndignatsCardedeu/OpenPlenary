
<%@ page import="org.mayfifteen.openplenary.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.content.list" /></h1>
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
							
							<g:sortableColumn property="title" title="${message(code: 'content.title.label', default: 'Title')}" class="table-header-repeat line-left"/>
													
							<g:sortableColumn property="keyname" title="${message(code: 'content.keyname.label', default: 'Keyname')}" class="table-header-repeat line-left"/>
						
							<g:sortableColumn property="language" title="${message(code: 'content.language.label', default: 'Language')}" class="table-header-repeat line-left"/>													

							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>						
						</tr>
					</thead>
					<tbody>
					<g:each in="${contentInstanceList}" status="i" var="contentInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
							
							<td></td>
							
							<td><g:link action="show" id="${contentInstance.id}">${fieldValue(bean: contentInstance, field: "title")}</g:link></td>
												
							<td>${fieldValue(bean: contentInstance, field: "keyname")}</td>
						
							<td>${fieldValue(bean: contentInstance, field: "language")}</td>						
							
							<td class="options-width">
								<g:link controller="content" action="edit" id="${contentInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="content" action="delete" id="${contentInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
							</td>								
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<g:link class="edit form-submit" controller="content" action="create"><g:message code="admin.content.create" /></g:link>
										
				<div id="paging-table" class="pagination">
					<g:paginate total="${contentInstanceTotal}" next=" " prev=" " />						
				</div>
			</div>
		</div>
	</body>
</html>
