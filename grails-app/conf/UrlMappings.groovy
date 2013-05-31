class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/admin" (controller:"main", action:'admin')
		"/signup" (controller:"webUser", action:'signup')
		"/register" (controller:"webUser", action:'register')
		"/profile" (controller:"webUser", action:'profile')
		"/tag/$tag" (controller:"tag", action: 'index')
		"/tag/party/$id/$tag" (controller:"tag", action: 'party')
		"/tag/session/$id/$tag" (controller:"tag", action: 'session')
		"/"(controller:"main", action:"home")
		"/$action?/$id?"(controller:"main")
		"500"(view:'/error')
	}
}
