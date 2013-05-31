package org.mayfifteen.openplenary

import org.springframework.dao.DataIntegrityViolationException

class PartyProposalController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [partyVoteInstanceList: PartyProposal.list(params), partyVoteInstanceTotal: PartyProposal.count()]
    }

    def create() {
        [partyVoteInstance: new PartyProposal(params)]
    }

    def save() {
        def partyVoteInstance = new PartyProposal(params)
        if (!partyVoteInstance.save(flush: true)) {
            render(view: "create", model: [partyVoteInstance: partyVoteInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), partyVoteInstance.id])
        redirect(action: "show", id: partyVoteInstance.id)
    }

    def show(Long id) {
        def partyVoteInstance = PartyProposal.get(id)
        if (!partyVoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "list")
            return
        }

        [partyVoteInstance: partyVoteInstance]
    }

    def edit(Long id) {
        def partyVoteInstance = PartyProposal.get(id)
        if (!partyVoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "list")
            return
        }

        [partyVoteInstance: partyVoteInstance]
    }

    def update(Long id, Long version) {
        def partyVoteInstance = PartyProposal.get(id)
        if (!partyVoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (partyVoteInstance.version > version) {
                partyVoteInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'partyVote.label', default: 'PartyVote')] as Object[],
                          "Another user has updated this PartyVote while you were editing")
                render(view: "edit", model: [partyVoteInstance: partyVoteInstance])
                return
            }
        }

        partyVoteInstance.properties = params

        if (!partyVoteInstance.save(flush: true)) {
            render(view: "edit", model: [partyVoteInstance: partyVoteInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), partyVoteInstance.id])
        redirect(action: "show", id: partyVoteInstance.id)
    }

    def delete(Long id) {
        def partyVoteInstance = PartyProposal.get(id)
        if (!partyVoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "list")
            return
        }

        try {
            partyVoteInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'partyVote.label', default: 'PartyVote'), id])
            redirect(action: "show", id: id)
        }
    }
}
