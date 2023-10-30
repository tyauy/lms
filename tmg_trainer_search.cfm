<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,3,5,6,8,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="teaching_criteria_id" default="0">
<cfparam name="country_criteria_id" default="0">
<cfparam name="speaking_criteria_id" default="0">
<cfparam name="avail_criteria_id" default="0">
<cfparam name="speciality_criteria_id" default="0">
<cfparam name="method_criteria_id" default="1">
<cfparam name="local_criteria_id" default="0">
<cfparam name="user_status_id" default="4">
<cfparam name="view_select" default="thumb">

<cfquery name="get_attach_type" datasource="#SESSION.BDDSOURCE#">
SELECT attach_type_id, attach_type_#SESSION.LANG_CODE# as attach_type FROM user_attach_type WHERE profile_id = 4 AND attach_mandatory = 1
</cfquery>

<cfquery name="get_language" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name, formation_code FROM lms_formation
</cfquery>

<cfquery name="get_country" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT country_id, country_name_#SESSION.LANG_CODE# as country_name, language_name_#SESSION.LANG_CODE# as language_name, country_code FROM settings_country ORDER BY country_id
</cfquery>

<cfquery name="get_country_selected" datasource="#SESSION.BDDSOURCE#">
SELECT country_id FROM user WHERE profile_id = 4
</cfquery>
<cfset list_country = "0">
<cfoutput query="get_country_selected">
<cfif not listfind(list_country,country_id) AND country_id neq "null" AND country_id neq "0">
<cfset list_country = listappend(country_id,list_country,",")>
</cfif>
</cfoutput>

<cfquery name="get_country_available" datasource="#SESSION.BDDSOURCE#">
SELECT country_id, country_name_#SESSION.LANG_CODE# as country_name FROM settings_country WHERE country_id IN (#list_country#)
</cfquery>

<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.user_lastconnect, u.user_video_link, u.speciality_id, u.method_id, u.user_add_weight,
c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
s.user_status_trainer_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css,
t.user_type_name_#SESSION.LANG_CODE# as user_type_name, t.user_type_id

<cfif user_status_id eq "4" OR user_status_id eq "5">
,
(
SELECT COUNT(t.tp_id)
FROM lms_tp t 
INNER JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
WHERE p.planner_id = u.user_id
<!---- TO LAUNCH / TO LAUNCH AT DATE --->
AND (t.tp_status_id = 1 OR t.tp_status_id = 6)
) as total_tp_launch,
(
SELECT COUNT(t.tp_id)
FROM lms_tp t 
INNER JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
WHERE p.planner_id = u.user_id
AND (t.tp_status_id = 2 OR t.tp_status_id = 7)
) as total_tp_active
</cfif>



<!---(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
		(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson
	--->	


FROM user u
INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
LEFT JOIN settings_country c ON c.country_id = u.country_id
LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
LEFT JOIN user_type t ON t.user_type_id = u.user_type_id





WHERE upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4">


<cfif user_status_id neq "0">
AND (1 = 2 
<cfloop list="#user_status_id#" index="cor">
OR u.user_status_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">
</cfloop>
)

</cfif>


<!---- SPOKEN LANGUAGE --->
<cfif speaking_criteria_id neq "0" AND speaking_criteria_id neq "">
	AND u.user_id IN (SELECT user_id FROM user_speaking WHERE (formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#speaking_criteria_id#">))
</cfif>

<!---- TAUGHT LANGUAGE --->
<cfif teaching_criteria_id neq "0" AND teaching_criteria_id neq "">
	AND u.user_id IN (SELECT user_id FROM user_teaching WHERE (formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#"> <cfif speciality_criteria_id neq "0" AND speciality_criteria_id neq "">AND FIND_IN_SET(#speciality_criteria_id#,level_id)</cfif>))
</cfif>

<cfif country_criteria_id neq "0">
AND (1 = 2 
<cfloop list="#country_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,u.country_id)
</cfloop>
)
</cfif>

<!---<cfif avail_criteria_id neq "0">
AND (1 = 2 
<cfloop list="#avail_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,avail_id)
</cfloop>
)
</cfif>--->

<cfif speciality_criteria_id neq "0">
AND (1 = 2 
<cfloop list="#speciality_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,speciality_id)
</cfloop>
)
</cfif>

<cfif method_criteria_id neq "0">
AND (1 = 2 
<cfloop list="#method_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,method_id)
</cfloop>
)
</cfif>

ORDER BY user_status_id, user_firstname ASC
</cfquery>

</cfsilent>

<!--- <cfdump var="#get_trainer#"> --->
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formateurs WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  	
								
				<div class="row">
				
					<div class="col-md-12">
					
						<div class="card border-top border-info">
							
							<div class="card-body">
							
								<h5 class="card-title d-inline">Recherche : <span id="counter_search d-inline" style="max-width:250px"><cfoutput>#get_trainer.recordcount# trainers</cfoutput></span></h5>
								
								<div class="clearfix"></div>
								<cfform action="tmg_trainer_search.cfm">
								<div class="row">
									<div class="col-md-2">
										<label for="user_status_id">Activit&eacute;</label><br>
										<label><input type="radio" name="user_status_id" value="4" <cfif user_status_id eq "4">checked</cfif>> Actif</label>
										<label><input type="radio" name="user_status_id" value="6" <cfif user_status_id eq "6">checked</cfif>> Training</label>
										<label><input type="radio" name="user_status_id" value="3" <cfif user_status_id eq "3">checked</cfif>> Finalize</label>
										<label><input type="radio" name="user_status_id" value="2" <cfif user_status_id eq "2">checked</cfif>> To check</label>
										<label><input type="radio" name="user_status_id" value="1" <cfif user_status_id eq "1">checked</cfif>> Not completed</label>
										<label><input type="radio" name="user_status_id" value="5" <cfif user_status_id eq "5">checked</cfif>> Inactif</label>
									</div>
									<div class="col-md-2">
										<label for="method_criteria_id">M&eacute;thode</label><br>
										<label><input type="checkbox" name="method_criteria_id" value="1" <cfif listfind(method_criteria_id,"1")>checked</cfif>> VISIO</label>
										<label><input type="checkbox" name="method_criteria_id" value="2" <cfif listfind(method_criteria_id,"2")>checked</cfif>> F2F</label>
									</div>
									<div class="col-md-2">
										<label for="teaching_criteria_id"><cfoutput>#obj_translater.get_translate('table_th_teaches')#</cfoutput></label><br>
										<cfselect name="teaching_criteria_id" id="teaching_criteria_id" class="form-control" query="get_language" display="language_name" value="formation_id" multiple="yes" size="1" selected="#teaching_criteria_id#"></cfselect>
									</div>
									<div class="col-md-2">
										<label for="country_criteria_id"><cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput></label><br>
										<cfselect name="country_criteria_id" id="country_criteria_id" class="form-control" query="get_country_available" display="country_name" value="country_id" multiple="yes" size="1" selected="#country_criteria_id#"></cfselect>
									</div>
									<div class="col-md-2">
										<label for="speaking_criteria_id"><cfoutput>#obj_translater.get_translate('table_th_speaks')#</cfoutput></label><br>
										<cfselect name="speaking_criteria_id" id="speaking_criteria_id" class="form-control" query="get_language" display="language_name" value="formation_id" multiple="yes" size="1" selected="#speaking_criteria_id#"></cfselect>
									</div>
									<!---<div class="col-md-2">
										<label for="avail_id"><cfoutput>#obj_translater.get_translate('table_th_availabilities')#</cfoutput></label><br>
										<cfselect name="avail_criteria_id" id="avail_criteria_id" class="form-control" query="get_avail" display="avail_name" value="avail_id" multiple="yes" size="1" group="group_name" selected="#avail_criteria_id#"></cfselect>
									</div>--->
									<div class="col-md-2">
										
										<cfoutput><input type="hidden" name="view_select" value="#view_select#"></cfoutput>
										<input type="submit" class="btn btn-sm btn-outline-secondary" value="Go">
									</div>
									

									
									
								</div>
								</cfform>

							</div>
						</div>
						
                    </div>
					
							
						
						<!---<div class="col-md-2">
						<label for="method_id"><cfoutput>#obj_translater.get_translate('table_th_methods')#</cfoutput></label>
						<cfselect name="method_criteria_id" id="method_criteria_id" class="form-control" query="get_lesson_method" display="method_name" value="method_id" multiple="yes" size="1" selected="#method_criteria_id#"></cfselect>
						</div>--->
						
					
										
			
			

			
			
			</div>
			





			<ul class="nav nav-tabs" id="learner_list" role="tablist">
				<li class="nav-item">		
					<a href="#resume_trainers" class="nav-link active" role="tab" data-toggle="tab">
						<i class="fa-light fa-user"></i> Resume Mode
					</a>
				</li>
				<li class="nav-item">
					<a href="#analytic_trainers" class="nav-link" role="tab" data-toggle="tab">
						<i class="fa-light fa-chart-line"></i> Analytic Mode
					</a>
				</li>
				<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
				<li class="nav-item">
					<a href="#admin_trainers" class="nav-link" role="tab" data-toggle="tab">
						<i class="fa-light fa-folder-open"></i> Admin Mode
					</a>
				</li>
				</cfif>
			</ul>
			
			
			<div class="tab-content">
			
				<div role="tabpanel" class="tab-pane active show mt-2" id="resume_trainers">
			
					<div class="table-responsive">

						<table class="table bg-white">
							<tbody>
							<tr bgcolor="#F3F3F3" align="center">
								<th><input type="checkbox" class="select_all"></th>
								<th>Method</th>
								<th>Status</th>
								<th width="180">Firstname</th>
								<th width="200">Teaches</th>
								<th width="200">Speaks</th>
								<cfif user_status_id eq "4" OR user_status_id eq "5">
									<th>TP</th>
									<th>Avails</th>				
									<!--- <th>Charge</th>	 --->
									<cfif isDefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq 1>
										<th>Algo W</th>
									</cfif>
									<th>Sign</th>
									<th>Video</th>	
									<th>Resume</th>
								<cfelse>
									<th>Avails</th>	
									<th>Video</th>
									<th>Last connect</th>	
								</cfif>
							</tr>
						
			
			
			
			
			
			
			
			
			
							<cfoutput>	
							<cfloop query="get_trainer">	
			
							<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
							SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
							</cfquery>
			
							<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
							<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>

							<cfquery name="get_workinghour" datasource="#SESSION.BDDSOURCE#">
							SELECT 
							TIMEDIFF(day_mon_end_am,day_mon_start_am) AS day_mon_timediff_am,
							TIMEDIFF(day_mon_end_pm,day_mon_start_pm) AS day_mon_timediff_pm,
							SUM(TIME_TO_SEC(day_mon_end_am) - TIME_TO_SEC(day_mon_start_am)) as s_mon_diff_am,
							SUM(TIME_TO_SEC(day_mon_end_pm) - TIME_TO_SEC(day_mon_start_pm)) as s_mon_diff_pm,
			
			
							TIMEDIFF(day_tue_end_am,day_tue_start_am) AS day_tue_timediff_am,
							TIMEDIFF(day_tue_end_pm,day_tue_start_pm) AS day_tue_timediff_pm,
							SUM(TIME_TO_SEC(day_tue_end_am) - TIME_TO_SEC(day_tue_start_am)) as s_tue_diff_am,
							SUM(TIME_TO_SEC(day_tue_end_pm) - TIME_TO_SEC(day_tue_start_pm)) as s_tue_diff_pm,
			
							TIMEDIFF(day_wed_end_am,day_wed_start_am) AS day_wed_timediff_am,
							TIMEDIFF(day_wed_end_pm,day_wed_start_pm) AS day_wed_timediff_pm,
							SUM(TIME_TO_SEC(day_wed_end_am) - TIME_TO_SEC(day_wed_start_am)) as s_wed_diff_am,
							SUM(TIME_TO_SEC(day_wed_end_pm) - TIME_TO_SEC(day_wed_start_pm)) as s_wed_diff_pm,
			
							TIMEDIFF(day_thu_end_am,day_thu_start_am) AS day_thu_timediff_am,
							TIMEDIFF(day_thu_end_pm,day_thu_start_pm) AS day_thu_timediff_pm,
							SUM(TIME_TO_SEC(day_thu_end_am) - TIME_TO_SEC(day_thu_start_am)) as s_thu_diff_am,
							SUM(TIME_TO_SEC(day_thu_end_pm) - TIME_TO_SEC(day_thu_start_pm)) as s_thu_diff_pm,
			
							TIMEDIFF(day_fri_end_am,day_fri_start_am) AS day_fri_timediff_am,
							TIMEDIFF(day_fri_end_pm,day_fri_start_pm) AS day_fri_timediff_pm,
							SUM(TIME_TO_SEC(day_fri_end_am) - TIME_TO_SEC(day_fri_start_am)) as s_fri_diff_am,
							SUM(TIME_TO_SEC(day_fri_end_pm) - TIME_TO_SEC(day_fri_start_pm)) as s_fri_diff_pm,
			
							TIMEDIFF(day_sat_end_am,day_sat_start_am) AS day_sat_timediff_am,
							TIMEDIFF(day_sat_end_pm,day_sat_start_pm) AS day_sat_timediff_pm,
							SUM(TIME_TO_SEC(day_sat_end_am) - TIME_TO_SEC(day_sat_start_am)) as s_sat_diff_am,
							SUM(TIME_TO_SEC(day_sat_end_pm) - TIME_TO_SEC(day_sat_start_pm)) as s_sat_diff_pm,
			
							TIMEDIFF(day_sun_end_am,day_sun_start_am) AS day_sun_timediff_am,
							TIMEDIFF(day_sun_end_pm,day_sun_start_pm) AS day_sun_timediff_pm,
							SUM(TIME_TO_SEC(day_sun_end_am) - TIME_TO_SEC(day_sun_start_am)) as s_sun_diff_am,
							SUM(TIME_TO_SEC(day_sun_end_pm) - TIME_TO_SEC(day_sun_start_pm)) as s_sun_diff_pm,
			
							uw.*
							FROM user_workinghour uw WHERE user_id = #user_id#
							</cfquery>
			
							<cfif not listfind(user_status_id,"1") AND not listfind(user_status_id,"2")>
							<cfquery name="get_bad" datasource="#SESSION.BDDSOURCE#">
							SELECT (SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson, t.tp_id
							FROM lms_tp t 
							LEFT JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
							WHERE (p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">)
							<!---- TP STATUS EN COURS OU TRANSFERE --->
							AND (t.tp_status_id = 2 OR t.tp_status_id = 7)
							<!---- VISIO OU F2F --->
							AND (t.method_id = 1 OR t.method_id = 2)
							GROUP BY t.tp_id
							HAVING last_lesson < date_add(now(), INTERVAL -2 MONTH) 
							</cfquery>
			
							<cfquery name="get_nnl" datasource="#SESSION.BDDSOURCE#">
							SELECT (SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 1) AND lesson_start > NOW()) as next_lesson, t.tp_id
							FROM lms_tp t 
							LEFT JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
							WHERE (p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">)
							<!---- TP STATUS EN COURS OU TRANSFERE --->
							AND (t.tp_status_id = 2 OR t.tp_status_id = 7)
							<!---- VISIO OU F2F --->
							AND (t.method_id = 1 OR t.method_id = 2)
							GROUP BY t.tp_id
							HAVING next_lesson IS NULL
							</cfquery>
			
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
			
							<!---- CALCULATE ACTIVITY--->
			
								 <cfquery name="get_slot" datasource="#SESSION.BDDSOURCE#">
								SELECT SUM(TIME_TO_SEC(slot_end) - TIME_TO_SEC(slot_start)) as s_avail
								FROM user_slots 
								WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
								AND YEAR(slot_start) = YEAR(CURDATE())
								AND WEEK(slot_start) = WEEK(CURDATE())
								</cfquery>
				
								<cfquery name="get_lesson_week" datasource="#SESSION.BDDSOURCE#">
								SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_activity 
								FROM lms_lesson2 
								WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
								AND (status_id <> 3 AND status_id IS NOT NULL)
								AND YEAR(lesson_start) = YEAR(CURDATE())
								AND WEEK(lesson_start) = WEEK(CURDATE())
								</cfquery>
								
								<cfif get_lesson_week.s_activity eq "">
									<cfset s_activity = 0>
								<cfelse>
									<cfset s_activity = get_lesson_week.s_activity>
								</cfif>
				
								<cfquery name="get_blocker_week" datasource="#SESSION.BDDSOURCE#">
								SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_blocker
								FROM lms_lesson2 
								WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
								AND status_id IS NULL
								AND YEAR(lesson_start) = YEAR(CURDATE())
								AND WEEK(lesson_start) = WEEK(CURDATE())
								</cfquery>
			

								<cfset total_hour = total_hour/3600>
								<cfif get_slot.s_avail neq "">
									<cfset total_slot = get_slot.s_avail/3600>
										<cfset h_activity = s_activity/3600>
										<cfif total_slot neq 0 AND h_activity neq 0>
											<cfset h_activity_rate = round((h_activity/total_slot)*100)>
										<cfelse>
											<cfset h_activity_rate = 0>
										</cfif>
									<cfif get_blocker_week.s_blocker neq "" AND total_slot neq 0>
										<cfset h_blocker = get_blocker_week.s_blocker/3600>
										<cfset h_blocker_rate = round((h_blocker/total_slot)*100)>
									<cfelse>
										<cfset h_blocker = 0>
										<cfset h_blocker_rate = "-">
									</cfif>
									<cfif total_slot neq 0>
										<cfset charge_work = round((h_activity+h_blocker)/total_slot*100)>
									<cfelse>
										<cfset charge_work = 0>
									</cfif>
								<cfelse>
									<cfset total_hour = "NA">
									<cfset total_slot = "NA">
									<cfset h_activity = "NA">
									<cfset h_blocker = "NA">
									<cfset charge_work = "NA">
								</cfif> 
								
							
							</cfif>
			
							<tr>
								<td><input type="checkbox" class="trainer_sel" name="p_id" value="#user_id#"></td>
								<td align="center"><cfif listfind(method_id,1)><i class="fal fa-webcam fa-2x text-info"></i> </cfif><cfif listfind(method_id,2)><i class="fal fa-user-friends fa-2x text-info"></i> </cfif></td>
								<td align="center">
			
									<a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-info" id="edit_status">#user_status_name#</a>
									
									<a href="##" class="p-1 btn btn-sm btn_learner_edit_type <cfif user_type_id eq "1">btn-danger<cfelse>btn-info</cfif>" >#user_type_name#</a>
			
									<cfif user_status_id eq "4" OR user_status_id eq "5">
									
										<cfinvoke component="api/users/user_trainer_get" method="get_trainer_teach_ready" returnvariable="user_ready_go">
											<cfinvokeargument name="user_id" value="#user_id#">
										</cfinvoke>
			
										<table class="table table-bordered table-sm bg-white mt-3">
											<tr class="bg-light text-dark" align="center">
												<td width="25%"><small><strong></strong></small></td>
												<td width="25%"><small><strong>B2B</strong></small></td>
												<td width="25%"><small><strong>B2C</strong></small></td>
												<td width="25%"><small><strong>TEST</strong></small></td>
												<td width="25%"><small><strong>GRP</strong></small></td>
												<td width="25%"><small><strong>CLA.</strong></small></td>
												<td width="25%"><small><strong>TM</strong></small></td>
												<td width="25%"><small><strong>VIP</strong></small></td>
												<td width="25%"><small><strong>CHILD</strong></small></td>
												<td width="25%"><small><strong>GYM</strong></small></td>
											</tr>
											<cfloop query="user_ready_go">
												<tr align="center">
													<td width="25%">
														<span class="lang-sm" lang="#lcase(user_ready_go.formation_code)#"></span>
													</td>
													<td width="25%">
														<cfif user_ready_go.user_ready_france eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is W FRANCE">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is W FRANCE">NO</a>
														</cfif>
													</td>
													<td width="25%">
														<cfif user_ready_go.user_ready_germany eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is W GERMANY">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is W GERMANY">NO</a>
														</cfif>
													</td>								
													<td width="25%">
														<cfif user_ready_go.user_ready_test eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is TEST">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is TEST">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_group eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is TEST">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is TEST">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_classic eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is CLASSIC">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is CLASSIC">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_tm eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is TM">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is TM">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_vip eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is VIP">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is VIP">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_children eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is MINOR">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is MINOR">NO</a>
														</cfif>
													</td>	
													<td width="25%">
														<cfif user_ready_go.user_ready_partner eq "1">
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is GYMGLISH">OK</a>
														<cfelse>
															<a href="##" class="btn font-weight-normal m-0 p-0  btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is GYMGLISH">NO</a>
														</cfif>
													</td>	
												</tr>
											</cfloop>
										</table>
										
										<cfset get_tps = obj_tp_get.oget_tps(p_id="#user_id#",m_id="12")>
										<a href="common_tp_details.cfm?t_id=#get_tps.tp_id#">OPS TP</a>

									</cfif>
								
								</td>
								<!--- <td> --->
								<!--- <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")> --->
									<!--- <video controls width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo_video.jpg")>poster="./assets/user/#user_id#/photo_video.jpg"</cfif>> --->
										<!--- <source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4"> --->
									<!--- </video> --->
								<!--- </cfif> --->
																								
								
								
								<!--- </td> --->
								<td align="center">
									<a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark">#obj_lms.get_thumb(user_id="#user_id#",size="60",responsive="yes")#</a>
									<br>
									<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> <a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark"><strong>#ucase(user_firstname)#</strong></a>
								</td>
			
								<td align="center">
								
									<table class="table table-sm table-borderless">
									<cfloop query="get_teaching">
									<tr>
									<td width="20"> <span class="lang-sm" lang="#get_teaching.formation_code#" style="top:4px"></span></td>
									<td align="left">
									<cfloop list="#get_teaching.level_id#" index="cor">
									<span class="badge bg-white border">
									<cfif cor eq "0">A0
									<cfelseif cor eq "1">A1
									<cfelseif cor eq "2">A2
									<cfelseif cor eq "3">B1
									<cfelseif cor eq "4">B2
									<cfelseif cor eq "5">C1
									<cfelseif cor eq "6">C2
									</cfif>
									</span>
									</cfloop>
									</td>
									</tr>
									</cfloop>
									</table>
			
								</td>
													
								<td>
									<cfloop query="get_speaking">
									<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
									#get_speaking.formation_name# 
									<cfset level_id = get_speaking.level_id>
									<div class="clearfix"></div>
									<div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
									</span>
									</cfloop>	
								</td>
			
								<cfif user_status_id eq "4" OR user_status_id eq "5">
								<td>
									<table class="table table-bordered table-sm bg-white m-0 border">
										<tr class="bg-light" align="center">
											<!---<td><small><strong>Learners</strong></small></td>			--->							
											<td width="25%"><small><strong>Launch</strong></small></td>									
											<td width="25%"><small><strong>Active</strong></small></td>	
											<td width="25%"><small><strong>NNL</strong></small></td>								
											<td width="25%"><small><strong>Bad</strong></small></td>							
											<!---<td width="25%"><small><strong>DL</strong></small></td>--->
										</tr>
			
			
										<tr align="center">
											<!---<td><a href="cs_learners.cfm?p_id=#user_id#&ust_id=100" class="btn btn-info btn-sm">#get_learner_trainer.recordcount#</a></td>--->
											
											<td><a href="common_trainer_learners.cfm?p_id=#user_id#&view=tolaunch" class="btn btn-info btn-sm">#total_tp_launch#</a></td>
											<td><a href="common_trainer_learners.cfm?p_id=#user_id#&view=active" class="btn btn-success btn-sm">#total_tp_active#</a></td>
											<td><a href="common_trainer_learners.cfm?p_id=#user_id#&view=active" class="btn btn-warning btn-sm">#get_nnl.recordcount#</a></td>
											<td><a href="common_trainer_learners.cfm?p_id=#user_id#&view=active" class="btn btn-danger btn-sm">#get_bad.recordcount#</a></td>
											<!---<td><a href="common_trainer_learners.cfm?p_id=#user_id#" class="btn btn-danger btn-sm">-</a></td>--->
										</tr>
									</table>
								</td>
								</cfif>
								
								<td valign="top">	
									<cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
										<cfinvokeargument name="u_id" value="#user_id#">
									</cfinvoke>	
									<cfset planner_view = "view_toggle_vertical">
									<cfinclude template="./widget/wid_planner.cfm">
								</td>
			
								<cfif user_status_id eq "4" OR user_status_id eq "5">
								<td>
									<cfif listfind(method_id,1)>
									<cfif (isdefined("h_activity") AND isdefined("h_activity_rate"))>
										<table class="table table-sm border bg-light p-2">
											<tr>
												<td width="20%">
													<small>LESSONS</small>
												</td>
												<td>
													<small><strong>#h_activity#h (#h_activity_rate#%)</strong></small>
												</td>
											</tr>
											<tr>
												<td>
													<small>BLOCKERS</small>
												</td>
												<td>
													<cfif h_blocker_rate gt 30 AND h_blocker_rate neq "NA">
													<span class="badge badge-danger">#h_blocker#h (#h_blocker_rate#%)</span>
													<cfelse>
													<small><strong>#h_blocker#h (#h_blocker_rate#%)</strong></small>
													</cfif>
													
												</td>
											</tr>
											<tr>
												<td>
													<small>BIZ H</small>
												</td>
												<td>
													<small><strong>#total_hour#h</strong></small>
												</td>
											</tr>
											<tr>
												<td>
													<small>EFF. SLOTS</small>
												</td>
												<td>
													<small><strong>#total_slot#h</strong></small>
												</td>
											</tr>
											<tr>
												<td>
													<small>CHARGE</small>
												</td>
												<td>
													<cfif charge_work gt 75 AND charge_work neq "NA">
													<span class="badge badge-danger">#charge_work#%</span>
													<cfelse>
													<small><strong>#charge_work#%</strong></small>
													</cfif>
												</td>
											</tr>
										</table>
									</cfif>
									</cfif>
								</td>
								</cfif> 

								<cfif isDefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq 1>
									<td align="center">
										<span>
											<cfoutput>#user_add_weight neq "" ? user_add_weight : 0#</cfoutput>
										</span>
									</td>
								</cfif>
			
								<cfif user_status_id eq "4" OR user_status_id eq "5">
								<td align="center">
									<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/signature.png")>		
									<i class="fas fa-check-circle" style="color:##20b027"></i>
									<cfelse>
									<i class="fas fa-times-circle" style="color:##FF0000"></i>
									</cfif>
								</td>
								</cfif>
			
								<td align="center">
									<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>		
										<i class="fas fa-check-circle" style="color:##20b027"></i>
									<cfelse>
										<cfif user_video_link neq "">
											<a class="btn btn-info" target="_blank" href="#user_video_link#">
											<i class="fal fa-video fa-2x"></i>
											</a>
										<cfelse>
											<i class="fas fa-times-circle" style="color:##FF0000"></i>
										</cfif>
									</cfif>
								</td>
			
								<cfif user_status_id eq "4" OR user_status_id eq "5">
								<td>
									<a target="_blank" href="./tpl/trainer_container.cfm?u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="far fa-file-pdf"></i></a>
								</td>
								</cfif>
			
								<cfif user_status_id neq "4" AND user_status_id neq "5">
								<td>
									#dateformat(user_lastconnect,"dd/mm/yyyy")#
								</td>
								</cfif>
			
							</tr>
						</cfloop>
						</cfoutput>
						</tbody>
						
					</table>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane mt-2" id="analytic_trainers">
			
					<div class="table-responsive">

						<table class="table bg-white">
							<tbody>
							<tr bgcolor="#F3F3F3" align="center">
								<th width="180">Trainer</th>
								<th width="200">S+1</th>
								<th>S+2</th>
								<th>S+3</th>				
								<th>S+4</th>	
							</tr>

							<cfoutput>	
							<cfloop query="get_trainer">	

							<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>

							<tr>

								<td align="center">
									<a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark">#obj_lms.get_thumb(user_id="#user_id#",size="60",responsive="yes")#</a>
									<br>
									<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> <a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark"><strong>#ucase(user_firstname)#</strong></a>
								</td>
								<td>
									64h / week
									<div class="progress">
										<div class="progress-bar progress-bar-striped bg-danger" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
										<div class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
										<div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
									 </div>

								</td>

							</tr>
							</cfloop>
							</cfoutput>

							</tbody>

						</table>

					</div>
				</div>

				<div role="tabpanel" class="tab-pane mt-2" id="admin_trainers">
			
					<div class="table-responsive">

						<table class="table bg-white">
							<tbody>
							<tr bgcolor="#F3F3F3" align="center">
								<th width="180">Trainer</th>
								<cfloop query="get_attach_type">
									<cfoutput>
									<th width="180">#attach_type#</th>
									</cfoutput>
								</cfloop>
							</tr>

							<cfoutput>	
							<cfloop query="get_trainer">	

							<tr>
								<td align="center">
									<a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark">#obj_lms.get_thumb(user_id="#user_id#",size="60",responsive="yes")#</a>
									<br>
									<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> <a href="common_trainer_account.cfm?p_id=#user_id#" class="text-dark"><strong>#ucase(user_firstname)#</strong></a>
								</td>
								<cfloop query="get_attach_type">
									<td>
										<cfif fileexists("#SESSION.BO_ROOT#/admin/conv/xxx")>
										<a class="btn btn-sm btn-success btn-block text-white p-0 btn_upload" id="upload_#get_trainer.user_id#_#attach_type_id#" href="./admin/conv/xxx" target="_blank"><i class="fal fa-check"></i><br>#attach_type#</a>
										<cfelse> 
										<button class="btn btn-sm btn-outline-danger btn-block p-0 btn_upload" id="upload_#get_trainer.user_id#_#attach_type_id#"><i class="fal fa-times"></i><br>#attach_type#</button>
										</cfif>
									</td>

								</cfloop>
								<!--- <td>
									<cfif fileexists("#SESSION.BO_ROOT#/admin/conv/#order_conv#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/conv/#order_conv#" target="_blank"><i class="fal fa-check"></i><br>CONV</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CONV</button>
									</cfif>
								</td>
								<td>
									<cfif fileexists("#SESSION.BO_ROOT#/admin/bdc/#order_bdc#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bdc/#order_bdc#" target="_blank"><i class="fal fa-check"></i><br>BDC</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>BDC</button>
									</cfif>
								</td> --->
							</tr>
							</cfloop>
							</cfoutput>

							</tbody>

						</table>

					</div>

				</div>

			</div>





			<!--- <cfdump var="#get_trainer#"> --->
			
			
				
			
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">



<script type="text/javascript">
						

$(document).ready(function() {


	$('.btn_upload').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		var attach_type_id = idtemp[2];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload Document");
		$('#modal_body_xl').load("modal_window_upload.cfm?u_id="+u_id+"&attach_type_id="+attach_type_id, function() {});

	})


	
    
    function submit_form_doc() {
            event.preventDefault();
            
            var fd = new FormData(document.getElementById("form_doc"));
    
            $.ajax({
                url        : './api/users/user_trainer_post.cfc?method=upload_doc',
                type       : 'POST',
                data       : fd,
                enctype	   : 'multipart/form-data',
                contentType: false,
                cache      : false,
                processData: false,
                xhr        : function ()
                {
                    var jqXHR = null;
                    if ( window.ActiveXObject )
                    {
                        jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
                    }
                    else
                    {
                        jqXHR = new window.XMLHttpRequest();
                    }
    
                    //Upload progress
                    jqXHR.upload.addEventListener("progress",function(evt)
                    {
                        if ( evt.lengthComputable )
                        {
                            var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
                            //Do something with upload progress
                            console.log( 'Uploaded percent', percentComplete );
                            
                            $("#progress_doc").css("width",percentComplete+"%");
                        }
                    }, false );
    
                    //Download progress
                    jqXHR.addEventListener("progress",function(evt)
                    {
                        if ( evt.lengthComputable )
                        {
                            var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
                            //Do something with download progress
                            $("#progress_doc").css("width","100%");
                            console.log( 'Downloaded percent', percentComplete );
                        }
                    }, false );
    
                    return jqXHR;
                },
                success    : function ( data )
                {
    
                    var doc_length = $('#file_holder tr').length;
                    const obj = JSON.parse(data);
                    // console.log("yeah", data)
                    console.log(doc_length)
                    console.log(obj)
    
    
                }
            });
                
                        
        };
    







	function go_data(element, checked, select){

	<!--- $.ajax({	 --->
			
			<!--- data : "teaching_criteria_id="+$('#teaching_criteria_id').val()+"&country_criteria_id="+$('#country_criteria_id').val()+"&speaking_criteria_id="+$('#speaking_criteria_id').val()+"&avail_criteria_id="+$('#avail_criteria_id').val()+"&speciality_criteria_id="+$('#speciality_criteria_id').val()+"&local_criteria_id="+$('#local_criteria_id').val()+"&perso_criteria_id="+$('#perso_criteria_id').val(), --->
			<!--- url : './components/queries.cfc?method=get_trainer', --->
			<!--- type : 'POST', --->
			<!--- dataType : 'html',		 --->
			<!--- success : function(html_return, statut){ --->
				<!--- console.log(html_return); --->
				<!--- $('#counter_search').empty(); --->
				<!--- $('#counter_search').html("<h1>"+html_return+" trainers</h1>"); --->
				
			<!--- }, --->

		   <!--- error : function(html_return, statut, erreur){ --->
			<!--- alert("erreur"); --->

		   <!--- } --->
			
		<!--- }) --->
	}


	
	



	$('.btn_trainer_sel').click(function(event) {	
		
		var checkbox_val = [];
		
		$('.trainer_sel:checked').each(function(){
			checkbox_val.push($(this).val());
			
		});
		
	
		$('#planner_id').val(checkbox_val);
		
		$('#form_pdf').submit();
		
		
	});
	
	
		
		
	$(".select_all").click(function(){
		if($(this).prop('checked') == true)
		{
			$('.trainer_sel').prop('checked', true);
		}
		else{
			$('.trainer_sel').prop('checked', false);
		}
	});

		
	$(".trainer_sel").click(function(){
		$('.select_all').prop('checked', false);
	})
	
	
	$('#teaching_criteria_id').multiselect({	
	numberDisplayed: 1,
	onChange: go_data
	});
	$('#country_criteria_id').multiselect({	
	/*enableFiltering: true,
	enableCaseInsensitiveFiltering: true,*/
	numberDisplayed: 1,
	onChange: go_data					
	});
	$('#speaking_criteria_id').multiselect({	
	numberDisplayed: 1,
	onChange: go_data
	});
	$('#avail_criteria_id').multiselect({
	numberDisplayed: 1,
	onChange: go_data
	});
	$('#speciality_criteria_id').multiselect({
	numberDisplayed: 1,
	onChange: go_data	
	});
	$('#method_criteria_id').multiselect({
	numberDisplayed: 1	,
	onChange: go_data
	});
	$('#local_criteria_id').multiselect({
	numberDisplayed: 1	,
	onChange: go_data
	});
	$('#perso_criteria_id').multiselect({
	numberDisplayed: 1	,
	onChange: go_data
	});
});
</script>
						
</body>
</html>