package org.mayfifteen.openplenary

class LegislatureController {

    def index() { 
		redirect(action: "list", params: params)
	}
	
	def list() {
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
		[legislatures: Mandate.list(params), legislaturesTotal: Mandate.count()]
	}
}
