<ul>
	<g:each in="${parties}" status="i" var="party">
		<li>
			<g:link controller="main" action="party" id="${party.id}"><img src="${resource(dir: 'images/parties')}/${party.logo}"/> 
			${party.description}</g:link>
		</li>
	</g:each>
</ul>