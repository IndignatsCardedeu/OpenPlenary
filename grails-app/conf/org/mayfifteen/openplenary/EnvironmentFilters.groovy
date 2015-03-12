package org.mayfifteen.openplenary

class EnvironmentFilters {

    def filters = {
        all(controller:'*', action:'*') {
			before = {				
				if (!session["currentMandate"]){
					Date date = new Date()
					Mandate mandate = Mandate.findByStartDateLessThanEqualsAndEndDateGreaterThanEqualsAndPublished(date,date,true)
					if (!mandate) {				
						mandate = Mandate.findByStartDateLessThanEqualsAndPublished(date,true)
					}
					session["currentMandate"] = mandate
				}
			}
			after = { Map model ->

			}
			afterView = { Exception e ->

			}
        }
		
    }
}
