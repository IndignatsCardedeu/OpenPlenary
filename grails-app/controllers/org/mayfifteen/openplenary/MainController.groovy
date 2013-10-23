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

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.mayfifteen.openplenary.utils.StringUtils

class MainController {
	
	def springSecurityService

    def home(){ 
		int max = 10
		def meetings = Meeting.findAllByPublished(true, [max: max, sort: "startDate", order: "desc"])
		def mainMeeting = meetings.get(0)
		def relevants = getRelevants(mainMeeting.subjects)
		
		def parties = PoliticalParty.list(sort: "name")		
		
		[
			currentMeeting: mainMeeting, 
			relevants: relevants, 
			parties: parties, 
			currentMeetingTags: mainMeeting.tags, 
			meetings: meetings
		]
	}
	
	def faq(){
		def language = org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).language
		[ questions: FAQ.findAllByLanguage(language, [sort: "position"])]
	}
	
	def contact(){
		def contact = Content.findByKeyname("CONTACT")
		render(view: "content", model: [content: contact])
	}
	
	def legal(){
		def terms = Content.findByKeyname("TERMS")
		render(view: "content", model: [content: terms])
	}
	
	def party(){
		PoliticalParty party = PoliticalParty.get(params.id)

		def proposals = PartyProposal.createCriteria().list() {
							eq("party", party)
							or {
								eq("author", true) 
								eq("support", true)
							}
							subject {
								meeting {
									eq("published", true)
									order("startDate", "desc")
								}
								order("id", "desc")
							}						
						}
		
		def voteUpList = PartyProposal.createCriteria().list() {
							eq("party", party)
							gt("voteUp", 0)
							subject {
								meeting {
									eq("published", true)
									order("startDate", "desc")
								}
								order("id", "desc")
							}						
						}
		
		def tags = [:]
		voteUpList.each {
			it.subject.tags.each {
				if (tags[it]) tags[it]++
					else tags[it] = 1
			}
		}
		
		if (voteUpList.size()>10) voteUpList = voteUpList[0..9]
		
		def voteDownList = PartyProposal.createCriteria().list() {
								eq("party", party)
								gt("voteDown", 0)
								subject {
									meeting {
										eq("published", true)
										order("startDate", "desc")
									}
									order("id", "desc")
								}						
							}
		if (voteDownList.size()>10) voteDownList = voteDownList[0..9]
		
		if (proposals.size()>5) proposals = proposals[0..9]
		
		[
			party: party, 
			tags: tags, 
			voteUpList: voteUpList, 
			voteDownList: voteDownList,
			proposals: proposals
		]
	}
	
	@Secured(['ROLE_ADMIN'])
	def admin(){
		
	}
	
	def saveComment(){
		if (params.comment.replaceAll("\\s","")!=""){
			def comment = new Comment(params)
			
			comment.user = springSecurityService.currentUser
			
			if (comment.save(flush: true)) {
				render(template: "includes/comments", model: [comment: comment])
			}else render "ERROR"
		}else render "ERROR"
	}
	
	def sessions(){
        params.max = Math.min(params.max ? params.int('max') : 15, 100)
        [meetings: Meeting.findAllByPublished(true, params), meetingsTotal: Meeting.countByPublished(true)]
	}
	
	def session(){
		Meeting meeting = Meeting.get(params.id)
		
		if (meeting && meeting.published){
			def relevants = getRelevants(meeting.subjects)
			def subjects = meeting.subjects.minus(relevants).sort{ it.votes.size() }.reverse()
			
			[meeting: meeting, subjects: subjects, relevants: relevants, meetingTags: meeting.tags]
		}else{
			redirect(action: "home")
		}
	}
	
	def point(){
		Subject subject = Subject.get(params.id)
		if (subject && subject.meeting.published){
			[item: Subject.get(params.id)]
		}else{
			redirect(action: "home")
		}
	}
	
	def agree(){
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		
		def party = PoliticalParty.get(params.id)
		def proposals = PartyProposal.createCriteria().list(params) {
			eq("party", party)
			gt("voteUp", 0)
			subject {
				meeting {
					eq("published", true)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, proposals: proposals, subjectsTotal: proposals.totalCount])
	}
	
	def against(){
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		
		def party = PoliticalParty.get(params.id)
		def proposals = PartyProposal.createCriteria().list(params) {
			eq("party", party)
			gt("voteDown", 0)
			subject {
				meeting {
					eq("published", true)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, proposals: proposals, subjectsTotal: proposals.totalCount])
	}
	
	def proposals(){
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		
		def party = PoliticalParty.get(params.id)
		def proposals = PartyProposal.createCriteria().list(params) {
			eq("party", party)
			or {
				eq("author", true)
				eq("support", true)
			}
			subject {
				meeting {
					eq("published", true)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, proposals: proposals, subjectsTotal: proposals.totalCount])
	}
	
	def voteUp(){
		def code = vote(1, params.id.toInteger())
		render getVoteResult(1, code) 
	}
	
	def voteDown(){
		def code = vote(-1, params.id.toInteger())
		render getVoteResult(-1, code)
	}
	
	private List getRelevants(def subjects){
		def relevants = null		
		
		if (subjects){
			def selected = subjects.findAll{ it.relevant }
			relevants = subjects.findAll{ it.votes && it.votes.size()>0 }.sort{ it.votes.size() }.reverse()
			if (!relevants && !selected) {
				relevants = subjects.asList()
				if (relevants.size()>3) {
					relevants = relevants.subList(0,3)
				}
			}else if (relevants.size()>3){
				relevants = relevants.subList(0,3)
			}else if (relevants.size()<3 && selected && selected.size()>=3){
				relevants.addAll(selected.asList().minus(relevants).subList(0,(3-relevants.size())))
			}else if (relevants.size()<3 && subjects.size()>=3){
				relevants.addAll(subjects.asList().minus(relevants).subList(0,(3-relevants.size())))
			}				
		}
		
		return relevants
	}
	
	private JSON getVoteResult(int vote, String code){

		def result = [
			code: code,
			vote: vote,
			title: message(code: "user." + code + ".error.title"),
			message1: message(code: "user." + code + ".error.message.1"),
			message2: message(code: "user." + code + ".error.message.2", args: [ createLink(controller:"webUser", action:"signup") ])
		]
		
		return result as JSON
	}
	
	private String vote(int value, int subjectId){
		def subject = Subject.get(subjectId)		
		def userVote = new SubjectUserVote()
		def user = springSecurityService.currentUser		
		boolean allowAnonymous = grailsApplication.config.grails.openplenary.voting.allowAnonymous
		int maxAnonymous = grailsApplication.config.grails.openplenary.voting.maxAnonymousVotes
		
		def remoteAddr = request.getRemoteAddr()
		def userAgent = request.getHeader("User-Agent")
		def hash = StringUtils.generateMD5( remoteAddr + "_" + userAgent )
		
		String result = "OK"
		
		userVote.hash = hash
		
		if (subject.meeting.published){
			def anonymousVotes = 0
			def votes = 0
			
			if (user){
				votes = SubjectUserVote.countBySubjectAndUser(subject, user)
			}else {
				votes = SubjectUserVote.countBySubjectAndHashAndUserIsNull(subject, hash)
				anonymousVotes = SubjectUserVote.countBySubjectAndUserIsNull(subject)
			}
			
			if (user && votes>0){
				result = "error"
			}else if (!user && !allowAnonymous){
				result = "notloggedin"
			}else if (!user && allowAnonymous && (votes>0 || anonymousVotes>=maxAnonymous)){
				if (votes>0) result = "error"			
					else result = "maxanonymous"
			}else{
				userVote.user = user
				userVote.subject = subject
				userVote.vote = value
				if (!userVote.save(flush: true)) result = "error"
			}		 
		}else result = "error"
	
		return result
	}

}
