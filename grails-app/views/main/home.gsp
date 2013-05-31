<!doctype html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication.config.grails.openplenary.layout}">	
		<g:javascript library="jquery" />	
	</head>
	<body>	
		<div id="current_meeting">
			<div id="current_meeting_main">
				<h1><g:link action="session" id="${currentMeeting.id}"><g:message code="meeting.next"/></g:link></h1>
				<div id="current_meeting_name">
					<span class="date"><g:formatDate date="${currentMeeting.startDate}" format="dd/MM" /></span>
					<g:link action="session" id="${currentMeeting.id}"> "${currentMeeting.name}"</g:link>
				</div>
				<p>${currentMeeting.description}</p>
				<tc:tagCloud tags="${currentMeetingTags}" controller="tag" action="session" id="${currentMeeting.id}" paramName="tag"/>				
				<ul class="officialLinks">
					<g:if test="${currentMeeting.officialAgendaUrl}">
						<li><a href="${currentMeeting.officialAgendaUrl}">Ordre del dia oficial</a></li>
					</g:if>
					<g:if test="${currentMeeting.officialMinutesUrl}">
						<li><a href="${currentMeeting.officialMinutesUrl}">Acta oficial</a></li>
					</g:if>
				</ul>				
				<div id="current_meeting_footer">				
					<g:link action="session" id="${currentMeeting.id}" class="button"><g:message code="meeting.moreInfo"/></g:link>
				</div>
			</div>
			<div id="current_meeting_points">
				<h2><g:message code="meeting.relevants"/></h2>
				<g:each in="${relevants}" status="i" var="subject">
				<div class="meeting_point">
					<div class="meeting_point_results">
						<g:remoteLink controller="main" action="voteUp" id="${subject.id}" onSuccess="addVote(data, '#thumbsUp_${subject.id}');">
							<div id="thumbsUp_${subject.id}" class="vote
								<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString())>0}"> 
									up_on
								</g:if>
								<g:else>
									up
								</g:else>
							">${subject.getThumbsUp()}</div>
						</g:remoteLink>
						<g:remoteLink controller="main" action="voteDown" id="${subject.id}" onSuccess="addVote(data, '#thumbsDown_${subject.id}');">
							<div id="thumbsDown_${subject.id}" class="vote 
								<g:if test="${subject.getUserVote(sec.loggedInUserInfo(field:'id').toString())<0}"> 
									down_on
								</g:if>
								<g:else>
									down
								</g:else>
							">${subject.getThumbsDown()}</div>
						</g:remoteLink>
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