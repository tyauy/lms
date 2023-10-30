<cfcomponent>

	
	<cffunction name="oget_learner" access="public" returntype="query" output="true">
	
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="ust_id" type="any" required="no">
		<cfargument name="usty_id" type="any" required="no">
		<cfargument name="st_id" type="any" required="no">
		<cfargument name="m_id" type="any" required="no">
		<cfargument name="pf_id" type="any" required="no">
		<cfargument name="list_learner_account" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">
		<cfargument name="g_id" type="any" required="no">
		<cfargument name="o_by" type="any" required="no">
		<cfargument name="manager_id" type="any" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="limit" type="any" required="no">

		
		<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_phone, u.user_email, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_steps, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, 
		upc.profile_id, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_zh, u.user_qpt_lock_zh,
		u.user_create, u.user_elapsed, u.user_qpt, u.user_lst, u.user_lastconnect, u.user_ctc_cpf, u.user_ctc_formation, u.interest_id, u.avail_id, u.user_needs_nbtrainer,
		a.account_id, a.account_name, g.group_name,
		t.tp_name,
		us.user_status_name_#SESSION.LANG_CODE# as user_status_name, us.user_status_css,
		usty.user_type_name_#SESSION.LANG_CODE# as user_type_name,
		up.profile_name, up.profile_css,
		o.order_id, o.order_ref, o.order_start, o.order_end,
		ofi.status_finance_name, ofi.status_finance_css,
		usi.situation_name_fr
		
		FROM user u 
			
		INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
		LEFT JOIN user_profile up ON up.profile_id = upc.profile_id

		LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
		LEFT JOIN user_type usty ON usty.user_type_id = u.user_type_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN account_group g ON g.group_id = a.group_id
		LEFT JOIN lms_tp t ON t.user_id = u.user_id
		LEFT JOIN orders o ON t.order_id = o.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		LEFT JOIN user_situation usi ON usi.situation_id = u.situation_id 
		
		LEFT JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
		
		WHERE 1 = 1
		
		<cfif isdefined("u_id") AND u_id neq "">
		AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("pf_id") AND pf_id neq "100">
		AND upc.profile_id IN(<cfqueryparam list="yes" cfsqltype="cf_sql_varchar" value="#pf_id#">)
		<cfelseif isdefined("pf_id") AND pf_id eq "100">
		AND upc.profile_id IN(3,9,7)
		</cfif>

		<cfif isdefined("ust_id") AND ust_id neq "100">
		AND u.user_status_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ust_id#" list="yes">)
		</cfif>	

		<cfif isdefined("usty_id") AND usty_id neq "100">
		AND u.user_type_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#usty_id#" list="yes">)
		</cfif>	
		
		<cfif isdefined("p_id") AND p_id neq "0">
			AND p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		
		<cfif isdefined("st_id") AND st_id neq "0" AND st_id neq "100">
		AND t.tp_status_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#st_id#" list="yes">)
		<cfelseif isdefined("st_id") AND st_id eq "0">
		AND t.tp_id IS NULL
		</cfif>
		
		<cfif isdefined("m_id") AND m_id neq "100">
		AND (1 = 2 
		<cfloop list="#m_id#" index="cor">
		OR t.method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfloop>
		)
		</cfif>	
		
		
		<cfif isdefined("a_id")>

		<cfif a_id neq 0 AND listlen(a_id) eq 1>
			AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		<cfelse> 
			AND u.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)
		</cfif>
		
		</cfif>

		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		
		<cfif isdefined("manager_id")>
		AND g.manager_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#manager_id#">
		</cfif>
		
		
		<cfif isdefined("g_id")>
		AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>	
		
		<cfif isdefined("step_id")>
		<cfif step_id eq "0">
		AND u.user_steps = ""
		<cfelse>
		AND u.user_steps = <cfqueryparam cfsqltype="cf_sql_integer" value="#step_id#">
		</cfif>	
		</cfif>	
		
		<cfif isdefined("list_learner_account") AND list_learner_account neq "">
		AND u.user_id IN (#list_learner_account#)
		</cfif>	
		
		<cfif isdefined("tselect")>
			AND DATE_FORMAT(u.user_create, "%Y-%m") = '#tselect#'
		</cfif>
		
		<cfif isdefined("yselect")>
			AND DATE_FORMAT(u.user_create, "%Y") = '#yselect#'
		</cfif>
		
		GROUP BY u.user_id
		
		<cfif isdefined("o_by")>
			<cfif o_by eq "account_id">
				ORDER BY u.account_id, u.user_name
			<cfelseif o_by eq "account_name">
				ORDER BY a.account_name, u.user_name
			<cfelseif o_by eq "creation">
				ORDER BY u.user_create DESC
			<cfelseif o_by eq "name">
				ORDER BY u.user_name ASC
			<cfelseif o_by eq "profile_id">
				ORDER BY upc.profile_id ASC, u.user_name ASC
			</cfif>
		<cfelse>
		ORDER BY u.user_name
		</cfif>
		
		<cfif isdefined("limit")>
		LIMIT #limit#
		</cfif>
		
		</cfquery>
				
		<cfreturn get_learner> 
		
	</cffunction>
	
	
	
	
	<cffunction name="oget_learner_solo" access="public" output="yes">
	
		<cfargument name="u_id" type="numeric" required="yes">

		<cfif listFindNoCase("TRAINER,TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
			<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
			SELECT u.*
			FROM user u
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfquery>
			
			<cfset u_id = get_user.user_id>
			<cfset user_lastname = get_user.user_name>
			<cfset user_email = get_user.user_email>
			<cfset user_alias = get_user.user_alias>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_gender = get_user.user_gender>
			<cfset user_phone = get_user.user_phone>
			<cfset user_jobtitle = get_user.user_jobtitle>
			
			<cfset avail_id = get_user.avail_id>
			<cfset user_based = get_user.user_based>
			<cfset int_id = get_user.interest_id>
			
			<cfset user_needs_course = get_user.user_needs_course>
			<cfset user_needs_trainer = get_user.user_needs_trainer>
			<cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
			<cfset user_needs_frequency = get_user.user_needs_frequency>
			<cfset user_needs_learn = get_user.user_needs_learn>
			<cfset user_needs_complement = get_user.user_needs_complement>
			<cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement>
			<cfset user_needs_theme = get_user.user_needs_theme>
			
			<cfset user_access_tp = get_user.user_access_tp>
			<cfset user_shortlist = get_user.user_shortlist>
			
			<cfloop list="#SESSION.LIST_PT#" index="cor">
			<cfset "user_qpt_#cor#" = evaluate("get_user.user_qpt_#cor#")>
			<cfset "user_qpt_lock_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>
			</cfloop>
			
			<cfreturn get_user> 
			
		<cfelseif SESSION.USER_PROFILE eq "learner">
		
			<cfset u_id = SESSION.USER_ID>
			<cfset user_lastname = SESSION.USER_LASTNAME>
			<cfset user_profile = SESSION.USER_PROFILE>
			<cfset user_email = SESSION.USER_EMAIL>
			<cfset user_alias = SESSION.USER_ALIAS>
			<cfset user_firstname = SESSION.USER_FIRSTNAME>
			<cfset user_gender = SESSION.USER_FIRSTNAME>
			<cfset user_phone = SESSION.USER_PHONE>
			<cfset user_jobtitle = SESSION.USER_JOBTITLE>
			
			<cfset avail_id = SESSION.AVAIL_ID>
			<cfset user_based = SESSION.USER_BASED>
			<cfset int_id = SESSION.INTEREST_ID>
			
			<cfset user_needs_course = SESSION.USER_NEEDS_COURSE>
			<cfset user_needs_trainer = SESSION.USER_NEEDS_TRAINER>
			<cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER>
			<cfset user_needs_frequency = SESSION.USER_NEEDS_FREQUENCY>
			<cfset user_needs_learn = SESSION.USER_NEEDS_LEARN>
			<cfset user_needs_complement = SESSION.USER_NEEDS_COMPLEMENT>
			<cfset user_needs_trainer_complement = SESSION.USER_NEEDS_TRAINER_COMPLEMENT>
			<cfset user_needs_theme = SESSION.USER_NEEDS_THEME>
			
			<cfset user_access_tp = SESSION.USER_ACCESS_TP>
			<cfset user_shortlist = SESSION.USER_SHORTLIST>
			
			<cfloop list="#SESSION.LIST_PT#" index="cor">
			<cfset "user_qpt_#cor#" = evaluate("SESSION.USER_QPT_#cor#")>
			<cfset "user_qpt_lock_#cor#" = evaluate("SESSION.USER_QPT_LOCK_#cor#")>
			</cfloop>
			
		</cfif>
				
	</cffunction>
	
	
	
	
	
	
	
	
	

	
	
	<cffunction name="oget_session_tp" access="public" returntype="query" output="true">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">
		
		<cfquery name="get_session_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		t.tp_id, t.tp_name, t.method_id,
		s.session_id, s.session_duration, s.session_rank, s.session_close, s.session_name,
		sm.sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.sessionmaster_description, sm.sessionmaster_objectives, sm.sessionmaster_grammar, sm.sessionmaster_vocabulary,
		c.cat_id, c.cat_name_#SESSION.LANG_CODE# as cat_name
		FROM lms_tp t
		INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
		ORDER BY s.session_rank ASC, s.session_id
		</cfquery>
		
		<cfreturn get_session_tp> 
		
	</cffunction>
	
	
	<!--- adding user_techno utech JOIN --->
	<cffunction name="oget_lesson" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="all_learner" type="numeric" required="no" default="0">
	
		<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.lesson_duration, l.tp_id, l.planner_id, l.user_id, l.method_id, l.updater_id, l.updater_date, l.booker_id, l.booker_date, l.completed_date,
		utech.user_techno_link as lesson_redirect, utech.user_techno_key as lesson_redirect_key,
		lltech.techno_name_#SESSION.LANG_CODE# as tech_name, techno_icon,
		ul.user_id as learner_id, ul.user_md5 as learner_md5, ul.user_firstname as learner_firstname, ul.user_name as learner_lastname, ul.user_email as learner_email, ul.user_lang as learner_lang, ul.user_phone as learner_phone, ul.user_remind_missed as learner_remind_missed, ul.user_remind_cancelled as learner_remind_cancelled, ul.user_remind_scheduled as learner_remind_scheduled, ul.user_remind_sms_missed as learner_remind_sms_missed, ul.user_remind_sms_scheduled as learner_remind_sms_scheduled,
		ut.user_firstname as trainer_firstname, ut.user_name as trainer_lastname, ut.user_email as trainer_email, ut.user_lang as trainer_lang, ut.user_phone as trainer_phone, ut.user_remind_missed as trainer_remind_missed, ut.user_remind_cancelled as trainer_remind_cancelled, ut.user_remind_scheduled as trainer_remind_scheduled, ut.user_remind_sms_missed as trainer_remind_sms_missed, ut.user_remind_sms_scheduled as trainer_remind_sms_scheduled,
		ub.user_firstname as booker_firstname, ub.user_name as booker_lastname,
		uu.user_firstname as updater_firstname, uu.user_name as updater_lastname,
		c.cat_name_#SESSION.LANG_CODE# as cat_name,		
		sm.sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code, sm.level_id,
		a.account_name, a.account_id, a.group_id, a.provider_id,
		s.session_duration, 
		lla_v.subscribed,
		ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name,
		lm.method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_lesson2 l
		INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		INNER JOIN lms_tp t ON t.tp_id = s.tp_id
		LEFT JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN user ul ON ul.user_id = tpu.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id	
		LEFT JOIN user ub ON ub.user_id = l.booker_id	
		LEFT JOIN user uu ON uu.user_id = l.updater_id	
		LEFT JOIN account a ON a.account_id = ul.account_id
		LEFT JOIN user_techno utech ON utech.user_id = l.planner_id  AND utech.techno_id = t.techno_id 
		LEFT JOIN lms_list_techno lltech ON lltech.techno_id = t.techno_id 
		LEFT JOIN lms_lesson2_attendance lla_v ON lla_v.lesson_id = l.lesson_id AND lla_v.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		<cfif isdefined("u_id") AND all_learner eq 0>
		AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		ORDER BY tpu.is_group_leader DESC
		<cfif all_learner eq 0>
			LIMIT 1
		</cfif>
		</cfquery>
		
		<cfreturn get_lesson>
	
	</cffunction>
	
	<cffunction name="oget_lesson_default_tech" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="yes">

		<cfquery name="get_lesson_default_tech" datasource="#SESSION.BDDSOURCE#">
		SELECT `user_techno_link` as lesson_redirect, `user_techno_key` as lesson_redirect_key, `lms_list_techno`.techno_name_#SESSION.LANG_CODE# as tech_name, `lms_list_techno`.techno_icon 
		FROM `user_techno` LEFT JOIN `lms_list_techno` ON `lms_list_techno`.techno_id = `user_techno`.techno_id
		WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND `user_techno_preferred` = 1 LIMIT 1
		</cfquery>

	<cfreturn get_lesson_default_tech>
	</cffunction>
	
	
	<cffunction name="oget_lesson_details" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="no">
	
		<cfquery name="get_lesson_details" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.lesson_duration, l.tp_id, l.planner_id, l.user_id, l.method_id,
		ul.user_firstname as learner_firstname, ul.user_name as learner_lastname, ul.user_email as learner_email, ul.user_lang as learner_lang, ul.user_phone as learner_phone, ul.user_remind_missed as learner_remind_missed, ul.user_remind_cancelled as learner_remind_cancelled, ul.user_remind_scheduled as learner_remind_scheduled, ul.user_remind_sms_missed as learner_remind_sms_missed, ul.user_remind_sms_scheduled as learner_remind_sms_scheduled,
		ut.user_firstname as trainer_firstname, ut.user_name as trainer_lastname, ut.user_email as trainer_email, ut.user_lang as trainer_lang, ut.user_phone as trainer_phone, ut.user_remind_missed as trainer_remind_missed, ut.user_remind_cancelled as trainer_remind_cancelled, ut.user_remind_scheduled as trainer_remind_scheduled, ut.user_remind_sms_missed as trainer_remind_sms_missed, ut.user_remind_sms_scheduled as trainer_remind_sms_scheduled,
		ub.user_firstname as booker_firstname, ut.user_name as booker_lastname,
		c.cat_name_#SESSION.LANG_CODE# as cat_name,		
		sm.sessionmaster_name, sm.sessionmaster_id,
		a.account_name,
		ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name,
		lm.method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_lesson2 l
		INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = l.sm_id
		LEFT JOIN lms_tpsession_category c ON sm.sessionmaster_cat_id = c.cat_id AND c.cat_public = 1
		INNER JOIN lms_tp t ON t.tp_id = l.tp_id
		LEFT JOIN user ul ON ul.user_id = l.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id	
		LEFT JOIN user ub ON ub.user_id = l.booker_id	
		LEFT JOIN account a ON a.account_id = ul.account_id
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		</cfquery>
		
		<cfreturn get_lesson_details> 
	
	</cffunction>
	
	
	
	
	<cffunction name="oget_lessonnote" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="lang" type="string" required="no">

		<cfif not isDefined("lang")>
			<cfquery name="get_lang" datasource="#SESSION.BDDSOURCE#">
				SELECT f.formation_code FROM lms_lesson2 l 
				LEFT JOIN lms_tp t ON t.tp_id = l.tp_id 
				LEFT JOIN lms_formation f ON f.formation_id = t.formation_id 
				WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
			</cfquery>

			<cfif get_lang.recordCount eq 0>
				<cfset _lang = "en">
			<cfelse>
				<cfif get_lang.formation_code eq "fr" OR get_lang.formation_code eq "en" OR get_lang.formation_code eq "de" OR get_lang.formation_code eq "es" OR get_lang.formation_code eq "it">
					<cfset _lang = lcase(get_lang.formation_code)>
				<cfelse>
					<cfset _lang = "en">
				</cfif>

			</cfif>
		<cfelse>
			<cfif lang neq "fr" AND lang neq "en" AND lang neq "de" AND lang neq "es" AND lang neq "it">
				<cfset _lang = "en">
			<cfelse>
				<cfset _lang = lang>
			</cfif>
		</cfif>

	
		<cfquery name="get_lessonnote" datasource="#SESSION.BDDSOURCE#">
		SELECT ln.note_id, ln.lesson_intro, ln.lesson_main, ln.lesson_grammar, ln.lesson_vocabulary, ln.lesson_add_misc, ln.lesson_add_vocabulary, ln.lesson_add_correction, ln.lesson_feedback, ln.lesson_homework, ln.lesson_footer, ln.lesson_date, ln.lesson_open_main, ln.lesson_open_ressources, ln.lesson_na_needs, ln.lesson_na_improve, ln.lesson_na_workon, ln.lesson_lock, ln.keyword_id as ln_keyword_id, ln.skill_id as ln_skill_id, ln.grammar_id as ln_grammar_id, ln.lesson_pta_initial, ln.lesson_pta_achievement,
		t.tp_id, t.tp_name, t.formation_id,
		s.session_id, s.session_duration, s.session_rank, s.session_close, s.sessionmaster_id, s.skill_id as s_skill_id,
		(CASE WHEN sm.sessionmaster_name_#_lang# <> "" THEN sm.sessionmaster_name_#_lang# ELSE sm.sessionmaster_name END) AS sessionmaster_name, 
		(CASE WHEN sm.sessionmaster_description_#_lang# <> "" THEN sm.sessionmaster_description_#_lang# ELSE sm.sessionmaster_description END) AS sessionmaster_description, 
		sm.sessionmaster_code, sm.keyword_id as sm_keyword_id, sm.skill_id as sm_skill_id, sm.grammar_id as sm_grammar_id, sm.sessionmaster_ln_vocabulary, sm.sessionmaster_ln_grammar, sm.sessionmaster_objectives, sm.sessionmaster_grammar, sm.sessionmaster_vocabulary,
		lm.method_name_#SESSION.LANG_CODE# as method_name,
		f.formation_name_en as formation_name,
		u2.user_alias as trainer_alias, u2.user_id as planner_id, u2.user_firstname as planner_firstname,
		u.user_firstname, u.user_name, u.user_id, u.interest_id as u_keyword_id, u.user_needs_learn as u_skill_id, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de,
		l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, l.method_id, l.lesson_duration, l.lesson_id as lesson_id,
		ls.status_css, ls.status_bootstrap, ls.status_name_#SESSION.LANG_CODE# as status_name,
		tm.tpmaster_type
		FROM lms_lesson2 l
		INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		INNER JOIN lms_tp t ON t.tp_id = s.tp_id
		INNER JOIN lms_formation f ON f.formation_id = t.formation_id	
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpmastercor2 tmc ON tmc.sessionmaster_id = sm.sessionmaster_id
		LEFT JOIN lms_tpmaster2 tm ON tm.tpmaster_id = tmc.tpmaster_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id	
		LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
		INNER JOIN account a ON a.account_id = u.account_id
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
		LIMIT 1
		</cfquery>
		
		<cfreturn get_lessonnote> 
	
	</cffunction>
	
	
	
	
	<cffunction name="oget_lessons" access="public" returntype="query" output="true">
		<cfargument name="st_id" type="any" required="no">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="t_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">
		<cfargument name="g_id" type="any" required="no">
		
		<cfargument name="start_range" type="date" required="no">
		<cfargument name="end_range" type="date" required="no">
		<cfargument name="period_month" type="any" required="no">
		
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		
		<cfargument name="orderby" type="any" required="no">
		<cfargument name="tosign" type="any" required="no">
		<cfargument name="ghosted" type="any" required="no" default="0">
		<cfargument name="pmissed" type="any" required="no" default="0">
		<cfargument name="invoicing" type="any" required="no" default="0">
		<cfargument name="tm" type="any" required="no" default="0">

		<cfquery name="get_lessons" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_firstname, u.user_name, u.user_id, 
		up.profile_name, 
		u2.user_alias, u2.user_id as planner_id, u2.user_firstname as planner_firstname, u2.user_temp_alias as planner_temp_firstname,
		l.lesson_id, l.method_id, l.tp_id, l.lesson_start, l.completed_date, l.lesson_duration, l.status_id, l.lesson_end,
		a.account_name, ap.provider_name, ap.provider_id,
		sm.sessionmaster_name, sm.sessionmaster_ressource, sm.sessionmaster_id,
		tp.*,
		ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name, 
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias,
		cat.cat_name_#SESSION.LANG_CODE# as cat_name, cat.cat_id,
		f.formation_code,
		o.order_ref,
		ln.note_id, ln.lesson_lock,
		lla_v.subscribed,
		<cfif isdefined("tosign")>
			lla.attendance_id, lla.signature_base64,
		</cfif>
		<cfif invoicing neq "0">
			uprice.pricing_amount, uprice.pricing_currency,
		</cfif>
		tpd.*,
		tpc.*,
		tpe.*
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category cat ON cat.cat_id = sm.sessionmaster_cat_id AND cat.cat_public = 1
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		LEFT JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id

		LEFT JOIN user_profile_cor upc ON u.user_id = upc.user_id
		LEFT JOIN user_profile up ON up.profile_id = upc.profile_id

		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN account_group ag ON a.group_id = ag.group_id
		LEFT JOIN account_provider ap ON ag.provider_id = ap.provider_id
		LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
		LEFT JOIN orders o ON o.order_id = tp.order_id
		<cfif invoicing neq "0">
			LEFT JOIN user_pricing uprice ON uprice.user_id = u2.user_id 
			AND uprice.formation_id = tp.formation_id
			AND uprice.pricing_cat = sm.sessionmaster_cat_id
			AND uprice.pricing_method = l.method_id
		</cfif>
		
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = tp.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = tp.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = tp.elearning_id
		
		LEFT JOIN lms_lesson2_attendance lla_v ON lla_v.lesson_id = l.lesson_id AND lla_v.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

		<cfif isdefined("tosign")>
			LEFT JOIN lms_lesson2_attendance lla ON lla.lesson_id = l.lesson_id AND lla.user_id = l.user_id
		</cfif>

		WHERE l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		
		<cfif ghosted eq "0">
			AND (lesson_ghost != 1 OR lesson_ghost IS NULL)
		</cfif>

		<cfif tm eq "1">
			AND u.user_hide_report_all != 1
			AND !(u.user_hide_report_free_remain = 1 AND tp.order_id = 3)
		</cfif>


		<cfif isdefined("st_id") AND listlen(st_id) neq "0" AND st_id neq "0">
		AND ( l.status_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#st_id#" list="true">)
		<cfif pmissed neq "0">
			OR (l.status_id = 4 AND u2.user_paid_missed = 1)
		</cfif>
		)
		<cfelse>
			AND l.status_id <> 3
			<cfif pmissed neq "0">
				AND (l.status_id <> 4 OR (l.status_id = 4 AND u2.user_paid_missed = 1))
			</cfif>
		</cfif>

		
		
		<cfif isdefined("u_id")>
			AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("t_id")>
			AND tp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfif>
		
		<cfif isdefined("p_id") AND p_id neq "0">
			AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
	
		
		<cfif invoicing neq "0">

			<cfif isdefined("period_month") AND period_month neq "all">
				AND DATE_FORMAT(l.completed_date, "%Y-%m") = '#period_month#'
			</cfif>
		
			<cfif isdefined("start_range")>
				AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") >= '#dateformat(start_range,'yyyy-mm-dd')#'
			</cfif>
			
			<cfif isdefined("end_range")>
				AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") <= '#dateformat(end_range,'yyyy-mm-dd')#'
			</cfif>
			
			<cfif isdefined("tselect")>
				AND DATE_FORMAT(l.completed_date, "%Y-%m") = '#tselect#'
			</cfif>
			
			<cfif isdefined("yselect")>
				AND DATE_FORMAT(l.completed_date, "%Y") = '#yselect#'
			</cfif>

		<cfelse>

			<cfif isdefined("period_month") AND period_month neq "all">
				AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#period_month#'
			</cfif>

			<cfif isdefined("start_range")>
				AND DATE_FORMAT(l.lesson_start, "%Y-%m-%d") >= '#dateformat(start_range,'yyyy-mm-dd')#'
			</cfif>

			<cfif isdefined("end_range")>
				AND DATE_FORMAT(l.lesson_start, "%Y-%m-%d") <= '#dateformat(end_range,'yyyy-mm-dd')#'
			</cfif>

			<cfif isdefined("tselect")>
				AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
			</cfif>

			<cfif isdefined("yselect")>
				AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
			</cfif>
		</cfif>
		
		
		<cfif isdefined("a_id") AND a_id neq "">
			<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			AND u.account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
			<cfelseif SESSION.USER_PROFILE eq "TM">
			AND u.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">)
			</cfif>
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		
		<cfif isdefined("g_id") AND g_id neq "">
			AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		
		<cfif isdefined("tosign")>
			AND (l.lesson_signed = 0 OR lla.lesson_signed IS NULL OR lla.lesson_signed <> 1)
		</cfif>
		
		GROUP BY l.lesson_id
		
		<cfif isdefined("orderby")>
		<cfif orderby eq "trainer_firstname">
		ORDER BY u2.user_temp_alias ASC
		<cfelseif orderby eq "trainer">
		ORDER BY u2.user_firstname ASC
		<cfelseif orderby eq "learner_name">
		ORDER BY u.user_name ASC
		<cfelse>
		ORDER BY lesson_start ASC
		</cfif>
		<cfelse>
		ORDER BY lesson_start DESC
		</cfif>
		
		
		</cfquery>
		
		<cfreturn get_lessons> 
	
	</cffunction>
	
	
	
	<cffunction name="oget_lessons_all" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">

		<cfquery name="get_lessons_all" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id <> 3
		</cfquery>
		
		<cfreturn get_lessons_all> 
	
	</cffunction>
	
	<cffunction name="oget_lessons_scheduled" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="select_start" type="any" required="no">
		<cfargument name="select_end" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">

		
		<cfquery name="get_lessons_scheduled" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("select_end") AND isdefined("select_end")>
		AND l.lesson_start BETWEEN '#select_start#' AND '#select_end#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id = 1
		</cfquery>
		
		<cfreturn get_lessons_scheduled> 
	
	</cffunction>
	
	
	
	
	
	
	
	<cffunction name="oget_lessons_inprogress" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="select_start" type="any" required="no">
		<cfargument name="select_end" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">

		
		<cfquery name="get_lessons_inprogress" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("select_end") AND isdefined("select_end")>
		AND l.lesson_start BETWEEN '#select_start#' AND '#select_end#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id = 2
		</cfquery>
		
		<cfreturn get_lessons_inprogress> 
	
	</cffunction>
	
	
	
	<cffunction name="oget_lessons_cancelled" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">


		<cfquery name="get_lessons_cancelled" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id = 3
		</cfquery>
		
		<cfreturn get_lessons_cancelled> 
	
	</cffunction>
	
	
	
	<cffunction name="oget_lessons_missed" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="select_start" type="any" required="no">
		<cfargument name="select_end" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">

		
		<cfquery name="get_lessons_missed" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("select_end") AND isdefined("select_end")>
		AND l.lesson_start BETWEEN '#select_start#' AND '#select_end#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id = 4
		</cfquery>
		
		<cfreturn get_lessons_missed> 
	
	</cffunction>
	
	<cffunction name="oget_lessons_completed" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="tselect" type="any" required="no">
		<cfargument name="yselect" type="any" required="no">
		<cfargument name="select_start" type="any" required="no">
		<cfargument name="select_end" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="list_account" type="any" required="no">


		<cfquery name="get_lessons_completed" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u ON u.user_id = l.user_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		WHERE l.user_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
		<cfif isdefined("u_id")>
		AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("p_id") AND p_id neq "0">
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		<cfif isdefined("tselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#'
		</cfif>
		<cfif isdefined("yselect")>
		AND DATE_FORMAT(l.lesson_start, "%Y") = '#yselect#'
		</cfif>
		<cfif isdefined("select_end") AND isdefined("select_end")>
		AND l.lesson_start BETWEEN '#select_start#' AND '#select_end#'
		</cfif>
		<cfif isdefined("a_id") AND a_id neq "">
		<cfif a_id neq 0>AND u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif> AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
			<cfif list_account eq 0>
				AND u.account_id IN (<cfqueryparam value="#SESSION.USER_ACCOUNT_RIGHT_ID#" cfsqltype="cf_sql_integer" list="yes">)
			<cfelse>
				AND u.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
			</cfif>
		</cfif>
		AND l.status_id = 5
		AND (l.lesson_ghost != 1 OR l.lesson_ghost IS NULL)
		</cfquery>
		
		<cfreturn get_lessons_completed> 
	
	</cffunction>
	
	
	
	
	
	
	
	
	
	<cffunction name="oget_lesson_light" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
	
		<cfquery name="get_lesson_light" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_start, l.lesson_end, l.lesson_duration, lm.method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_lesson2 l
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
		</cfquery>
		
		<cfreturn get_lesson_light> 
	
	</cffunction>
			
			
	<cffunction name="oget_session_solo" access="public" returntype="query" output="true">
		<cfargument name="s_id" type="numeric" required="yes">
	
		<cfquery name="get_session_solo" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		s.method_id, s.session_duration, s.keyword_id, s.session_name, s.skill_id, s.expertise_id, s.grammar_id, s.level_id, s.mapping_id, s.tp_id, s.origin_id,
		sm.sessionmaster_id, sm.sessionmaster_name,
		lm.method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_tpsession s
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id		
		INNER JOIN lms_lesson_method lm ON lm.method_id = s.method_id
		
		WHERE s.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#"> 
		</cfquery>
		
		<cfreturn get_session_solo> 
	
	</cffunction>	
	
	<cffunction name="oget_session_description" access="public" returntype="query" output="true">
		<cfargument name="s_id" type="numeric" required="no">
		<cfargument name="sm_id" type="numeric" required="no">
	
		<cfquery name="get_session_description" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		sm.sessionmaster_id, sm.sessionmaster_cat_id, sm.module_id, sm.module_id, sm.voc_cat_id, sm.keyword_id, sm.grammar_id, sm.sessionmaster_audio_bool, sm.sessionmaster_video_bool, sm.sessionmaster_support_bool, sm.sessionmaster_code, sm.sessionmaster_level, sm.sessionmaster_type, sm.sessionmaster_duration, sm.sessionmaster_url, sm.sessionmaster_ressource, sm.sessionmaster_subtype, sm.sessionmaster_group, sm.sessionmaster_ln_grammar, sm.sessionmaster_ln_vocabulary, sm.sessionmaster_md, sm.sessionmaster_transcript, sm.sessionmaster_video, sm.sessionmaster_el_duration, sm.sessionmaster_exercice, sm.sessionmaster_date, sm.sessionmaster_icon, 
		
		CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
		CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
		CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
		CASE WHEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_grammar_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# ELSE sessionmaster_grammar END AS sessionmaster_grammar,
		CASE WHEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_vocabulary,
		
		COUNT(q.quiz_id) as quiz_id,
		ue.sm_elapsed, ue.sm_lastview
		FROM lms_tpsessionmaster2 sm
		LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
		LEFT JOIN user_elapsed ue ON ue.sm_id = sm.sessionmaster_id	AND ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		<cfif isdefined("s_id")>
		INNER JOIN lms_tpsession s ON sm.sessionmaster_id = s.sessionmaster_id
		WHERE s.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#"> 
		<cfelseif isdefined("sm_id")>
		WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> 
		</cfif>
		GROUP BY sm.sessionmaster_id
		</cfquery>
		
		<cfreturn get_session_description> 
	
	</cffunction>

	<cffunction name="oget_lesson_description" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="sm_id" type="numeric" required="yes">
	
		<cfquery name="get_lesson_description" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		sm.*		
		FROM lms_tpsessionmaster2 sm
		INNER JOIN lms_tpsession s ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_lesson2 l ON l.session_id = s.session_id
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
		</cfquery>
		
		<cfreturn get_lesson_description> 
	
	</cffunction>
	
		
	<cffunction name="oget_session_lesson_description" access="public" returntype="query" output="true">
		<cfargument name="sm_id" type="numeric" required="yes">
		<cfargument name="l_id" type="numeric" required="yes">
	
		<cfquery name="oget_session_lesson_description" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		sm.sessionmaster_md, sm.sessionmaster_description, sm.sessionmaster_ressource, sm.sessionmaster_duration, sm.sessionmaster_objectives, sm.sessionmaster_grammar, sm.sessionmaster_vocabulary,
		sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_ln_grammar, sm.sessionmaster_ln_vocabulary,
		COUNT(q.quiz_id) as quiz_id,
		l.lesson_elapsed
		FROM lms_tpsessionmaster2 sm
		INNER JOIN lms_lesson2 l ON l.sm_id = sm.sessionmaster_id
		LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
		WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> AND l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>
		
		<cfreturn oget_session_lesson_description> 
	
	</cffunction>
	
	<cffunction name="oget_planner" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="p_list" type="any" required="no">
	
		<cfquery name="get_planner" datasource="#SESSION.BDDSOURCE#">
		SELECT u.*, s.user_status_trainer_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css,
		tz.timezone_text as user_timezone,
		c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
		t.user_type_name_#SESSION.LANG_CODE# as user_type_name
		FROM user u
		LEFT JOIN settings_timezone tz ON u.timezone_id = tz.timezone_id
		LEFT JOIN settings_country c ON c.country_id = u.country_id
		LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
		LEFT JOIN user_type t ON t.user_type_id = u.user_type_id
		<cfif isdefined("p_id")>
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		<cfelseif isdefined("p_list") AND listlen(p_list) gt 0>
		WHERE user_id IN (#p_list#) ORDER BY FIELD(user_id,#p_list#)
		<cfelse>
		WHERE 1 = 0
		</cfif>
		</cfquery> 
		
		<cfreturn get_planner> 
	
	</cffunction>
	
	
	
	
	<!----------------------------- QUERIES FOR USER DETAILS ---------------------->
	<cffunction name="oget_speaking" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_speaking" datasource="#SESSION.BDDSOURCE#">
		SELECT s.*, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_code,
		l.level_name_#SESSION.LANG_CODE# as level_name, l.level_alias
		FROM user_speaking s
		INNER JOIN lms_formation f ON f.formation_id = s.formation_id
		LEFT JOIN lms_level l ON l.level_id = s.level_id
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		ORDER BY level_id DESC
		</cfquery>
		
		<cfreturn get_speaking> 
	
	</cffunction>
	
	<cffunction name="oget_teaching" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_teaching" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_code, lfa.formation_accent_name_#SESSION.LANG_CODE# as accent_name
		FROM user_teaching t
		INNER JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_formation_accent lfa ON t.accent_id = lfa.formation_accent_id
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<cfreturn get_teaching> 
	
	</cffunction>
	
	<cffunction name="oget_personnality" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">

		<cfquery name="get_personnality" datasource="#SESSION.BDDSOURCE#">

		SELECT p.perso_name_#SESSION.LANG_CODE# as perso_name,
		p.perso_id,
		up.user_id
		FROM user_personality_index p

		LEFT JOIN user_personality up ON p.perso_id = up.personality_id
		AND up.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">

        GROUP BY p.perso_id
		
		</cfquery>
		
		<cfreturn get_personnality> 
	
	</cffunction>
	
	<cffunction name="oget_country" access="public" returntype="query" output="true">
		<cfargument name="country_id" type="any" required="no">
		<cfargument name="p_id" type="numeric" required="no">

		<cfquery name="get_country" datasource="#SESSION.BDDSOURCE#">
		SELECT c.country_name_#SESSION.LANG_CODE# as country_name FROM settings_country c

		<cfif isdefined("country_id") AND country_id neq "">
		WHERE country_id IN (#country_id#)
		<cfelseif isdefined("p_id")>
		WHERE country_id IN (SELECT country_id FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
		<cfelse>
		WHERE 1 = 2
		</cfif>

		</cfquery>
		
		<cfreturn get_country> 
	
	</cffunction>
	
	<cffunction name="oget_method" access="public" returntype="query" output="true">
		<cfargument name="method_id" type="any" required="no">
		<cfargument name="p_id" type="numeric" required="no">

		<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
		SELECT m.method_name_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method m
		
		<cfif isdefined("method_id") AND method_id neq "">
		WHERE method_id IN (#method_id#)
		<cfelseif isdefined("p_id")>
		WHERE method_id IN (SELECT method_id FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
		<cfelse>
		WHERE 1 = 2
		</cfif>

		</cfquery>
		
		<cfreturn get_method> 
	
	</cffunction>
	
	
	<cffunction name="oget_interest" access="public" returntype="query">
		<cfargument name="interest_id" type="any" required="no">
		<cfargument name="p_id" type="numeric" required="no">

		<cfquery name="get_user_interest" datasource="#SESSION.BDDSOURCE#">
			SELECT interest_id FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		<cfset int_list = "">
		<cfif get_user_interest.recordCount GT 0>
			<cfset tmp = QueryGetRow(get_user_interest, 1)>
			<cfset int_list = tmp.interest_id>
		</cfif>
	
		<cfquery name="get_interest" datasource="#SESSION.BDDSOURCE#">
		SELECT i.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword i
		WHERE keyword_cat_id = 3
		<cfif isdefined("interest_id") AND interest_id neq "">
		AND keyword_id IN (#interest_id#)
		<cfelseif isdefined("p_id") and int_list neq "">
		AND keyword_id IN (#int_list#)
		<cfelse>
		AND 1 = 2
		</cfif>
		ORDER BY keyword_name ASC
		</cfquery>
		
		<cfreturn get_interest> 
	
	</cffunction>

	<cffunction name="oget_function" access="public" returntype="query">
		<cfargument name="function_id" type="any" required="no">
		<cfargument name="p_id" type="numeric" required="no">

		<cfquery name="get_user_interest" datasource="#SESSION.BDDSOURCE#">
			SELECT function_id FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		<cfset int_list = "">
		<cfif get_user_interest.recordCount GT 0>
			<cfset tmp = QueryGetRow(get_user_interest, 1)>
			<cfset int_list = tmp.function_id>
		</cfif>
	
		<cfquery name="get_function" datasource="#SESSION.BDDSOURCE#">
		SELECT i.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword i
		WHERE keyword_cat_id in (4,5)

		<cfif isdefined("function_id") AND function_id neq "">
		AND keyword_id IN (#function_id#)
		<cfelseif isdefined("p_id") and int_list neq "">
		AND keyword_id IN (#int_list#)
		<cfelse>
		AND 1 = 2
		</cfif>

		ORDER BY keyword_name ASC

		</cfquery>
		
		<cfreturn get_function> 
	
	</cffunction>
	

	<cffunction name="oget_certif" access="public" returntype="query" output="true">
		<cfargument name="certif_id" type="any" required="no">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="exclude_ol" type="numeric" required="no" default="0">

		<cfquery name="get_certif" datasource="#SESSION.BDDSOURCE#">

		SELECT llc.certif_name, llc.certif_id, uc.user_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_code
		FROM lms_list_certification llc

		INNER JOIN lms_formation f ON f.formation_id = llc.formation_id
		INNER JOIN user_certif uc ON llc.certif_id = uc.certif_id AND uc.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">

		<cfif exclude_ol neq 0>
			INNER JOIN user_teaching ut ON ut.formation_id = llc.formation_id AND ut.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">

			WHERE certif_parent_id IS NULL
		</cfif>
		
		</cfquery>
		
		<!--- 		SELECT c.certif_name
		FROM lms_list_certification c

		<cfif isdefined("certif_id") AND certif_id neq "">
		WHERE certif_id IN (#certif_id#)
		<cfelseif isdefined("p_id")>
		WHERE certif_id IN (SELECT certif_id FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
		<cfelse>
		WHERE 1 = 2
		</cfif> --->

		<cfreturn get_certif> 
	
	</cffunction>

	<cffunction name="oget_expertise_business" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_expertise_business" datasource="#SESSION.BDDSOURCE#">
		SELECT e.*, k.keyword_name_#SESSION.LANG_CODE# as keyword_name
		FROM user_expertise_business e
		INNER JOIN lms_keyword k ON k.keyword_id = e.keyword_id
		WHERE e.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		ORDER BY keyword_name ASC
		</cfquery>
		
		<cfreturn get_expertise_business> 
	
	</cffunction>

	<cffunction name="oget_cursus" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_cursus" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM user_cursus
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		ORDER BY cursus_start DESC
		</cfquery>
		
		<cfreturn get_cursus> 
	
	</cffunction>
	
	<cffunction name="oget_experience" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_experience" datasource="#SESSION.BDDSOURCE#">
		SELECT experience_id, experience_start, experience_end, experience_today, 
		CASE WHEN experience_title_#SESSION.LANG_CODE# != "" THEN experience_title_#SESSION.LANG_CODE# ELSE experience_title_en END AS experience_title, 
		CASE WHEN experience_description_#SESSION.LANG_CODE# != "" THEN experience_description_#SESSION.LANG_CODE# ELSE experience_description_en END AS experience_description, 
		experience_localisation 
		FROM user_experience
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		ORDER BY experience_start DESC
		</cfquery>
		
		<cfreturn get_experience> 
	
	</cffunction>
	
	<cffunction name="oget_techno" access="public" returntype="query" output="true">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="techno_id" type="numeric" required="no">
	
		<cfquery name="get_techno" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*, ut.user_techno_link, ut.user_techno_key, ut.user_techno_preferred 
		FROM user_techno ut
		INNER JOIN lms_list_techno t ON t.techno_id = ut.techno_id
		WHERE ut.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		<cfif isdefined("techno_id")>
		AND t.techno_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#techno_id#">
		</cfif>
		</cfquery>
		
		<cfreturn get_techno> 
	
	</cffunction>
	
	<cffunction name="oget_about" access="public" returntype="query">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_about" datasource="#SESSION.BDDSOURCE#">
		SELECT ua.*, uaq.about_question_#SESSION.LANG_CODE# as quest
		FROM user_about ua
		INNER JOIN user_about_question uaq ON uaq.user_about_question_id=ua.user_about_type
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
		ORDER BY user_about_type
		</cfquery>
		
		<cfreturn get_about> 
	
	</cffunction>

	<cffunction name="oget_paragraph" access="public" returntype="query">
		<cfargument name="p_id" type="numeric" required="yes">
	
		<cfquery name="get_paragraph" datasource="#SESSION.BDDSOURCE#">
			SELECT user_about_desc, user_about_id
			FROM user_about
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND user_about_type = 0
		</cfquery>
		
		<cfreturn get_paragraph> 
	
	</cffunction>
	
	
	<cffunction name="oget_user" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="yes">

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT u.*, a.account_name, a.account_id, a.group_id, upc.profile_id, up.profile_name
		FROM user u
		INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
		INNER JOIN user_profile up ON upc.profile_id = up.profile_id
		LEFT JOIN account a ON a.account_id = u.account_id
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery> 
		
		<cfreturn get_user> 
	
	</cffunction>
	
	<cffunction name="oget_learner_trainer" access="public" returntype="query">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="ust_id" type="any" required="no">

		<cfquery name="get_learner_trainer" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_id, u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, us.user_status_name_#SESSION.LANG_CODE# as user_status_name, u.user_status_id
		FROM user u
		INNER JOIN lms_tpuser tu ON tu.user_id = u.user_id AND tu.tpuser_active = 1
		INNER JOIN lms_tpplanner p ON (tu.tp_id = p.tp_id AND p.active = 1 AND p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
		INNER JOIN user_status us ON us.user_status_id = u.user_status_id
		 
		<cfif isdefined("ust_id") AND ust_id neq "100">
			WHERE u.user_status_id IN (#ust_id#)
		</cfif>	
		
		ORDER BY u.user_status_id, u.user_firstname
		</cfquery>
		
		<cfreturn get_learner_trainer> 
	
	</cffunction>	
	
	
	<cffunction name="oget_trainer_learner" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="yes">

		<cfquery name="get_learner_trainer" datasource="#SESSION.BDDSOURCE#">
			SELECT u.user_id, u.user_firstname, u.user_name
			FROM user u
			INNER JOIN lms_tpplanner p ON u.user_id = p.planner_id AND p.active = 1
			INNER JOIN lms_tpuser tu ON tu.tp_id = p.tp_id AND tu.tpuser_active = 1
			WHERE (tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND u.user_id <> 2656 AND u.user_id <> 201)
		</cfquery>
		
		<cfreturn get_learner_trainer> 
	
	</cffunction>
	
	
	<cffunction name="oget_trainer_tp" access="public" returntype="query" output="true">
		<cfargument name="t_id" type="numeric" required="yes">

		<cfquery name="get_trainer_tp" datasource="#SESSION.BDDSOURCE#">
			SELECT u.user_id, u.user_firstname, u.user_name, u.user_blocker
			FROM lms_tpplanner p 
			INNER JOIN user u ON p.planner_id = u.user_id 
			WHERE p.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			AND active = 1
		</cfquery>
		
		<cfreturn get_trainer_tp> 
	
	</cffunction>
	

	
	
	


	<cffunction name="oget_task" access="public" returntype="query" output="true">
		<cfargument name="tk_id" type="numeric" required="no">

		<cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*, tt.*, sender.user_firstname as sender, recipient.user_firstname as recipient, lo.*
		FROM task t 
		INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
		LEFT JOIN user sender ON t.from_id = sender.user_id
		LEFT JOIN user recipient ON t.to_id = recipient.user_id
		
		LEFT JOIN logs lo ON lo.task_id = t.task_id
		
		WHERE 1 = 1
		<cfif isdefined("tk_id")>
		AND t.task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tk_id#">
		</cfif>
		</cfquery>
		
		<cfreturn get_task> 
	
	</cffunction>
	
	
	<cffunction name="oget_log" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="category" type="any" required="no">
		<cfargument name="o_by" type="any" required="no">
		<cfargument name="profile_id" type="any" required="no">
		<cfargument name="log_status" type="any" required="no">

		<cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
		SELECT lo.*, f.user_firstname as sender, t.user_firstname as recipient, tt.task_type_name, tt.task_color, tt.task_category, u.user_firstname as user_firstname, u.user_name as user_name
		FROM logs lo
		LEFT JOIN task_type tt ON tt.task_type_id = lo.task_type_id 
		LEFT JOIN user f ON lo.from_id = f.user_id
		LEFT JOIN user t ON lo.to_id = t.user_id
		LEFT JOIN user u ON lo.user_id = u.user_id
		WHERE 1 = 1
		
		<cfif isdefined("u_id") AND u_id neq "0">
		AND lo.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("a_id") AND a_id neq "0">
		AND lo.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>

		<cfif isdefined("g_id") AND g_id neq "0">
		AND lo.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		
		<cfif isdefined("o_id")>
		AND lo.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfif>
		
		<cfif isdefined("log_status")>
		<cfif log_status eq "1">
		AND lo.log_status = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_status#">
		<cfelse>
		AND lo.log_status IS NULL
		</cfif>
		
		</cfif>
		
		<cfif isdefined("category")>
		AND tt.task_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#category#">
		</cfif>
		<cfif isdefined("profile_id")>
		AND (1 = 2
		<cfloop list="#profile_id#" index="cor">
		OR FIND_IN_SET(#cor#,lo.profile_id)
		</cfloop>
		)
		</cfif>
		
		<cfif isdefined("o_by")>
		<cfif o_by eq "log_remind">
		ORDER BY lo.log_remind ASC
		<cfelse>
		ORDER BY lo.log_date DESC
		</cfif>		
		</cfif>
		
		</cfquery>
		
		<cfreturn get_log> 
	
	</cffunction>
	
	
	<cffunction name="oget_tasks" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="task_group" type="any" required="no">
		<cfargument name="a_id" type="numeric" required="no">

		<cfquery name="get_tasks" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*, tt.*, sender.user_firstname as sender, recipient.user_firstname as recipient, ac.*
		FROM task t 
		INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
		LEFT JOIN account_contact ac ON ac.contact_id = t.contact_id
		LEFT JOIN user sender ON t.from_id = sender.user_id
		LEFT JOIN user recipient ON t.to_id = recipient.user_id
		
		WHERE 1 = 1
		<cfif isdefined("u_id")>
		AND t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		<cfif isdefined("task_group")>
		AND tt.task_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#">
		</cfif>
		<cfif isdefined("a_id")>
		AND t.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>

	
		</cfquery>
		
		<cfreturn get_tasks> 
	
	</cffunction>
	
	
	<cffunction name="oget_account_tm" access="public" returntype="query" output="true">
		<cfargument name="list_account" type="any" required="no">
		
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		a.account_id, a.account_name
		FROM account a 
		WHERE account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
		</cfquery>
		
		<cfreturn get_account> 
		
	</cffunction>
	
	
	<cffunction name="oget_account" access="public" returntype="query" output="true">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="a_list" type="any" required="no">
		
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_name, a.account_address, a.account_address2, a.account_postal, a.account_city,
		c.country_name_#SESSION.LANG_CODE# as account_country 
		FROM account a
		LEFT JOIN settings_country c ON c.country_id = a.account_country
		WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		<cfif isdefined("a_list")>AND a.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)</cfif>
		</cfquery>
		
		<cfreturn get_account> 
		
	</cffunction>
	
	
	<!--- TODO user_id de order used qqpart --->
	
	<cffunction name="oget_orders" access="public" returntype="query" output="true">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="s_id" type="numeric" required="no">
		<cfargument name="y_id" type="numeric" required="no">
		<cfargument name="list_account" type="any" required="no">
		<cfargument name="st_tm_id" type="numeric" required="no">
		<cfargument name="manager_id" type="numeric" required="no">
		<cfargument name="c_id" type="numeric" required="no">
		
		<cfargument name="alert_close" type="numeric" required="no">
		<cfargument name="alert_dead" type="numeric" required="no">
		
		<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		a.account_name, a.account_id, a.account_name as opca_name, 
		o.*, 
		oc.*,
		u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
		oim.order_item_mode_name, 
		ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_tm_#SESSION.LANG_CODE# as status_finance_tm,
		otm.status_tm_name, otm.status_tm_css, 
		oi.*, 
		
		u.user_firstname, u.user_name,
		u2.user_firstname as manager_firstname, u2.user_color as manager_color,
		f.formation_id, f.formation_code
		
		FROM orders o

		INNER JOIN account a ON a.account_id = o.account_id
		LEFT JOIN account_group ag ON ag.group_id = a.group_id
		LEFT JOIN user u2 ON u2.user_id = ag.manager_id

		INNER JOIN orders_users ou ON ou.order_id = o.order_id 
		INNER JOIN user u ON ou.user_id = u.user_id
		
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
		
		LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
		LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
		
		LEFT JOIN order_context oc ON oc.context_id = o.context_id
		LEFT JOIN lms_formation f ON f.formation_id = o.formation_id
		
		<!---LEFT JOIN order_item oi ON oi.order_id = o.order_id
		LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
		LEFT JOIN order_mode om ON om.order_mode_id = o.order_mode_id--->
		<!---LEFT JOIN logs lo ON lo.order_id = oi.order_id--->
		
		WHERE 1 = 1
		<cfif isdefined("s_id")>
		AND o.order_status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
		</cfif>
		
		<cfif isdefined("a_id")>
		<cfif a_id neq 0>AND o.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"><cfelse>AND o.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)</cfif>
		</cfif>
		
		<cfif isdefined("o_id")>
		AND o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfif>
		
		<cfif isdefined("u_id")>
		AND ou.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("manager_id")>
		AND ag.manager_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#manager_id#">
		</cfif>
		
		<cfif isdefined("y_id")>
		AND SUBSTRING(o.order_ref, 1, 2) = <cfqueryparam cfsqltype="cf_sql_integer" value="#y_id#">
		</cfif>
		 
		<cfif isdefined("c_id")>
		AND o.context_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
		</cfif>
		
		<cfif isdefined("list_account") AND listlen(list_account) neq "0">
		AND a.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
		</cfif>
		
		<cfif isdefined("st_tm_id")>
		<cfif st_tm_id eq "1">
		AND (
		o.order_status_id = 1
		OR o.order_status_id = 2
		)
		<cfelseif st_tm_id eq "2">
		AND (
		o.order_status_id = 3
		OR o.order_status_id = 4
		)
		<cfelseif st_tm_id eq "3">
		AND (
		o.order_status_id = 5
		OR o.order_status_id = 10
		)
		</cfif>
		</cfif>
		
		
		<cfif isdefined("alert_close")>
		AND o.order_end <= #dateadd('m',+2,now())# AND o.order_end > now() AND o.order_status_id <> "10" AND o.order_status_id <> "11" AND o.order_status_id <> "6"
		</cfif>
		
		<cfif isdefined("alert_dead")>
		AND o.order_end <= now() AND o.order_status_id <> "10" AND o.order_status_id <> "11" AND o.order_status_id <> "6"
		</cfif>
		
		ORDER BY o.order_ref DESC
		</cfquery>
		
		<cfreturn get_orders> 
	
	</cffunction>
	
	
	
	
	
	
	<cffunction name="oget_workinghour" access="public" returntype="query" output="true">
	
		<cfargument name="p_id" type="numeric" required="yes">
	
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
		FROM user_workinghour uw WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		<cfreturn get_workinghour> 
	
	</cffunction>
	
	
	<cffunction name="oget_rating" access="public" returntype="query">
	
		<cfargument name="l_id" type="numeric" required="yes">
	
		<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_rating WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>

		<cfreturn get_rating> 
	
	</cffunction>
	
	
	
	





	<!------------------ GET LST  ------------->
	<cffunction name="oget_result_lst" access="remote" returntype="query">

		<cfargument name="p_id" type="integer" required="yes">

		<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND quiz_id = 3
		</cfquery>

		<cfreturn get_result_lst> 

	</cffunction>



	<!------------------ GET QUIZ MAX SCORE FOR SCALING  ------------->
	<cffunction name="oget_quiz_score" access="remote" returntype="query">

		<cfargument name="quiz_type" type="any" required="yes">
		<cfargument name="skill_category" type="any" required="no">
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		WHERE q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		<cfif isdefined("skill_category")>
			<cfif skill_category eq "grammar">
				AND (qq.qu_category_id = 1 OR qq.qu_category_id = 2) 
			<cfelseif skill_category eq "reading">
				AND qq.qu_category_id = 3
			<cfelseif skill_category eq "listening">
				AND qq.qu_category_id = 4
			</cfif>
		</cfif>
		</cfquery>

		<cfreturn get_quiz_score> 

	</cffunction>

	<!------------------ GET PT ALL  ------------->
	<cffunction name="oget_qpt_all" access="remote" returntype="query">

		<cfargument name="quiz_type" type="any" required="yes">

		<cfquery name="get_qpt_all" datasource="#SESSION.BDDSOURCE#">
		SELECT q.quiz_id, q.quiz_name_#SESSION.LANG_CODE# as quiz_name, q.quiz_alias, q.quiz_type,
		l.level_id, l.level_desc_#SESSION.LANG_CODE# as level_desc, l.level_name_#SESSION.LANG_CODE# as level_name, l.level_css
		FROM lms_quiz q
		INNER JOIN lms_level l ON l.level_id = q.level_id
		WHERE q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		ORDER BY q.quiz_rank ASC
		</cfquery>
		
		<cfreturn get_qpt_all> 

	</cffunction>


	<!------------------ GET FIRST PT TEST  ------------->
	<cffunction name="oget_first_pt" access="remote" returntype="any">

		<cfargument name="quiz_type" type="any" required="yes">

		<cfquery name="get_first_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id FROM lms_quiz 
		WHERE quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		ORDER BY quiz_rank ASC LIMIT 1
		</cfquery>
		
		<cfreturn get_first_pt.quiz_id> 

	</cffunction>

	<!------------------ GET DISTINCTS TP  ------------->
	<!--- ! quiz_success = 1 to remove empty test from showing --->
	<cffunction name="oget_distinct_pt" access="remote" returntype="query">

		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="quiz_type" type="any" required="yes">
		<cfargument name="pt_type" type="any" required="no">
		<cfargument name="pt_speed" type="any" required="no">
		<cfargument name="t_id" type="any" required="no">

		<cfquery name="get_distinct_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT qu.quiz_user_group_id, qu.pt_type, qu.pt_speed, qu.tp_id, qu.quiz_user_start
		FROM lms_quiz_user qu
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		LEFT JOIN lms_quiz_user_tp lqut ON lqut.quiz_user_group_id = qu.quiz_user_group_id 
		WHERE qu.quiz_user_end IS NOT NULL
		AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		<cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
		AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		</cfif>
		<cfif isdefined("pt_type") AND pt_type neq "">
		AND lqut.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
		<cfelse>
		AND lqut.type IS NULL
		</cfif>
		<cfif isdefined("pt_speed") AND pt_speed neq "">
		AND qu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		GROUP BY qu.quiz_user_group_id
		</cfquery>
		
		<cfreturn get_distinct_pt> 

	</cffunction>

	<!--- 		<cfquery name="get_attributed_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT lqu.quiz_user_id, lqu.quiz_user_end, l.tp_id, l.tp_date_end,
		lqu.quiz_user_group_id, lqu.pt_type, lqu.pt_speed, lqu.quiz_user_start,
		(l.tp_quiz_start_id = lqu.quiz_user_group_id) as _start, 
		(l.tp_quiz_end_id = lqu.quiz_user_group_id) as _end,
		l.tp_rank, f.formation_code, l.method_id, 
		l.tp_duration
		FROM lms_quiz_user lqu 
		INNER JOIN lms_quiz q ON q.quiz_id = lqu.quiz_id
		INNER JOIN lms_tp l
		<cfif attributed eq 1>
			on ((l.tp_quiz_start_id = lqu.quiz_user_group_id) OR (l.tp_quiz_end_id = lqu.quiz_user_group_id))
		<cfelse>
			on ((l.tp_quiz_start_id IS NULL) AND (l.tp_quiz_end_id IS NULL))
		</cfif>
		LEFT JOIN lms_formation f ON f.formation_id = l.formation_id
		WHERE lqu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		<cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
			AND l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		</cfif>
		<cfif isdefined("pt_speed") AND pt_speed neq "">
			AND lqu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		GROUP BY lqu.quiz_user_group_id
		</cfquery> --->
	<cffunction name="oget_attributed_pt" access="remote" returntype="query">

		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="quiz_type" type="any" required="yes">
		<cfargument name="pt_speed" type="any" required="no">
		<cfargument name="t_id" type="any" required="no">
		<cfargument name="attributed" type="numeric" required="yes">

		<cfquery name="get_attributed_pt" datasource="#SESSION.BDDSOURCE#">
			SELECT lqu.quiz_user_id, lqut.type, lqu.quiz_user_end, l.tp_id, l.tp_date_end, 
			lqu.quiz_user_group_id, lqu.pt_type, lqu.pt_speed, lqu.quiz_user_start, 
			l.tp_rank, f.formation_code, l.method_id, l.tp_duration, l.tp_name,
			tpe.elearning_name, l.elearning_duration, tpc.certif_name
			FROM  lms_quiz_user lqu
			INNER JOIN lms_quiz q ON q.quiz_id = lqu.quiz_id 
			LEFT JOIN lms_quiz_user_tp lqut ON lqut.quiz_user_group_id = lqu.quiz_user_group_id 
			LEFT JOIN lms_tp l on l.tp_id = lqut.tp_id
			LEFT JOIN lms_formation f ON f.formation_id = l.formation_id 
			LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = l.elearning_id
			LEFT JOIN lms_list_certification tpc ON tpc.certif_id = l.certif_id
			WHERE lqu.quiz_user_end IS NOT NULL
			AND lqu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
			<cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
				AND l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
			</cfif>
			<cfif isdefined("pt_speed") AND pt_speed neq "">
				AND lqu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
			</cfif>
			<cfif attributed eq 1>
				AND l.tp_id IS NOT NULL
			<cfelse>
				AND l.tp_id IS NULL
			</cfif>
			GROUP BY lqu.quiz_user_group_id, lqut.type
			</cfquery>


		
		<cfreturn get_attributed_pt> 

	</cffunction>

	<!------------------ GET PT  ------------->
	<cffunction name="oget_pt" access="remote" returntype="query">

		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="quiz_type" type="any" required="no">
		<cfargument name="quiz_user_group_id" type="numeric" required="no">
		<cfargument name="quiz_user_id" type="numeric" required="no">
		<cfargument name="pt_type" type="any" required="no">
		<cfargument name="pt_speed" type="any" required="no">
		<cfargument name="t_id" type="any" required="no">
		<cfargument name="level_id" type="numeric" required="no">


		<cfquery name="get_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT qu.quiz_user_id, qu.pt_type, qu.pt_speed, qutp.tp_id, qutp.type, qu.quiz_user_start, qu.quiz_user_group_id, q.quiz_type
		FROM lms_quiz_result qr
		INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
		LEFT JOIN lms_quiz_user_tp qutp ON qutp.quiz_user_group_id = qu.quiz_user_group_id
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		WHERE qu.quiz_user_end IS NOT NULL
		AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 	
		
		<cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
			AND qutp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		</cfif>
		<cfif isdefined("pt_type") AND pt_type neq "">
			AND qutp.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
		</cfif> 

		<cfif isdefined("quiz_user_group_id")>
			AND qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
		</cfif>
		<cfif isdefined("quiz_user_id")>
			AND qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfif>
		<cfif isdefined("quiz_type")>
			AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		</cfif>
		<cfif isdefined("pt_speed") AND pt_speed neq "">
			AND qu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		<cfif isdefined("level_id")>
			AND q.level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_id#">
		</cfif>
		
		GROUP BY qu.quiz_user_id
		ORDER BY qu.quiz_user_id DESC
		</cfquery>
		
		<cfreturn get_pt> 

	</cffunction>


	<!------------------ GET PT GLOBAL LEVEL  ------------->
	<cffunction name="oget_result_global_pt" access="remote" returntype="query">

		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="t_id" type="any" required="no">
		<cfargument name="quiz_type" type="any" required="no">
		<cfargument name="pt_type" type="any" required="no">
		<cfargument name="pt_speed" type="any" required="no">

		<cfquery name="get_result_global_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT l.level_alias, l.level_css FROM lms_quiz_user qu
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		INNER JOIN lms_level l ON q.level_id = l.level_id
		WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		AND qu.quiz_user_end IS NOT NULL
		<cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
		AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
		</cfif>
		<cfif isdefined("quiz_type")>
		AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		</cfif>
		<cfif isdefined("pt_type") AND pt_type neq "">
		AND qu.pt_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
		</cfif>
		<cfif isdefined("pt_speed") AND pt_speed neq "">
		AND qu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		ORDER BY q.level_id DESC LIMIT 1
		</cfquery>
		
		<cfreturn get_result_global_pt> 

	</cffunction>


	<!------------------ GET PT DETAILS SKILL LEVEL ------------->
	<cffunction name="oget_result_detail_pt" access="remote" returntype="query">

		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="quiz_user_group_id" type="numeric" required="no">
		<cfargument name="quiz_user_id" type="any" required="no">
		<cfargument name="skill_category" type="any" required="no">

		<cfquery name="get_result_pt" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(qr.ans_gain) as score
		FROM lms_quiz_result qr
		INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
		WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		AND qu.quiz_user_end IS NOT NULL
		<cfif isdefined("quiz_user_group_id")>
		AND qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">		
		</cfif>
		<cfif isdefined("quiz_user_id") AND quiz_user_id neq "">
		AND qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfif>
		<cfif isdefined("quiz_type")>
		AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
		</cfif>
		<cfif isdefined("skill_category")>
			<cfif skill_category eq "grammar">
				AND (que.qu_category_id = 1 OR que.qu_category_id = 2) 
			<cfelseif skill_category eq "reading">
				AND que.qu_category_id = 3
			<cfelseif skill_category eq "listening">
				AND que.qu_category_id = 4
			</cfif>
		</cfif>

		GROUP BY qu.user_id
		</cfquery>

		<cfreturn get_result_pt>
		
	</cffunction>



	<cffunction name="oget_products_json" access="remote" returntype="any" returnFormat="JSON">
		
		<cfquery name="get_products" datasource="#SESSION.BDDSOURCE#">
			SELECT product_id, product_name FROM product
		</cfquery>
		
		<cfreturn get_products>
	
	</cffunction>

</cfcomponent>