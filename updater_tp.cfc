<cfcomponent>


	<cffunction name="add_prebuilt" access="remote" output="false" returntype="any" returnFormat="JSON">
		<cfargument name="tpmaster_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
	
		<!---- CLEAN TP ---->
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_tpsession 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		</cfquery>
		
		<cfquery name="get_prefilled" datasource="#SESSION.BDDSOURCE#">
		SELECT sm.sessionmaster_id, tc.sessionmaster_schedule_duration, tc.sessionmaster_rank, sm.sessionmaster_cat_id
		FROM lms_tpmaster2 tp
		INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
		LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
		<!--- LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id --->
		WHERE tp.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
		AND tp.tpmaster_prebuilt = 1
		AND sm.sessionmaster_online_visio = 1
			
		GROUP BY tc.tpmaster_id, tc.sessionmaster_rank, tc.sessionmaster_id
		ORDER BY tc.tpmaster_id, tc.sessionmaster_rank, sm.sessionmaster_name
		</cfquery>
		
		<cfoutput query="get_prefilled">
		<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpsession 
		(
		tp_id,
		sessionmaster_id,
		session_duration,
		session_rank,
		method_id,
		cat_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_schedule_duration#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_rank#">,
		2,
		1
		)
		</cfquery>		
		</cfoutput>
			
		
		<!--- <cfreturn get_session_order> --->
		
	</cffunction>
	
	
	<cffunction name="add_session" access="remote" output="false" returntype="any" returnFormat="JSON">
		<cfargument name="sm_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
		<!--- <cfargument name="u_id" type="numeric" required="yes"> --->
		<cfargument name="s_duration" type="numeric" required="yes">
	
		<!---- FORCE ANYWAY FIRST LESSON TO BE RANK 1 --->
		<cfquery name="check_first" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND sessionmaster_id = 695
		</cfquery>
		
		<cfif check_first.recordcount eq "1">
		
		<cfquery name="updt_fl" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tpsession SET 
		session_rank = 1		
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND sessionmaster_id = 695
		</cfquery>
		
		<!---- IF NO 1st LESSON, CHECK EMPTY TP AND FORCE TO BE RANK 1 --->
		<!--- <cfquery name="get_nbsession" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT * FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND sessionmaster_id = 695 --->
		<!--- </cfquery> --->
		
		<!--- <cfif get_nbsession.recordcount eq "0"> --->
		
		<!--- <cfquery name="updt_fl" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- UPDATE lms_tpsession SET  --->
		<!--- session_rank = 1		 --->
		<!--- WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> --->
		<!--- AND sessionmaster_id = 695 --->
		<!--- </cfquery> --->
		
		<!--- </cfif> --->
		
		</cfif>
			
		<!---- GET PTA --->
		<cfquery name="check_last" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND sessionmaster_id = 694
		</cfquery>
		
		<!---- GET MAX RANKING --->
		<cfquery name="get_max_rank" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(session_rank) AS session_rank FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
		
		<cfif get_max_rank.session_rank eq "">
			<cfset session_rank = 1>
		<cfelse>
			<cfif check_last.recordcount eq "1">
				<!---- FORCE ANYWAY PTA TO BE LAST --->		
				<cfset session_rank = get_max_rank.session_rank>
				<cfquery name="updt_pta" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tpsession SET 
				session_rank = #session_rank+1#		
				WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
				AND sessionmaster_id = 694
				</cfquery>
			<cfelse>
				<cfset session_rank = get_max_rank.session_rank+1>
			</cfif>
		</cfif>
		
		<!---- INSERT SESSION --->
		<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpsession
		(
		tp_id,
		sessionmaster_id,
		session_duration,
		session_rank,
		session_close,
		method_id,
		cat_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#s_duration#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#session_rank#">,
		0,
		1,
		1
		)
		</cfquery>
		
		<cfquery name="get_max_id" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(session_id) AS maxid FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
		
		<cfquery name="get_session_order" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> ORDER BY session_rank ASC
		</cfquery>
		
		<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
		SELECT sessionmaster_name 
		FROM lms_tpsessionmaster2 
		WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
		</cfquery>
		
		<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
		SELECT m.module_id, COUNT(s.session_id) as nb FROM lms_tpsession s
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id
		WHERE m.module_id = (SELECT module_id FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">)
		AND s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
		
		<cfset result = StructNew()>
		<cfset result[0] = get_max_id.maxid>
		<cfset result[1] = session_rank>
		<cfset result[2] = get_module>
		<cfset result[3] = get_session_order>
		<cfset result[4] = get_sm.sessionmaster_name>
		<cfreturn result>
		
	</cffunction>
	
	
	
	<cffunction name="del_session" access="remote" output="false" returntype="any" returnFormat="JSON">
		<cfargument name="s_id" type="numeric" required="yes">
		<cfargument name="sm_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
	
		<!---- DELETE ---->
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_tpsession 
		WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
		AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
		</cfquery>
		
		<!---- GET AND REORDER ---->
		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		SELECT session_id, session_rank FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> ORDER BY session_rank ASC
		</cfquery>
		
		<cfset counter = 0>
		<cfoutput query="get_session">
		<cfset counter ++>
		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tpsession SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#counter#"> WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
		</cfoutput>
				
		<cfquery name="get_session_order" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> ORDER BY session_rank ASC
		</cfquery>
		
		<cfreturn get_session_order>
		
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
	
	
	
	
	
	<!--- <cffunction name="del" access="remote" output="false" returntype="any" returnformat="plain"> --->
	
	
		<!--- <cfargument name="act" type="any" required="yes"> --->
		<!--- <cfargument name="l_id" type="numeric" required="yes"> --->
		<!--- <cfargument name="t_id" type="numeric" required="yes"> --->
		<!--- <cfargument name="u_id" type="numeric" required="yes"> --->

		<!--- <cfquery name="delete" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- DELETE FROM lms_lesson2  --->
		<!--- WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">  --->
		<!--- AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> --->
		<!--- AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> --->
		<!--- </cfquery> --->

		<!--- <cfreturn "ok"> --->
		
		
	<!--- </cffunction> --->
	
	
	
	
	
	
	
	
	
	
	
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
	
	
	






	<!--------------------------- UPDATE LEVEL FROM FORM -------------------------->
	<cffunction name="updt_level" access="remote" httpmethod="GET" output="false" returntype="any" returnformat="json">
		<cfargument name="user_level" type="any" required="yes">
		<cfargument name="f_code" type="any" required="yes">

		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET user_qpt_#lcase(f_code)# =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">, user_qpt_lock_#lcase(f_code)# = 0
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>

		<cftry>
			<!--- NEW INSERT LEVEL --->
			<cfquery name="get_f" datasource="#SESSION.BDDSOURCE#">
				SELECT formation_id FROM lms_formation WHERE formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(f_code)#">
			</cfquery>

			<cfquery name="get_l" datasource="#SESSION.BDDSOURCE#">
				SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">
			</cfquery>

			<cfinvoke component="api/users/user_post" method="up_user_level">
				<cfinvokeargument name="user_id" value="#SESSION.USER_ID#">
				<cfinvokeargument name="skill_id" value="0">
				<cfinvokeargument name="formation_id" value="#get_f.formation_id#">
				<cfinvokeargument name="formation_code" value="#cor#">
				<cfinvokeargument name="level_id" value="#get_l.level_id#">
				<cfinvokeargument name="level_code" value="#evaluate("SESSION.USER_QPT_#ucase(cor)#")#">
				<cfinvokeargument name="level_verified" value="1">
			</cfinvoke>

		<cfcatch type="any">
			updt_user_level: <cfoutput>#cfcatch.message#</cfoutput>
		</cfcatch>
		</cftry>

		
		<!----------- REMOVE STEP LEVEL -------------->
		<cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
		<cfset temp = obj_lms.updt_step("2")>
		
		<!----------- SET CORRECT QPT LEVEL -------------->
		<cfset "SESSION.USER_QPT_#ucase(f_code)#" = user_level>
		<cfset "SESSION.USER_QPT_#ucase(f_code)#_LOCK" = 0>

		<cfreturn "ok">		
		
	</cffunction>





	
	
	<!--------------------------- UPDATE FORMULA FROM FORM -------------------------->
	<cffunction name="updt_tp_formula" access="remote" httpmethod="POST" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_formula_id" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">

		<cfquery name="updt_tp_formula" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_formula_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_formula_id#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>
		
		<!---<cfset SESSION.USER_NEEDS_DURATION = user_needs_duration>

		<cfquery name="updt_user_duration" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_needs_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_needs_duration#"> 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>	--->

		<cfreturn "ok">
		
	</cffunction>
	
	
	
	
	<!--------------------------- UPDATE SKILL FROM FORM -------------------------->
	<cffunction name="updt_tp_skill" access="remote" httpmethod="GET" output="false" returntype="any" returnformat="json">
		
		<cfargument name="skill_id" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">
		

		<cfquery name="updt_tp_skill" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_skill_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#skill_id#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>

		<cfreturn "ok">		
		
	</cffunction>
	
	
	
	<!--------------------------- UPDATE SESSION DURATION FROM FORM -------------------------->
	<cffunction name="updt_tp_session_duration" access="remote" httpmethod="GET" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_session_duration" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">
		
		<cfquery name="updt_tp_session_duration" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_session_duration = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_session_duration#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>

		<cfreturn "ok">		
		
	</cffunction>


	<!--------------------------- UPDATE SUPPORT FROM FORM -------------------------->
	<cffunction name="updt_tp_support" access="remote" httpmethod="GET" output="false" returntype="any" returnformat="json">
		
		<cfargument name="tp_support_id" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">
		

		<cfquery name="updt_tp_skill" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_support_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_support_id#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>

		<cfreturn "ok">		
		
	</cffunction>
	
	
	
	
	<!--------------------------- UPDATE TYPE FROM FORM -------------------------->
	<cffunction name="updt_tp_type" access="remote" httpmethod="GET" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_type_id" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">

		<cfquery name="updt_tp_type" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_type_id#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>

		<!---- CREATE EMPTY TP FOR COLLABORATIVE ---->
		<cfif tp_type_id eq "3">
			
			<cfset obj_query = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.queries")>
			<cfset obj_tp_get = createobject("component", "#SESSION.BO_ROOT_API#.tp.tp_get")>
			
			<!---- CLEAN TP ANYWAY ---->
			<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_tpsession 
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
			</cfquery>
			
			<cfset get_tp = obj_tp_get.oget_tp(u_id="#SESSION.USER_ID#",t_id="#t_id#")>

			<cfset s_dur = get_tp.tp_session_duration>
			<cfif s_dur eq "">
				<cfset s_dur = 60>
			</cfif>

			<cfset tp_master_hour = get_tp.tp_duration/ s_dur>
			<cfset tp_hour_remain = get_tp.tp_duration - 60>
			<cfset tp_session_rank = 2>

			<cfoutput>#get_tp.tp_duration#</cfoutput>
		
			<cfif get_tp.tp_duration gt s_dur>
				
				<!---- INS FL ---->
				<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_tpsession
				(
				tp_id,
				sessionmaster_id,
				session_duration,
				session_rank,
				method_id,
				cat_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
				695,
				30,
				1,
				1,
				1
				)
				</cfquery>

				<!--- <cfif s_dur eq 30>
					<cfset tp_master_hour = tp_master_hour - 1>
				</cfif> --->
				<cfloop from="2" to="#tp_master_hour#" index="cor">
				
					<cfif tp_hour_remain GTE s_dur>

						<!---- INS FL + PTA ---->
						<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
						INSERT INTO lms_tpsession
						(
						tp_id,
						sessionmaster_id,
						session_duration,
						session_rank,
						method_id,
						cat_id
						)
						VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
						696,
						#s_dur#,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_session_rank#">,
						1,
						1
						)
						</cfquery>

						<cfset tp_session_rank = tp_session_rank + 1>


					<cfelseif tp_hour_remain GT 0>

						<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
							INSERT INTO lms_tpsession
							(
							tp_id,
							sessionmaster_id,
							session_duration,
							session_rank,
							method_id,
							cat_id
							)
							VALUES
							(
							<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
							696,
							#tp_hour_remain#,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_session_rank#">,
							1,
							1
							)
						</cfquery>

						<cfset tp_session_rank = tp_session_rank + 1>

					</cfif>
					
					<cfset tp_hour_remain = tp_hour_remain - s_dur>

				
				</cfloop>

				<!---- INS PTA ---->
				<cfquery name="ins_pta" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_tpsession
				(
				tp_id,
				sessionmaster_id,
				session_duration,
				session_rank,
				method_id,
				cat_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
				694,
				30,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_session_rank#">,
				1,
				1
				)
				</cfquery>

			<cfelse>

				<!---- INS TEST LESSON ---->
				<cfquery name="ins_test" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_tpsession
				(
				tp_id,
				sessionmaster_id,
				session_duration,
				session_rank,
				method_id,
				cat_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
				769,
				45,
				1,
				1,
				1
				)
				</cfquery>

			</cfif>
		
		</cfif>

		<cfreturn "ok">
		
	</cffunction>
	
	
	
	<!--------------------------- UPDATE ORIENTATION FROM FORM -------------------------->
	<cffunction name="updt_tp_orientation" access="remote" httpmethod="POST" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_orientation_id" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">

		<cfquery name="updt_tp_orientation" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_orientation_id#"> 
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		</cfquery>		

		<cfreturn tp_orientation_id>
		
	</cffunction>
	
	
	
	<!--------------------------- UPDATE INTERESTS FROM FORM -------------------------->
	<cffunction name="updt_tp_keyword" access="remote" httpmethod="POST" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_interest_id" type="any" required="no">
		<cfargument name="tp_function_id" type="any" required="no">
		<cfargument name="t_id" type="any" required="yes">

		<cfif isdefined("tp_interest_id") AND tp_interest_id neq "">
			<cfquery name="updt_tp_keyword" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tp SET 
			tp_interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_interest_id#">
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
			AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
			</cfquery>	
		</cfif>	

		<cfif isdefined("tp_function_id") AND tp_function_id neq "">
			<cfquery name="updt_tp_keyword" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tp SET 
			tp_function_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_function_id#">
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
			AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
			</cfquery>	
		</cfif>

		<cfreturn "ok">
		
	</cffunction>
	
	
	
	
	
	<!--------------------------- UPDATE SESSION SUPPORT FOR TEST -------------------------->
	<cffunction name="updt_session_sm" access="remote" httpmethod="POST" output="false" returntype="any" returnformat="json">
	
		<cfargument name="tp_support_id" type="any" required="yes">

		<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
		SELECT sm_id FROM lms_tpsupport WHERE tp_support_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_support_id#"> 
		</cfquery>
		
		<cfquery name="updt_session_sm" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tpsession SET 
		sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_sm.sm_id#">
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.TP_ID#"> 
		AND session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SESSION_ID#"> 
		</cfquery>		

		<cfreturn "ok">
		
	</cffunction>
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!--- <cffunction name="shortlist" access="remote" output="false" returntype="any" returnformat="plain"> --->
	
	
		<!--- <cfargument name="sm_id" type="numeric" required="yes"> --->

		<!--- <cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sm_id#)> --->
			
			<!--- <cfset new_shortlist = listdeleteat(SESSION.USER_SHORTLIST, ListFind(SESSION.USER_SHORTLIST,sm_id)) /> --->
			
		<!--- <cfelse> --->
		
			<!--- <cfset new_shortlist = listappend(SESSION.USER_SHORTLIST,sm_id)> --->
			
		<!--- </cfif> --->
		
		<!--- <cfset SESSION.USER_SHORTLIST = new_shortlist> --->
		
		<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- UPDATE user SET user_shortlist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_shortlist#"> --->
		<!--- WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> --->
		<!--- </cfquery> --->
			
		<!--- <cfreturn "ok"> --->
		
	<!--- </cffunction> --->
	
	
	<!--- <cffunction name="updt_progress" access="remote" output="false" returntype="any"> --->
			
		<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- UPDATE user SET user_elapsed = user_elapsed+5 --->
		<!--- WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> --->
		<!--- </cfquery> --->
		
		<!--- <cfquery name="get_time" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT user_elapsed FROM user --->
		<!--- WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> --->
		<!--- </cfquery> --->
		
		<!--- <cfset SESSION.USER_ELAPSED = get_time.user_elapsed> --->
			
		<!--- <cfreturn "ok"> --->
		
	<!--- </cffunction> --->
	
	
	
	
	<!--- <cffunction name="updt_progress_lesson" access="remote" output="false" returntype="any"> --->
			
		<!--- <cfargument name="sm_id" type="numeric" required="yes"> --->
		
		<!--- <cfquery name="check_sm" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT elapsed_id FROM user_elapsed --->
		<!--- WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">  --->
		<!--- AND sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> --->
		<!--- </cfquery> --->
		
		<!--- <cfif check_sm.recordcount neq "0"> --->
			<!--- <cfquery name="updt_elapsed" datasource="#SESSION.BDDSOURCE#"> --->
			<!--- UPDATE user_elapsed SET sm_elapsed = sm_elapsed+5, sm_lastview = now() --->
			<!--- WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">  --->
			<!--- AND sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> --->
			<!--- </cfquery> --->
		<!--- <cfelse> --->
			<!--- <cfquery name="insert_elapsed" datasource="#SESSION.BDDSOURCE#"> --->
			<!--- INSERT INTO user_elapsed  --->
			<!--- ( --->
			<!--- sm_id, --->
			<!--- user_id, --->
			<!--- sm_elapsed, --->
			<!--- sm_lastview		 --->
			<!--- ) --->
			<!--- VALUES --->
			<!--- ( --->
			<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">, --->
			<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">, --->
			<!--- 5, --->
			<!--- now() --->
			<!--- ) --->
			<!--- </cfquery> --->
		<!--- </cfif> --->
				
		<!--- <cfreturn "ok"> --->
		
	<!--- </cffunction> --->
	
	
</cfcomponent>