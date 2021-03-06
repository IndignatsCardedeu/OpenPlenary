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

package org.mayfifteen.openplenary.utils

import java.security.MessageDigest

class StringUtils {
	
	static String textCleaner( String input ) {
		char elegem = 0x97
		return input.replaceAll(elegem.toString(),"·")
	}
	
	static String generateMD5( String input ){
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		md5.update(input.getBytes());
		BigInteger hash = new BigInteger(1, md5.digest());
		return hash.toString(16);
	}
	
}
