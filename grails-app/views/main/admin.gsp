<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin"/>
	</head>
	<body>
		<div id="page-heading">
			<h1>Open Plenary Admin</h1>
		</div>			
		<div id="page-content">
			<h3><g:message code="admin.main.dashboard.title"/></h3>
			<p><g:message code="admin.main.dashboard.message" args="[grailsApplication.config.grails.openplenary.name]"/></p>
			<div id="dashboard_actions_container">
				<div class="dashboard_action" onclick="window.location='${resource(dir: 'meeting')}'">
					<img src="${resource(dir: 'images/admin', file: 'meeting.png')}"/>
					Plenaris
				</div>	
				<div class="dashboard_action" onclick="window.location='${resource(dir: 'politicalParty')}'">
					<img src="${resource(dir: 'images/admin', file: 'politicalparty.png')}"/>
					Partits Polítics
				</div>	
				<div class="dashboard_action" onclick="window.location='${resource(dir: 'user')}'">
					<img src="${resource(dir: 'images/admin', file: 'user.png')}"/>
					Usuaris
				</div>							
			</div>
		</div>
	</body>
</html>
