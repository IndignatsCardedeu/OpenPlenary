<ul>
	<g:each in="${mandates}" status="i" var="item">
		<li>
			<g:link controller="main" action="legislature" id="${item.id}">${item.name}</g:link>
		</li>
	</g:each>
</ul>