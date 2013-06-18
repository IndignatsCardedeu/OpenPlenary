<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> ::
    		<g:if test="${params.action=='agree'}">
    			<g:message code="party.proposals.voteUp"/>
    		</g:if>
    		<g:elseif test="${params.action=='against'}">
    			<g:message code="party.proposals.voteDown"/>
    		</g:elseif>			    		
    		<g:elseif test="${params.action=='proposals'}">
    			<g:message code="party.proposals.author"/>
    		</g:elseif>	- 
			${party.description} (${party.name})
		</title>
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
					<div class="party-name">
						<g:link action="party" id="${party.id}">
			    			<span class="image"><img src="${resource(dir: 'images/parties')}/${party.logo}"/></span>
							${party.name}
						</g:link> -			    							
			    		<g:if test="${params.action=='agree'}">
			    			<g:message code="party.proposals.voteUp"/>
			    		</g:if>
			    		<g:elseif test="${params.action=='against'}">
			    			<g:message code="party.proposals.voteDown"/>
			    		</g:elseif>			    		
			    		<g:elseif test="${params.action=='proposals'}">
			    			<g:message code="party.proposals.author"/>
			    		</g:elseif>
		    		</div>
		    	</div> 	
		    	<g:each in="${proposals}" var="item" status="i" > 
		    		<div class="meeting_point">		
				    	<div class="meeting_point_area">
							<div class="meeting_point_results">
								<g:remoteLink controller="main" action="voteUp" id="${item.subject.id}" onSuccess="addVote(data, ${item.subject.id});">
									<div id="thumbsUp_${item.subject.id}" class="vote 
										<g:if test="${item.subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))>0}"> 
											up_on
										</g:if>
										<g:else>
											up
										</g:else>
									">${item.subject.getThumbsUp()}</div>
								</g:remoteLink>
								<g:remoteLink controller="main" action="voteDown" id="${item.subject.id}" onSuccess="addVote(data, ${item.subject.id});">
									<div id="thumbsDown_${item.subject.id}" class="vote
										<g:if test="${item.subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))<0}"> 
											down_on
										</g:if>
										<g:else>
											down
										</g:else>
									">${item.subject.getThumbsDown()}</div>
								</g:remoteLink>
								<div id="voteText_${item.subject.id}" class="meeting_point_vote_text">
									<g:if test="${item.subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))==0}">
										<g:message code="main.user.vote"/>
									</g:if>
									<g:else>
										<g:message code="main.user.vote.ok"/>
									</g:else>
								</div>
							</div>		
							<div class="meeting_point_text">
								<strong><g:link controller="main" action="point" id="${item.id}">${item.subject.name}.</g:link></strong> <op:truncate text="${item.subject.description}" length="200"/>
							</div>		
							<div class="meeting_point_area_buttons">
								<div class="meeting_point_tags">
									<g:each in="${item.subject.tags}" var="tag" status="j">
									 	<g:if test="${j>0}">,</g:if>
										<g:link controller="main" action="tag" id="${tag}">${tag}</g:link>
									</g:each>
								</div>
								<g:link controller="main" action="point" id="${item.subject.id}" class="button">${item.subject.comments.size()} <g:message code="meeting.point.comments"/></g:link>
							</div>
				    	</div>	
						<g:if test="${item.subject.getPartyThumbsUp()>0 || item.subject.getPartyThumbsDown()>0 || item.subject.getPartyAbstention()>0}">
							<div id="meeting_point_${item.subject.id}" class="meeting_point_official_results">
								<div class="results_title show"><g:message code="meeting.point.officialResults"/></div>
								<div id="politicians_${item.subject.id}" class="show_results">
									<g:if test="${item.subject.getPartyThumbsUp()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">
											<div class="vote up">${item.subject.getPartyThumbsUp()}</div>										
										</div>		
										<g:each in="${item.subject.getPartyThumbsUpList()}" status="j" var="vote">					
											<g:img dir="images/parties" file="${vote.party.logo}" title="${vote.party.name} ${vote.voteUp} ${message(code:'meeting.point.votes')}"/>
										</g:each>							
									</div>
									</g:if>
									<g:if test="${item.subject.getPartyThumbsDown()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote down">${item.subject.getPartyThumbsDown()}</div>
										</div>								
										<g:each in="${item.subject.getPartyThumbsDownList()}" status="j" var="vote">					
											<g:img dir="images/parties" file="${vote.party.logo}" title="${vote.party.name} ${vote.voteDown} ${message(code:'meeting.point.votes')}"/>
										</g:each>									
									</div>
									</g:if>
									<g:if test="${item.subject.getPartyAbstention()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote abstention">${item.subject.getPartyAbstention()}</div>
										</div>								
										<g:each in="${item.subject.getAbstentionList()}" status="j" var="vote">					
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
