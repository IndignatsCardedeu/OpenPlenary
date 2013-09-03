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

import org.mayfifteen.openplenary.FacebookUser;
import org.mayfifteen.openplenary.User;

import com.restfb.DefaultFacebookClient
import com.restfb.FacebookClient
import com.the6hours.grails.springsecurity.facebook.FacebookAuthToken

class FacebookAuthService {

    void onCreate(FacebookUser user, FacebookAuthToken token){
		FacebookClient fb = new DefaultFacebookClient(token.accessToken.accessToken)
		com.restfb.types.User fbuser = fb.fetchObject("me", com.restfb.types.User.class)
		User systemUser = User.get(user.user.id)
		systemUser.username = fbuser.firstName + "_" + systemUser.username 
		systemUser.save(flush:true)
	}
}
