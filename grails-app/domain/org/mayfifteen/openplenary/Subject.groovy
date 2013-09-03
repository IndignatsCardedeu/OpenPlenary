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

import org.grails.taggable.Taggable
import org.mayfifteen.openplenary.utils.StringUtils

class Subject implements Taggable {
	
	static belongsTo = [meeting: Meeting]
	static hasMany = [votes: SubjectUserVote, partyProposals: PartyProposal, comments: Comment]
	
	String name
	String description
	String agreements
	boolean relevant = false

    static constraints = {
		name(size:0..500,nullable:false, blank:false)
    }
	
	static mapping = {
		description type:"text"
		agreements type:"text"
		comments sort: "dateCreated"
	}
	
	int getUserVote(String id, String remoteAddr, String userAgent){		
		int res = 0
		def aux = null
				
		if (id) {
			aux = votes.find { it.user!=null && it.user.id == id.toLong() }			
		}else{
			def hash = StringUtils.generateMD5( remoteAddr + "_" + userAgent )
			aux = votes.find { it.user==null && it.hash == hash }			
		}	
		
		if (aux) res = aux.vote
		
		return res
	}
	
	int getThumbsUp(){
		return votes.findAll{ it.vote == 1 }.size()
	}
	
	int getThumbsDown(){
		return votes.findAll{ it.vote == -1 }.size()
	}
	
	Collection<PartyProposal> getPartyThumbsUpList(){
		return partyProposals.findAll{ it.voteUp > 0 }
	}
	
	Collection<PartyProposal> getPartyThumbsDownList(){
		return partyProposals.findAll{ it.voteDown > 0 }
	}
	
	Collection<PartyProposal> getAbstentionList(){
		return partyProposals.findAll{ it.abstention > 0 }
	}
	
	int getPartyThumbsUp(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.voteUp;
		}
		
		return result;
	}
	
	int getPartyThumbsDown(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.voteDown;
		}
		
		return result;
	}
	
	int getPartyAbstention(){
		int result = 0;
		
		partyProposals.each {
			result = result + it.abstention;
		}
		
		return result;
	}
}
