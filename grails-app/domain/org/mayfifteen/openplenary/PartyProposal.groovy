package org.mayfifteen.openplenary

import java.io.Serializable;

class PartyProposal {
	
	static belongsTo = [party: PoliticalParty, subject: Subject]

	int voteUp = 0
	int voteDown = 0
	int abstention = 0
	Boolean author = false
	Boolean support = false

    static constraints = {
    }
	
}
