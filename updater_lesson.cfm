<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">

<cfparam name="u_id" default="#SESSION.USER_ID#">

<!--- INSERT NEW LESSON --->
<cfif isdefined("form") AND isdefined("t_id") AND isdefined("u_id") AND isdefined("m_id") AND isdefined("p_id") AND isdefined("s_id") AND isdefined("s_dur") AND isdefined("l_date_start") AND isdefined("l_time_start")>
	
	<cfset start_format = "#l_date_start# #replacenocase(l_time_start,"-",":","ALL")#:00">
	<cfset end_format = "#dateadd('n',s_dur,start_format)#">

	<!--- ABORT IF DATE BEFORE TODAY FOR LEARNER ROLE --->
	<cfif start_format LTE now() AND listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
		<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&e=1">
		<cfabort>
	</cfif>

	<!--- GET TRAINER INFO --->
	<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>
	
	<!--- INSERT LESSON --->
	<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#" result="new_lesson">
	INSERT INTO lms_lesson2
	(
	session_id,
	tp_id,
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
	<cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#start_format#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#end_format#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#s_dur#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#m_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
	now()
	)
	</cfquery>
	

	<!--- GENERATE CALENDAR INVITE --->
	<cfinvoke component="api/tp/tp_get" method="get_calendar_invite" returnvariable="_inv">
		<cfinvokeargument name="l_id" value="#new_lesson.generatedkey#">
	</cfinvoke>

	<!--- GET ALL TP LEARNER --->
	<cfset get_lesson = obj_query.oget_lesson(l_id="#new_lesson.generatedkey#",all_learner="1")>
	
	<!--- <cfset get_lesson = QueryGetRow(get_lesson_all, 1)> --->
	<cfset _get_lesson = QueryGetRow(get_lesson, 1)>
	<cfset tp_firstlesson = "">

	<cfif _get_lesson.method_id neq 10 >
	<!--- NOTIFICATION BLOCK --->
	<!--- we group by learner so Trainer only get 1 mail sent to them --->
	<cfoutput query="get_lesson" group="lesson_id">


	<!---------------------------- TRAINER SMS NOTIFICATION ----------------------->			
	<cfif get_lesson.trainer_remind_sms_scheduled eq "1">
		<cfif get_lesson.trainer_lang eq "fr">
			<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.learner_firstname# #get_lesson.learner_lastname#")>
		<cfelseif get_lesson.trainer_lang eq "en">
			<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'yyyy-mm-dd')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.learner_firstname# #get_lesson.learner_lastname#")>
		<cfelseif get_lesson.trainer_lang eq "de">
			<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.learner_firstname# #get_lesson.learner_lastname#")>
		<cfelseif get_lesson.trainer_lang eq "es">
			<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.learner_firstname# #get_lesson.learner_lastname#")>
		<cfelseif get_lesson.trainer_lang eq "it">
			<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.learner_firstname# #get_lesson.learner_lastname#")>
		</cfif>	
		
		
		<cfhttp url="http://www.isendpro.com/cgi-bin/" method="POST" result="objHttp">
			<cfhttpparam type="FORMFIELD" name="keyid" value="hkuwWRg6vEpwSDMnoSmGlUGmo7nem1Ca" />
			<cfhttpparam type="FORMFIELD" name="emetteur" value="WEFIT" />
			<cfhttpparam type="FORMFIELD" name="nostop" value="1" />
			<cfhttpparam type="FORMFIELD" name="num" value="#get_lesson.trainer_phone#" />
			<cfhttpparam type="FORMFIELD" name="sms" value="#smsgo#" />
		</cfhttp>
	</cfif>

	<!---------------------------- TRAINER NOTIFICATION ----------------------->
	<cfif get_lesson.trainer_remind_scheduled eq "1">

		<!--- SUBJECT AND OPTION SET-UP --->
	<cfif get_lesson.sessionmaster_id eq "695">

		<cfif get_lesson.trainer_lang eq "fr">
			<cfset subject = "[LMS] Nouvel apprenant - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "en">
			<cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "de">
			<cfset subject = "[LMS] Neuer Schüler - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "es">
			<cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "it">
			<cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		</cfif>

		<cfset status = "na">

	<cfelseif get_lesson.sessionmaster_id eq "694">
				
		<cfif get_lesson.trainer_lang eq "fr">
			<cfset subject = "[LMS] Nouveau PTA planifié - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "en">
			<cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "de">
			<cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "es">
			<cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "it">
			<cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		</cfif>

		<cfset status = "pta_booked">

	<cfelse>
		
		<cfif get_lesson.trainer_lang eq "fr">
			<cfset subject = "[LMS] Nouveau cours planifié - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "en">
			<cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "de">
			<cfset subject = "[LMS] Neuer Kurs gebucht - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "es">
			<cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		<cfelseif get_lesson.trainer_lang eq "it">
			<cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
		</cfif>

		<cfset status = "confirm">

	</cfif>

	<!--- MAIL SENDER TRAINER --->
	<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.trainer_email#" subject="#subject#" type="html" server="localhost">
		<cfset lang = get_lesson.trainer_lang>
		<!--- <cfset status = "pta_booked"> --->
		<cfset recipient = "trainer">			
		<cfinclude template="./email/email_lesson_status.cfm">	
		<cfmailparam type="text/calendar" file="#_inv#">
	</cfmail>

	</cfif>
	<!--- TRAINER END --->

	<!--- HERE WE LOOP TROUGHT EACH LEARNER --->
	<cfoutput>
		

		<!--- CREATE LESSON ATTENDANCE SPOT --->
		<cfquery name="insert_attendance" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_lesson2_attendance(
				lesson_id, 
				tp_id,
				user_id
				) 
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#new_lesson.generatedkey#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.learner_id#">
				)
		</cfquery>

		<!---------------------------- LEARNER SMS NOTIFICATION ----------------------->			
		<cfif get_lesson.learner_remind_sms_scheduled eq "1">
			<cfif get_lesson.learner_lang eq "fr">
				<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.trainer_firstname#")>
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'yyyy-mm-dd')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.trainer_firstname#")>
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.trainer_firstname#")>
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.trainer_firstname#")>
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset smsgo = URLEncodedFormat("Reservation #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# : cours de #get_lesson.lesson_duration# min avec #get_lesson.trainer_firstname#")>
			</cfif>
			
			
			<cfhttp url="http://www.isendpro.com/cgi-bin/" method="POST" result="objHttp">
				<cfhttpparam type="FORMFIELD" name="keyid" value="hkuwWRg6vEpwSDMnoSmGlUGmo7nem1Ca" />
				<cfhttpparam type="FORMFIELD" name="emetteur" value="WEFIT" />
				<cfhttpparam type="FORMFIELD" name="nostop" value="1" />
				<cfhttpparam type="FORMFIELD" name="num" value="#get_lesson.learner_phone#" />
				<cfhttpparam type="FORMFIELD" name="sms" value="#smsgo#" />
			</cfhttp>
		</cfif>

		
		<cfset tp_firstlesson = "">

		<!-------------- IF BOOKING NA ---------->
		<cfif get_lesson.sessionmaster_id eq "695">
			
			<!-------------- UPDATE FOR SIGNING CHARTER ---------->
			<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET user_charter = 1
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.learner_id#">
			</cfquery>
			
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Réservation 1er cours avec #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Die Buchung Ihres ersten Kurses mit #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
			</cfif>
							
			<cfset status = "na">
			<cfset tp_firstlesson = "&tp_firstlesson=1">

			<!---------------------------- INSERT TASK ----------------------->			
			<cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
				<cfinvokeargument name="task_type_id" value="74">
				<cfinvokeargument name="u_id" value="#get_lesson.learner_id#">
				<cfinvokeargument name="task_channel_id" value="6">
			</cfinvoke>
				
		<!-------------- IF BOOKING PTA ---------->
		<cfelseif get_lesson.sessionmaster_id eq "694">
		
			
			<!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Confirmation réservation avec #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Kurs mit #get_lesson.trainer_firstname# bestätigt">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
			</cfif>
				
			<cfset status = "pta_booked">

			<!---------------------------- CS EMAIL NOTIFICATION ----------------------->			
			<cfmail from="W-LMS <service@wefitgroup.com>" to="service@wefitgroup.com" subject="[LMS] New PTA booked" type="html" server="localhost">
				<cfset lang = "fr">
				<cfset status = "pta_booked">
				<cfset recipient = "trainer">
				<cfinclude template="./email/email_lesson_status.cfm">	
				<cfmailparam type="text/calendar" file="#_inv#">	
			</cfmail>

			<!---------------------------- INSERT TASK ----------------------->			
			<cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
				<cfinvokeargument name="task_type_id" value="37">
				<cfinvokeargument name="u_id" value="#get_lesson.learner_id#">
				<cfinvokeargument name="task_channel_id" value="6">
			</cfinvoke>
			
		

			
		<!-------------- IF BOOKING REGULAR LESSON ---------->
		<cfelse>
			
			<!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
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
			
			<cfset status = "confirm">

		</cfif>


		<!-------------- UPDATE STATUS AND TRAINER CHOICE WHEN LESSON BOOKED FOR TEST USER --------->
		<cfif SESSION.USER_PROFILE eq "TEST" AND isdefined("SESSION.TP_ID")>
			<cfset SESSION.USER_STATUS_ID = "4">
			<cfset SESSION.ACCESS_VISIO = "1">
			<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET user_status_id = 4 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			</cfquery>

			<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.TP_ID#">
			</cfquery>
			<cfset obj_tp_post.updt_tptrainer_add(t_id=SESSION.TP_ID,u_id=SESSION.USER_ID,p_id=p_id,interne='yes')>

			<!---------------------------- SERVICE NOTIFICATION ----------------------->
			<cfset subject = "[LMS] Test Learner - Lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">

			<cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com,sales@wefitgroup.com,trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = SESSION.LANG_CODE>
				<cfset status = "test_booked">		
				<cfinclude template="./email/email_lesson_status.cfm">
				<cfif _inv neq "0">
					<cfmailparam type="text/calendar" file="#_inv#">
				</cfif>
			</cfmail>	
		<!-------------- END UPDATE TEST USER --------->

		<!--- SEND MAIL IF NOTIF ACTIVATED --->
		<cfelseif get_lesson.learner_remind_scheduled eq "1">	

			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<!--- <cfset status = "na"> --->
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">
				<cfmailparam type="text/calendar" file="#_inv#">	
			</cfmail>
		</cfif>

	</cfoutput>
	<!--- LEARNER END --->
	</cfoutput>
	</cfif>
	
	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&k=2#tp_firstlesson#">

			
</cfif>	


<!-------------------------------- ANNULATION -------------------------------------->

<cfif isdefined("l_id") AND isdefined("cancel")>
	
	<cfinvoke component="api/tp/tp_post" method="cancel_tp" returnvariable="res">
        <cfinvokeargument name="l_id" value="#l_id#">
        <cfinvokeargument name="_status" value="cancel">
		<cfinvokeargument name="status_id" value="3">
    </cfinvoke>
		
	
	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&p_id=#p_id#&k=3">

</cfif>


<!-------------------------------- ANNULATION TARDIVE -------------------------------------->

<cfif isdefined("l_id") AND isdefined("fcancel")>

	<cfinvoke component="api/tp/tp_post" method="cancel_tp" returnvariable="res">
        <cfinvokeargument name="l_id" value="#l_id#">
        <cfinvokeargument name="_status" value="fcancel">
        <cfinvokeargument name="status_id" value="4">
    </cfinvoke>
	
	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&p_id=#p_id#&k=3">

</cfif>


<!------------------------- SCHEDULE APPOINTMENT WITH CS ---------------------->

<cfif isdefined("u_id") AND isdefined("p_id") AND isdefined("l_dur") AND isdefined("l_date_start") AND isdefined("l_time_start") AND isdefined("cs_event")>

	<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>
	
	<cfset start_format = "#l_date_start# #replacenocase(l_time_start,"-",":","ALL")#:00">
	<cfset end_format = "#dateadd('n',l_dur,start_format)#">
		
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
	
	<cfmail from="W-LMS <service@wefitgroup.com>" to="service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
		<cfset lang = "fr">
		<cfset status = "confirm">
		<cfset recipient = "trainer">			
		<cfinclude template="./email/email_lesson_status.cfm">
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
			<cfinclude template="./email/email_lesson_status.cfm">
			<!--- <cfmailparam type="text/calendar" file="#_inv#">		 --->
		</cfmail>
	</cfif>
		
		
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
</cfif>


<!------------------------- DELETE SCHEDULE APPOINTMENT WITH CS ---------------------->

<cfif isdefined("u_id") AND isdefined("p_id") AND isdefined("l_id") AND isdefined("faction") AND (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>

<cfquery name="del_lesson" datasource="#SESSION.BDDSOURCE#">
DELETE FROM lms_lesson2	WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>
		
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
</cfif>


</cfprocessingdirective>
