<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">

	<!--------------- DEFAULT DATE & VIEW  ------------->
	<cfparam name="msel" default="#month(now())#">
	<cfif SESSION.LANG_CODE neq "fr">
	<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
	<cfelse>
	<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
	</cfif>
	<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
	<cfparam name="ysel" default="#year(now())#">
	<cfparam name="tselect" default="#ysel#-#msel#">
	<cfset y = mid(ysel,3,2)>

	<cfparam name="view" default="reg">
	<!--------------- DEFAULT DATE & VIEW  ------------->

	<cfparam name="teaching_criteria_id" default="1,2,3,4">

	<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
	c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
	s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
	FROM user u
	LEFT JOIN settings_country c ON c.country_id = u.country_id
	LEFT JOIN user_status s ON s.user_status_id = s.user_status_id = u.user_status_id

	<!---- PROFIL TRAINER, ACTIVE --->
	WHERE profile_id = 4 
	AND u.user_status_id = 4
	AND u.user_id NOT IN (4784,4785)

	AND u.user_id IN (SELECT user_id FROM user_teaching WHERE formation_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#" list="yes">))
		
	
	<!---- VISIO --->
	AND FIND_IN_SET(1,method_id)

	GROUP BY u.user_id
	ORDER BY user_firstname

	</cfquery>


	<cfquery name="get_tp_fr" datasource="#SESSION.BDDSOURCE#">
	SELECT s.tp_status_name_#SESSION.LANG_CODE# as tp_status_name, t.tp_duration, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, s.tp_status_id, u.user_id, u.user_firstname, u.user_name, a.account_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id, t.tp_date_start
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (1,6) AND u.user_status_id IN (2,4) AND a.provider_id IN (1,3)
	ORDER BY t.tp_status_id, t.formation_id, a.account_name, u.user_name, a.provider_id
	</cfquery>

	<cfquery name="get_tp_de" datasource="#SESSION.BDDSOURCE#">
	SELECT s.tp_status_name_#SESSION.LANG_CODE# as tp_status_name, t.tp_duration, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, s.tp_status_id, u.user_id, u.user_firstname, u.user_name, a.account_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id, t.tp_date_start
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (1,6) AND u.user_status_id IN (2,4) AND a.provider_id IN (2)
	ORDER BY t.tp_status_id, t.formation_id, a.account_name, u.user_name, a.provider_id
	</cfquery>

	<cfquery name="get_tp_type_fr" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(t.tp_id) as nb, s.tp_status_name_fr, s.tp_status_id, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name,ut.user_type_name_#SESSION.LANG_CODE# as type_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN user_type ut ON ut.user_type_id = u.user_type_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (1,6) AND u.user_status_id IN (2,4) AND a.provider_id IN (1,3)
	GROUP BY t.tp_status_id, t.formation_id, u.user_type_id, provider_id
	</cfquery>

	<cfquery name="get_tp_type_de" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(t.tp_id) as nb, s.tp_status_name_fr, s.tp_status_id, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name,ut.user_type_name_#SESSION.LANG_CODE# as type_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN user_type ut ON ut.user_type_id = u.user_type_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (1,6) AND u.user_status_id IN (2,4) AND a.provider_id IN (2)
	GROUP BY t.tp_status_id, t.formation_id, u.user_type_id, provider_id
	</cfquery>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "DASHBOARD TRAINER MANAGER">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">

			<cfset urlgo = "tmg_index.cfm">
			<cfinclude template="./incl/incl_nav_tmg.cfm">
			
			<cfinclude template="./widget/wid_team_translation.cfm">

			<div class="row">
				<cfloop list="fr,de" index="provider_cor">
				<cfloop list="1,6" index="tp_status_cor">
				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">

							<h6><img src="./assets/img_formation/<cfif provider_cor eq "fr">1<cfelse>3</cfif>.png" width="20"> <cfif tp_status_cor eq "1">NOT STARTED<cfelseif tp_status_cor eq "6">LAUNCH AT DATE</cfif></h6>

							<cfoutput query="get_tp_#provider_cor#" group="tp_status_id">
						
								<cfif tp_status_id eq tp_status_cor>
									<cfoutput group="formation_id">
									<select class="form-control form-control-sm" onchange="window.open('common_learner_account.cfm?u_id='+$(this).val()+'');">
										<option value="0" selected><img src="./assets/img_formation/#formation_id#.png" width="20"> #formation_name#</option>
										<cfoutput>
										<option value="#user_id#"><cfif tp_status_cor eq "6">#dateformat(tp_date_start,'dd/mm/yyyy')#</cfif> [#account_name#] [#tp_duration/60# h] #user_name# #user_firstname#</option>
										</cfoutput>
									</select>
								</cfoutput>
								</cfif>
								
							</cfoutput>

							<table class="table table-sm">

								<cfoutput query="get_tp_type_#provider_cor#">
									<cfif tp_status_id eq tp_status_cor>
									<tr>
										<td>
											<img src="./assets/img_formation/#formation_id#.png" width="20"> #formation_name#
										</td>
										<td>
											#type_name#
										</td>
										<td>
											#nb#
										</td>
									</tr>
								</cfif>
								</cfoutput>

							</table>

						</div>

					</div>

				</div>
				</cfloop>
				</cfloop>

			</div>


			<div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border">
						<div class="card-body">
	
							<div class="w-100">
								<h6 class="d-inline">Activité</h6>
								<hr class="border-top mb-1 mt-2">
							</div>
							
							<cfset cal_view = "basicWeek">
							<cfset u_id = "0">
							<cfset p_id = SESSION.USER_ID>
							<cfset cal_height = "260">
							<div id="calendar" class="mt-3"></div> 
						</div>
					</div>			
				</div>
				
			</div>

			
			<div class="card border mb-3">

				<div class="card-body">
			
					<h6>LISTING</h6>

					<div class="d-flex justify-content-around">

						<table class="table table-sm">
							<cfoutput query="get_trainer">

							<!---- OBJ QUERIES--->
							<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
							<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
							<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>

							
<cfquery name="get_lesson_week" datasource="#SESSION.BDDSOURCE#">
SELECT WEEK(lesson_start) as s_week, SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_activity 
FROM lms_lesson2 
WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
AND (status_id = 1)
AND YEAR(lesson_start) = YEAR(CURDATE())
AND WEEK(lesson_start) < WEEK(CURDATE())+3
GROUP BY s_week
</cfquery>

<cfquery name="get_blocker_week" datasource="#SESSION.BDDSOURCE#">
SELECT WEEK(lesson_start) as s_week, SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_blocker
FROM lms_lesson2 
WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
AND status_id IS NULL
AND YEAR(lesson_start) = YEAR(CURDATE())
AND WEEK(lesson_start) < WEEK(CURDATE())+3
GROUP BY s_week
</cfquery>


<cfquery name="get_slot" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(TIME_TO_SEC(slot_end) - TIME_TO_SEC(slot_start)) as s_avail
FROM user_slots 
WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
AND YEAR(slot_start) = YEAR(CURDATE())
AND WEEK(slot_start) = WEEK(CURDATE())
</cfquery>


<cfquery name="get_nb_cancelled" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(l.lesson_id) as nb
FROM lms_lesson2 l
WHERE l.updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
AND l.updater_date > #dateadd('m',-1,now())#
AND l.status_id = 3
</cfquery>





							<tr>
								<td>
									<a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark">#obj_lms.get_thumb(user_id="#user_id#",size="27",responsive="yes")#</a>
									<cfloop query="get_teaching">
										<img src="./assets/img_formation/#formation_id#.png" width="27">
									</cfloop>
								</td>
								<td> #user_id# #user_firstname#</td>
								<td>
									<!---- CALCULATE GLOBAL NB HOUR A WEEK--->
									<cfset total_hour = 0>
												
									<cfloop list="#SESSION.DAYWEEK_EN#" index="cor">
										<cfif evaluate("get_workinghour.day_#cor#_timediff_am") neq "">
											<cfset ham_count = evaluate("get_workinghour.s_#cor#_diff_am")>
											<cfset total_hour = total_hour+ham_count>
										</cfif>
										<cfif evaluate("get_workinghour.day_#cor#_timediff_pm") neq "">
											<cfset hpm_count = evaluate("get_workinghour.s_#cor#_diff_pm")>
											<cfset total_hour = total_hour+hpm_count>
										</cfif>
									</cfloop>

									<cfset total_hour = total_hour/3600>

									<h6><span class="badge bg-success text-white">#total_hour# H</span></h6>

									<!--- <cfdump var="#get_workinghour#"> --->
								</td>
								<td>
									<div class="card border">
										LAST 30 JOURS
										<table class="table table-sm">
											<tr>
												<td>#get_nb_cancelled.nb# Cancellations</td>
											</tr>
										</table>
									</div>
								</td>
								
								<td>
									<table class="table table-sm">
									<tr>
									<cfloop from="#week(now())#" to="#week(now())+2#" index="cor" >
										
										<td>
												
												<strong>WEEK #cor#</strong>
												<br>

<!--- <strong>AVAIL : </strong> <cfif get_slot.s_avail neq "">#obj_lms.get_format_hms(toformat="#get_slot.s_avail#",unit="sec")#</cfif>

<br> --->

<cfloop query="get_lesson_week">
	<cfif s_week eq cor>
		<!--- <strong>LESSON : </strong> --->
		<!--- #obj_lms.get_format_hms(toformat="#s_activity#",unit="sec")# --->

		<cfif get_slot.s_avail neq "" AND get_slot.s_avail neq 0>
			<cfset "percent_lesson_#get_trainer.user_id#_#s_week#" = round((s_activity/get_slot.s_avail)*100)>
			<!--- >>> #evaluate('percent_lesson_#get_trainer.user_id#_#s_week#')# --->
		</cfif>

	</cfif>
</cfloop>
			
<br>

<cfloop query="get_blocker_week">
	<cfif s_week eq cor>
		<!--- <strong>BLOCKER : </strong> --->
		<!--- #obj_lms.get_format_hms(toformat="#s_blocker#",unit="sec")# --->

		<cfif get_slot.s_avail neq "" AND get_slot.s_avail neq 0>
			<cfset "percent_blocker_#get_trainer.user_id#_#s_week#" = round((s_blocker/get_slot.s_avail)*100)>
			<!--- >>> #percent_blocker# --->
		</cfif>

	</cfif>
</cfloop>


<div class="progress">

	<cfif isdefined("percent_blocker_#get_trainer.user_id#_#cor#")>

		<div class="progress-bar progress-bar-striped bg-dark" role="progressbar" style="width: #evaluate('percent_blocker_#get_trainer.user_id#_#cor#')#%" aria-valuenow="1#evaluate('percent_blocker_#get_trainer.user_id#_#cor#')#" aria-valuemin="0" aria-valuemax="100"></div>

	</cfif>

	<cfif isdefined("percent_lesson_#get_trainer.user_id#_#cor#")>

		<div class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: #evaluate('percent_lesson_#get_trainer.user_id#_#cor#')#%" aria-valuenow="1#evaluate('percent_lesson_#get_trainer.user_id#_#cor#')#" aria-valuemin="0" aria-valuemax="100"></div>

	</cfif>


<!--- <div class="progress-bar bg-success progress-bar-striped" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div> --->
</div> 


										<!--- <div class="card border"> --->

											<!--- --->

												<!--- <cfset data1 = QueryGetRow(get_lesson_week,currentrow)>
											
												<cfif data1.s_activity neq "">
												
												</cfif>

												<cfif get_blocker_week.recordcount gte currentrow>

													<cfset data2 = QueryGetRow(get_blocker_week,currentrow)>

													<cfif data2.s_blocker neq "">
														<strong>BLOCKER : </strong>#obj_lms.get_format_hms(toformat="#data2.s_blocker#",unit="sec")#
													</cfif>
													
												</cfif> --->


												<!--- <cfif s_blocker neq "">
												h blocker #obj_lms.get_format_hms(toformat="#evaluate("get_blocker_week_#cor#").s_blocker#",unit="sec")#
												</cfif> --->
											</td>

										</div>

									</cfloop>
									</tr>

									</table>

								</td>
								
							</tr>
							</cfoutput>

						</table>


						
						
					</div>
					
				</div>
			</div>


			

				
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">







<script>

	<cfif not isdefined("picker")>
	<cfset picker = dateformat(now(),"yyyy-mm-dd")>
	</cfif>
	
	var avail_choice = "remove";
	var currentTimezone = "UTC";
	
	
$(document).ready(function() {


	function renderCalendar() {
		
		$('#calendar').fullCalendar({

		
		schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
		defaultDate: '<cfoutput>#picker#</cfoutput>',	
		timeFormat: 'H:mm',
		hiddenDays: [0,6],
		lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
		axisFormat: 'HH:mm',
		allDaySlot: true,	
		defaultEventMinutes:15,
		timezone: currentTimezone,
		<cfif isdefined("cal_view")>
		defaultView: '<cfoutput>#cal_view#</cfoutput>',
		<cfelse>
		defaultView: 'agendaWeek',
		</cfif>	
		selectHelper: false,	
		firstDay: 1,
		minTime: '06:00:00',
		maxTime: '23:00:00',
		slotDuration: '00:15:00',
		navLinks: true,
		editable: false,
		eventStartEditable: false,
		eventResizableFromStart: false,
		eventDurationEditable: false,
		droppable: false,
		eventOrder:["task_group_alias"],
		height:200,
			
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'agendaWeek,month'
		},		
		
		eventOrder:'title',
	  
		/**************SOURCE****************/	
		eventSources: [
			"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_trainer&task_closed=0"
		],		
		/**************END SOURCE****************/
	
			
			eventClick: function(event) {
	
				if($.isNumeric(event.user_id) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+event.user_id, function() {})
				}
				else if($.isNumeric(event.account_id_log) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+event.account_id_log, function() {})
				}
				else if($.isNumeric(event.group_id_log) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+event.group_id_log, function() {})
				}
				
			},
		  
			eventRender: function(event, element) {
				
				if($.isNumeric(event.lesson_id) && $.isNumeric(event.calendartype)){    
					if(event.calendartype == "2")
					{
						
						element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><a class="btn btn-sm btn-danger text-white p-0 m-0 remove" style="min-width:20px !important; padding:2px !important"><i class="fas fa-times"></i></a><br><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
						element.find(".remove").on("click", function() {
						if(confirm("Remove Setup ?"))
							{
							document.location.href='updater_lesson.cfm?faction=erase&l_id='+event.lesson_id+'&p_id='+event.planner_id+'&u_id='+event.user_id;
							}
						})
					
					}
					else{
						element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><!---<a class="btn btn-sm btn-danger text-white p-0 m-0 remove" href=""><i class="fas fa-times"></i></a><br>---><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
					}
			
				}
				
				element.find(".fc-title").html(element.find('.fc-title').text());
	
			}
		
		
	});
	
		
	}
	
	
	renderCalendar();
	
		

	});
	</script>



</body>
</html>