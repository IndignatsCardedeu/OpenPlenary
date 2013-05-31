package org.mayfifteen.openplenary

class User {

	transient springSecurityService

	Date dateCreated
	Date lastUpdated

	String username
	String password
	String email
	String avatar = ""
	String validate = ""
	Date lastLogin = new Date()	
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	
	static constraints = {
		username blank: false, unique: true
		password blank: false
		email email: true, nullable: true, unique: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
