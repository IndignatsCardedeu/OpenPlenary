<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><g:layoutTitle default="Grails"/></title>
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'css/radio', file: 'style.css')}" media="screen" />
	<g:javascript library="jquery" />
	<g:layoutHead/>
    <r:layoutResources />	
</head>

<body>
	<div id="main_container">
	
		<div id="header">
	    	<div id="logo"><a href="${resource(dir:'/')}"><img src="${resource(dir: 'images/radio', file: 'logo.gif')}" alt="" title="" border="0" /></a></div>
	        <div class="on_air">
	        	<sec:ifNotLoggedIn>
	        	Tens un usuari per <g:link controller="login">accedir</g:link>?<br/> 
	        	No? <g:link uri="/signup">Vols registrar-te</g:link>?
	        	</sec:ifNotLoggedIn>
	        	<sec:ifLoggedIn>
	        		Welcome <sec:username />! <br/>
	        		<g:link controller="logout">Sortir</g:link>
	        	</sec:ifLoggedIn>
	        	
	        </div>
	    </div>
	    
	    <div id="menu">
	        <ul>                                                                                                                      
	            <li><a class="current" href="${resource(dir:'/')}" title="">Inici</a></li>
	            <li><g:link action="sessions">Plens</g:link></li>	            
	            <li><a href="#" title="">FAQ</a></li>
	            <li><a href="#" title="">Qui som</a></li>
	            <li><a href="#" title="">Contacte</a></li>
	        </ul>
	    </div>
	    
		<g:layoutBody/>	    
    
	    <div id="footer">
	    	<div class="footer_links">                      
		        <a href="#">home</a>
		        <a href="#">listen live</a>
		        <a href="#">about the team</a>
		        <a href="#">contact us </a>
	        </div>
	     	<div class="copyright">
				<a href="http://csstemplatesmarket.com"><img src="${resource(dir: 'images/radio', file: 'csstemplatesmarket.gif')}" border="0" alt="" title="" /></a>
	        </div>    
	    </div> 
	
	
	</div>
	<r:layoutResources />
</body>
</html>