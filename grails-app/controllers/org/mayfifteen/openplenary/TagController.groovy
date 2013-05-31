package org.mayfifteen.openplenary

class TagController {

	def index(){
		def subjects = Subject.findAllByTagWithCriteria(params.tag){
			meeting {
				eq("published", true)
				order("startDate","desc")
			}
		}
		[subjects: subjects]
	}
	
	def party(){
		def party = PoliticalParty.get(params.id)
		def subjects = Subject.findAllByTagWithCriteria(params.tag){
			partyProposals {
				eq("party", party)
				gt("voteUp", 0)
			}
			meeting {
				eq("published", true)
				order("startDate","desc")
			}
		}

		[party: party, subjects: subjects]
	}
	
	def session(){
		def meeting = Meeting.get(params.id)
		def subjects = null

		if (meeting.published){
			subjects = Subject.findAllByTagWithCriteria(params.tag){				
				eq("meeting", meeting)
			}
		}
		
		[meeting: meeting, subjects: subjects]
	}
}
