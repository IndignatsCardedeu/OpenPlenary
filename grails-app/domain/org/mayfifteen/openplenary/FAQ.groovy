package org.mayfifteen.openplenary

class FAQ {
	
	String question
	String answer
	Integer position
	String language

    static constraints = {
		question(nullable: false, blank: false)
		answer(nullable: false, blank: false)
		position(nullable: false)
		language(nullable: false, blank: false)
    }
	
	static mapping = {
		answer type:"text"
	}
}
