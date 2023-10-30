<cfcomponent>

	<cffunction name="oget_lesson" access="public" returntype="query" output="true">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="no">
	
		<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.lesson_duration, l.tp_id, l.planner_id, l.user_id, l.method_id, l.updater_id, l.updater_date, l.booker_id, l.booker_date, l.completed_date,
		utech.user_techno_link as lesson_redirect, utech.user_techno_key as lesson_redirect_key,
		lltech.techno_name_#SESSION.LANG_CODE# as tech_name, techno_icon,
		ul.user_md5 as learner_md5, ul.user_firstname as learner_firstname, ul.user_name as learner_lastname, ul.user_email as learner_email, ul.user_lang as learner_lang, ul.user_phone as learner_phone, ul.user_remind_missed as learner_remind_missed, ul.user_remind_cancelled as learner_remind_cancelled, ul.user_remind_scheduled as learner_remind_scheduled, ul.user_remind_sms_missed as learner_remind_sms_missed, ul.user_remind_sms_scheduled as learner_remind_sms_scheduled,
		ut.user_firstname as trainer_firstname, ut.user_name as trainer_lastname, ut.user_email as trainer_email, ut.user_lang as trainer_lang, ut.user_phone as trainer_phone, ut.user_remind_missed as trainer_remind_missed, ut.user_remind_cancelled as trainer_remind_cancelled, ut.user_remind_scheduled as trainer_remind_scheduled, ut.user_remind_sms_missed as trainer_remind_sms_missed, ut.user_remind_sms_scheduled as trainer_remind_sms_scheduled,
		ub.user_firstname as booker_firstname, ut.user_name as booker_lastname,
		uu.user_firstname as updater_firstname, uu.user_name as updater_lastname,
		c.cat_name_#SESSION.LANG_CODE# as cat_name,		
		sm.sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code, sm.level_id, sm.sessionmaster_ressource, sm.sessionmaster_description,
		l.method_id,
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
		LEFT JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id <!---AND tpu.tpuser_active = 1--->
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN user ul ON ul.user_id = tpu.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id	
		LEFT JOIN user ub ON ub.user_id = l.booker_id	
		LEFT JOIN user uu ON uu.user_id = l.updater_id	
		LEFT JOIN account a ON a.account_id = ul.account_id
		LEFT JOIN user_techno utech ON utech.user_id = l.planner_id  AND utech.techno_id = t.techno_id 
		LEFT JOIN lms_list_techno lltech ON lltech.techno_id = t.techno_id 
		LEFT JOIN lms_lesson2_attendance lla_v ON lla_v.lesson_id = l.lesson_id <cfif isdefined("u_id")>AND lla_v.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"></cfif>
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		<cfif isdefined("u_id")>
		AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		LIMIT 1
		</cfquery>
		
		<cfreturn get_lesson>
	
	</cffunction>

</cfcomponent>