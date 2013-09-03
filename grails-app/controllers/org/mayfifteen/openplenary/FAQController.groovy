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

import grails.plugins.springsecurity.Secured

import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class FAQController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [FAQInstanceList: FAQ.list(params), FAQInstanceTotal: FAQ.count()]
    }

    def create() {
        [FAQInstance: new FAQ(params)]
    }

    def save() {
        def FAQInstance = new FAQ(params)
        if (!FAQInstance.save(flush: true)) {
            render(view: "create", model: [FAQInstance: FAQInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'FAQ.label', default: 'FAQ'), FAQInstance.id])
        redirect(action: "show", id: FAQInstance.id)
    }

    def show(Long id) {
        def FAQInstance = FAQ.get(id)
        if (!FAQInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "list")
            return
        }

        [FAQInstance: FAQInstance]
    }

    def edit(Long id) {
        def FAQInstance = FAQ.get(id)
        if (!FAQInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "list")
            return
        }

        [FAQInstance: FAQInstance]
    }

    def update(Long id, Long version) {
        def FAQInstance = FAQ.get(id)
        if (!FAQInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (FAQInstance.version > version) {
                FAQInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'FAQ.label', default: 'FAQ')] as Object[],
                          "Another user has updated this FAQ while you were editing")
                render(view: "edit", model: [FAQInstance: FAQInstance])
                return
            }
        }

        FAQInstance.properties = params

        if (!FAQInstance.save(flush: true)) {
            render(view: "edit", model: [FAQInstance: FAQInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'FAQ.label', default: 'FAQ'), FAQInstance.id])
        redirect(action: "show", id: FAQInstance.id)
    }

    def delete(Long id) {
        def FAQInstance = FAQ.get(id)
        if (!FAQInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "list")
            return
        }

        try {
            FAQInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'FAQ.label', default: 'FAQ'), id])
            redirect(action: "show", id: id)
        }
    }
}
