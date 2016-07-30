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

import java.util.List;

class CustomTagLib {
	
	static namespace = "op"
	
	def springSecurityService
	def subjectTagsService
	def affinityService
	
	def username = { attrs ->		
		String username				
		if (attrs.name) username = attrs.name
			else username =	springSecurityService.currentUser.username
		out << username.split("_")[0]
	}
	
	def truncate = { attrs ->
		String text = attrs.text.replaceAll("<(.|\n)*?>", '')
		int length = attrs.length.toInteger()
		
		if (text.length()>=length) text = text.substring(0, length) + "..."
		
		out << text
		
	}
	
	def setMinutesLink = { attrs ->
		String linkText = "<a href='" + attrs.minutesLink + "'>" + message(code: 'meeting.minutes.moreInfo') + "</a>" 
		if (!attrs.minutesLink) linkText = "<a>" + message(code: 'meeting.minutes.moreInfo') + "</a> <em>(" +message(code: 'meeting.minutes.notAvailable') + ")</em>"
		
		String text = attrs.text.replaceAll("#ACTA#",linkText)
		out << text
	}
	
	def parties = { attrs ->		
		Mandate mandate = session["currentMandate"]
		if (attrs.mandate) mandate = Mandate.get(attrs.mandate) 
		def parties = mandate.getPoliticalParties()
		out << render(template:"/main/includes/parties", model: [parties: parties])
	}
	
	def composition = { attrs ->
		Mandate mandate = session["currentMandate"]
		if (attrs.mandate) mandate = Mandate.get(attrs.mandate)
		def parties = mandate.composition
		out << render(template:"/main/includes/composition", model: [parties: parties])
	}
	
	def mandates = { attrs ->
		def mandates = Mandate.findAllByPublished(true, params).sort{it.startDate}.reverse()
		out << render(template:"/main/includes/mandates", model: [mandates: mandates])
	}
	
	def partyAffinitiesChart = { attrs ->
		Mandate mandate = session["currentMandate"]
		boolean multiple = attrs.multiple ? attrs.multiple.toBoolean() : false
		long partyId = attrs.party ? attrs.party.toLong() : mandate.getPoliticalParties()[0].id
		if (attrs.mandate) mandate = Mandate.get(attrs.mandate)
		def affinities = affinityService.getPartyAffinity(partyId, mandate.id)
		if (multiple) affinities = affinities.sort{ it.partyName } 
		def affParties = this.getPartyAffinitiesRows(partyId, mandate)
		
		out << render(
				template:"/main/includes/affinitiesChart", 
				model: [
						affinities: affinities, 
						partyId: partyId, 
						mandate: mandate,
						multiple: multiple,
						affCols: affParties.affCols, 
						affData: affParties.affData, 
						affColors: affParties.affColors
					]
				)
	}
	
	def partyAffinities = { attrs ->
		Mandate mandate = session["currentMandate"]		
		long partyId = attrs.party.toLong()
		if (attrs.mandate) mandate = Mandate.get(attrs.mandate)
		
		def affinities = affinityService.getPartyAffinity(partyId, mandate.id)		
		
		out << render(template:"/main/includes/affinities", model: [affinities: affinities])
	}
	
	def page = { attrs ->
		def content = Content.findByKeyname(attrs.keyname)
		out << render(template:"/main/includes/content", model: [content: content])
	}
	
	def pageUrl = { attrs ->
		String url = "http://" + request.serverName	
		if (request.serverPort!=80) url = url + ":" + request.serverPort		
		url = url + request.forwardURI
		 
		out << url
	}
	
	def tagCloud = { attrs ->		
		def mandate = attrs.mandate ? attrs.mandate : session["currentMandate"]
		def controller = attrs.controller
		def action = attrs.action
		def color = attrs.color
		def id = attrs.id
		def paramName = attrs.paramName		
		def party = attrs.party
		def size = attrs.size
		
		if (attrs.mandate){
			mandate = attrs.mandate 
		}
		
		def tags = [:]
		
		if (party){
			tags = subjectTagsService.getTagCounts(party, mandate)
			params.mandate = mandate.id			
			out << tc.tagCloud(tags: tags, controller: controller, action: action, color: color, id: party.id, paramName: paramName, size: size)
		}else{
			tags = subjectTagsService.getTagCounts(mandate)
			out << tc.tagCloud(tags: tags, controller: controller, action: action, color: color, id: mandate.id, paramName: paramName, size: size)
		}
		
		
	}
	
	private Map getPartyAffinitiesRows(def partyId, def mandate){
		def partyAffinities = affinityService.getPartyAffinitySerie(partyId, mandate.id)		
		def affCols = [['date','Date']]
		def partyColors = [:] 
		def parties = mandate.getPoliticalParties()
		Integer counter = 0
		
		parties.each {
			if (it.id!=partyId){
				affCols.add(['number', it.name])
				def color = it.color ? [color: it.color] : null 
				partyColors.put(counter, new Expando(color))
				counter++
			}
		}
		
		def affData = []
		def affRow
		def acumRow = [0] * counter
		
		def meetingId
		
		int total = 0
		def meetingIdList = partyAffinities.meetingId.unique()
		
		meetingIdList.each { obj ->
			
			def meetingAffinities = partyAffinities.findAll { it.meetingId == obj }
			def partyTotal = meetingAffinities.find { it.partyId == partyId }.value
			affRow = []
			
			affRow.add(meetingAffinities[0].meetingDate)
			
			for (int i=1; i<affCols.size(); i++){
				def aff = meetingAffinities.find { it.partyName == affCols[i][1] }
				
				if (aff){
					affRow.add(aff.value)
				}else{
					affRow.add(0)
				}
			}

			total = total + partyTotal
			
			affRow = calcRow(acumRow, affRow, total)
			affData.add(affRow)
		}
		
		return [affCols: affCols, affData: affData, affColors: partyColors]
	}
	
	private List calcRow(def row1, def row2, def total){
		def res = []
		row2.eachWithIndex { obj, index ->
			if (index==0) res.add(obj)
			else {
				row1[index-1] = row1[index-1] + obj
				res.add((int)(row1[index-1]*100/total))
			}
		}
		
		return res
	}
	
}
