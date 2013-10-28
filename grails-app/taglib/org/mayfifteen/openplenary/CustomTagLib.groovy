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

class CustomTagLib {
	
	static namespace = "op"
	
	def springSecurityService
	
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
		def parties = PoliticalParty.list(sort: "name")
		out << render(template:"/main/includes/parties", model: [parties: parties])
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
	
}
