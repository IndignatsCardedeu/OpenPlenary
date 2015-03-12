<ul>
	<g:each in="${parties}" status="i" var="item">
		<li>
			<g:link controller="main" action="party" id="${item.id}"><img src="${createLink(controller:'files', action:'logo', id: item.logo)}"/> 
			${item.description}</g:link>
		</li>
	</g:each>
</ul>