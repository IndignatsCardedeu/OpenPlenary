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
