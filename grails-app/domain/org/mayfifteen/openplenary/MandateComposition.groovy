package org.mayfifteen.openplenary

import java.io.Serializable;

class MandateComposition implements Serializable {
	
	static belongsTo = [party: PoliticalParty, mandate: Mandate]
	
	int members

	static constraints = {
	}
	
	static mapping = {
		id composite: ['party', 'mandate']
	}

}
