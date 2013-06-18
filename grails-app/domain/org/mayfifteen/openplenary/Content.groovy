package org.mayfifteen.openplenary

class Content {
	
	String title
	String body
	String language
	String keyname

    static constraints = {
		title(nullable: false, blank: false)
		keyname(nullable: false, blank: false)
		language(nullable: false, blank: false)
    }
	
	static mapping = {
		body type:"text"
	}
}
