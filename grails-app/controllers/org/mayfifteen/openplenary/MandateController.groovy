package org.mayfifteen.openplenary

import org.springframework.dao.DataIntegrityViolationException

class MandateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mandateInstanceList: Mandate.list(params), mandateInstanceTotal: Mandate.count()]
    }

    def create() {
        [mandateInstance: new Mandate(params)]
    }

    def save() {
        def mandateInstance = new Mandate(params)
        if (!mandateInstance.save(flush: true)) {
            render(view: "create", model: [mandateInstance: mandateInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mandate.label', default: 'Mandate'), mandateInstance.id])
        redirect(action: "show", id: mandateInstance.id)
    }

    def show(Long id) {
        def mandateInstance = Mandate.get(id)
        if (!mandateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "list")
            return
        }

        [mandateInstance: mandateInstance]
    }

    def edit(Long id) {
        def mandateInstance = Mandate.get(id)
        if (!mandateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "list")
            return
        }

        [mandateInstance: mandateInstance]
    }

    def update(Long id, Long version) {
        def mandateInstance = Mandate.get(id)
        if (!mandateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mandateInstance.version > version) {
                mandateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'mandate.label', default: 'Mandate')] as Object[],
                          "Another user has updated this Mandate while you were editing")
                render(view: "edit", model: [mandateInstance: mandateInstance])
                return
            }
        }

        mandateInstance.properties = params

        if (!mandateInstance.save(flush: true)) {
            render(view: "edit", model: [mandateInstance: mandateInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mandate.label', default: 'Mandate'), mandateInstance.id])
        redirect(action: "show", id: mandateInstance.id)
    }

    def delete(Long id) {
        def mandateInstance = Mandate.get(id)
        if (!mandateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "list")
            return
        }

        try {
            mandateInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mandate.label', default: 'Mandate'), id])
            redirect(action: "show", id: id)
        }
    }
}
