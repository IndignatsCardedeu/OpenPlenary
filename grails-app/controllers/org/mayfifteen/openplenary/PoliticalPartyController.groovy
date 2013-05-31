package org.mayfifteen.openplenary

import grails.plugins.springsecurity.Secured

import org.mayfifteen.openplenary.PoliticalParty;
import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class PoliticalPartyController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [partyInstanceList: PoliticalParty.list(params), partyInstanceTotal: PoliticalParty.count()]
    }

    def create() {
        [partyInstance: new PoliticalParty(params)]
    }

    def save() {
        def partyInstance = new PoliticalParty(params)
        if (!partyInstance.save(flush: true)) {
            render(view: "create", model: [partyInstance: partyInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'party.label', default: 'Party'), partyInstance.id])
        redirect(action: "list", id: partyInstance.id)
    }

    def show(Long id) {
        def partyInstance = PoliticalParty.get(id)
        if (!partyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "list")
            return
        }

        [partyInstance: partyInstance]
    }

    def edit(Long id) {
        def partyInstance = PoliticalParty.get(id)
        if (!partyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "list")
            return
        }

        [partyInstance: partyInstance]
    }

    def update(Long id, Long version) {
        def partyInstance = PoliticalParty.get(id)
        if (!partyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (partyInstance.version > version) {
                partyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'party.label', default: 'Party')] as Object[],
                          "Another user has updated this Party while you were editing")
                render(view: "edit", model: [partyInstance: partyInstance])
                return
            }
        }

        partyInstance.properties = params

        if (!partyInstance.save(flush: true)) {
            render(view: "edit", model: [partyInstance: partyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'party.label', default: 'Party'), partyInstance.id])
        redirect(action: "list", id: partyInstance.id)
    }

    def delete(Long id) {
        def partyInstance = PoliticalParty.get(id)
        if (!partyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "list")
            return
        }

        try {
            partyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'party.label', default: 'Party'), id])
            redirect(action: "show", id: id)
        }
    }
}
