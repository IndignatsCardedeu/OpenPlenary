<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<script type="text/javascript">
			$(document).ready(function(){
				$(".meeting_point_official_results").click(function () {
					if ($(this).find(".show_results").css("display")!="block"){
						$(this).find(".show").addClass("hide");
						$(this).find(".show").removeClass("show");					
					}else{
						$(this).find(".hide").addClass("show");
						$(this).find(".hide").removeClass("hide");													
					}
					$(this).find(".show_results").slideToggle("slow");
				});
			});
		</script>		
	</head>
	<body>		
		<div id="meetings-box">
			<div class="meeting_point subject-item-list">
				<div class="meeting"> 
					<div class="meeting-name">
			    		<span class="date">Etiqueta</span>
			    		${params.id}
		    		</div>
		    	</div> 		
				<g:each in="${subjects}" var="item" status="i" >
					<div class="meeting_point">			    	
				    	<div class="meeting_point_area">
							<div class="meeting_point_results">
								<g:remoteLink controller="main" action="voteUp" id="${item.id}" onSuccess="addVote(data, ${item.id});">
									<div id="thumbsUp_${item.id}" class="vote 
										<g:if test="${item.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))>0}"> 
											up_on
										</g:if>
										<g:else>
											up
										</g:else>
									">${item.getThumbsUp()}</div>
								</g:remoteLink>
								<g:remoteLink controller="main" action="voteDown" id="${item.id}" onSuccess="addVote(data, ${item.id});">
									<div id="thumbsDown_${item.id}" class="vote
										<g:if test="${item.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))<0}"> 
											down_on
										</g:if>
										<g:else>
											down
										</g:else>
									">${item.getThumbsDown()}</div>
								</g:remoteLink>
								<div id="voteText_${item.id}" class="meeting_point_vote_text">
									<g:if test="${item.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))==0}">
										<g:message code="main.user.vote"/>
									</g:if>
									<g:else>
										<g:message code="main.user.vote.ok"/>
									</g:else>
								</div>
							</div>		
							<div class="meeting_point_text">
								<strong><g:link controller="main" action="point" id="${item.id}">${item.name}.</g:link></strong> <op:truncate text="${item.description}" length="200"/>
							</div>		
							<div class="meeting_point_area_buttons">
								<div class="meeting_point_tags">
									<g:each in="${item.tags}" var="tag" status="j">
									 	<g:if test="${j>0}">,</g:if>
										<g:link controller="main" action="tag" id="${tag}">${tag}</g:link>
									</g:each>
								</div>
								<g:link controller="main" action="point" id="${item.id}" class="button">${item.comments.size()} <g:message code="meeting.point.comments"/></g:link>
							</div>
				    	</div>	
						<g:if test="${item.getPartyThumbsUp()>0 || item.getPartyThumbsDown()>0 || item.getPartyAbstention()>0}">
							<div id="meeting_point_${item.id}" class="meeting_point_official_results">
								<div class="results_title show"><g:message code="meeting.point.officialResults"/></div>
								<div id="politicians_${item.id}" class="show_results">
									<g:if test="${item.getPartyThumbsUp()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">
											<div class="vote up">${item.getPartyThumbsUp()}</div>										
										</div>		
										<g:each in="${item.getPartyThumbsUpList()}" status="j" var="vote">					
											<g:img dir="images/parties" file="${vote.party.logo}" title="${vote.party.name} ${vote.voteUp} ${message(code:'meeting.point.votes')}"/>
										</g:each>							
									</div>
									</g:if>
									<g:if test="${item.getPartyThumbsDown()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote down">${item.getPartyThumbsDown()}</div>
										</div>								
										<g:each in="${item.getPartyThumbsDownList()}" status="j" var="vote">					
											<g:img dir="images/parties" file="${vote.party.logo}" title="${vote.party.name} ${vote.voteDown} ${message(code:'meeting.point.votes')}"/>
										</g:each>									
									</div>
									</g:if>
									<g:if test="${item.getPartyAbstention()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote abstention">${item.getPartyAbstention()}</div>
										</div>								
										<g:each in="${item.getAbstentionList()}" status="j" var="vote">					
											<g:img dir="images/parties" file="${vote.party.logo}" title="${vote.party.name} ${vote.abstention} ${message(code:'meeting.point.votes')}"/>
										</g:each>									
									</div>								
									</g:if>
								</div> 
							</div>
						</g:if> 
					</div>
		 		</g:each> 							
			</div> 				
		</div>			
	</body>
</html>
