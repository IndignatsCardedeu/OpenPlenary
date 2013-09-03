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
