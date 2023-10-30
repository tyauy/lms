<cfparam name="t_id">
<cfparam name="u_id">
<cfparam name="m_id">
<cfparam name="s_id">
<cfparam name="s_dur">
<cfparam name="date_select">

<cfset date_display = dateformat(date_select,'dd/mm/yyyy')>
<cfset date_link = dateformat(date_select,'yyyy-mm-dd')>

<cfset get_trainer_tp = obj_query.oget_trainer_tp(t_id="#t_id#")>

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
<cfelse>
	<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
</cfif>

<div class="row justify-content-center">					
<cfoutput query="get_trainer_tp">

	<cfif m_id eq 7>
		<cfinvoke component="api/users/user_trainer_get" method="get_calendar_dispo_certif" returnvariable="available_date_list">
			<cfinvokeargument name="date_link" value="#date_link#">
			<cfinvokeargument name="user_id" value="#user_id#">
			<cfinvokeargument name="s_dur" value="#s_dur#">
		</cfinvoke>
	<cfelseif DateCompare(date_link, get_tp.tp_date_end) neq 1 OR get_tp.tp_vip eq 1>
		<cfinvoke component="api/users/user_trainer_get" method="get_calendar_dispo" returnvariable="available_date_list">
			<cfinvokeargument name="date_link" value="#date_link#">
			<cfinvokeargument name="user_id" value="#user_id#">
			<cfinvokeargument name="s_dur" value="#s_dur#">
		</cfinvoke>
	<cfelse>
		<cfset available_date_list = []>
	</cfif>

	<cfset list_slot_clean = "">

	<cfset list_slot_final = "">

	<!---- GET BOOKED LESSON / IGNORE CANCELLED--->
	<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	t.tp_id,
	l.lesson_id, l.lesson_start, l.lesson_end,
	sm.sessionmaster_id, sm.sessionmaster_name,
	ul.user_firstname, ul.user_name,
	ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css
	FROM lms_lesson2 l
	INNER JOIN lms_tpsession s ON l.session_id = s.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
	INNER JOIN lms_tp t ON t.tp_id = s.tp_id
	INNER JOIN user ul ON ul.user_id = l.user_id
	INNER JOIN user ut ON ut.user_id = l.planner_id
	
	<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	<cfelseif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST">
		WHERE t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfif>
	
	AND DATE_FORMAT(lesson_start,'%Y-%m-%d') = '#date_link#' 
	AND (l.status_id <> "3")
	<!---AND s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">--->
	ORDER BY lesson_start ASC
	</cfquery>


	<!---<div <cfif SESSION.USER_PROFILE eq "trainer">class="col-md-6"<cfelse>class="col-md-4"</cfif>>--->
	<cfif get_trainer_tp.recordcount eq "1">
		<cfset styler = "width:60px; padding:3px">
		<div class="col-md-9">
	<cfelseif get_trainer_tp.recordcount eq "2">
		<cfset styler = "width:60px; padding:3px">
		<div class="col-md-6">
	<cfelse>
		<cfset styler = "width:46px; padding:2px">
		<div class="col-md-4">
	</cfif>
		<div class="p-2 bg-light border">
			<div align="center">#obj_lms.get_thumb(user_id="#user_id#",size="40")# #user_firstname#</div>
				
			<cfif get_lesson.recordcount neq "0">
	
				<h6 class="text-warning mt-3">#obj_translater.get_translate('modal_planning_title')#</h6>
				<div class="border-bottom border-warning mb-1"></div>
																	
				<cfloop query="get_lesson">
				
					<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
						<cfif get_trainer_tp.user_id eq SESSION.USER_ID OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
							<a href="##" id="l_#lesson_id#" class="btn btn-sm btn-#status_css# btn_view_lesson my-1" style="#styler#" data-toggle="tooltip" data-html="true" title="#status_name#">#TimeFormat(lesson_start,'HH:mm')#</a>#sessionmaster_name# [ #get_lesson.user_firstname# #get_lesson.user_name# ]
						<cfelse>
							<a href="##" id="l_#lesson_id#" class="btn btn-sm btn-#status_css# my-1" style="#styler#" data-toggle="tooltip" data-html="true" title="#status_name#">#TimeFormat(lesson_start,'HH:mm')#</a>#sessionmaster_name# [ #get_lesson.user_firstname# #get_lesson.user_name# ]
						</cfif>
					<cfelse>
						<a href="" id="l_#lesson_id#" class="btn btn-sm btn-#status_css# btn_view_lesson my-1" style="#styler#" data-toggle="tooltip" data-html="true" title="#status_name#">#TimeFormat(lesson_start,'HH:mm')#</a>#sessionmaster_name#
					</cfif>
					<div class="clearfix"></div>
						
				</cfloop>
				
			</cfif>
				
				
				<h6 class="text-info mt-3">#obj_translater.get_translate('modal_avail_title')#</h6>
					<div class="border-bottom border-info mb-1"></div>
					
					<cfif Arraylen(available_date_list) neq "0">
						<cfset counter = "0">

						<cfloop array="#available_date_list#" index="temp"> 


							<cfset counter++>
							<a href="##" id="a_#dateformat(temp,'yyyy-mm-dd')#_#timeformat(temp,'HH-mm')#_#get_trainer_tp.user_id#" class="btn btn-sm <cfif temp gt dateadd('h',7,now())>btn-outline-info<cfelse>btn-outline-warning</cfif> btn_book_lesson my-1" style="#styler#">#timeformat(temp,'HH:mm')#</a>
						</cfloop>

						<cfif counter eq "0">
						
							<div class="alert alert-secondary mt-3" role="alert">
								<div class="text-center"><em>#obj_translater.get_translate('alert_no_avail')#</em></div>
							</div>
							
						</cfif>
					<cfelse>

						<div class="alert alert-secondary mt-3" role="alert">
							<div class="text-center"><em>#obj_translater.get_translate('alert_no_avail')#</em></div>
						</div>
									
					</cfif>				
		</div>
	</div>				
</cfoutput>
						
						
	
		
</div>

			
<script>
$(document).ready(function() {
	<cfoutput>
	$('.btn_book_lesson').click(function(event) {		
		event.preventDefault();		
		var temp = $(this).attr("id");
		var res = temp.split("_");
		var lesson_date_start = res[1];
		var lesson_time_start = res[2];
		var planner_id = res[3];		
		if(confirm("#obj_translater.get_translate('js_book_confirm')#"))
		{
		var urlgo = "updater_lesson.cfm?m_id=#m_id#&t_id=#t_id#&u_id=#u_id#&p_id="+planner_id+"&s_id=#s_id#&s_dur=#s_dur#&l_date_start="+lesson_date_start+"&l_time_start="+lesson_time_start;
		document.location.href=urlgo;
		}
		
	});
	$('.btn_view_lesson').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_detail')#");
		$('##modal_body_lg').load("modal_window_event_light2.cfm?lesson_id="+idtemp, function() {});
	});
	</cfoutput>
	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})
});
</script>
