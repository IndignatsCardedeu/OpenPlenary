<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">	
		<g:javascript library="jquery" />	
	</head>
	<body>	
		<div id="current_meeting">
			<div id="current_meeting_main">
				<h1>
					<g:link action="session" id="${currentMeeting.id}">
						<g:if test="${currentMeeting.startDate<new Date()}">
							<g:message code="meeting.last"/>
						</g:if>
						<g:else>
							<g:message code="meeting.next"/>
						</g:else>
					</g:link>
				</h1>
				<div id="current_meeting_name">
					<span class="date"><g:formatDate date="${currentMeeting.startDate}" format="dd/MM" /></span>
					<g:link action="session" id="${currentMeeting.id}"> "${currentMeeting.name}"</g:link>
				</div>
				<p>${currentMeeting.description}</p>
				<tc:tagCloud tags="${currentMeetingTags}" controller="tag" action="session" id="${currentMeeting.id}" paramName="tag"/>					
				<div id="current_meeting_footer">
					<g:if test="${currentMeeting.officialMinutesUrl}">
						<a href="${currentMeeting.officialMinutesUrl}" class="button"><g:message code="meeting.minutes"/></a>
					</g:if>
					<g:link action="session" id="${currentMeeting.id}" class="button"><g:message code="meeting.viewAll"/></g:link>
				</div>
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
			</div>
		</div>
		
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