
<%@ page import="org.mayfifteen.openplenary.FAQ" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'FAQ.label', default: 'FAQ')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.faq.list" /></h1>
		</div>			
		<div id="page-content">	
			<div id="list-FAQ" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table id="product-table">
					<thead>
						<tr>
						
							<th class="table-header-check"></th>
						
							<g:sortableColumn property="question" title="${message(code: 'admin.faq.qustion.label', default: 'Question')}" class="table-header-repeat line-left"/>
												
							<g:sortableColumn property="position" title="${message(code: 'admin.faq.position.label', default: 'Position')}" class="table-header-repeat line-left"/>
							
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>							
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${FAQInstanceList}" status="i" var="FAQInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
						
							<td></td>
						
							<td><g:link action="show" id="${FAQInstance.id}">${fieldValue(bean: FAQInstance, field: "question")}</g:link></td>
						
							<td>${fieldValue(bean: FAQInstance, field: "position")}</td>
							
							<td class="options-width">
								<g:link controller="FAQ" action="edit" id="${FAQInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="FAQ" action="delete" id="${FAQInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
							</td>								
						
						</tr>
					</g:each>
					</tbody>
				</table>
				
				<g:link class="edit form-submit" controller="FAQ" action="create"><g:message code="admin.faq.create" /></g:link>
										
				<div id="paging-table" class="pagination">
					<g:paginate total="${FAQInstanceTotal}" next=" " prev=" " />						
				</div>
			</div>
		</div>
	</body>
</html>
