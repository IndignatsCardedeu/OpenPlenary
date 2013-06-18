import grails.util.Holders

// Place your Spring DSL code here
beans = {
	localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
		def config = Holders.config	
		println("OpenPlenary default Locale: " + config.grails.openplenary.defaultLocale)
		defaultLocale = config.grails.openplenary.defaultLocale
		java.util.Locale.setDefault(defaultLocale)
	 }
}
