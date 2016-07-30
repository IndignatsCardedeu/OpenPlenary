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
import org.grails.taggable.TagLink

import org.mayfifteen.openplenary.utils.StringUtils

class MainController {
	
	def springSecurityService	
	def taggableService

    def home(){ 
		int max = 10
		Mandate mandate = session["currentMandate"]
		def meetings = Meeting.findAllByPublishedAndMandate(true, mandate, [max: max, sort: "startDate", order: "desc"])
		def mainMeeting = meetings ? meetings.get(0) : null		
		def relevants
		def tags
		
		if (mainMeeting){
			relevants = getRelevants(mainMeeting.subjects)
			tags = mainMeeting.tags
		}			
		
		[
			currentMeeting: mainMeeting, 
			relevants: relevants, 			 
			currentMeetingTags: tags, 
			meetings: meetings,
		]
	}
	
	def faq(){
		def language = org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).language
		[ questions: FAQ.findAllByLanguage(language, [sort: "position"])]
	}
	
	def contact(){
		def language = org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).language
		def contact = Content.findByKeynameAndLanguage("CONTACT", language)
		if (!contact) contact = new Content();
		render(view: "content", model: [content: contact])
	}
	
	def legal(){
		def terms = Content.findByKeyname("TERMS")
		render(view: "content", model: [content: terms])
	}
	
	def party(){
		PoliticalParty party = PoliticalParty.get(params.id)
		def mandate = params.mandate ? Mandate.get(params.mandate) : session["currentMandate"]
		
		def qparams = [max: 5, offset: 0]

		def proposals = PartyProposal.createCriteria().list(qparams) {
							eq("party", party)
							or {
								eq("author", true) 
								eq("support", true)
							}
							subject {
								meeting {
									eq("published", true)
									eq("mandate", mandate)
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
									eq("mandate", mandate)
									order("startDate", "desc")
								}
								order("id", "desc")
							}							
						}
		
		int totalVoteUp = voteUpList.size()
		
		def tags = [:]
		voteUpList.each {
			it.subject.tags.each {
				if (tags[it]) tags[it]++
					else tags[it] = 1
			}
		}
		
		if (voteUpList.size()>5) voteUpList = voteUpList[0..4]
		
		def voteDownList = PartyProposal.createCriteria().list(qparams) {
								eq("party", party)
								gt("voteDown", 0)
								subject {
									meeting {
										eq("published", true)
										eq("mandate", mandate)
										order("startDate", "desc")
									}
									order("id", "desc")
								}									
							}
		
		[
			party: party, 
			tags: tags, 
			voteUpList: voteUpList, 
			voteDownList: voteDownList,
			proposals: proposals,
			totalProposals: proposals.totalCount,
			totalVoteUp: totalVoteUp,
			totalvoteDown: voteDownList.totalCount,
			mandate: mandate
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
		
		Mandate mandate = params.id ? Mandate.get(params.id) : session["currentMandate"]		
		
        [
			meetings: Meeting.findAllByPublishedAndMandate(true, mandate, params), 
			meetingsTotal: Meeting.countByPublishedAndMandate(true, mandate),
			mandate: mandate
		]
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
	
	def legislatures(){
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
		def legislatures = Mandate.findAllByPublished(true, params).sort{it.startDate}.reverse()
		def legislaturesTotal = Mandate.countByPublished(true)
		
		if (legislaturesTotal>1){		
			[legislatures: legislatures, legislaturesTotal: legislaturesTotal]
		}else{
			redirect(action: "legislature", id: legislatures[0].id)
		}
	}
	
	def legislature(){
		Mandate mandate = Mandate.get(params.id)
		def meetings = Meeting.findAllByMandate(mandate, [max: 10, sort: "startDate", order: "desc"])
		
		[mandate: mandate, meetings: meetings]
	}
	
	def partyAffinitiesGraph(){
		Mandate mandate = Mandate.get(params.mandate)
		render(template: "remote/affgraph", model: [party: params.party, mandate: mandate])
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
		
		Mandate mandate = params.mandate ? Mandate.get(params.mandate) : session["currentMandate"]
		
		def party = PoliticalParty.get(params.id)
		def proposals = PartyProposal.createCriteria().list(params) {
			eq("party", party)
			gt("voteUp", 0)
			subject {
				meeting {
					eq("published", true)
					eq("mandate", mandate)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, mandate: mandate, proposals: proposals, subjectsTotal: proposals.totalCount])
	}
	
	def against(){
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		
		Mandate mandate = params.mandate ? Mandate.get(params.mandate) : session["currentMandate"]
		
		def party = PoliticalParty.get(params.id)
		def proposals = PartyProposal.createCriteria().list(params) {
			eq("party", party)
			gt("voteDown", 0)
			subject {
				meeting {
					eq("published", true)
					eq("mandate", mandate)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, mandate: mandate, proposals: proposals, subjectsTotal: proposals.totalCount])
	}
	
	def proposals(){
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		
		Mandate mandate = params.mandate ? Mandate.get(params.mandate) : session["currentMandate"]
		
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
					eq("mandate", mandate)
					order("startDate", "desc")
				}
				order("id", "desc")
			}
		}
		
		render(view: "partyProposals", model: [party: party, mandate: mandate, proposals: proposals, subjectsTotal: proposals.totalCount])
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
			
			if ((subject.meeting.startDate + 30)>new Date()){
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
			}else result = "votingexpires"	 
		}else result = "error"
	
		return result
	}

}
