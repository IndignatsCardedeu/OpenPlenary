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

class Mandate {
	
	static hasMany = [composition: MandateComposition]
	
	String name
	Date startDate
	Date endDate
	boolean published

	static mapping = {
		composition sort: "members", order: "desc"
	}
	
    static constraints = {
		
    }
	
	def getPoliticalParties(){
		return PoliticalParty.executeQuery("SELECT p FROM PoliticalParty p, MandateComposition m WHERE m.party.id=p.id AND m.mandate=:mandate ORDER BY m.members DESC", [mandate: this])
	}
}
