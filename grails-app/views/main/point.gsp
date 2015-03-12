<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">
		<title> :: ${item.name}</title>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#meeting_point_content_desc").expander({
					slicePoint: ${grailsApplication.config.grails.openplenary.subject.slicePoint},
					expandText: '<g:message code="main.read.more"/>',
					userCollapseText: '<g:message code="main.read.less"/>'
				});
				
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
		    		<span class="date"><g:formatDate date="${item.meeting.startDate}" format="dd-MM" /></span>
		    		<g:link controller="main" action="session" id="${item.meeting.id}" >${item.meeting.name}</g:link>
	    		</div>
	    	</div> 		
	    	<div class="meeting_point meeting_point_area">
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
					<div class="meeting_point_content">
						<h3>${item.name}.</h3>
						<g:if test="${item.attachments}">
							<div id="related">
								Contingut relacionat
								<ul>
									<g:each in="${item.attachments}" var="attachment">
										<li>
											<a 
												<g:if test="${attachment.type==0}">
													href="${attachment.filename}"
												</g:if>
												<g:else>
													href="<g:createLink controller="files" action="document" id="${attachment.filename}" />"
												</g:else>
											>
												${attachment.title}
											</a>
										</li>
									</g:each>
								</ul>
							</div>						 
						</g:if>
						<div id="meeting_point_content_desc">
							<op:setMinutesLink text="${item.description}" minutesLink="${item.meeting.officialMinutesUrl}"/>
						</div>						
					</div>
					<div class="meeting_point_agreements">
					 	<op:setMinutesLink text="${item.agreements}" minutesLink="${item.meeting.officialMinutesUrl}"/>
					</div>
				</div>		
				<div class="meeting_point_area_buttons">
					<div class="meeting_point_tags">
						<ul class="meeting-point-item-list">
							<li class="meeting-point-item taglist-item">
								<g:each in="${item.tags}" var="tag" status="j">						 	
									<g:link controller="tag" action="index" id="${item.meeting.mandate.id}" params="${[tag: tag]}">${tag}</g:link>
									<g:if test="${j+1<item.tags.size()}">,</g:if>
								</g:each>
							</li>
							<li class="meeting-point-item social-item">
								<a href="http://www.facebook.com/sharer.php?u=<op:pageUrl  />&title=${item.name}" class="popup" title="<g:message code="main.share.content" /> Facebook"><img src="${resource(dir:'images/social', file:'facebook.png')}" /></a>
								<a href="http://twitter.com/share?url=<op:pageUrl  />&text=${item.name}" class="popup" title="<g:message code="main.share.content" /> Twitter"><img src="${resource(dir:'images/social', file:'twitter.png')}" /></a>
								<a href="https://plus.google.com/share?url=<op:pageUrl  />" class="popup" title="<g:message code="main.share.content" /> Google+"><img src="${resource(dir:'images/social', file:'google.png')}" /></a>
								<a href="http://www.linkedin.com/shareArticle?mini=true&url=<op:pageUrl  />&title=${item.name}" class="popup" title="<g:message code="main.share.content" /> LinkedIn"><img src="${resource(dir:'images/social', file:'linkedin.png')}" /></a>
								<a href="http://friendfeed.com/?url=<op:pageUrl  />&title=${item.name}" class="popup" title="<g:message code="main.share.content" /> FrienFeed"><img src="${resource(dir:'images/social', file:'friendfeed.png')}" /></a>
								<a href="https://delicious.com/post?url=<op:pageUrl  />&title=${item.name}" class="popup" title="<g:message code="main.share.content" /> Delicious"><img src="${resource(dir:'images/social', file:'delicious.png')}" /></a>
							</li>								
						</ul>
					</div>
					<span class="button">${item.comments.size()} <g:message code="meeting.point.comments"/></span>
				</div>
	    	</div>	
	    	<g:if test="${item.getPartyThumbsUp()>0 || item.getPartyThumbsDown()>0 || item.getPartyAbstention()>0}">
				<div id="meeting_point_${item.id}" class="meeting_point meeting_point_official_results">
					<div class="results_title show"><g:message code="meeting.point.officialResults"/></div>
					<div id="politicians_${item.id}" class="show_results">
						<g:if test="${item.getPartyThumbsUp()>0}">
							<div class="show_thumbs">
								<div class="meeting_point_party_results">
									<div class="vote up">${item.getPartyThumbsUp()}</div>										
								</div>								
								<g:each in="${item.getPartyThumbsUpList()}" status="j" var="vote">					
									<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteUp} ${message(code:'meeting.point.votes')}"/>
								</g:each>							
							</div>
						</g:if>
						<g:if test="${item.getPartyThumbsDown()>0}">
							<div class="show_thumbs">
								<div class="meeting_point_party_results">										
									<div class="vote down">${item.getPartyThumbsDown()}</div>
								</div>								
								<g:each in="${item.getPartyThumbsDownList()}" status="j" var="vote">					
									<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.voteDown} ${message(code:'meeting.point.votes')}"/>
								</g:each>	
							</div>
						</g:if>
						<g:if test="${item.getPartyAbstention()>0}">
							<div class="show_thumbs">
								<div class="meeting_point_party_results">										
									<div class="vote abstention">${item.getPartyAbstention()}</div>
								</div>								
								<g:each in="${item.getAbstentionList()}" status="j" var="vote">					
									<img src="${createLink(controller:'files', action:'logo', id: vote.party.logo)}" title="${vote.party.name} ${vote.abstention} ${message(code:'meeting.point.votes')}"/>
								</g:each>									
							</div>						
						</g:if>
					</div> 			
				</div>
			</g:if>	    			
	    	<div id="subject_comments">
    			<h3><g:message code="meeting.point.comments"/></h3>
    			<g:if test="${item.comments}">
	    			<g:each in="${item.comments}" status="i" var="comment">
						<g:render template="includes/comments" model="['comment': comment]" />    				
					</g:each>
				</g:if>
				<g:else>
					<p><g:message code="meeting.point.comments.none"/></p>
				</g:else>
	    	</div>
	    	
	    	<div id="subject_comments_form">
    			<h3><g:message code="meeting.point.comment.giveYours"/></h3>
    			<sec:ifLoggedIn>
					<g:formRemote name="commentsForm" url="[controller: 'main', action: 'saveComment']" onSuccess="putComment(data)" onFailure="putComment(data)">
						<g:textArea name="comment"></g:textArea>
						<g:hiddenField name="subject.id" value="${item.id}"/>
						<g:submitButton name="send" class="button" value="${message(code: 'meeting.point.comment.send')}" onclick="return validateComment();"/>
					</g:formRemote>
		    	</sec:ifLoggedIn>
		    	<sec:ifNotLoggedIn>
		    		<g:link action="signup"><g:message code="meeting.point.comments.notLoggedIn"/></g:link>
		    	</sec:ifNotLoggedIn>				
	    	</div>		   
		</div>		
	</body>
</html>

