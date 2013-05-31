package org.mayfifteen.openplenary

class PoliticalParty {
	
	static hasMany = [proposals: PartyProposal]
	
	String name
	String description
	String logo	

    static constraints = {
		name(nullable: false, blank: false)
		logo(nullable: false, blank: false)
    }
}
