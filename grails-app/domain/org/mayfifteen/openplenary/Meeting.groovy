package org.mayfifteen.openplenary

class Meeting {
	
	static belongsTo = [mandate: Mandate]
	static hasMany = [subjects: Subject]
	
	String name
	String description	
	Date startDate
	Date endDate
	String officialMinutesUrl
	String officialAgendaUrl
	boolean published

    static constraints = {
		name(nullable: false, blank: false)
		officialMinutesUrl(url: true, nullable: true, blank: true)
		officialAgendaUrl(url: true, nullable: true, blank: true)
    }
	
	static mapping = {
		description type:"text"
		sort startDate: "desc"
		subjects sort: 'id', order: 'asc'
	}
}
