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
	
	def getPartyAffinity(long partyId, long mandateId){
		def session = sessionFactory.getCurrentSession()
		
		String query = "SELECT political_party.id as partyId, political_party.name as partyName, " +
					"political_party.logo as partyLogo, count(*) as value FROM ( " +
					"(SELECT subject_id, party_id, abstention, vote_up, vote_down " + 
					"FROM party_proposal, subject, meeting WHERE party_proposal.subject_id=subject.id AND " +
					"subject.meeting_id=meeting.id AND meeting.mandate_id= :mandateId) AS pvs, " + 
					"(SELECT subject_id, party_id, abstention, vote_up, vote_down " + 
					"FROM party_proposal, subject, meeting WHERE party_id= :partyId AND " +
					"party_proposal.subject_id=subject.id AND subject.meeting_id=meeting.id AND " +
					"meeting.mandate_id= :mandateId) AS pv), political_party WHERE " + 
					"pvs.subject_id=pv.subject_id AND ((pvs.abstention>0 AND pv.abstention>0) OR " + 
					"(pvs.vote_up>0 AND pv.vote_up>0) OR (pvs.vote_down>0 AND pv.vote_down>0)) AND " +
					"political_party.id=pvs.party_id GROUP BY partyId, partyName, partyLogo ORDER BY value DESC"
					
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
		sqlQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
		
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
			
		}
		
		return result
	}
	
	def getPartyAffinitySerie(long partyId, long mandateId){
		def session = sessionFactory.getCurrentSession()
		
		String query = "SELECT political_party.id as partyId, political_party.name as partyName, " +
						"political_party.logo as partyLogo, pvs.meetingId as meetingId, " +
						"pvs.meetingDate as meetingDate, count(*) as value " + 
						"FROM ((SELECT meeting.id as meetingId,	meeting.start_date as meetingDate, " +
						"subject_id, party_id, abstention, vote_up,	vote_down FROM party_proposal, " + 
						"subject, meeting WHERE party_proposal.subject_id=subject.id AND " +
						"subject.meeting_id=meeting.id AND meeting.mandate_id= :mandateId ) AS pvs, " + 
						"(SELECT meeting.id as meetingId, meeting.start_date as meetingDate, subject_id, " + 
						"party_id, abstention, vote_up, vote_down FROM party_proposal, subject,	meeting " + 
						"WHERE party_id= :partyId AND party_proposal.subject_id=subject.id AND " + 
						"subject.meeting_id=meeting.id AND meeting.mandate_id= :mandateId) AS pv ), political_party " + 
						"WHERE pvs.subject_id=pv.subject_id AND	((pvs.abstention>0 AND pv.abstention>0) OR " + 
						"(pvs.vote_up>0 AND pv.vote_up>0) OR (pvs.vote_down>0 AND pv.vote_down>0)) AND " + 
						"political_party.id=pvs.party_id " + 
						"GROUP BY partyId, partyName, partyLogo, meetingId, meetingDate ORDER BY " +
						"meetingDate,meetingId,partyId"

		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
		sqlQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
		
		sqlQuery.addScalar("partyId", Hibernate.LONG)
		sqlQuery.addScalar("partyName", Hibernate.STRING)
		sqlQuery.addScalar("partyLogo", Hibernate.STRING)
		sqlQuery.addScalar("value", Hibernate.INTEGER)
		sqlQuery.addScalar("meetingId", Hibernate.LONG)
		sqlQuery.addScalar("meetingDate", Hibernate.DATE)
		sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
		
		def result = sqlQuery.list()
		
		return result

	}
	
	def getPartyPopularAcceptance(long partyId, long mandateId) {
		def session = sessionFactory.getCurrentSession()
		double result = 0
		def votes = SubjectUserVote.count()
		
		if (votes>0){
			String query = "SELECT count(*) as value FROM " +
				"subject_user_vote as suv, party_proposal as pp, political_party, subject, meeting WHERE " +
				"suv.subject_id=pp.subject_id AND ( " +
				"(pp.vote_up>0 AND suv.vote=1) OR " +
				"(pp.vote_down>0 AND suv.vote=-1) " +
				") AND " +			
				"pp.party_id= :partyId AND " +
				"pp.party_id=political_party.id AND " +
				"subject.id=pp.subject_id AND " +
				"subject.meeting_id=meeting.id AND " +
				"meeting.mandate_id= :mandateId "
			
			def sqlQuery = session.createSQLQuery(query)
			sqlQuery.setParameter("partyId", partyId, Hibernate.LONG)
			sqlQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
			
			result = (sqlQuery.uniqueResult().intValue() * 100 / votes).toDouble().round(1)
		}
		return result
	}
	
	def getPartyPopularAcceptance(long mandateId) {
		def session = sessionFactory.getCurrentSession()
		def result
		def votes = SubjectUserVote.count()
		
		if (votes>0){
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
					"meeting.mandate_id= :mandateId " +
					"GROUP BY partyId, partyName, partyLogo ORDER BY value DESC"
					
			String query2 = "SELECT	count(*) as value  FROM " +
				"subject_user_vote as suv, party_proposal as pp, subject, meeting WHERE " +
				"suv.subject_id=pp.subject_id AND pp.abstention>0 AND " +
				"pp.party_id= :partyId AND pp.subject_id=subject.id AND " +
				"subject.meeting_id=meeting.id AND meeting.mandate_id= :mandateId"
						
				
			def sqlQuery = session.createSQLQuery(query)	
			sqlQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
			
			sqlQuery.addScalar("partyId", Hibernate.LONG)
			sqlQuery.addScalar("partyName", Hibernate.STRING)
			sqlQuery.addScalar("partyLogo", Hibernate.STRING)
			sqlQuery.addScalar("value", Hibernate.INTEGER)
			sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
			
			result = sqlQuery.list()
			
			result.each {
				def absQuery = session.createSQLQuery(query2)
				absQuery.setParameter("partyId", it.partyId, Hibernate.LONG)
				absQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
				double absTotal = absQuery.uniqueResult().intValue() / 2
				it.value = (it.value + absTotal) * 100 / votes				
			}
						
		}
		
		result.sort{ -it.value }		
		
		return result
	}
	
	def getPartyPopularAcceptanceSerie(long mandateId){
		def session = sessionFactory.getCurrentSession()
		def result
		
		String query = "SELECT " +
						"political_party.id as partyId, " +
						"political_party.name as partyName, " +
						"political_party.logo as partyLogo, " +
						"meeting.id as meetingId, " +
						"meeting.start_date as meetingDate, " +
						"count(*) as value " +
					"FROM " +
						"subject_user_vote as suv, " +
						"party_proposal as pp, " +
						"political_party, " +
						"subject, " +
						"meeting " +
					"WHERE " +
						"suv.subject_id=pp.subject_id AND ( " +
							"(pp.vote_up>0 AND suv.vote=1) OR " +
							"(pp.vote_down>0 AND suv.vote=-1) " +
						") AND " +
						"pp.party_id=political_party.id AND " +
						"subject.id=pp.subject_id AND " +
						"subject.meeting_id=meeting.id AND " +
						"meeting.mandate_id= :mandateId " +
					"GROUP BY " +
						"partyId, " +
						"partyName, " +
						"partyLogo, " +
						"meetingId, " + 
						"meetingDate " +
					"ORDER BY " +
						"meetingDate,meetingId,partyId " +
					"ASC"
					
		String query2 = "SELECT	" + 
							"count(*) as value " +
						"FROM " +
							"subject_user_vote as suv, " + 
							"party_proposal as pp, " + 
							"subject " + 
						"WHERE " +
							"suv.subject_id=pp.subject_id AND " + 
							"pp.abstention>0 AND " +
							"pp.subject_id=subject.id AND " +
							"pp.party_id= :partyId AND " + 
							"subject.meeting_id= :meetingId"
					
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("mandateId", mandateId, Hibernate.LONG)
		
		sqlQuery.addScalar("partyId", Hibernate.LONG)
		sqlQuery.addScalar("partyName", Hibernate.STRING)
		sqlQuery.addScalar("partyLogo", Hibernate.STRING)
		sqlQuery.addScalar("value", Hibernate.INTEGER)
		sqlQuery.addScalar("meetingId", Hibernate.LONG)
		sqlQuery.addScalar("meetingDate", Hibernate.DATE)
		sqlQuery.setResultTransformer(Transformers.aliasToBean(AffinityBean.class))
		
		result = sqlQuery.list()
		
		result.each {
			def absQuery = session.createSQLQuery(query2)
			absQuery.setParameter("partyId", it.partyId, Hibernate.LONG)
			absQuery.setParameter("meetingId", it.meetingId, Hibernate.LONG)
			double absTotal = absQuery.uniqueResult().intValue() / 2.0
			it.value = it.value + absTotal
		}
		
		return result
	}
	
	def getTotalMeetingUserVotes(long meetingId){
		def session = sessionFactory.getCurrentSession()
		
		def query = "SELECT count(*) FROM subject_user_vote suv, subject s WHERE " +
					"suv.subject_id=s.id AND s.meeting_id= :meetingId"
					
		def sqlQuery = session.createSQLQuery(query)
		sqlQuery.setParameter("meetingId", meetingId, Hibernate.LONG)

		def result = sqlQuery.uniqueResult().intValue()
		
		return result
	}
	
	
}
