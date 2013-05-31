import grails.converters.JSON

import org.mayfifteen.openplenary.Mandate
import org.mayfifteen.openplenary.MandateComposition
import org.mayfifteen.openplenary.Meeting
import org.mayfifteen.openplenary.PartyProposal
import org.mayfifteen.openplenary.PoliticalParty
import org.mayfifteen.openplenary.Role
import org.mayfifteen.openplenary.Subject
import org.mayfifteen.openplenary.User
import org.mayfifteen.openplenary.UserRole
import org.springframework.web.context.support.WebApplicationContextUtils

class BootStrap {
	
	def springSecurityService

    def init = { servletContext ->
		def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)
		
		JSON.registerObjectMarshaller(PartyProposal) {
			def returnArray = [:]
			returnArray['partyId'] = it.party.id
			returnArray['partyName'] = it.party.name
			returnArray['voteUp'] = it.voteUp
			returnArray['voteDown'] = it.voteDown
			returnArray['abstention'] = it.abstention
			return returnArray
		}
		
		createUsersAndRoles()
		
		createPoliticalParties()
		
		createMandates()	

    }
	
    def destroy = {
    }
	
	private void createUsersAndRoles(){
		def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)
		def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)
		def facebookRole = Role.findByAuthority('ROLE_FACEBOOK') ?: new Role(authority: 'ROLE_FACEBOOK').save(failOnError: true)
		
		def adminUser = User.findByUsername('admin') ?: new User(
			username: 'admin',
			email: 'admin@openplenary.cat',
			password: 'admin',
			enabled: true).save(failOnError: true)

		if (!adminUser.authorities.contains(adminRole)) {
			UserRole.create adminUser, adminRole
		}
	}
	
	private void createMandates(){
		def mandate = Mandate.findByName("2011/2015")
		if (!mandate){
			mandate = new Mandate(name:'2011/2015')
			mandate.setStartDate(new Date().parse("dd/MM/yyyy", "22/05/2011"))
			mandate.setEndDate(new Date().parse("dd/MM/yyyy", "22/05/2015"))
			
			def ciu = new MandateComposition()
			ciu.members = 6
			ciu.party = PoliticalParty.findByName("CiU")
			mandate.addToComposition(ciu)
			
			def gpc = new MandateComposition()
			gpc.members = 1
			gpc.party = PoliticalParty.findByName("GpC")
			mandate.addToComposition(gpc)
			
			def pp = new MandateComposition()
			pp.members = 2
			pp.party = PoliticalParty.findByName("PP")
			mandate.addToComposition(pp)
			
			def cup = new MandateComposition()
			cup.members = 2
			cup.party = PoliticalParty.findByName("CUP")
			mandate.addToComposition(cup)
			
			def erc = new MandateComposition()
			erc.members = 1
			erc.party = PoliticalParty.findByName("ERC")
			mandate.addToComposition(erc)
			
			def icveuia = new MandateComposition()
			icveuia.members = 1
			icveuia.party = PoliticalParty.findByName("ICV-EUiA")
			mandate.addToComposition(icveuia)
			
			def psc = new MandateComposition()
			psc.members = 4
			psc.party = PoliticalParty.findByName("PSC")
			mandate.addToComposition(psc)
			
			mandate.save(failOnError: true)
			
			if (Meeting.list().size()==0){
				
				String name
				String description
				Date startDate
				Date endDate
				String officialMinutesUrl
				String officialAgendaUrl
				boolean published
				
				def meeting = new Meeting(name: "Test", description: "Lorem ipsum", startDate: new Date(), endDate: new Date(), published:true, mandate: mandate)
				meeting.save(failOnError: true)
				
				def subject1 = new Subject(name: "Foo", description: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla", meeting: meeting)
				subject1.save(failOnError: true)
				
				def subject2 = new Subject(name: "Bar", description: "ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ble ", meeting: meeting)
				subject2.save(failOnError: true)
			}
		}		
	}
	
	private void createPoliticalParties(){
		def ciu = PoliticalParty.findByName("CiU")
		if (!ciu){
			ciu = new PoliticalParty(name: "CiU", logo: "ciu.png", description: "Convergència i Unió")
			ciu.save(failOnError: true)
		}
		
		def gpc = PoliticalParty.findByName("GpC")
		if (!gpc){
			gpc = new PoliticalParty(name: "GpC", logo: "gpc.png", description: "Gent pel Canvi")
			gpc.save(failOnError: true)
		}
		
		def pp = PoliticalParty.findByName("PP")
		if (!pp){
			pp = new PoliticalParty(name: "PP", logo: "pp.png", description: "Partit Popular")
			pp.save(failOnError: true)
		}
		
		def cup = PoliticalParty.findByName("CUP")
		if (!cup){
			cup = new PoliticalParty(name: "CUP", logo: "cup.png", description: "Candidatura d'Unitat Popular")
			cup.save(failOnError: true)
		}
		
		def erc = PoliticalParty.findByName("ERC")
		if (!erc){
			erc = new PoliticalParty(name: "ERC", logo: "erc.png", description: "Esquerra Republicana de Catalunya")
			erc.save(failOnError: true)
		}
		
		def icveuia = PoliticalParty.findByName("ICV-EUiA")
		if (!icveuia){
			icveuia = new PoliticalParty(name: "ICV-EUiA", logo: "icv-euia.png", description: "Iniciativa per Catalunya Verds - Esquerra Unida i Alternativa")
			icveuia.save(failOnError: true)
		}
		
		def psc = PoliticalParty.findByName("PSC")
		if (!psc){
			psc = new PoliticalParty(name: "PSC", logo: "psc.png", description: "Partit Socialista de Catalunya")
			psc.save(failOnError: true)
		}
	}
}
