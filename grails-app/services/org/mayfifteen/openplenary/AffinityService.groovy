package org.mayfifteen.openplenary

import org.hibernate.Hibernate
import org.hibernate.transform.Transformers

class AffinityService {
	
	def sessionFactory
	
	static transactional = true

    def getUserAffinity(User user) {
		def session = sessionFactory.getCurrentSession()
		
		def votes = SubjectUserVote.countByUser(user)
		
		println("TOTAL: " + votes)
		
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
					"political_party.id=pvs.party_id GROUP BY pvs.party_id ORDER BY value DESC"
		
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
		
		sqlQuery.addScalar("partyId", Hibernate.LONG)
		sqlQuery.addScalar("partyName", Hibernate.STRING)
		sqlQuery.addScalar("partyLogo", Hibernate.STRING)
		sqlQuery.addScalar("value", Hibernate.INTEGER)
		sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
		
		List result = sqlQuery.list()
		int total = result[0].value
		
		result.each {
			it.value = it.value * 100 / total
		}
		
		result.remove(0)
		
		return result
	}
}
