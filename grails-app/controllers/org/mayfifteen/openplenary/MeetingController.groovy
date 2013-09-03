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
import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class MeetingController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [meetingInstanceList: Meeting.list(params), meetingInstanceTotal: Meeting.count()]
    }

    def create() {
        [meetingInstance: new Meeting(params)]
    }

    def save() {
        def meetingInstance = new Meeting(params)		
		meetingInstance.description = StringUtils.textCleaner(meetingInstance.description)
		
        if (!meetingInstance.save(flush: true)) {
            render(view: "create", model: [meetingInstance: meetingInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'meeting.label', default: 'Meeting'), meetingInstance.id])
        redirect(action: "subjects", id: meetingInstance.id)
    }

    def show() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        [meetingInstance: meetingInstance]
    }

    def edit() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        [meetingInstance: meetingInstance]
    }

    def update() {
        def meetingInstance = Meeting.get(params.id)		
		
        if (!meetingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (meetingInstance.version > version) {
                meetingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'meeting.label', default: 'Meeting')] as Object[],
                          "Another user has updated this Meeting while you were editing")
                render(view: "edit", model: [meetingInstance: meetingInstance])
                return
            }
        }

        meetingInstance.properties = params
		meetingInstance.description = StringUtils.textCleaner(meetingInstance.description)

        if (!meetingInstance.save(flush: true)) {
            render(view: "edit", model: [meetingInstance: meetingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'meeting.label', default: 'Meeting'), meetingInstance.id])
        redirect(action: "list", id: meetingInstance.id)
    }

    def delete() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            meetingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def subjects() {
		def meetingInstance = Meeting.get(params.id)
		if (!meetingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
			redirect(action: "list")
			return
		}

		[meetingInstance: meetingInstance]
	}
	
	def partyVotes() {
		def meetingInstance = Meeting.get(params.id)		
		if (!meetingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
			redirect(action: "list")
			return
		}

		[meetingInstance: meetingInstance]
	}
	
	def saveSubjectPartyVotes(){
		def subject = Subject.get(params.subject.id)
		int i = 0
		
		try {
			params.party.id.each {
				def party = PoliticalParty.get(it)
				def partyVote = PartyProposal.findBySubjectAndParty(subject, party)
	
							if (!partyVote){
					partyVote = new PartyProposal(subject: subject, party: party)
				}
				
				partyVote.voteUp = params.voteUp[i].toInteger()
				partyVote.voteDown = params.voteDown[i].toInteger()
				partyVote.abstention = params.abstention[i].toInteger()
				partyVote.save(flush:true, failOnError: true)
				
				i++
			}
			
			render subject.id
		}catch(Exception e){
			render "ERROR"
		}
	}
	
	def getSubjectPartyVotes(){
		def subject = Subject.get(params.id)
		
		render subject.partyProposals as JSON
	}
	
}
