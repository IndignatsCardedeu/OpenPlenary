package org.mayfifteen.openplenary

class SubjectUserVote implements Serializable {
	
	static belongsTo = [user: User, subject: Subject]
	
	int vote
	Date dateCreated
	String hash

    static constraints = {
		user (nullable:true)
    }
		
	static void removeByUser(User user) {
		executeUpdate ('DELETE FROM SubjectUserVote WHERE user=:user', [user: user])
	}
	
	//RENAME TABLE subject_user_vote TO subject_user_vote_bak;
	//INSERT INTO subject_user_vote (user_id, subject_id, vote, date_created, hash) SELECT user_id, subject_id, vote, date_created, hash from subject_user_vote_bak
	//DROP TABLE subject_user_vote_bak
}
