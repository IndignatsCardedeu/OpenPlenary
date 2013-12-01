<g:each in="${attachments}" var="item" status="i">
	<tr class="${(i % 2) == 0 ? '' : 'alternate-row'}" id="attachment_${item.id}">
		<td>
			<a
				<g:if test="${item.type==0}">
					href="${item.filename}"
				</g:if>
				<g:else>
					href="<g:createLink controller="files" action="document" id="${item.filename}" />"
				</g:else>
			>
				${item.title}
			</a>
		</td>
		<td><g:remoteLink controller="meeting" action="deleteSubjectAttachment" id="${item.id}" onSuccess="attachmentDeleted(data)"><img src="${resource(dir:'images/admin', file: 'delete.png')}"/></g:remoteLink>
	</tr>
</g:each>