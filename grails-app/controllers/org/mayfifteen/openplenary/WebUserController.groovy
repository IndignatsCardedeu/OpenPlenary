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

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class WebUserController {
	
	def springSecurityService
	def authenticateService
	def messageSource
	def grailsApplication
	def simpleCaptchaService

    def signup() {
		def config = SpringSecurityUtils.securityConfig
		def terms = Content.findByKeyname("TERMS")
		String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
		[userInstance: new User(params), postUrl: postUrl, terms: terms]
	}
		
	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def profile(){		
		[userInstance: springSecurityService.currentUser]
	}
	
	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def update(){
		def user = User.get(springSecurityService.currentUser.id)
		if (!user) {
			redirect(controller: "main", action: "home")
		}else{
			
			if (params.password==""){
				params.password = user.password
				params.confirm = user.password
			}
			
			user.properties = params
	
			if (!user.save(flush: true)) {				
				render(view: "profile", model: [userInstance: user])
			}else{
				springSecurityService.reauthenticate(user.username, user.password)
				flash.message = message(code: 'user.updated.message')
				redirect(action: "profile", id: user.id)
			}
		}
	}
	
	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def delete(){
		def user = User.get(springSecurityService.currentUser.id)
		
		if (user.authorities.any{ it.authority == 'ROLE_FACEBOOK'}){
			def fbUser = FacebookUser.findWhere(user: user)
			fbUser.delete()
		}
		
		SubjectUserVote.removeByUser(user)
		Comment.removeByUser(user)
		UserRole.removeAll(user)
		user.delete()
		
		redirect(controller: "logout")
	}
	
	def register(){	
		def webUser= new User(params)		
		
		if (simpleCaptchaService.validateCaptcha(params.captcha)){
			webUser.validate =  UUID.randomUUID().toString()
	
			if (!webUser.save(flush:true)) {
				render(view: "signup", model: [userInstance: webUser])
				return
			}
			
			def userRole = Role.findByAuthority('ROLE_USER')
			UserRole.create webUser, userRole
			
			this.mail(
				message(code:"user.signup.confirmation.mail.subject", args:[grailsApplication.config.grails.openplenary.name]),
				message(code:"user.signup.confirmation.mail.body", args:[grailsApplication.config.grails.serverURL, webUser.validate]), webUser.email)
	
			flash.message = message(code: 'user.created.message', args: [message(code: 'user.label', default: 'User'), webUser.id])
		}else{		
			flash.error = message(code: 'user.captcha.fail')
			render(view: "signup", model: [userInstance: webUser])
		}
	}
	
	def confirm(){
		def webUser = User.findByValidate(params.key)
		
		if (webUser){
			webUser.enabled = true
			webUser.save(flush: true, failOnError: true)
			flash.message = message(code: 'user.confirmed.message', args: [webUser.username])
		}else{
			redirect(controller: "main", action: "home")
		}				
	}
	
	private void mail(mailSubject, mailBody, mailTo){
		String mailFrom = grailsApplication.config.grails.openplenary.mail.from
		
		sendMail {
			from mailFrom
			to mailTo
			subject mailSubject
			body mailBody
		  }
	}
	
}
