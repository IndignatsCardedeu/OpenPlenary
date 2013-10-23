<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><g:message code='main.app.name'/> - ${grailsApplication.config.grails.openplenary.name} <g:layoutTitle /></title>
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'css/main', file: 'style.css')}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'colorbox.css')}" media="screen" />	
	<g:javascript library="jquery" />					
    <r:layoutResources />	    
    <jq:plugin name="colorbox"/>  
    <jq:plugin name="expander"/>
    <script type="text/javascript" src="${resource(dir:'js',file:'application.js')}"></script>       
    <g:layoutHead/>    
</head>

<body>
	<div id="container">
		<div id="header">
			<div id="logo">
				<a href="${resource(dir:'/')}">
				<g:message code="main.app.name"/>
				${grailsApplication.config.grails.openplenary.name}
				</a>
			</div>
		    <div id="menu">
		        <ul>                                                                                                                      
		            <li 
		            	<g:if test="${params.action=='home'}">
		            		class="current"
		            	</g:if>
		            >
		            	<a class="current" href="${resource(dir:'/')}" title=""><g:message code="main.menu.option.home"/></a>
		            </li>
		            <li
		            	<g:if test="${params.action=='sessions' || params.action=='session' || params.action=='item' || params.action=='tag'}">
		            		class="current"
		            	</g:if>
		            >
		            	<g:link controller="main" action="sessions"><g:message code="main.menu.option.plenary"/></g:link>
		            </li>	            
		            <li
		            	<g:if test="${params.action=='faq'}">
		            		class="current"
		            	</g:if>
		            >
		            	<g:link controller="main" action="faq"><g:message code="main.menu.option.faq"/></g:link>
		            </li>
		            <li
		            	<g:if test="${params.action=='contact'}">
		            		class="current"
		            	</g:if>
		            >
		            	<g:link controller="main" action="contact"><g:message code="main.menu.option.contact"/></g:link>
		            </li>
		        </ul>
		    </div>
		    <div id="userbox">
		    	<sec:ifNotLoggedIn>
			    	<g:link controller="login" action="auth"><div class="button"><g:message code="springSecurity.login.button"/></div></g:link>
			    	<g:link uri="/signup"><div class="button"><g:message code="user.register.label"/></div></g:link>
		    	</sec:ifNotLoggedIn>
	        	<sec:ifLoggedIn>
        			<g:link controller="profile"><div class="button"><op:username /></div></g:link>
	        		<g:link controller="logout"><div class="button"><g:message code="main.user.exit"/></div></g:link>
	        	</sec:ifLoggedIn>		    	
		    </div>			
		</div>
		<div id="content">
			<g:layoutBody/>	
			<g:if test="${params.action!='home' && params.action!='profile' && params.action!='auth' && params.action!='signup' && params.action!='register' && params.action!='update'}">
				<div id="box-area">
					<div class="box-a">
						<h3><g:message code="party.title" /></h3>
						<op:parties />
					</div>
					<div class="box-b">
						<tc:tagCloud controller="tag" action="index" bean="${org.mayfifteen.openplenary.Subject}" color="${[start: '#888', end: '#444']}" id="tag" paramName="tag"/>
					</div>			
				</div>		
			</g:if>			
		</div>
		<div id="footer">
			<g:link controller="main" action="legal"><g:message code="main.legal"/></g:link> :: <g:message code="main.copyright"/>
		</div>
	</div>
	<div id="overlay">
	  <img src="${resource(dir:'/images/main', file: 'ajax-loader.gif')}" id="img-load" />
	</div>
	<div style='display:none'>
		<div id='notloggedin' style='padding:10px; background:#fff;'>
			<p id="notloggedin_title"></p>
			<p id="notloggedin_message_1"></p>
			<p id="notloggedin_message_2"></p>
		</div>
	</div>		
	<r:layoutResources />
</body>
</html>