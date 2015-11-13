# OpenPlenary

## Overview
OpenPlenary is a web application to open the city council plenaries and let the people know the decisions taken by the councilors. It it developed using the Groovy language and the Grails framework.

## Build Instructions

 * Download the [source code](https://github.com/IndignatsCardedeu/OpenPlenary)
 * Download and install [Grails 2.2.4](http://grails.org/download). Follow the [instructions](http://grails.github.io/grails-doc/2.2.4/guide/gettingStarted.html)
 * Once done, from the command line, go to the project directory and execute: *> grails compile*
 * Test the application to see if it works: *>grails run-app*
 * Open your browser and go to: http://localhost:8080/openplenary/admin (user admin, password admin) 

## Configuration options
You can configure OpenPlenary using the provided _"openplenary-config.groovy.sample"_ file, just rename it removing the ".sample" extension.

The configuration entries are:

 * **grails.serverURL:** Needed to generate the user register confirmation link. Type your domain and/or context if it is different than the default value http://localhost:8080/openplenary
 * **grails.openplenary.defaultLocale:** application language, by default: _new Locale("en","EN")_
 * **dataSource:** By default H2 database in memory mode. Recommended MySQL. [See the Grails documentation for details](http://grails.org/doc/2.1.0/guide/single.html#dataSource)
 * **mail:** See the [Mail plugin documentation](http://grails.org/plugin/mail) for configuration details 
 * **grails.openplenary.mail.from:** The from email address used in the register confirmation message
 * **grails.openplenary.layout:** The HTML layout. By default 'main' 
 * **grails.openplenary.style:** The color style to be applied to the layout (blue, brown, green, orange, red, violet or yellow). By default "yellow".
 * **grails.openplenary.name:** The name of the town, city or entity
 * **grails.openplenary.voting.allowAnonymous:** Allow anonymous votes. By default false.
 * **grails.openplenary.voting.maxAnonymousVotes:** Maximum number of anonymous votes if "grails.openplenary.voting.allowAnonymous" is set to true. By default 5.
 * **grails.openplenary.subject.slicePoint:** Numbers of limit characters to slice the text of a point. By default 1000
 * **grails.openplenary.encodeEmail:** If true the users email is encoded in the database. By default false
 * **grails.openplenary.fileUploadPath:** File upload directory 
 * **grails.plugins.springsecurity.facebook.appId:** Application identifier for Facebook login
 * **grails.plugins.springsecurity.facebook.secret:** Secret word for Facebook login 
