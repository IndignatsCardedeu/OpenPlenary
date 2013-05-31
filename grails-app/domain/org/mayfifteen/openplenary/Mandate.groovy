package org.mayfifteen.openplenary

class Mandate {
	
	static hasMany = [composition: MandateComposition]
	
	String name
	Date startDate
	Date endDate

	static mapping = {
		composition sort: "members", order: "desc"
	}
	
    static constraints = {
		
    }
}
