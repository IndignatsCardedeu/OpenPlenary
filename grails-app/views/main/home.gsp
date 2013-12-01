<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">	
		<g:javascript library="jquery" />	
	</head>
	<body>	
		<div id="current_meeting">
			<div id="current_meeting_main">
				<div id="current_meeting_name">
					<span class="date"><g:formatDate date="${currentMeeting.startDate}" format="dd/MM" /></span>
					<g:link action="session" id="${currentMeeting.id}"> "${currentMeeting.name}"</g:link>
				</div>
				<p>${currentMeeting.description}</p>
				<ul class="meeting-item-list">
					<g:if test="${currentMeeting.officialMinutesUrl}">
						<li class="meeting-item minutes-item">
							<a href="${currentMeeting.officialMinutesUrl}"><g:message code="meeting.minutes"/></a>						
						</li>				
					</g:if>					
					<li class="meeting-item taglist-item">										
						<g:each in="${currentMeetingTags}" var="tag" status="j">
							<g:link controller="tag" action="session" id="${currentMeeting.id}" params="${[tag: tag.key]}">${tag.key}</g:link><g:if test="${j+1<currentMeetingTags.size()}">,</g:if>							
						</g:each>
					</li>
				</ul>
			</div>		
			<div id="current_meeting_points">			
				<h2><g:message code="meeting.relevants"/></h2>
				<g:each in="${relevants}" status="i" var="subject">
				<div class="meeting_point">
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
				</div>
				</g:each>
				<div class="last_meeting_footer">
					<g:link action="session" id="${currentMeeting.id}" class="button"><g:message code="main.viewAll"/></g:link>
				</div>
			</div>
		</div>
		<sec:ifLoggedIn>
		   	<div id="affinities" class="affinities_home">
		   		<h2><g:message code="main.affinity.user"/></h2>
	    		<g:each in="${affinities}" var="item">
	    			<div class="affinity_block">
	    				<g:link controller="main" action="party" id="${item.partyId}"><img src="${createLink(controller:'files', action:'logo', id: item.partyLogo)}" alt="${item.partyName}" title="${item.partyName}"/></g:link> 
	    				${item.value}% 
	    			</div>
	    		</g:each>
	    	</div>		
    	</sec:ifLoggedIn>
		<div id="last_meetings">
			<div class="last_meeting_block block_0">
				<h2><g:message code="main.parties"/></h2>
				<op:parties/>
			</div>
			<div class="last_meeting_block block_1">
				<h2><g:message code="main.tagcloud"/></h2>
				<tc:tagCloud controller="main" action="tag" bean="${org.mayfifteen.openplenary.Subject}" color="${[start: '#888', end: '#444']}" />	
			</div>				
			<div class="last_meeting_block block_2">
				<h2><g:message code="main.plenaries"/></h2>
				<ul>
					<g:each in="${meetings}" status="index" var="item">
					<li><g:link controller="main" action="session" id="${item.id}">${item.name}</g:link></li>
					</g:each>
				</ul>
			</div>								
		</div>
	</body>
</html>