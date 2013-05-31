<%@ page import="org.mayfifteen.openplenary.Subject" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'subject.label', default: 'Subject')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.meetings.update.subjects" args="[entityName]" />: ${subjectInstance.meeting.name}</h1>
		</div>		
		<div id="page-content">
			<div id="edit-subject" class="content scaffold-edit" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${subjectInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${subjectInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no-off">1</div>
					<div class="step-light-left"><g:link controller="meeting" action="edit" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit"/></g:link></div>
					<div class="step-light-right">&nbsp;</div>
					<div class="step-no">2</div>
					<div class="step-dark-left"><g:link controller="meeting" action="subjects" id="${meetingInstance?.id}"><g:message code="admin.meetings.edit.subjects"/></g:link></div>
					<div class="step-dark-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->				
				<g:form method="post" >
					<g:hiddenField name="id" value="${subjectInstance?.id}" />
					<g:hiddenField name="version" value="${subjectInstance?.version}" />
					<g:render template="form"/>
					<div class="fieldcontain">
						<label for="tags">
							<g:message code="admin.subject.proposalBy.label" />		
						</label>
						<div class="formfield">
							<table id="product-table">
								<thead>
									<tr>
										<th class="table-header-check"></th>
										
										<th class="table-header-repeat line-left"><a><g:message code="admin.party.label"/></a></th>
									
										<th class="table-header-options" style="text-align:center">
											<a>Presentat</a>
										</th>		
										
										<th class="table-header-options" style="text-align:center">
											<a>Adhesió</a>
										</th>			
									</tr>
								</thead>
								<tbody>
								<g:each in="${composition}" status="i" var="item">
									<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
									
										<td>${item.party.id}</td>						
											
										<td>
											<img src="${resource(dir: 'images/parties')}/${item.party.logo}"/>
										</td>
										
										<td style="text-align:center">
											<g:hiddenField name="partyProposals.party.id" value="${item.party.id}"/>
											<g:checkBox name="partyProposals.author" value="${item.party.id}" checked="${item.author}"/> 
										</td>
										
										<td style="text-align:center">											
											<g:checkBox name="partyProposals.support" value="${item.party.id}" checked="${item.support}"/> 
										</td>										
									</tr>
								</g:each>
								</tbody>
							</table>		
						</div>
					</div>						
					<g:actionSubmit class="save form-submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
