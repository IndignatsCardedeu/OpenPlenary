package org.mayfifteen.openplenary

import grails.plugins.springsecurity.Secured

import org.mayfifteen.openplenary.utils.StringUtils
import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class SubjectController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [subjectInstanceList: Subject.list(params), subjectInstanceTotal: Subject.count()]
    }

    def create() {
		Meeting meeting = Meeting.get(params.id)			
        [subjectInstance: new Subject(params), meeting: meeting, composition: meeting.mandate.composition]
    }

    def save() {
        def subjectInstance = new Subject(params)
		subjectInstance.description = StringUtils.textCleaner(subjectInstance.description)
		
		Meeting meeting = Meeting.get(params.meeting.id)
		
		params.partyProposals.party.id.each{
			PartyProposal pp = new PartyProposal()
			PoliticalParty party = PoliticalParty.get(it)
			pp.party = party
			
			if (params.partyProposals.author)
				pp.author = params.partyProposals.author.contains(it)
			if (params.partyProposals.support)
				pp.support = params.partyProposals.support.contains(it)
				
			subjectInstance.addToPartyProposals(pp)
		}				
		
        if (!subjectInstance.save(flush: true)) {
            render(view: "create", model: [subjectInstance: subjectInstance, meeting: meeting, composition: meeting.mandate.composition])
            return
        }		
		
		subjectInstance.parseTags(params.tags)

		flash.message = message(code: 'default.created.message', args: [message(code: 'subject.label', default: 'Subject'), subjectInstance.id])
        redirect(controller: "meeting", action: "subjects", id: subjectInstance.meeting.id)
    }

    def show() {
        def subjectInstance = Subject.get(params.id)
        if (!subjectInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(action: "list")
            return
        }

        [subjectInstance: subjectInstance]
    }

    def edit() {
        def subjectInstance = Subject.get(params.id)
        if (!subjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(action: "list")
            return
        }

        [subjectInstance: subjectInstance, composition: subjectInstance.partyProposals]
    }

    def update() {
        def subjectInstance = Subject.get(params.id)
        if (!subjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (subjectInstance.version > version) {
                subjectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'subject.label', default: 'Subject')] as Object[],
                          "Another user has updated this Subject while you were editing")
                render(view: "edit", model: [subjectInstance: subjectInstance])
                return
            }
        }

        subjectInstance.properties = params
		subjectInstance.description = StringUtils.textCleaner(subjectInstance.description)
		
		def tagsList = params.tags.split(",") as List
		for (int i=0; i<tagsList.size(); i++){
			tagsList[i] = tagsList[i].trim()
		}
		subjectInstance.setTags(tagsList)
		
		subjectInstance.partyProposals.each {
			if (params.partyProposals.author){
				it.author = params.partyProposals.author.contains(it.party.id.toString())
			}else{
				it.author = false
			}
			
			if (params.partyProposals.support){
				it.support = params.partyProposals.support.contains(it.party.id.toString())
			}else{
				it.support = false
			}
		}
		
        if (!subjectInstance.save(flush: true)) {
            render(view: "edit", model: [subjectInstance: subjectInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'subject.label', default: 'Subject'), subjectInstance.id])
        redirect(controller: "meeting", action: "subjects", id: subjectInstance.meeting.id)
    }

    def delete() {
        def subjectInstance = Subject.get(params.id)
        if (!subjectInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(controller: "meeting", action: "subjects", id: subjectInstance.meeting.id)
            return
        }

        try {
            subjectInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(controller: "meeting", action: "subjects", id: subjectInstance.meeting.id)
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'subject.label', default: 'Subject'), params.id])
            redirect(controller: "meeting", action: "subjects", id: subjectInstance.meeting.id)
        }
    }
	
	def relevant(){
		def subjectInstance = Subject.get(params.id)
		subjectInstance.relevant = !subjectInstance.relevant
		
		if (!subjectInstance.save(flush: true)) {
			render "ERROR"
		}else{
			render subjectInstance.relevant
		}
	}
}
