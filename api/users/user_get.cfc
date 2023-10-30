<cfcomponent>

	<cffunction name="oget_account_user" access="remote" returntype="any" returnFormat="JSON" description="Retrieve list of active users for given account">
		<cfargument name="a_id" type="numeric" required="yes">
		<cfargument name="g_id" type="numeric" required="no" default="0">
		<cfargument name="learner_only" type="numeric" required="no">
		<cfargument name="staff_only" type="numeric" required="no" default="0">
		<cfargument name="o_by" type="string" required="no" default="name">

		<cfquery name="get_user_crm" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_firstname, u.user_name, u.user_id, up.profile_name 
		FROM user u
		INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
		INNER JOIN user_profile up ON up.profile_id = upc.profile_id
		INNER JOIN account a ON u.account_id = a.account_id
		WHERE 
		<cfif a_id neq "" AND a_id neq 0>
			u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		<cfelseif g_id neq "" AND g_id neq 0>
			a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		<cfelse>
			u.account_id IS NULL
		</cfif>
		<cfif isDefined("learner_only") >
			AND (upc.profile_id = 3 OR upc.profile_id = 7 OR upc.profile_id = 9)
		<cfelseif staff_only eq 1>
		AND (upc.profile_id NOT IN (3,4,7,8,9,10) OR upc.profile_id = 12)
		AND u.user_status_id =4
		<cfelseif staff_only eq 2>
			 upc.profile_id = 4
			AND u.user_status_id IN (4,6)
		</cfif>

		<cfif o_by eq "name">
			ORDER BY u.user_name
		<cfelseif o_by eq "firstname">
			ORDER BY u.user_firstname
		</cfif>
		</cfquery>
		<!--- u.user_status_id = 4 AND - active only --->


		<cfprocessingdirective suppresswhitespace="yes">
		<cfset result = SerializeJSON(get_user_crm, "struct")>
		</cfprocessingdirective>

    	<cfreturn result>
	</cffunction>

	<cffunction name="oget_account_group" access="remote" returntype="any" returnFormat="JSON" description="Retrieve list of active users for given account">
		<cfargument name="a_id" type="numeric" required="yes">

		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_id, a.account_name, a.group_id, a.provider_id
		FROM account a 
		WHERE a.group_id = (
			SELECT a2.group_id 
			FROM account a2 
			WHERE a2.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
			)
		</cfquery>

		<cfprocessingdirective suppresswhitespace="yes">
		<cfset result = SerializeJSON(get_account, "struct")>
		</cfprocessingdirective>

    	<cfreturn result>
	</cffunction>

	<cffunction name="oget_country_phone" access="remote" returntype="any" returnFormat="JSON" description="Retrieve list of country phone">

		<cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
		SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name FROM settings_country WHERE phone_code IS NOT NULL
		</cfquery>


		<cfprocessingdirective suppresswhitespace="yes">
		<cfset result = SerializeJSON(get_country_phone, "struct")>
		</cfprocessingdirective>

    	<cfreturn result>
		
	</cffunction>

	<cffunction name="oget_user_trainer" access="public" returntype="query" output="false" description="Retrieve User's trainers">
		<cfargument name="u_id" type="numeric" required="yes">

		<cftry>

		<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#" result="data">
			SELECT p.planner_id, u.user_firstname as planner FROM lms_tpplanner p 
			INNER JOIN user u ON p.planner_id = u.user_id 
			INNER JOIN lms_tpuser tu ON tu.tp_id = p.tp_id AND tpu.tpuser_active = 1
			WHERE tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			AND u.active = 1
		</cfquery>
		
		<cfreturn get_trainer>

		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>


	</cffunction>


	<cffunction name="oget_user" access="public" returntype="query" output="true">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="pf_id" type="numeric" required="no">

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		u.user_id, u.account_id, u.user_ismanager, u.user_status_id, u.user_type_id, u.timezone_id, u.contact_id, u.user_gender, u.user_firstname, u.user_name, u.user_alias, u.user_temp_alias, u.user_email, u.user_email_2, u.user_phone, u.user_phone_2, u.user_phone_code, u.user_phone_2_code, u.user_password, u.user_pwd_chg, u.user_create, u.user_color, u.user_css, u.user_lang, u.user_charter, u.situation_id, u.interest_id, u.function_id, u.business_id, u.method_id, u.speciality_id, u.country_id, u.avail_id, u.perso_id, u.expertise_id, u.techno_id, u.certif_id, u.user_jobtitle, u.user_birthday, u.user_based, u.user_adress, u.user_postal, u.user_city, u.user_company, u.user_school, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, u.country_id_inv, u.user_news, u.user_needs, u.user_needs_course, u.user_needs_trainer, u.user_needs_frequency, u.user_needs_nbtrainer, u.user_needs_learn, u.user_needs_complement, u.user_needs_trainer_complement, u.user_needs_theme, u.user_needs_duration, u.user_needs_speaking_id, u.user_needs_expertise_id, u.user_remind_1d, u.user_remind_3h, u.user_remind_1h, u.user_remind_15m, u.user_remind_missed, u.user_remind_cancelled, u.user_remind_scheduled, u.user_notification_late_canceled, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h, u.user_remind_sms_15m, u.user_remind_sms_missed, u.user_remind_sms_scheduled, u.user_hide_report_all, u.user_hide_report_free_remain, u.user_steps, u.user_level, u.user_access_tp, u.user_el_list, u.user_shortlist, u.user_elapsed, u.user_lastconnect, u.user_md5, u.user_blocker, u.user_visio_rate, u.user_f2f_rate, u.user_add_course, u.user_add_learner, u.user_paid_global, u.user_paid_missed, u.user_paid_tva, u.user_resume, u.user_video, u.user_video_link, u.user_signature, u.user_abstract, u.user_account_right_id, u.user_session_right_id, u.user_widget, u.user_pref_task_group, u.user_appointlet, u.user_ref, u.user_ref2, u.user_ctc_cpf, u.user_ctc_formation, u.user_optin, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr, u.user_setup, u.user_gymglish_link, u.user_pt_mandatory,
		a.account_name, a.account_id, a.group_id, a.account_pt_mandatory, a.provider_id,
		ag.group_name,
		upc.profile_id, up.profile_name
		FROM user u
		INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
		INNER JOIN user_profile up ON upc.profile_id = up.profile_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN account_group ag ON ag.group_id = a.group_id
		
		LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id

		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		<cfif isdefined("pf_id")>
			AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pf_id#">
		</cfif>
		GROUP BY u.user_id
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

</cfcomponent>