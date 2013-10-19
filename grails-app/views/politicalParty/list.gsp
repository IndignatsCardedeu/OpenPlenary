
<%@ page import="org.mayfifteen.openplenary.PoliticalParty" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'party.label', default: 'Party')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.parties.list" /></h1>
		</div>	
		<div id="page-content">	
			<div id="list-party" class="content scaffold-list" role="main">			
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table id="product-table">
					<thead>
						<tr>
							<th class="table-header-check"></th>
						
							<g:sortableColumn property="name" title="${message(code: 'admin.party.name.label', default: 'Name')}" class="table-header-repeat line-left"/>
						
							<g:sortableColumn property="logo" title="${message(code: 'admin.party.logo.label', default: 'Logo')}" class="table-header-repeat line-left"/>							

							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>						
						</tr>
					</thead>
					<tbody>
					<g:each in="${partyInstanceList}" status="i" var="partyInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
						
							<td></td>
						
							<td><g:link action="show" id="${partyInstance.id}">${fieldValue(bean: partyInstance, field: "name")}</g:link></td>
						
							<td>
							
								<img src="${createLink(controller:'files', action:'logo', id: partyInstance.logo)}" />
								
							</td>

							<td class="options-width">
								<g:link controller="politicalParty" action="edit" id="${partyInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="politicalParty" action="delete" id="${partyInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>
							</td>							
						</tr>
					</g:each>
					</tbody>
				</table>
									
				<g:link class="edit form-submit" controller="politicalParty" action="create"><g:message code="admin.parties.create" /></g:link>				
									
				<div id="paging-table" class="pagination">
					<g:paginate total="${partyInstanceTotal}" next=" " prev=" " />						
				</div>			
			</div>
		</div>
	</body>
</html>
