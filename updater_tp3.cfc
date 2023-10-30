<cfcomponent>

	<cffunction name="updt" access="remote" output="false" returntype="any" returnformat="plain">
	
	
		<cfargument name="act" type="any" required="yes">
		<cfargument name="sm_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="l_dur" type="numeric" required="yes">

		<cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT method_id FROM lms_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		<cfif get_tp.recordcount eq "0">

			<cfreturn '<li class="mt-3 border p-2 w-100 bg-light">Traitement impossible !</li>'>

		<cfelse>

			<cfquery name="get_count" datasource="#SESSION.BDDSOURCE#">
			SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>
			
			<cfquery name="get_code" datasource="#SESSION.BDDSOURCE#">
			SELECT sessionmaster_code FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
			</cfquery>
			
			<cfif get_count.nb eq "0">
				<cfset counter = 1>
			<cfelse>
				<cfset counter = get_count.nb+1>
			</cfif>
			

			<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_lesson2
			(
			sm_id,
			tp_id,
			method_id,
			status_id,
			user_id,
			lesson_rank,
			lesson_duration
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.method_id#">,
			null,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#counter#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#l_dur#">
			)
			</cfquery>

			<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
			SELECT sessionmaster_name, module_name
			FROM lms_tpsessionmaster2 sm
			LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id
			WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
			</cfquery>
			
			<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(lesson_id) as id FROM lms_lesson2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>

			<cfset toreturn = '<li class="mt-3 border w-100 bg-light active" id="LR_#get_max.id#_#sm_id#_#l_dur#_#counter#"><div class="container"><div class="row" style="background-color:##ECECEC">'>
			
			<cfset toreturn = toreturn & '<div class="col-md-11 p-1" align="center">'>
			
			<cfif sm_id neq "695" AND sm_id neq "694">
			<cfset toreturn = toreturn & '<div class="btn btn-sm pull-left p-0 m-0 handle" style="border:1px solid ##000; min-width:20px !important"><i class="fas fa-arrows-alt"></i></div>'>
			</cfif>	
			
			<cfif get_sessionmaster.module_name neq ""><cfset toreturn = toreturn & '#get_sessionmaster.module_name#'><cfelse><cfset toreturn = toreturn & 'Diverse'></cfif>
			
			<cfset toreturn = toreturn & '</div>'>
										
			<cfset toreturn = toreturn & '<div class="col-md-1 p-1 pull-right"><a href="##" class="btn btn-sm btn-secondary del_liner pull-right p-0 m-0" style="border:1px solid ##000; min-width:20px !important" id="LTD_#get_max.id#_#sm_id#_#l_dur#_#counter#"><i class="fas fa-times"></i></a></div>'>
			
			<cfset toreturn = toreturn & '</div><div class="row p-2">'>
			
			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_code.sessionmaster_code#.jpg")>			
			<cfset toreturn = toreturn & '<div class="col-md-1"><img src="../assets/img_material/#get_code.sessionmaster_code#.jpg" class="btn_view_session mr-2" width="60"><br><span class="badge badge-secondary"><i class="far fa-clock"></i> #l_dur#min</span></div>'>
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sm_id#.jpg")>			
			<cfset toreturn = toreturn & '<div class="col-md-1"><img src="../assets/img_material/#sm_id#.jpg" class="btn_view_session mr-2" width="60"><br><span class="badge badge-secondary"><i class="far fa-clock"></i> #l_dur#min</span></div>'>
			<cfelse>
			<cfset toreturn = toreturn & '<div class="col-md-1"><img src="../assets/img/wefit_lesson.jpg" class="btn_view_session mr-2" width="60"><br><span class="badge badge-secondary"><i class="far fa-clock"></i> #l_dur#min</span></div>'>
			</cfif>
					
					
			<cfset toreturn = toreturn & '<div class="col-md-5">#get_sessionmaster.sessionmaster_name#
			<br>
			<span class="btn_view_lesson_work" id="l_#get_max.id#" role="button">
			<small style="cursor:pointer"><strong>[more info]</strong></small>
			</span>
			</div>'>					
			
			<cfif get_tp.method_id eq "1">
			<cfset toreturn = toreturn & '<div class="col-md-3" align="center"><div class="p-1 border" style="border:1px dashed ##ffc107 !important"><span class="badge badge-warning text-white"> <i class="fas fa-video"></i> #l_dur#min : VISIO</span><br><button class="btn btn-sm btn-outline-warning btn_edit_calendar m-0" id="LTB_#get_max.id#_#sm_id#_#l_dur#_#counter#"><i class="far fa-calendar-plus"></i> <div class="d-none d-lg-block">R&eacute;server</div></button></div></div>'>
			<cfelseif get_tp.method_id eq "2">
			<cfset toreturn = toreturn & '<div class="col-md-3" align="center"><div class="p-1 border" style="border:1px dashed ##ffc107 !important"><span class="badge badge-warning text-white"> <i class="fas fa-user-friends"></i> #l_dur#min : F2F</span><br><button class="btn btn-sm btn-outline-warning btn_edit_calendar m-0" id="LTB_#get_max.id#_#sm_id#_#l_dur#_#counter#"><i class="far fa-calendar-plus"></i> <div class="d-none d-lg-block">R&eacute;server</div></button></div></div>'>
			</cfif>
			
			
											
											
			<cfset toreturn = toreturn & '</div></div></li>'>
			
			<cfreturn toreturn>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
							<!---<li class="mt-3 border w-100 bg-light <cfif sessionmaster_id neq "695" AND sessionmaster_id neq "694">active</cfif>" id="LR_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#">
							<cfset count++>	
								<div class="container">
								
								<div class="row" style="background-color:##ECECEC">
									<div class="col-md-11 p-1" align="center">
										<cfif sessionmaster_id neq "695" AND sessionmaster_id neq "694">
										<div class="btn btn-sm pull-left p-0 m-0 handle" style="border:1px solid ##000; min-width:20px !important"><i class="fas fa-arrows-alt"></i></div>
										</cfif>							
										<cfif module_name neq "">#module_name#<cfelse>Diverse</cfif>
									</div>
									<div class="col-md-1 p-1 pull-right">
										<cfif lesson_start eq "">
										<a href="##" class="btn btn-sm btn-secondary del_liner pull-right p-0 m-0" style="border:1px solid ##000; min-width:20px !important" id="LTD_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#"><i class="fas fa-times"></i></a>
										</cfif>
									</div>
								</div>
								
								<div class="row p-2">
									<div class="col-md-1" align="center">
									#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="60")#
									<cfif lesson_duration neq ""><br><span class="badge badge-secondary"><i class="far fa-clock"></i> #lesson_duration#min</span></cfif>
									</div>
									
									<div class="col-md-5">
									#sessionmaster_name# - #lesson_id# - #lesson_rank#
									<br>
									<span class="btn_view_lesson_work" id="l_#lesson_id#" role="button" <!---data-toggle="collapse" data-target="##collapse_#lesson_id#" aria-expanded="true" aria-controls="collapse_#lesson_id#"--->>
									<small style="cursor:pointer"><strong>[more info]</strong></small>
									</span>
									</div>
									
									<cfif lesson_start neq "">
									<div class="col-md-3">
										<div class="p-2 border border-#status_css# bg-white h-100">
											<span class="badge badge-#status_css# btn_view_lesson text-white" id="lesson_#lesson_id#" style="cursor:pointer"><cfif method_id eq "1"><i class="fas fa-video"></i><cfelseif method_id eq "2"><i class="fas fa-user-friends"></i></cfif> #__lesson# #l_status_name#</span>
											<cfif status_id eq "1">
												<a class="btn btn-sm btn-outline-#status_css# btn_view_lesson pull-right" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('tooltip_cancel_lesson')#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i></a>
											</cfif>
											<br>
											<strong>#dateformat(lesson_start,'dd/mm/yyyy')#</strong>
											#timeformat(lesson_start,'HH:mm')#-#timeformat(lesson_end,'HH:mm')#<br>
											#obj_translater.get_translate('with')# #planner_firstname#										
										</div>
									</div>
									<cfelse>
									<div class="col-md-3" align="center">
										<div class="p-2 border bg-white h-100" style="border:1px dashed ##ffc107 !important">
											<span class="badge badge-warning text-white"><cfif method_id eq "1"><i class="fas fa-video"></i> VISIO<cfelseif method_id eq "2"><i class="fas fa-user-friends"></i> F2F</cfif></span>
											<br>
											<button class="btn btn-sm btn-outline-warning btn_edit_calendar" id="LTB_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#"><i class="far fa-calendar-plus"></i> <div class="d-none d-lg-block">R&eacute;server</div></button>
										</div>
									</div>
									</cfif>
									
									<cfif sessionmaster_id neq "694" AND sessionmaster_id neq "695" AND sessionmaster_id neq "696" AND sessionmaster_id neq "697" AND sessionmaster_id neq "769">
									<div class="col-md-3" align="center">
										<cfif lesson_elapsed neq "0">
										<div class="p-2 border border-success bg-white h-100">
										
											<cftry>
											<span class="badge badge-success"><i class="fas fa-laptop"></i> #round(lesson_elapsed/60)# min</span>
											<br>
											<cfcatch type="any"></cfcatch>
											</cftry>
											
											<a class="btn btn-sm btn-outline-success" href="learner_practice.cfm?sm_id=#sessionmaster_id#&l_id=#lesson_id#&t_id=#tp_id#"><i class="fas fa-play-circle"></i> <div class="d-none d-lg-block">Continuer</div> </a>
										</div>
										<cfelse>
										<div class="p-2 border bg-white h-100" style="border:1px dashed ##28a745 !important">
											<span class="badge badge-success"><i class="fas fa-laptop"></i> eLearning</span>
											<br>
											<a class="btn btn-sm btn-outline-success" href="learner_practice.cfm?sm_id=#sessionmaster_id#&l_id=#lesson_id#&t_id=#tp_id#"><i class="fas fa-play-circle"></i> <div class="d-none d-lg-block">Commencer</div> </a>
										</div>
										</cfif>
									</div>
									</cfif>
									
									</div>
									
								</div>---->
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

		</cfif>
		
		
	</cffunction>
	
	
	
	
	
	
	
	<cffunction name="retrieve_activity" access="remote" output="false" returntype="any" returnformat="JSON">
	
	
		<cfargument name="t_id" type="any" required="yes">
		<cfargument name="u_id" type="any" required="yes">

		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
SELECT
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id IS NULL) as tp_toschedule,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
(SELECT IFNULL(tp_inprogress,0)+IFNULL(tp_completed,0)) as tp_completed_full,
(SELECT tp_duration-IFNULL(tp_toschedule,0)-IFNULL(tp_scheduled,0)-IFNULL(tp_completed_full,0)-IFNULL(tp_missed,0)) as tp_remain
FROM lms_tp t 

INNER JOIN user u ON t.user_id = u.user_id
INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
LEFT JOIN account a ON a.account_id = u.account_id

WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>

<cfset table_data = arraynew(1)>

<cfoutput query="get_tp">
	
	<cfif tp_toschedule eq "" OR tp_toschedule eq "0"><cfset tp_toschedule_go = "0"><cfelse><cfset tp_toschedule_go = tp_toschedule/60></cfif>
	<cfif tp_scheduled eq "" OR tp_scheduled eq "0"><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled/60></cfif>
	<cfif tp_completed_full eq "" OR tp_completed_full eq "0"><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed_full/60></cfif>
	<cfif tp_missed eq "" OR tp_missed eq "0"><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed/60></cfif>
	<cfif tp_remain eq "" OR tp_remain eq "0"><cfset tp_remain_go = "0"><cfelse><cfset tp_remain_go = tp_remain/60></cfif>
	
	<cfset temp = arrayAppend(table_data, structNew())>
	<cfset table_data[1] = tp_toschedule_go>
	<cfset temp = arrayAppend(table_data, structNew())>
	<cfset table_data[2] = tp_scheduled_go>
	<cfset temp = arrayAppend(table_data, structNew())>
	<cfset table_data[3] = tp_completed_go>
	<cfset temp = arrayAppend(table_data, structNew())>
	<cfset table_data[4] = tp_missed_go>
	<cfset temp = arrayAppend(table_data, structNew())>
	<cfset table_data[5] = tp_remain_go>
	
</cfoutput>

<cfset table_js = SerializeJSON(table_data)>


<cfreturn table_js>
		
	</cffunction>
	
	
	
	
	
	<cffunction name="del" access="remote" output="false" returntype="any" returnformat="plain">
	
	
		<cfargument name="act" type="any" required="yes">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">

		<cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_lesson2 
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
		AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		<cfreturn "ok">
		
		
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	
	<cffunction name="updt_rank" access="remote" output="false" returntype="any" returnformat="plain">
	
		<cfargument name="lesson_rank_table" type="any" required="yes">

		<cfoutput>
		<cfset counter = 0>
		
		<cfloop list="#lesson_rank_table#" index="cor">
		<cfset l_id = listgetat(cor,2,'_')>
		<cfset counter ++>
				
		<cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET lesson_rank = #counter#
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
		</cfquery>
		</cfloop>
		
		</cfoutput>
		

		<cfreturn "ok">
		
		
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<cffunction name="shortlist" access="remote" output="false" returntype="any" returnformat="plain">
	
	
		<cfargument name="sm_id" type="numeric" required="yes">

		<cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sm_id#)>
			
			<cfset new_shortlist = listdeleteat(SESSION.USER_SHORTLIST, ListFind(SESSION.USER_SHORTLIST,sm_id)) />
			
		<cfelse>
		
			<cfset new_shortlist = listappend(SESSION.USER_SHORTLIST,sm_id)>
			
		</cfif>
		
		<cfset SESSION.USER_SHORTLIST = new_shortlist>
		
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_shortlist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_shortlist#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
			
		<cfreturn "ok">
		
	</cffunction>
	
	
	<cffunction name="updt_progress" access="remote" output="false" returntype="any">
			
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_elapsed = user_elapsed+5
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfquery name="get_time" datasource="#SESSION.BDDSOURCE#">
		SELECT user_elapsed FROM user
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfset SESSION.USER_ELAPSED = get_time.user_elapsed>
			
		<cfreturn "ok">
		
	</cffunction>
	
	
	
	
	<cffunction name="updt_progress_lesson" access="remote" output="false" returntype="any">
			
		<cfargument name="sm_id" type="numeric" required="yes">
		
		<cfquery name="check_sm" datasource="#SESSION.BDDSOURCE#">
		SELECT elapsed_id FROM user_elapsed
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		AND sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
		</cfquery>
		
		<cfif check_sm.recordcount neq "0">
			<cfquery name="updt_elapsed" datasource="#SESSION.BDDSOURCE#">
			UPDATE user_elapsed SET sm_elapsed = sm_elapsed+5, sm_lastview = now()
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
			AND sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
			</cfquery>
		<cfelse>
			<cfquery name="insert_elapsed" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_elapsed 
			(
			sm_id,
			user_id,
			sm_elapsed,
			sm_lastview		
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
			5,
			now()
			)
			</cfquery>
		</cfif>
				
		<cfreturn "ok">
		
	</cffunction>
	
	
</cfcomponent>