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
class MandateController {

    static allowedMethods = [save: "POST", update: "POST"]

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
        redirect(action: "composition", id: mandateInstance.id)
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

        if (!mandateInstance.save(flush: true, failOnError: true)) {
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
	
	def composition(Long id){
		def mandateInstance = Mandate.get(id)
		[mandateInstance: mandateInstance, parties: PoliticalParty.list()]
	}
	
	def updateComposition(Long id){
		def mandate = Mandate.get(id)
		int i = 0
		
		try {
			MandateComposition.executeUpdate ('DELETE FROM MandateComposition WHERE mandate=:mandate', [mandate: mandate])
			
			if (params.party){
				params.party.id.each {
					def party = PoliticalParty.get(it)
					def composition = new MandateComposition(mandate: mandate, party: party)			
					composition.members = params.members[i].toInteger()
					composition.save(flush:true, failOnError: true)					
					i++
				}
			}
            render(view: "show", model: [mandateInstance: mandate])
            return
		}catch(Exception e){
			render e.toString()
		}
	}
	
	def getParty(Long id){
		[party: PoliticalParty.get(id)]
	}
		
}
