<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: <g:message code="main.menu.option.contact" /></title>
		<script type="text/javascript">
			$(document).ready(function(){
				$(".faq-item").click(function () {	
					if ($(this).find(".faq-text").css("display")!="block"){
						$(this).find("h3").removeClass("close");
						$(this).find("h3").addClass("open");
					}else{
						$(this).find("h3").removeClass("open");
						$(this).find("h3").addClass("close");						
					}					

					$(this).find(".faq-text").slideToggle("slow");					
				});
			});
		</script>
	</head>
	<body>		
		<div id="faq-box">
			<op:page code="contact"/>
		</div>			
	</body>
</html>

