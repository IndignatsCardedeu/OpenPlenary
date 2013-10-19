<div class="party-composition" id="partyComp_${party.id}">
	<img src="${createLink(controller:'files', action:'logo', id: party.logo)}" title="${party.name}" alt="${party.name}"/> <img src="${resource(dir: 'images/admin/delete.png')}" class="clickme" onclick="removeElement('#partyComp_${party.id}');"/>
	<div class="mandate_members">
		<g:textField name="members" value="0"/>
		<g:hiddenField name="party.id" value="${party.id}"/>
	</div>
</div> 