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
			<h2><g:message code="faq.title" /></h2>
			<g:each in="${questions}" status="index" var="faq">
				<div class="faq-item">
					<div class="show faq-header">
						<h3 class="open">${faq.question}</h3>
					</div>
					<div class="show_results faq-text">
						${faq.answer}
					</div>
				</div>			
			</g:each>
		</div>			
	</body>
</html>

