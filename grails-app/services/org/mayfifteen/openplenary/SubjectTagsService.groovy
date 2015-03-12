package org.mayfifteen.openplenary

import org.grails.taggable.TagLink

class SubjectTagsService {
	
	static transactional = true

    public Map<Object,Object> getTagCounts(Mandate mandate) {
		def tagCounts = [:]
		String query = "SELECT tl.tag, count(tl.tagRef) " +
			"FROM org.grails.taggable.TagLink tl, Subject s " + 
			"WHERE tl.type='subject' " + 
			"AND s.id=tl.tagRef AND s.meeting.mandate.id= :mandateId " + 
			"GROUP BY tl.tag"
		
		def tagLinks = TagLink.executeQuery(query, [mandateId: mandate.id])
		tagLinks.each {
			def tagName = it[0].name
			def count = it[1]
			tagCounts[tagName] = tagCounts[tagName] ? (tagCounts[tagName] + count) : count
		}
		
		return tagCounts
    }
	
	public Map<Object,Object> getTagCounts(PoliticalParty party, Mandate mandate) {
		def tagCounts = [:]
		String query = "SELECT tl.tag, count(tl.tagRef) " +
			"FROM org.grails.taggable.TagLink tl, Subject s, PartyProposal pp " +
			"WHERE tl.type='subject' " +			
 			"AND s.id=tl.tagRef " + 
			"AND s.meeting.mandate= :mandate " +
			"AND pp.subject=s " +
			"AND pp.voteUp>0 " +
			"AND pp.party= :party " +
			"GROUP BY tl.tag"
			
		def tagLinks = TagLink.executeQuery(query, [mandate: mandate, party: party])
		tagLinks.each {
			def tagName = it[0].name
			def count = it[1]
			tagCounts[tagName] = tagCounts[tagName] ? (tagCounts[tagName] + count) : count
		}
		
		return tagCounts
	}
}
