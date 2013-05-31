<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: <g:message code="main.menu.option.faq" /></title>
		<script type="text/javascript">
			$(document).ready(function(){
				$(".faq-item").click(function () {	
					if ($(this).find(".faq-text").css("display")!="block"){
						$(this).find("h3").removeClass("open");
						$(this).find("h3").addClass("close");
					}else{
						$(this).find("h3").removeClass("close");
						$(this).find("h3").addClass("open");						
					}					

					$(this).find(".faq-text").slideToggle("slow");					
				});
			});
		</script>
	</head>
	<body>		
		<div id="faq-box">
			<h2>Preguntes més freqüents</h2>
			<op:page code="faq" />
		</div>			
	</body>
</html>

