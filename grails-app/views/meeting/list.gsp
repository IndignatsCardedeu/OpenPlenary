
<%@ page import="org.mayfifteen.openplenary.Meeting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.meetings.list" /></h1>
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
							
							<g:sortableColumn property="name" title="${message(code: 'admin.meeting.name.label', default: 'Name')}" class="table-header-repeat line-left"/>
							
							<g:sortableColumn property="startDate" title="${message(code: 'admin.meeting.startDate.label', default: 'Start Date')}" class="table-header-repeat line-left"/>							
											
							<g:sortableColumn property="endDate" title="${message(code: 'admin.meeting.endDate.label', default: 'End Date')}" class="table-header-repeat line-left"/>				
						
							<g:sortableColumn property="published" title="${message(code: 'admin.meeting.published.label', default: 'Published')}" class="table-header-repeat line-left"/>							
						
							<th class="table-header-options line-left">
								<a><g:message code="admin.list.options" /></a>
							</th>						
						</tr>
					</thead>
					<tbody>
					<g:each in="${meetingInstanceList}" status="i" var="meetingInstance">
						<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
						
							<td>${meetingInstance.id}</td>						
						
							<td><g:link action="show" id="${meetingInstance.id}">${fieldValue(bean: meetingInstance, field: "name")}</g:link></td>
							
							<td><g:formatDate date="${meetingInstance.startDate}" format="dd-MM-yyyy" /></td>
						
							<td><g:formatDate date="${meetingInstance.endDate}" format="dd-MM-yyyy" /></td>
						
							<td><g:formatBoolean boolean="${meetingInstance.published}" /></td>							

							<td class="options-width">
								<g:link controller="meeting" action="edit" id="${meetingInstance.id}" title="${g.message(code:'admin.action.edit')}" class="icon-1 info-tooltip"></g:link>
								<g:link  controller="meeting" action="subjects" id="${meetingInstance.id}" title="${g.message(code:'admin.meetings.edit.subjects')}" class="icon-3 info-tooltip"></g:link>
								<g:link  controller="meeting" action="delete" id="${meetingInstance.id}" title="${g.message(code:'admin.action.delete')}" class="icon-2 info-tooltip" onclick="return confirm('Are you sure?');"></g:link>								
							</td>						
						</tr>
					</g:each>
					</tbody>
				</table>
				
				<g:link class="edit form-submit" controller="meeting" action="create"><g:message code="admin.meetings.create" /></g:link>
				
				<div id="paging-table" class="pagination">
					<g:paginate total="${meetingInstanceTotal}" next=" " prev=" " />						
				</div>
			</div>		
		</div>
	</body>
</html>
