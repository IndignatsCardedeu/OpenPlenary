package org.mayfifteen.openplenary

import java.util.Date;

class Comment {
	
	static belongsTo = [ user: User, subject: Subject ]
	
	String comment
	Date dateCreated

    static constraints = {
    }
	
	static mapping = {
		comment type:"text"
	}
	
	static void removeByUser(User user) {
		executeUpdate ('DELETE FROM Comment WHERE user=:user', [user: user])
	}
}
