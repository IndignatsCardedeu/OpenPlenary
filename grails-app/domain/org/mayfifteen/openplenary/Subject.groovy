package org.mayfifteen.openplenary

import org.grails.taggable.Taggable

class Subject implements Taggable {
	
	static belongsTo = [meeting: Meeting]
	static hasMany = [votes: SubjectUserVote, partyProposals: PartyProposal, comments: Comment]
	
	String name
	String description
	boolean relevant = false

    static constraints = {
		name(size:0..500,nullable:false, blank:false)
    }
	
	static mapping = {
		description type:"text"
		comments sort: "dateCreated"
	}
	
	int getUserVote(String id){		
		int res = 0;
				
		if (id) {
			def aux = votes.find { it.user!=null && it.user.id == id.toLong() }
			if (aux) res = aux.vote
		}		
		
		return res
	}
	
	int getThumbsUp(){
		return votes.findAll{ it.vote == 1 }.size()
	}
	
	int getThumbsDown(){
		return votes.findAll{ it.vote == -1 }.size()
	}
	
	Collection<PartyProposal> getPartyThumbsUpList(){
		return partyProposals.findAll{ it.voteUp > 0 }
	}
	
	Collection<PartyProposal> getPartyThumbsDownList(){
		return partyProposals.findAll{ it.voteDown > 0 }
	}
	
	Collection<PartyProposal> getAbstentionList(){
		return partyProposals.findAll{ it.abstention > 0 }
	}
	
	int getPartyThumbsUp(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.voteUp;
		}
		
		return result;
	}
	
	int getPartyThumbsDown(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.voteDown;
		}
		
		return result;
	}
	
	int getPartyAbstention(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.abstention;
		}
		
		return result;
	}
}