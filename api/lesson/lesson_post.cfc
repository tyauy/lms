<cfcomponent>

	<cffunction name="insert_lesson_cs" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="u_id" type="numeric" required="yes">
        <cfargument name="p_id" type="numeric" required="yes">
        <cfargument name="l_dur" type="numeric" required="yes">
        <cfargument name="l_date_start" type="string" required="yes">
        <cfargument name="l_time_start" type="string" required="yes">


		<cfset start_format = "#l_date_start# #replacenocase(l_time_start,"-",":","ALL")#:00">
		<cfset end_format = "#dateadd('n',l_dur,start_format)#">
	
		<!--- ABORT IF DATE BEFORE TODAY FOR LEARNER ROLE --->
		<cfif start_format LTE now() AND listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
			<cfreturn 2>
		</cfif>
	
		<!--- GET TRAINER INFO --->
		<!--- <cfset get_planner = obj_query.oget_planner(p_id="#p_id#")> --->
		
		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#" result="new_lesson">
		INSERT INTO lms_lesson2
		(
		user_id,
		lesson_start,
		lesson_end,
		lesson_duration,
		status_id,
		method_id,
		planner_id,
		booker_id,
		booker_date
		)
		VALUES(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#start_format#">,
		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#end_format#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#l_dur#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		now()
		)
		</cfquery>
			
		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT max(lesson_id) as id FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery> --->
		
		<!----- PARAM VARIABLE TO DISPLAY MESSAGE & PREVENT TAKING A SECOND MEETING ---->
		<cfif SESSION.USER_PROFILE eq "learner">
			<cfset SESSION.SETUP_SCHEDULED = "1">
		</cfif>
		
		<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.lesson_duration, l.tp_id, l.planner_id, l.user_id, l.method_id,
		ul.user_md5 as learner_md5, ul.user_firstname as learner_firstname, ul.user_name as learner_lastname, ul.user_email as learner_email, ul.user_lang as learner_lang, ul.user_phone as learner_phone, ul.user_remind_missed as learner_remind_missed, ul.user_remind_cancelled as learner_remind_cancelled, ul.user_remind_scheduled as learner_remind_scheduled, ul.user_remind_sms_missed as learner_remind_sms_missed, ul.user_remind_sms_scheduled as learner_remind_sms_scheduled,
		ut.user_firstname as trainer_firstname, ut.user_name as trainer_lastname, ut.user_email as trainer_email, ut.user_lang as trainer_lang, ut.user_phone as trainer_phone, ut.user_remind_missed as trainer_remind_missed, ut.user_remind_cancelled as trainer_remind_cancelled, ut.user_remind_scheduled as trainer_remind_scheduled, ut.user_remind_sms_missed as trainer_remind_sms_missed, ut.user_remind_sms_scheduled as trainer_remind_sms_scheduled,
		ub.user_firstname as booker_firstname, ut.user_name as booker_lastname,
		c.cat_name_#SESSION.LANG_CODE# as cat_name,		
		sm.sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code,
		a.account_name,
		s.session_duration, 
		ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name,
		lm.method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_lesson2 l
		INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		INNER JOIN user ul ON ul.user_id = l.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id	
		LEFT JOIN lms_tpsession s ON s.session_id = l.session_id
		LEFT JOIN lms_tp t ON t.tp_id = s.tp_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN user ub ON ub.user_id = l.booker_id	
		INNER JOIN account a ON a.account_id = ul.account_id
		WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_lesson.generatedkey#">
		</cfquery>

		<cfinvoke component="api/tp/tp_get" method="get_calendar_invite" returnvariable="_inv">
			<cfinvokeargument name="l_id" value="#new_lesson.generatedkey#">
		</cfinvoke>
		
		<!---------------------------- SERVICE EMAIL NOTIFICATION ----------------------->	

		<cfset subject = "[LMS] Nouveau RDV Setup planifié - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		
		<cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
			<cfset lang = "fr">
			<cfset status = "confirm">
			<cfset recipient = "trainer">			
			<cfinclude template="../../email/email_lesson_status.cfm">
			<cfif _inv neq "0">
				<cfmailparam type="text/calendar" file="#_inv#">
			</cfif>
		</cfmail>
		
		<!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
		<cfif get_lesson.learner_remind_scheduled eq "1">
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Confirmation réservation avec #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Kurs bestätigt mit #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "confirm">
				<cfset recipient = "learner">
				<cfinclude template="../../email/email_lesson_status.cfm">
				<!--- <cfmailparam type="text/calendar" file="#_inv#">		 --->
			</cfmail>
		</cfif>

        <cfreturn 1>
        
    </cffunction>

</cfcomponent>