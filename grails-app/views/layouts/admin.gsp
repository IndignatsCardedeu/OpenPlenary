<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Open Plenary - Admin</title>
	<link rel="stylesheet" href="${resource(dir: 'css/admin', file: 'screen.css')}" type="text/css" media="screen" title="default" />
	<link rel="stylesheet" href="${resource(dir: 'css/admin', file: 'custom.css')}" type="text/css" media="screen" title="default" />
	<!--[if IE]>
	<link rel="stylesheet" media="all" type="text/css" href="${resource(dir: 'css/admin', file: 'pro_dropline_ie.css')}" />
	<![endif]-->
	<g:javascript library="jquery" />
	<r:require module="jquery-ui"/>
	<ckeditor:resources/>
	<r:layoutResources />

	<![if !IE 7]>

	<!--  styled select box script version 1 -->
	<script src="${resource(dir: 'js/jquery', file: 'jquery.selectbox-0.5.js')}" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.styledselect').selectbox({ inputClass: "selectbox_styled" });
		});
	</script>
 
	<![endif]>

	<!--  styled select box script version 2 --> 
	<script src="${resource(dir: 'js/jquery', file: 'jquery.selectbox-0.5_style_2.js')}" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.styledselect_form_1').selectbox({ inputClass: "styledselect_form_1" });
			$('.styledselect_form_2').selectbox({ inputClass: "styledselect_form_2" });
		});
	</script>

	<!--  styled select box script version 3 --> 
	<script src="${resource(dir: 'js/jquery', file: 'jquery.selectbox-0.5_style_2.js')}" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.styledselect_pages').selectbox({ inputClass: "styledselect_pages" });
		});
	</script>

	<!--  styled file upload script --> 
	<script src="${resource(dir: 'js/jquery', file: 'jquery.filestyle.js')}" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
  		$(function() {
      		$("input.file_1").filestyle({ 
          		image: "${resource(dir: 'images/admin/forms/', file: 'choose-file.gif')}",
          		imageheight : 21,
          		imagewidth : 78,
          		width : 310
      		});
  		});
	</script>

	<!-- Tooltips -->
	<script src="${resource(dir: 'js/jquery', file: 'jquery.tooltip.js')}" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			$('a.info-tooltip ').tooltip({
				track: true,
				delay: 0,
				fixPNG: true, 
				showURL: false,
				showBody: " - ",
				top: -35,
				left: 5
			});
		});
	</script> 

	<!--  date picker script -->
	<link rel="stylesheet" href="${resource(dir: 'css/admin', file: 'datePicker.css')}" type="text/css" />
	<script src="${resource(dir: 'js/jquery', file: 'date.js')}" type="text/javascript"></script>
	<script src="${resource(dir: 'js/jquery', file: 'jquery.datePicker.js')}" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
        $(function(){
			// initialise the "Select date" link
			$('#date-pick').datePicker(
			// associate the link with a date picker
			{
				createButton:false,
				startDate:'01/01/2005',
				endDate:'31/12/2020'
			}).bind(
			// when the link is clicked display the date picker
				'click',
				function(){
					updateSelects($(this).dpGetSelected()[0]);
					$(this).dpDisplay();
					return false;
				}
			).bind(
			// when a date is selected update the SELECTs
				'dateSelected',
				function(e, selectedDate, $td, state){
					updateSelects(selectedDate);
				}
			).bind(
				'dpClosed',
				function(e, selected){
					updateSelects(selected[0]);
				}
			);
	
			var updateSelects = function (selectedDate){
				var selectedDate = new Date(selectedDate);
				$('#d option[value=' + selectedDate.getDate() + ']').attr('selected', 'selected');
				$('#m option[value=' + (selectedDate.getMonth()+1) + ']').attr('selected', 'selected');
				$('#y option[value=' + (selectedDate.getFullYear()) + ']').attr('selected', 'selected');
			}
			// listen for when the selects are changed and update the picker
			$('#d, #m, #y').bind(
				'change',
				function(){
					var d = new Date(
							$('#y').val(),
							$('#m').val()-1,
							$('#d').val()
					);
					$('#date-pick').dpSetSelected(d.asString());
				}
			);
	
			// default the position of the selects to today
			var today = new Date();
			updateSelects(today.getTime());
		
			// and update the datePicker to reflect it...
			$('#d').trigger('change');
		});
	</script>

	<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
	<script src="${resource(dir: 'js/jquery', file: 'jquery.pngFix.pack.js')}" type="text/javascript"></script>
	<script src="${resource(dir: 'js', file: 'admin.js')}" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$(document).pngFix( );
		});

		contextPath = "${resource(dir:'')}";
	</script>
		
    <g:layoutHead/>	
</head>
<body> 
<!-- Start: page-top-outer -->
<div id="page-top-outer">    

	<!-- Start: page-top -->
	<div id="page-top">
	
		<!-- start logo -->
		<div id="logo">
			<g:link controller="main" action="home">Open Plenary</g:link>
		</div>
		<!-- end logo -->
		 	
	 	<div class="clear"></div>
	
	</div>
	<!-- End: page-top -->

</div>
<!-- End: page-top-outer -->
	
<div class="clear">&nbsp;</div>
 
<!--  start nav-outer-repeat................................................................................................. START -->
<div class="nav-outer-repeat"> 
<!--  start nav-outer -->
<div class="nav-outer"> 

		<!-- start nav-right -->
		<div id="nav-right">
			<!-- 
			<div class="nav-divider">&nbsp;</div>
			<div class="showhide-account"><img src="${resource(dir: 'images/admin/shared/nav', file: 'nav_myaccount.gif')}" width="93" height="14" alt="" /></div>
			-->
			<div class="nav-divider">&nbsp;</div>
			<g:link elementId="logout" controller="logout"><img src="${resource(dir: 'images/admin/shared/nav', file: 'nav_logout.gif')}" width="64" height="14" alt="" /></g:link>
			<div class="clear">&nbsp;</div>		
		
		</div>
		<!-- end nav-right -->


		<!--  start nav -->
		<div class="nav">
		<div class="table">
		
		<ul
			<g:if test="${params.controller=='main' && params.action=='admin'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>
		>
			<li>
				<g:link controller="main" action="admin"><b><g:message code="admin.menu.dashboard" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='main' && params.action=='admin'}">
						show
					</g:if>					
				">
					<ul class="sub">
						<li><a href="#nogo"></a></li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>
		
		<div class="nav-divider">&nbsp;</div>
		                    
		<ul
			<g:if test="${params.controller=='mandate'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>		
		>
			<li>
				<g:link controller="mandate"><b><g:message code="admin.menu.mandates" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='mandate'}">
						show
					</g:if>		 				 
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='mandate' && params.action=='list'}">
								class="sub_show"
							</g:if>
						>
							<g:link controller="mandate"><g:message code="admin.mandate.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='mandate' && params.action=='create'}">
								class="sub_show"
							</g:if>				
						>
							<g:link controller="mandate" action="create"><g:message code="admin.mandate.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>		
		
		<div class="nav-divider">&nbsp;</div>
		                    
		<ul
			<g:if test="${params.controller=='meeting'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>		
		>
			<li>
				<g:link controller="meeting"><b><g:message code="admin.menu.meetings" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='meeting'}">
						show
					</g:if>		 				 
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='meeting' && params.action=='list'}">
								class="sub_show"
							</g:if>
						>
							<g:link controller="meeting"><g:message code="admin.meetings.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='meeting' && params.action=='create'}">
								class="sub_show"
							</g:if>				
						>
							<g:link controller="meeting" action="create"><g:message code="admin.meetings.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>
		
		<div class="nav-divider">&nbsp;</div>
		
		<ul
			<g:if test="${params.controller=='politicalParty'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>		
		>
			<li>
				<g:link controller="politicalParty"><b><g:message code="admin.menu.parties" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='politicalParty'}">
						show
					</g:if>					
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='politicalParty' && params.action=='list'}">
								class="sub_show"
							</g:if>						
						>
							<g:link controller="politicalParty"><g:message code="admin.parties.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='politicalParty' && params.action=='create'}">
								class="sub_show"
							</g:if>						
						>
							<g:link controller="politicalParty" action="create"><g:message code="admin.parties.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>
		
		<div class="nav-divider">&nbsp;</div>
		
		<ul
			<g:if test="${params.controller=='user'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>			
		>
			<li>
				<g:link controller="user"><b><g:message code="admin.menu.users" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='user'}">
						show
					</g:if>					
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='user' && params.action=='list'}">
								class="sub_show"
							</g:if>						
						>
							<g:link controller="user"><g:message code="admin.users.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='user' && params.action=='create'}">
								class="sub_show"
							</g:if>						
						>
							<g:link controller="user" action="create"><g:message code="admin.users.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>		
		
		<div class="nav-divider">&nbsp;</div>
		
		<ul
			<g:if test="${params.controller=='FAQ'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>		
		>
			<li>
				<g:link controller="FAQ"><b><g:message code="admin.menu.faq" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='FAQ'}">
						show
					</g:if>		 				 
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='FAQ' && params.action=='list'}">
								class="sub_show"
							</g:if>
						>
							<g:link controller="FAQ"><g:message code="admin.faq.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='FAQ' && params.action=='create'}">
								class="sub_show"
							</g:if>				
						>
							<g:link controller="FAQ" action="create"><g:message code="admin.faq.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>		
		
		<div class="nav-divider">&nbsp;</div>
		
		<ul
			<g:if test="${params.controller=='content'}">
				class="current"
			</g:if>		 
			<g:else>
				class="select"
			</g:else>		
		>
			<li>
				<g:link controller="Content"><b><g:message code="admin.menu.content" /></b><!--[if IE 7]><!--></g:link><!--<![endif]-->
				<!--[if lte IE 6]><table><tr><td><![endif]-->
				<div class="select_sub
					<g:if test="${params.controller=='content'}">
						show
					</g:if>		 				 
				">
					<ul class="sub">
						<li
							<g:if test="${params.controller=='content' && params.action=='list'}">
								class="sub_show"
							</g:if>
						>
							<g:link controller="Content"><g:message code="admin.content.list" /></g:link>
						</li>
						<li
							<g:if test="${params.controller=='content' && params.action=='create'}">
								class="sub_show"
							</g:if>				
						>
							<g:link controller="Content" action="create"><g:message code="admin.content.create" /></g:link>
						</li>
					</ul>
				</div>
				<!--[if lte IE 6]></td></tr></table></a><![endif]-->
			</li>
		</ul>		
		
		
		<div class="clear"></div>
		</div>
		<div class="clear"></div>
		</div>
		<!--  start nav -->

</div>
<div class="clear"></div>
<!--  start nav-outer -->
</div>
<!--  start nav-outer-repeat................................................... END -->

  <div class="clear"></div>
 
<!-- start content-outer ........................................................................................................................START -->
<div id="content-outer">
<!-- start content -->
<div id="content">
	<g:layoutBody/>	
	<div class="clear">&nbsp;</div>
</div>
<!--  end content -->
<div class="clear">&nbsp;</div>
</div>
<!--  end content-outer........................................................END -->

<div class="clear">&nbsp;</div>
    
<!-- start footer -->         
<div id="footer">
<!-- <div id="footer-pad">&nbsp;</div> -->
	<!--  start footer-left -->
	<div id="footer-left">
	Admin Skin &copy; Copyright Internet Dreams Ltd. <a href="">www.netdreams.co.uk</a>. All rights reserved.</div>
	<!--  end footer-left -->
	<div class="clear">&nbsp;</div>
</div>
<!-- end footer -->
	<div id="modalLayer" class="modal">
		HOLA
	</div>
		
	<r:layoutResources />
</body>
</html>