<%@ page import="org.mayfifteen.openplenary.Mandate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'mandate.label', default: 'Mandate')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<script type="text/javascript">		
			$(document).ready(function() {
				$( "#partyselect-dialog" ).dialog({
					autoOpen: false,					 
					 modal: true,
					 width: 360,
					 buttons: {
					 	  Cancel: function() {
					 		$( this ).dialog( "close" );
						  }
					 }					 					
				});
			});
		</script>		
	</head>
	<body>
		<div id="page-heading">
			<h1><g:message code="admin.mandate.edit" /></h1>
		</div>		
		<div id="page-content">	
			<div id="edit-mandate" class="content scaffold-edit" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${mandateInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${mandateInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<!--  start step-holder -->
				<div id="step-holder">
					<div class="step-no">1</div>
					<div class="step-dark-left"><g:link controller="mandate" action="edit" id="${mandateInstance?.id}"><g:message code="admin.mandate.edit"/></g:link></div>
					<div class="step-dark-right">&nbsp;</div>
					<div class="step-no-off">2</div>
					<div class="step-light-left"><g:link controller="mandate" action="composition" id="${mandateInstance?.id}"><g:message code="admin.mandate.edit.composition"/></g:link></div>
					<div class="step-light-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->
				<g:form method="post" >
					<g:hiddenField name="id" value="${mandateInstance?.id}" />
					<g:hiddenField name="version" value="${mandateInstance?.version}" />
					<g:render template="form"/>
					<g:actionSubmit class="save form-submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete form-delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form>
			</div>
		</div>
	</body>
</html>
