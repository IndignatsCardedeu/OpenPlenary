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
