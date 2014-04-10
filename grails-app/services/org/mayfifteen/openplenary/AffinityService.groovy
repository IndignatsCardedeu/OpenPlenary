package org.mayfifteen.openplenary

import org.hibernate.Hibernate
import org.hibernate.transform.Transformers

class AffinityService {
	
	def sessionFactory
	
	static transactional = true

    def getUserAffinity(User user) {
		def session = sessionFactory.getCurrentSession()
		
		def votes = SubjectUserVote.countByUser(user)
		
		String query = "SELECT political_party.id as partyId, political_party.name as partyName, " +
					"political_party.logo as partyLogo, count(*) as value FROM " + 
					"subject_user_vote as suv, party_proposal as pp, political_party " + 
					"WHERE user_id= :userId AND suv.subject_id=pp.subject_id AND " +
					"((pp.vote_up>0 AND suv.vote=1) OR (pp.vote_down>0 AND suv.vote=-1)) and " + 
					"pp.party_id=political_party.id GROUP BY pp.party_id ORDER BY value DESC"
		
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("userId", user.id, Hibernate.LONG)
		
		sqlQuery.addScalar("partyId", Hibernate.LONG)
		sqlQuery.addScalar("partyName", Hibernate.STRING)
		sqlQuery.addScalar("partyLogo", Hibernate.STRING)
		sqlQuery.addScalar("value", Hibernate.INTEGER)
		sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
		
		List result = sqlQuery.list()
		
		result.each {
			it.value = it.value * 100 / votes
		}
		
		return result
    }
	
	def getPartyAffinity(long partyId){
		def session = sessionFactory.getCurrentSession()
		
		String query = "SELECT political_party.id as partyId, political_party.name as partyName, " +
					"political_party.logo as partyLogo, count(*) as value FROM ( " +
					"(SELECT subject_id, party_id, abstention, vote_up, vote_down " + 
					"FROM party_proposal) AS pvs, (SELECT subject_id, party_id, abstention, vote_up, vote_down " + 
					"FROM party_proposal WHERE party_id= :partyId) AS pv), political_party WHERE " + 
					"pvs.subject_id=pv.subject_id AND ((pvs.abstention>0 AND pv.abstention>0) OR " + 
					"(pvs.vote_up>0 AND pv.vote_up>0) OR (pvs.vote_down>0 AND pv.vote_down>0)) AND " +
					"political_party.id=pvs.party_id GROUP BY partyId, partyName, partyLogo ORDER BY value DESC"
					
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
		
		sqlQuery.addScalar("partyId", Hibernate.LONG)
		sqlQuery.addScalar("partyName", Hibernate.STRING)
		sqlQuery.addScalar("partyLogo", Hibernate.STRING)
		sqlQuery.addScalar("value", Hibernate.INTEGER)
		sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
		
		List result = sqlQuery.list()
		
		if (result){
			int total = result[0].value
			
			result.each {
				it.value = it.value * 100 / total
			}
			
			result.remove(0)
		}
		
		return result
	}
	
	def getPartyPopularAcceptance(long partyId) {
		def session = sessionFactory.getCurrentSession()
		double result = 0
		def votes = SubjectUserVote.count()
		
		if (votes>0){
			String query = "SELECT count(*) as value FROM " +
				"subject_user_vote as suv, party_proposal as pp, political_party WHERE " +
				"suv.subject_id=pp.subject_id AND ( " +
				"(pp.vote_up>0 AND suv.vote=1) OR " +
				"(pp.vote_down>0 AND suv.vote=-1) " +
				") AND " +			
				"pp.party_id= :partyId AND " +
				"pp.party_id=political_party.id "
			
			def sqlQuery = session.createSQLQuery(query)
			sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
			
			result = (sqlQuery.uniqueResult().intValue() * 100 / votes).toDouble().round(1)
		}
		return result
	}
	
	def getPartyPopularAcceptance() {
		def session = sessionFactory.getCurrentSession()
		def result
		def votes = SubjectUserVote.count()
		
		if (votes>0){
			String query ="SELECT political_party.id as partyId, political_party.name as partyName, " +
					"political_party.logo as partyLogo, count(*) as value FROM " +
					"subject_user_vote as suv, party_proposal as pp, political_party WHERE " +
					"suv.subject_id=pp.subject_id AND ( " +
					"(pp.vote_up>0 AND suv.vote=1) OR " +
					"(pp.vote_down>0 AND suv.vote=-1) " +
					") AND " +				
					"pp.party_id=political_party.id " +
					"GROUP BY partyId, partyName, partyLogo ORDER BY value DESC"
					
			String query2 = "SELECT	count(*) as value  FROM " +
				"subject_user_vote as suv, party_proposal as pp WHERE " +
				"suv.subject_id=pp.subject_id AND pp.abstention>0 AND " +
				"pp.party_id= :partyId" 
					
			/* TODO -> Take into account mandate
			String query ="SELECT political_party.id as partyId, political_party.name as partyName, " +
					"political_party.logo as partyLogo, count(*) as value FROM " +
					"subject_user_vote as suv, party_proposal as pp, political_party, subject, meeting WHERE " +
					"suv.subject_id=pp.subject_id AND ( " +
					"(pp.vote_up>0 AND suv.vote=1) OR " +
					"(pp.vote_down>0 AND suv.vote=-1) " +
					") AND " +
					"pp.party_id=political_party.id AND " +
					"subject.id=pp.subject_id AND " +
					"subject.meeting_id=meeting.id AND " +
					"meeting.mandate_id=1 " +
					"GROUP BY partyId, partyName, partyLogo ORDER BY value DESC"*/	
			
			def sqlQuery = session.createSQLQuery(query)	
			sqlQuery.addScalar("partyId", Hibernate.LONG)
			sqlQuery.addScalar("partyName", Hibernate.STRING)
			sqlQuery.addScalar("partyLogo", Hibernate.STRING)
			sqlQuery.addScalar("value", Hibernate.INTEGER)
			sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
			
			result = sqlQuery.list()
			
			result.each {
				def absQuery = session.createSQLQuery(query2)
				absQuery.setParameter("partyId", it.partyId, Hibernate.LONG)
				double absTotal = absQuery.uniqueResult().intValue() / 2

				println(it.partyName + ": [ " + it.value + ", " + absTotal + " ] - [" + (it.value * 100 / votes) + ", " + ((it.value + absTotal) * 100 / votes) + " ]")
				
				it.value = (it.value + absTotal) * 100 / votes				
			}
			
		}
		
		result.sort{ -it.value }
		
		return result
	}
	
}
