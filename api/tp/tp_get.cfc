<cfcomponent>

	<cffunction name="oget_tp_cancel_today" access="public" returntype="numeric" output="false" description="Retrieve count of canceled TP today">
		<cfargument name="t_id" type="numeric" required="yes">

		<cftry>

		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#" result="data">
			SELECT lesson_id
			FROM lms_lesson2 l 
			WHERE l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			AND status_id = 3 
			AND DATE_FORMAT(updater_date,'%Y-%m-%d') = DATE_FORMAT(NOW(),'%Y-%m-%d')
		</cfquery>
		
		<cfreturn data.RecordCount>

		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>


	</cffunction>

	<cffunction name="oget_tp_trainer" access="public" returntype="query" output="false" description="Retrieve Tp's trainers">
		<cfargument name="t_id" type="numeric" required="yes">

		<cftry>

		<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#" result="data">
		SELECT p.planner_id, u.user_firstname as planner, u.user_shortlist as planner_shortlist, u.user_email as planner_email
		FROM lms_tpplanner p 
		INNER JOIN user u ON p.planner_id = u.user_id 
		WHERE p.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND p.active = 1
		</cfquery>
		
		<cfreturn get_trainer>

		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
<!--- 			<cfreturn 0> --->
		</cfcatch>
		</cftry>


	</cffunction>





	<cffunction name="oget_tp_user" access="public" returntype="query" output="true">
		<cfargument name="t_id" type="numeric" required="yes">

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT u.*, a.account_name, a.account_id, a.group_id
		FROM user u
		INNER JOIN lms_tpuser tpu ON tpu.user_id = u.user_id AND tpu.tpuser_active = 1
		LEFT JOIN account a ON a.account_id = u.account_id
		WHERE tpu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery> 
		
		<cfreturn get_user> 
	
	</cffunction>







	<cffunction name="oget_tp" access="public" returntype="query" output="false" description="Retrieve all details of a tp">
	
		<cfargument name="t_id" type="numeric" required="no">
		<cfargument name="u_id" type="numeric" required="no" default="0">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="m_id" type="any" required="no">
		<cfargument name="display_remain" type="any" required="no">
		<cfargument name="o_by" type="any" required="no" default="">
		<cfargument name="lang" type="any" required="no" default="#SESSION.LANG_CODE#">


		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_name_#lang# as formation_name_lg, f.formation_alias,
		lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name, lv.level_css,
		lv2.level_id as tplevel_id, lv2.level_alias as tplevel_alias, lv2.level_name_#SESSION.LANG_CODE# as tplevel_name, lv2.level_css as tplevel_css,
		tpu.tpuser_id,
		a.account_name, a.account_id,
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name, ts.tp_status_css,
		o.order_id, o.order_ref, o.order_start, o.order_end,
		ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_alias,
		tpf.tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tpf.tp_formula_alias_#SESSION.LANG_CODE# as tp_formula_alias, tpf.tp_formula_desc_#SESSION.LANG_CODE# as tp_formula_desc, tpf.tp_formula_nbcourse,
		tpte.techno_alias,
		lt.token_code,
		tpt.tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tpt.tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tpt.tp_type_small_desc_#SESSION.LANG_CODE# as tp_type_small_desc, tpt.tp_type_small_desc_#SESSION.LANG_CODE# as tp_type_small_desc, tpt.tp_type_alias,
		tpo.tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tpo.tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc,
		(SELECT SUM(session_duration) as duration FROM lms_tpsession s WHERE s.tp_id = t.tp_id) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 6) as tp_signed,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
		(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson
		
		FROM lms_tp t 

		LEFT JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
				
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_level lv ON lv.level_id = s.level_id
		LEFT JOIN lms_level lv2 ON lv2.level_id = t.level_id
		LEFT JOIN lms_list_token lt ON lt.token_id = t.token_id

		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		LEFT JOIN lms_list_techno tpte ON tpte.techno_id = t.techno_id
		
		LEFT JOIN lms_tpformula tpf ON tpf.tp_formula_id = t.tp_formula_id
		LEFT JOIN lms_tptype tpt ON tpt.tp_type_id = t.tp_type_id
		LEFT JOIN lms_tporientation tpo ON tpo.tp_orientation_id = t.tp_orientation_id
		
		WHERE 1 = 1
		
		<cfif u_id neq 0 AND u_id neq "">
			AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("t_id")>
			AND t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfif>
		
		<cfif isdefined("display_remain") AND display_remain eq "0">
			AND t.order_id <> 3
		</cfif>

		<cfif isdefined("m_id") AND m_id neq "100">
		AND (1 = 2 
		<cfloop list="#m_id#" index="cor">
		OR t.method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfloop>
		)
		</cfif>
		
		GROUP BY t.tp_id

		<cfif o_by neq "">
			ORDER BY t.tp_date_end DESC
		</cfif>
		
		</cfquery>
				
		<cfreturn get_tp> 
		
	</cffunction>
	
	<cffunction name="oget_tps" access="public" returntype="query" output="false" description="Retrieve list of tp with different filters">
	
		<cfargument name="t_id" type="numeric" required="no">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="a_id" type="numeric" required="no">
		<cfargument name="schedule_only" type="numeric" required="no">
		<cfargument name="st_id" type="any" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="m_id" type="any" required="no">
		<cfargument name="o_by" type="any" required="no">
		<cfargument name="no_users" type="any" required="no" default="0">
		<cfargument name="f_id" type="any" required="no">
		<cfargument name="lvl_id" type="any" required="no">
		<cfargument name="lvl_max_id" type="any" required="no" default="0">
		
		<cfquery name="get_tps" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_type_id, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name, lv.level_css,
		lv2.level_id as tplevel_id, lv2.level_alias as tplevel_alias, lv2.level_name_#SESSION.LANG_CODE# as tplevel_name, lv2.level_css as tplevel_css,
		tpu.tpuser_id,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		oc.*,
		tpf.tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tpf.tp_formula_alias_#SESSION.LANG_CODE# as tp_formula_alias, tpf.tp_formula_nbcourse,
		tpte.techno_alias,
		tpt.tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tpt.tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tpt.tp_type_small_desc_#SESSION.LANG_CODE# as tp_type_small_desc, tpt.tp_type_small_desc_#SESSION.LANG_CODE# as tp_type_small_desc, tpt.tp_type_alias,
		tpo.tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tpo.tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc,
		lt.token_code,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name, ts.tp_status_css,
		COUNT(lo.log_id) as nb_log,
		o.order_id, o.order_ref, o.order_start, o.order_end,
		ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_alias,
		(SELECT SUM(session_duration) as duration FROM lms_tpsession s WHERE s.tp_id = t.tp_id) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 6) as tp_signed,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
		(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson
		
		FROM lms_tp t 

		<cfif no_users eq 0>
			INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		<cfelse>
			LEFT JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		</cfif>
		LEFT JOIN user u ON tpu.user_id = u.user_id
		
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		LEFT JOIN order_context oc ON oc.context_id = o.context_id
		LEFT JOIN logs lo ON lo.order_id = o.order_id
		LEFT JOIN lms_list_token lt ON lt.token_id = t.token_id
		
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_level lv ON lv.level_id = s.level_id
		LEFT JOIN lms_level lv2 ON lv2.level_id = t.level_id

		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		LEFT JOIN lms_list_techno tpte ON tpte.techno_id = t.techno_id

		LEFT JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
		
		LEFT JOIN lms_tpformula tpf ON tpf.tp_formula_id = t.tp_formula_id
		LEFT JOIN lms_tptype tpt ON tpt.tp_type_id = t.tp_type_id
		LEFT JOIN lms_tporientation tpo ON tpo.tp_orientation_id = t.tp_orientation_id
		
		WHERE 1 = 1
		
		<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
			<cfif no_users eq 0>
			AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			</cfif>
		<cfelseif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG,PARTNER,TM", SESSION.USER_PROFILE)>
			<cfif isdefined("u_id")>
			AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfif>
		</cfif>

		<cfif isdefined("schedule_only")>
			AND lm.method_scheduler = "scheduler"
		</cfif>
		
		<cfif isdefined("a_id")>
			<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"><cfelse> AND u.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)</cfif>
		</cfif>
		
		<cfif isdefined("f_id")>
			<cfif f_id neq 0>AND t.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"></cfif>
		</cfif>

		<cfif isdefined("lvl_id") AND lvl_max_id eq 0>
			<cfif lvl_id neq 0>AND t.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#"></cfif>
		</cfif>
		<cfif lvl_max_id neq 0>AND t.level_id <= <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_max_id#"></cfif>

		<cfif isdefined("st_id") AND st_id neq "0" AND st_id neq "100">
			AND (1 = 2
			<cfloop list="#st_id#" index="cor">
			OR t.tp_status_id = #cor#
			</cfloop>
			)
		<cfelseif isdefined("st_id") AND st_id eq "0">
			AND t.tp_id IS NULL
		</cfif>
		
		<cfif isdefined("p_id")>
			AND p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		
		<cfif isdefined("o_id")>
			AND t.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfif>
		
		<cfif isdefined("m_id") AND m_id neq "100">
		AND (1 = 2 
		<cfloop list="#m_id#" index="cor">
		OR t.method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfloop>
		)
		<cfelse>
			AND t.method_id != "12"
		</cfif>	
		
		GROUP BY t.tp_id 
		
		<cfif isdefined("o_by") AND o_by eq "id">
		ORDER BY t.order_id DESC, t.method_id ASC
		<cfelseif isdefined("o_by") AND o_by eq "user_firstname">
		ORDER BY u.user_firstname ASC
		<cfelseif isdefined("o_by") AND o_by eq "user_name">
		ORDER BY u.user_name ASC
		<cfelseif isdefined("o_by") AND o_by eq "method_id">
		ORDER BY t.method_id ASC
		<cfelseif isdefined("o_by") AND o_by eq "tp_level">
		ORDER BY tplevel_alias ASC
		<cfelse>
		ORDER BY FIELD(t.tp_status_id,2,7,1,6,3,4,5,9,10,11), t.order_id DESC, t.method_id ASC
		</cfif>
		</cfquery>
				
		<cfreturn get_tps> 
		
	</cffunction>
	
	
	<cffunction name="oget_tps_access" access="public" returntype="query" output="false">
	
		<cfargument name="u_id" type="numeric" required="yes">

		<cfquery name="get_tps_access" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name, ts.tp_status_css
		
		FROM lms_tp t 

		INNER JOIN user u ON t.user_id = u.user_id		
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE 1 = 1
		
		AND t.method_id != 11
		
		<cfif listFindNoCase("LEARNER,GUEST,TEST", SESSION.USER_PROFILE)>
			AND t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		<cfelseif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			AND t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		GROUP BY t.tp_id 
		
		ORDER BY t.order_id DESC
		</cfquery>
				
		<cfreturn get_tps_access> 
		
	</cffunction>



	<cffunction name="oget_session" access="public" returntype="query" output="true" description="Retrieve list of sessions attached to a tp">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="no" default="#SESSION.USER_ID#">
		<cfargument name="g_by" type="string" required="no" default="no">
		<cfargument name="l_by" type="string" required="no" default="no">
		<cfargument name="s_id" type="numeric" required="no">
		<cfargument name="status" type="any" required="no">
		
		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		t.tp_id, t.tp_name, t.tp_icon, t.method_id, t.tp_date_end, t.tp_max_participants,
		f.formation_id, f.formation_code, 
		s.session_id, s.session_duration, s.session_rank, s.session_close, s.session_name, s.mapping_id, s.origin_id, s.voc_cat_id as l_voc_cat_id,
		lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name, lv.level_css,
		sm.sessionmaster_id, sm.sessionmaster_online_el, sm.tp_orientation_id, sm.sessionmaster_cat_id, sm.module_id, sm.skill_id, sm.keyword_id, sm.grammar_id, sm.sessionmaster_audio_bool, sm.sessionmaster_video_bool, sm.sessionmaster_support_bool, sm.sessionmaster_code, sm.sessionmaster_level, sm.sessionmaster_type, sm.sessionmaster_duration, sm.sessionmaster_url, sm.sessionmaster_ressource, sm.sessionmaster_subtype, sm.sessionmaster_group, sm.sessionmaster_ln_grammar, sm.sessionmaster_ln_vocabulary, sm.sessionmaster_md, sm.sessionmaster_transcript, sm.sessionmaster_video, sm.sessionmaster_el_duration, sm.voc_cat_id, sm.sessionmaster_exercice, sm.sessionmaster_date, sm.sessionmaster_icon, 
		CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
		CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
		CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
		CASE WHEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_grammar_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# ELSE sessionmaster_grammar END AS sessionmaster_grammar,
		CASE WHEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_vocabulary,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		u2.user_alias as trainer_alias, u2.user_id as planner_id, u2.user_firstname as planner_firstname,
		u3.user_alias as booker_alias, u3.user_id as booker_id, u3.user_firstname as booker_firstname,
		l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, l.lesson_duration, l.lesson_unbookable, l.lesson_ghost, l.lesson_url,
		ls.status_css, ls.status_bootstrap, ls.status_name_#SESSION.LANG_CODE# as status_name,
		ln.note_id,
		c.cat_id, c.cat_name_#SESSION.LANG_CODE# as cat_name,
		la.subscribed,
		q.quiz_id
		FROM lms_tp t
		INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_level lv ON lv.level_id = s.level_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		<cfif l_by eq "yes">
			AND (l.status_id <> 3 OR l.status_id IS NULL)
		</cfif>
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
		LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
		LEFT JOIN user u ON u.user_id = l.user_id
		LEFT JOIN user u2 ON u2.user_id = l.planner_id
		LEFT JOIN user u3 ON u3.user_id = l.booker_id

		LEFT JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id AND la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		
		WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">

		<cfif isdefined("s_id")>
			AND s.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
		</cfif>

		<cfif isdefined("status")>
			<cfif status eq "past">
				AND l.lesson_start < now()
			<cfelse>
				AND (l.lesson_start IS NULL OR l.lesson_start > now())
			</cfif>
		</cfif>

		<!---<cfif SESSION.USER_PROFILE eq "learner">
			AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		<cfelseif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>--->
		<cfif g_by eq "s_id">
			GROUP BY s.session_id
		</cfif>
		ORDER BY s.session_rank ASC, s.session_id, l.lesson_start
		</cfquery>
		
		<cfreturn get_session> 
		
	</cffunction>


	<cffunction name="oget_session_display" access="remote" returnformat="plain" output="true" description="Construct the TP header">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="no" default="#SESSION.USER_ID#">
		<cfargument name="g_by" type="string" required="no" default="no">
		<cfargument name="l_by" type="string" required="no" default="no">
		<cfargument name="s_id" type="numeric" required="no">
		
		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		t.tp_id, t.tp_name, t.method_id, t.tp_date_end,
		s.session_id, s.session_duration, s.session_rank, s.session_close, s.session_name, s.mapping_id, s.origin_id,
		lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name, lv.level_css,
		sm.sessionmaster_id, sm.sessionmaster_cat_id, sm.module_id, sm.skill_id, sm.keyword_id, sm.grammar_id, sm.sessionmaster_audio_bool, sm.sessionmaster_video_bool, sm.sessionmaster_support_bool, sm.sessionmaster_code, sm.sessionmaster_level, sm.sessionmaster_type, sm.sessionmaster_duration, sm.sessionmaster_url, sm.sessionmaster_ressource, sm.sessionmaster_subtype, sm.sessionmaster_group, sm.sessionmaster_ln_grammar, sm.sessionmaster_ln_vocabulary, sm.sessionmaster_md, sm.sessionmaster_transcript, sm.sessionmaster_video, sm.sessionmaster_el_duration, sm.voc_cat_id, sm.sessionmaster_exercice, sm.sessionmaster_date, sm.sessionmaster_icon, 
		CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
		CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
		CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
		CASE WHEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_grammar_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# ELSE sessionmaster_grammar END AS sessionmaster_grammar,
		CASE WHEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_vocabulary,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		u2.user_alias as trainer_alias, u2.user_id as planner_id, u2.user_firstname as planner_firstname,
		u3.user_alias as booker_alias, u3.user_id as booker_id, u3.user_firstname as booker_firstname,
		l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, l.lesson_duration, l.lesson_unbookable, l.lesson_ghost,
		ls.status_css, ls.status_bootstrap, ls.status_name_#SESSION.LANG_CODE# as status_name,
		ln.note_id,
		c.cat_id, c.cat_name_#SESSION.LANG_CODE# as cat_name,
		la.subscribed,
		q.quiz_id
		FROM lms_tp t
		INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_level lv ON lv.level_id = s.level_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		<cfif l_by eq "yes">
			AND (l.status_id <> 3 OR l.status_id IS NULL)
		</cfif>
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
		LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
		LEFT JOIN user u ON u.user_id = l.user_id
		LEFT JOIN user u2 ON u2.user_id = l.planner_id
		LEFT JOIN user u3 ON u3.user_id = l.booker_id

		LEFT JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id AND la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		
		WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">

		<cfif isdefined("s_id")>
			AND s.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfif>


		<cfif g_by eq "s_id">
			GROUP BY s.session_id
		</cfif>
		ORDER BY s.session_rank ASC, s.session_id, l.lesson_start
		</cfquery>
		
		<div class="scrolling-wrapper row flex-row flex-nowrap mt-3 pb-1 pt-1" id="scroll1">
			<!--- <ul id="sortable"> --->

		<cfoutput query="get_session" group="session_id">
			<cfif lesson_id neq "">
				<div id="a_#dateformat(lesson_start,'yyyy-mm-dd')#_#timeFormat(lesson_start,'hh_mm')#_#planner_id#" class="cursored col-sm-1 border border-danger bg-white p-1 m-1 mb-2 shadow-sm btn_book_lesson" style="line-height:14px !important">
					<div class="d-flex justify-content-between">
						<div class="d-none d-lg-block">
							<img src="./assets/user/#planner_id#/photo.jpg" class="tthumb_#session_rank#" width="30" style="border-radius:50%; border: 2px solid ##8A2128 !important;" align="left">
						</div>
						<div class="ml-2">
							<small><strong class="d-none d-md-block">## #session_rank#</strong></small>
							
							<small>#lsDateTimeFormat(lesson_start,'dd/mm ', 'fr')#</small>				
							<br>
							<small>#lsDateTimeFormat(lesson_start,'HH:nn', 'fr')#</small>
						</div>
						<div class="ml-auto">

							<button class="p-1 btn-link">
								<i class="fa-sharp fa-solid fa-circle-xmark text-red"></i>

							</button>
						</div>
					</div>
					
				</div>
			<cfelse>
				<div id="tr_#session_rank#" class="col-sm-1 border bg-light p-1 m-1 mb-2 shadow-sm" style="line-height:14px !important">
					
					<cfset temp = randrange(1,2)>
					
					<div class="d-flex">
						<div class="d-none d-lg-block">
							<img src="./assets/img/<cfif temp eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" class="tthumb_#session_rank#" width="30" style="border-radius:50%;" align="left">
						</div>
						<div class="ml-2 d-inline">
							<small><strong class="d-none d-md-block">Cours #session_rank#</strong> </small>
						
						<small>#session_duration# min</small>		
						</div>
					</div>
				</div>
			
			</cfif>
        </cfoutput>

			<!--- </ul> --->
		</div>
		
	</cffunction>



	<cffunction name="oget_next_lesson" access="public" returntype="query" output="false" description="Display the next lessson to launch">
	
		<cfargument name="u_id" type="any" required="yes">
		<cfargument name="m_id" type="any" required="no">
		<cfargument name="tp_id" type="any" required="no">
		<cfargument name="subscribed" type="any" required="no">
		
		<cfquery name="get_next_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.planner_id, l.method_id, l.lesson_duration,
		la.attendance_id, la.subscribed,
		m.method_name_#SESSION.LANG_CODE# as method_name,
		tp.tp_id, tp.tp_name, tp.tp_icon, tp.method_id, tp.tp_date_end, tp.tp_max_participants,
		s.session_id, s.session_duration, s.session_rank, s.session_close, s.session_name, s.mapping_id, s.origin_id, s.voc_cat_id as l_voc_cat_id,
		lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name,
		sm.sessionmaster_id, sm.sessionmaster_code,
		f.formation_id, f.formation_code,
		ut.user_alias as trainer_alias, ut.user_id as planner_id, ut.user_firstname as planner_firstname, ut.user_firstname,
		CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
		CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description
		
		FROM lms_lesson2 l
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = tp.tp_id <!---AND tpu.tpuser_active = 1---> AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
		INNER JOIN lms_tpsession s ON l.session_id = s.session_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_level lv ON lv.level_id = tp.level_id
		LEFT JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user ut ON ut.user_id = l.planner_id
		<cfif isdefined("subscribed")>
		INNER JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id AND la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		<cfelse>
		LEFT JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id AND la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		WHERE tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		AND l.lesson_start > #dateadd("n",-15,now())#
		AND (l.status_id = "1" OR l.status_id = "2")

		<cfif isdefined("tp_id")>
		AND tp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
		</cfif>

		<cfif isdefined("m_id")>
		AND l.method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#m_id#">
		</cfif>
		
		ORDER BY l.lesson_start ASC, la.subscribed DESC
		LIMIT 1
		</cfquery>
				
		<cfreturn get_next_lesson> 
		
	</cffunction>


	<cffunction name="get_calendar_invite" access="public" returntype="string" output="false">
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="return_file" type="numeric" required="no" default="1">

        <cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson_without_user">
            <cfinvokeargument name="l_id" value="#l_id#">
            <cfinvokeargument name="all_learner" value="1">
        </cfinvoke>


		<cftry>

		<cfset get_lesson = QueryGetRow(get_lesson_without_user, 1)>

		<cfset ICSContent = "">
		<cfset dir_go = "#SESSION.BO_ROOT#/admin/calendar/#l_id#">
        <cfset CRLF=chr(13)&chr(10)>

        <cfinvoke component="components/translater" method="get_translate" returnVariable="table_th_trainer">
            <cfinvokeargument name="id_translate" value="table_th_trainer">
        </cfinvoke>
        <cfinvoke component="components/translater" method="get_translate" returnVariable="table_th_duration_short">
            <cfinvokeargument name="id_translate" value="table_th_duration_short">
        </cfinvoke>
        <cfinvoke component="components/translater" method="get_translate" returnVariable="table_th_course">
            <cfinvokeargument name="id_translate" value="table_th_course">
        </cfinvoke>

        <cfset ICSContent &= "BEGIN:VCALENDAR" & CRLF>
        <cfset ICSContent &= "VERSION:2.0" & CRLF>
        <cfset ICSContent &= "METHOD:PUBLISH" & CRLF>
        <cfset ICSContent &= "PRODID:-//Wefit Group//Coldfusion 2018//EN" & CRLF>
        <cfset ICSContent &= "BEGIN:VEVENT" & CRLF>
        <cfset ICSContent &= "UID:#l_id&"-"&lstimeformat(now(),'HHnnss', 'fr')#" & CRLF>
        <cfset ICSContent &= "SUMMARY:WEFIT LESSON with #ucase(get_lesson.trainer_firstname)#" & CRLF>
        <cfset ICSContent &= "DESCRIPTION: WEFIT #ucase(get_lesson.method_name)# \n #table_th_trainer# : #ucase(get_lesson.trainer_firstname)# \n #table_th_duration_short# : #get_lesson.lesson_duration#min \n #table_th_course# : #get_lesson.sessionmaster_name#" & CRLF>
        <cfset ICSContent &= "LOCATION:https://lms.wefitgroup.com/" & CRLF>
        <cfset ICSContent &= 'ORGANIZER:MAILTO:service@wefitgroup.com' & CRLF>
        <cfset ICSContent &= "DTSTAMP:#lsdateformat(now(),'yyyymmdd', 'fr')&"T"&lstimeformat(now(),'HHnnss', 'fr')#" & CRLF>
        <cfset ICSContent &= "DTSTART:#lsdateformat(get_lesson.lesson_start,'yyyymmdd', 'fr')&"T"&lstimeformat(get_lesson.lesson_start,'HHnnss', 'fr')#" & CRLF>
        <cfset ICSContent &= "DTEND:#lsdateformat(get_lesson.lesson_end,'yyyymmdd', 'fr')&"T"&lstimeformat(get_lesson.lesson_end,'HHnnss', 'fr')#" & CRLF>
        <cfset ICSContent &= 'CLASS:PUBLIC' & CRLF>
        <cfset ICSContent &= "END:VEVENT" & CRLF>
        <cfset ICSContent &= "END:VCALENDAR" & CRLF>

        <cfif return_file eq 1>

        <cfif not directoryExists(dir_go)>
			
            <cfdirectory directory="#dir_go#" action="create" mode="777">
            
        </cfif>
        
        <cffile
        action = "write" 
        file = "#dir_go#/inv_wefit.ics"
        output = "#ICSContent#"
        nameConflict = "Overwrite"
		mode="777"
        >

        <!--- <cfthread name="delete_file" action="run">
            <cfset sleep(20000)>
            <!--- <cffile action="DELETE" file="#dir_go#"> --->
            <cfdirectory directory="#dir_go#" action="DELETE" recurse="yes">
        </cfthread> --->

		<cfreturn "#dir_go#/inv_wefit.ics">

        <cfelse>
            <cfreturn "#ICSContent#">

        </cfif>
		<cfcatch type="any">
			<cfreturn "0">
		</cfcatch>
		</cftry>

	</cffunction>


</cfcomponent>