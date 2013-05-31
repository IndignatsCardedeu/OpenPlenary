<ul>
	<g:each in="${parties}" status="i" var="party">
		<li>
			<img src="${resource(dir: 'images/parties')}/${party.logo}"/> 
			<g:link controller="main" action="party" id="${party.id}">${party.description}</g:link>
		</li>
	</g:each>
</ul>