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

class Meeting {
	
	static belongsTo = [mandate: Mandate]
	static hasMany = [subjects: Subject]
	
	String name
	String description	
	Date startDate
	Date endDate
	String officialMinutesUrl
	String officialAgendaUrl
	boolean published

    static constraints = {
		name(nullable: false, blank: false)
		officialMinutesUrl(url: true, nullable: true, blank: true)
		officialAgendaUrl(url: true, nullable: true, blank: true)
    }
	
	static mapping = {
		description type:"text"
		sort startDate: "desc"
		subjects sort: 'id', order: 'asc'
	}
}
