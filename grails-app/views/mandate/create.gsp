<%@ page import="org.mayfifteen.openplenary.Mandate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'mandate.label', default: 'Mandate')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
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
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
		</div>		
		<div id="page-content">
			<div id="create-meeting" class="content scaffold-create" role="main">				
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
					<div class="step-no-off">1</div>
					<div class="step-light-left"><g:message code="admin.mandate.edit"/></div>
					<div class="step-light-right">&nbsp;</div>
					<div class="step-no-off">2</div>
					<div class="step-light-left"><g:message code="admin.mandate.edit.composition"/></div>
					<div class="step-light-round">&nbsp;</div>
					<div class="clear"></div>
				</div>
				<!--  end step-holder -->
				<g:form action="save" >
					<g:render template="form"/>
					<g:submitButton name="create" class="save form-submit" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</g:form>
			</div>
		</div>
		<g:render template="partySelect"/>
	</body>
</html>
