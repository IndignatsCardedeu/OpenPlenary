/**
 *   OpenPlenary - Open your city council plenaries
 *   Copyright (C) 2013  Indignats de Cardedeu (indignatsdecardedeu@gmail.com)
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
