package org.mayfifteen.openplenary

import org.springframework.context.ResourceLoaderAware
import org.springframework.core.io.ResourceLoader

class FilesController implements ResourceLoaderAware {
	
	ResourceLoader resourceLoader

    def logo() { 
		String filename = grailsApplication.config.grails.openplenary.fileUploadPath + "/" + params.id
		
		File file = new File(filename)
		if (!file.exists()) file = resourceLoader.getResource("/images/parties/anonymous.png").getFile()
		
		response.outputStream << file.newInputStream()
	}
	
	def document() {
		String filename = grailsApplication.config.grails.openplenary.fileUploadPath + "/" + params.id
		
		File file = new File(filename)		
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment;filename=${file.getName()}")
		
		response.outputStream << file.newInputStream()
	}
}
