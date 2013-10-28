<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: ${meeting.name}</title>
		<g:javascript library="jquery" />
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
			<div class="meeting"> 
				<div class="meeting-name">
		    		<span class="date"><g:formatDate date="${meeting.startDate}" format="dd-MM" /></span>
		    		${meeting.name}	    		 		    		
	    		</div>
				<p>${meeting.description}</p>
				<ul class="meeting-item-list">
					<g:if test="${meeting.officialMinutesUrl}">
						<li class="meeting-item minutes-item">
							<a href="${meeting.officialMinutesUrl}"><g:message code="meeting.minutes"/></a>				
						</li>
					</g:if>				
					<li class="meeting-item taglist-item">										
						<g:each in="${meetingTags}" var="tag" status="j">
							<g:link controller="tag" action="session" id="${meeting.id}" params="${[tag: tag.key]}">${tag.key}</g:link><g:if test="${j+1<meetingTags.size()}">,</g:if>
						</g:each>
					</li>
					<li class="meeting-item social-item">
						<a href="http://www.facebook.com/sharer.php?u=<op:pageUrl  />&title=${meeting.name}" class="popup" title="<g:message code="main.share.content" /> Facebook"><img src="${resource(dir:'images/social', file:'facebook.png')}" /></a>
						<a href="http://twitter.com/share?url=<op:pageUrl  />&text=${meeting.name}" class="popup" title="<g:message code="main.share.content" /> Twitter"><img src="${resource(dir:'images/social', file:'twitter.png')}" /></a>
						<a href="https://plus.google.com/share?url=<op:pageUrl  />" class="popup" title="<g:message code="main.share.content" /> Google+"><img src="${resource(dir:'images/social', file:'google.png')}" /></a>
						<a href="http://www.linkedin.com/shareArticle?mini=true&url=<op:pageUrl  />&title=${meeting.name}" class="popup" title="<g:message code="main.share.content" /> LinkedIn"><img src="${resource(dir:'images/social', file:'linkedin.png')}" /></a>
						<a href="http://friendfeed.com/?url=<op:pageUrl  />&title=${meeting.name}" class="popup" title="<g:message code="main.share.content" /> FrienFeed"><img src="${resource(dir:'images/social', file:'friendfeed.png')}" /></a>
						<a href="https://delicious.com/post?url=<op:pageUrl  />&title=${meeting.name}" class="popup" title="<g:message code="main.share.content" /> Delicious"><img src="${resource(dir:'images/social', file:'delicious.png')}" /></a>
					</li>					
				</ul>			 
	    	</div>	    	 	
	    	<g:if test="${relevants}">
		    	<div id="subjects-relevant-list">	    		
		    		<h2><g:message code="meeting.relevants" /></h2>	    		    			
		    		<g:each in="${relevants}" status="i" var="subject">
						<div class="meeting_point ${(i % 2) == 0 ? 'even' : 'odd'}">
							<div class="meeting_point_area">											
								<div class="meeting_point_results">
									<g:remoteLink controller="main" action="voteUp" id="${subject.id}" onSuccess="addVote(data, ${subject.id});">
										<div id="thumbsUp_${subject.id}" class="vote 
											<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))>0}"> 
												up_on
											</g:if>
											<g:else>
												up
											</g:else>
										">${subject.getThumbsUp()}</div>
									</g:remoteLink>
									<g:remoteLink controller="main" action="voteDown" id="${subject.id}" onSuccess="addVote(data, ${subject.id});">
										<div id="thumbsDown_${subject.id}" class="vote 
											<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))<0}"> 
												down_on
											</g:if>
											<g:else>
												down
											</g:else>
										">${subject.getThumbsDown()}</div>
									</g:remoteLink>
									<div id="voteText_${subject.id}" class="meeting_point_vote_text">
										<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))==0}">
											<g:message code="main.user.vote"/>
										</g:if>
										<g:else>
											<g:message code="main.user.vote.ok"/>
										</g:else>
									</div>
								</div>		
								<div class="meeting_point_text">
									<strong><g:link controller="main" action="point" id="${subject.id}">${subject.name}.</g:link></strong> <op:truncate text="${subject.description}" length="200"/>
								</div>			
								<div class="meeting_point_area_buttons">
									<div class="meeting_point_tags ">										
										<g:each in="${subject.tags}" var="tag" status="j">																					 
											<g:link controller="main" action="tag" id="${tag}">${tag}</g:link><g:if test="${j+1<subject.tags.size()}">,</g:if>
										</g:each>
									</div>
									<g:link controller="main" action="point" id="${subject.id}" class="button">${subject.comments.size()} <g:message code="meeting.point.comments"/></g:link>
								</div>										
							</div>
							<g:if test="${subject.getPartyThumbsUp()>0 || subject.getPartyThumbsDown()>0 || subject.getPartyAbstention()>0}">
								<div id="meeting_point_${subject.id}" class="meeting_point_official_results">
									<div class="results_title show"><g:message code="meeting.point.officialResults"/></div>
									<div id="politicians_${subject.id}" class="show_results">
										<g:if test="${subject.getPartyThumbsUp()>0}">
										<div class="show_thumbs">
											<div class="meeting_point_party_results">
												<div class="vote up">${subject.getPartyThumbsUp()}</div>										
											</div>		
											<g:each in="${subject.getPartyThumbsUpList()}" status="j" var="vote">					
												<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteUp} ${message(code:'meeting.point.votes')}"/>
											</g:each>							
										</div>
										</g:if>
										<g:if test="${subject.getPartyThumbsDown()>0}">
										<div class="show_thumbs">
											<div class="meeting_point_party_results">										
												<div class="vote down">${subject.getPartyThumbsDown()}</div>
											</div>								
											<g:each in="${subject.getPartyThumbsDownList()}" status="j" var="vote">					
												<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteDown} ${message(code:'meeting.point.votes')}"/>
											</g:each>									
										</div>
										</g:if>
										<g:if test="${subject.getPartyAbstention()>0}">
										<div class="show_thumbs">
											<div class="meeting_point_party_results">										
												<div class="vote abstention">${subject.getPartyAbstention()}</div>
											</div>								
											<g:each in="${subject.getAbstentionList()}" status="j" var="vote">					
												<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.abstention} ${message(code:'meeting.point.votes')}"/>
											</g:each>									
										</div>								
										</g:if>
									</div> 
								</div>
							</g:if>
						</div>   
		    		</g:each>	    	
		    	</div>
	    	</g:if>
	    	<div id="subjects-list">
	    		<g:each in="${subjects}" status="i" var="subject">
					<div class="meeting_point ${(i % 2) == 0 ? 'even' : 'odd'}">
						<div class="meeting_point_area">											
							<div class="meeting_point_results">
								<g:remoteLink controller="main" action="voteUp" id="${subject.id}" onSuccess="addVote(data, ${subject.id});">
									<div id="thumbsUp_${subject.id}" class="vote 
										<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))>0}"> 
											up_on
										</g:if>
										<g:else>
											up
										</g:else>
									">${subject.getThumbsUp()}</div>
								</g:remoteLink>
								<g:remoteLink controller="main" action="voteDown" id="${subject.id}" onSuccess="addVote(data, ${subject.id});">
									<div id="thumbsDown_${subject.id}" class="vote 
										<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))<0}"> 
											down_on
										</g:if>
										<g:else>
											down
										</g:else>
									">${subject.getThumbsDown()}</div>
								</g:remoteLink>
								<div id="voteText_${subject.id}" class="meeting_point_vote_text">
									<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString(), request.getRemoteAddr(), request.getHeader('User-Agent'))==0}">
										<g:message code="main.user.vote"/>
									</g:if>
									<g:else>
										<g:message code="main.user.vote.ok"/>
									</g:else>
								</div>
							</div>		
							<div class="meeting_point_text">
								<strong><g:link controller="main" action="point" id="${subject.id}">${subject.name}.</g:link></strong> <op:truncate text="${subject.description}" length="200"/>
							</div>			
							<div class="meeting_point_area_buttons">
								<div class="meeting_point_tags">
									<g:each in="${subject.tags}" var="tag" status="j">
									 	<g:if test="${j>0}">,</g:if>
										<g:link controller="main" action="tag" id="${tag}">${tag}</g:link>
									</g:each>
								</div>
								<g:link controller="main" action="point" id="${subject.id}" class="button">${subject.comments.size()} <g:message code="meeting.point.comments"/></g:link>
							</div>										
						</div>
						<g:if test="${subject.getPartyThumbsUp()>0 || subject.getPartyThumbsDown()>0 || subject.getPartyAbstention()>0}">
							<div id="meeting_point_${subject.id}" class="meeting_point_official_results">
								<div class="results_title show"><g:message code="meeting.point.officialResults"/></div>
								<div id="politicians_${subject.id}" class="show_results">
									<g:if test="${subject.getPartyThumbsUp()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">
											<div class="vote up">${subject.getPartyThumbsUp()}</div>										
										</div>		
										<g:each in="${subject.getPartyThumbsUpList()}" status="j" var="vote">					
											<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteUp} ${message(code:'meeting.point.votes')}"/>
										</g:each>							
									</div>
									</g:if>
									<g:if test="${subject.getPartyThumbsDown()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote down">${subject.getPartyThumbsDown()}</div>
										</div>								
										<g:each in="${subject.getPartyThumbsDownList()}" status="j" var="vote">					
											<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteDown} ${message(code:'meeting.point.votes')}"/>
										</g:each>									
									</div>
									</g:if>
									<g:if test="${subject.getPartyAbstention()>0}">
									<div class="show_thumbs">
										<div class="meeting_point_party_results">										
											<div class="vote abstention">${subject.getPartyAbstention()}</div>
										</div>								
										<g:each in="${subject.getAbstentionList()}" status="j" var="vote">					
											<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.abstention} ${message(code:'meeting.point.votes')}"/>
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
