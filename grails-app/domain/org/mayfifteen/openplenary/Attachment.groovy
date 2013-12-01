package org.mayfifteen.openplenary

class Attachment {
	
	static belongsTo = [subject: Subject]
	
	String title
	String filename
	int type	

    static constraints = {
    }
}
