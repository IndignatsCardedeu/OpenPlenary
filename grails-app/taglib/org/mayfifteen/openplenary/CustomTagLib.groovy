package org.mayfifteen.openplenary

class CustomTagLib {
	
	static namespace = "op"
	
	def springSecurityService
	
	def username = { attrs ->		
		String username				
		if (attrs.name) username = attrs.name
			else username =	springSecurityService.currentUser.username
		out << username.split("_")[0]
	}
	
	def truncate = { attrs ->
		String text = attrs.text.replaceAll("<(.|\n)*?>", '')
		int length = attrs.length.toInteger()
		
		if (text.length()>=length) text = text.substring(0, length) + "..."
		
		out << text
		
	}
	
	def parties = { attrs ->
		def parties = PoliticalParty.list(sort: "name")
		out << render(template:"/main/includes/parties", model: [parties: parties])
	}
	
	def page = { attrs ->
		def content = Content.findByKeyname(attrs.keyname)
		out << render(template:"/main/includes/content", model: [content: content])
	}
	
}
