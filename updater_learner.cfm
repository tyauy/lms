<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">



<cfif isdefined("updt_chart")>

	<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user 
	SET user_charter = 1
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>
	
	<cfset SESSION.USER_CHARTER = 1>

	<cflocation addtoken="no" url="index.cfm?k=3">
	
	
<cfelseif (isdefined("updt_learner") OR isdefined("updt_test") OR isdefined("updt_migration")) AND isdefined("FORM") AND isdefined("u_id")>

	<cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "test">
		<cfset u_id = SESSION.USER_ID>
	</cfif>
			
			






			
			
	<cfif isdefined("updt_avail")>

		<cfif SESSION.USER_PROFILE eq "LEARNER">
			<cfif isdefined("avail_id")>
				<!--- SET SESSION VARIABLES --->
				<cfset SESSION.AVAIL_ID = avail_id>
			<cfelse>
				<cfset SESSION.AVAIL_ID = "">
			</cfif>
		<cfelse>
			<cfif not isdefined("avail_id")>
				<cfset avail_id = "">
			</cfif>
		</cfif>

		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET avail_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#avail_id#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
	
	
	




	
	
	
	
	
	<cfelseif isdefined("updt_settings")>
			
		<cfif SESSION.USER_PROFILE eq "learner">
			<cfif isdefined("user_remind_1d")>
				<cfset SESSION.USER_REMIND_1D = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_1D = "">
			</cfif>
			
			<cfif isdefined("user_remind_3h")>
				<cfset SESSION.USER_REMIND_3H = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_3H = "">
			</cfif>
			
			<cfif isdefined("user_remind_15m")>
				<cfset SESSION.USER_REMIND_15M = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_15M = "">
			</cfif>
			
			<cfif isdefined("user_remind_scheduled")>
				<cfset SESSION.USER_REMIND_SCHEDULED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SCHEDULED = "">
			</cfif>
			
			<cfif isdefined("user_remind_missed")>
				<cfset SESSION.USER_REMIND_MISSED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_MISSED = "">
			</cfif>

			<cfif isdefined("user_notification_late_canceled")>
				<cfset SESSION.USER_NOTIFICATION_LATE_CANCELED = 1>
			<cfelse>
				<cfset SESSION.USER_NOTIFICATION_LATE_CANCELED = 0>
			</cfif>
			
			<cfif isdefined("user_remind_cancelled")>
				<cfset SESSION.USER_REMIND_CANCELLED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_CANCELLED = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_15m")>
				<cfset SESSION.USER_REMIND_SMS_15M = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_15M = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_missed")>
				<cfset SESSION.USER_REMIND_SMS_MISSED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_MISSED = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_scheduled")>
				<cfset SESSION.USER_REMIND_SMS_SCHEDULED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_SCHEDULED = "">
			</cfif>
			
			
			<cfset SESSION.USER_LANG = user_lang>
			<cfset SESSION.USER_NEEDS_DURATION = user_needs_duration>
			<!--- <cfset SESSION.USER_TIMEZONE_ID = user_timezone_id> --->
			
			<!--- <cfquery name="get_timezone" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM settings_timezone WHERE timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_timezone_id#">
			</cfquery>
			
			<cfset SESSION.USER_TIMEZONE = get_timezone.timezone_text> --->
			
			
		</cfif>
		
		

		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET
		<cfif isdefined("user_remind_1d")>
		user_remind_1d = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_1d#">,
		<cfelse>
		user_remind_1d = null,
		</cfif>
		<cfif isdefined("user_remind_3h")>
		user_remind_3h = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_3h#">,
		<cfelse>
		user_remind_3h = null,
		</cfif>
		<cfif isdefined("user_remind_15m")>
		user_remind_15m = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_15m#">,
		<cfelse>
		user_remind_15m = null,
		</cfif>
		<cfif isdefined("user_remind_cancelled")>
		user_remind_cancelled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_cancelled#">,
		<cfelse>
		user_remind_cancelled = null,
		</cfif>	
		<cfif isdefined("user_remind_missed")>
		user_remind_missed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_missed#">,
		<cfelse>
		user_remind_missed = null,
		</cfif>
		<cfif isdefined("user_notification_late_canceled")>
		user_notification_late_canceled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_notification_late_canceled#">,
		<cfelse>
		user_notification_late_canceled = 0,
		</cfif>
		<cfif isdefined("user_remind_scheduled")>
		user_remind_scheduled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_scheduled#">,
		<cfelse>
		user_remind_scheduled = null,
		</cfif>	
		<cfif isdefined("user_remind_sms_15m")>
		user_remind_sms_15m = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_15m#">,
		<cfelse>
		user_remind_sms_15m = null,
		</cfif>
		<cfif isdefined("user_remind_sms_missed")>
		user_remind_sms_missed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_missed#">,
		<cfelse>
		user_remind_sms_missed = null,
		</cfif>
		<cfif isdefined("user_remind_sms_scheduled")>
		user_remind_sms_scheduled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_scheduled#">,
		<cfelse>
		user_remind_sms_scheduled = null,
		</cfif>
		<cfif isdefined("user_pt_mandatory")>user_pt_mandatory = 1,<cfelse>user_pt_mandatory = 0,</cfif>
		user_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
		<!--- timezone_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_timezone_id#">,--->
		user_needs_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_needs_duration#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
		
		
		
		
		
		
		
		
		
		
		
	<cfelseif isdefined("updt_account")>

		<cfif SESSION.USER_PROFILE eq "learner">
			<cfset SESSION.USER_GENDER = user_gender>
			<cfset SESSION.USER_FIRSTNAME = user_firstname>
			<cfset SESSION.USER_LASTNAME = user_lastname>
			<cfset SESSION.USER_PHONE = user_phone>
			<cfset SESSION.USER_PHONE_CODE = user_phone_code>
			<cfset SESSION.USER_PHONE_2 = user_phone_2>
			<cfset SESSION.USER_PHONE_2_CODE = user_phone_2_code>
			<cfset SESSION.USER_EMAIL_2 = user_email_2>
			<cfset SESSION.USER_NAME = user_firstname & " " & user_lastname>
		</cfif>
		
		<cfif isdefined("user_file") AND user_file neq "">
			
			<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#u_id#">
				
			<cfif not directoryExists(dir_go)>
			
			<cfdirectory directory="#dir_go#" action="create" mode="777">
			
			</cfif>
				
			<cffile action = "upload" 
			filefield = "user_file" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777">			
			<cfif cffile.FileWasSaved>		
				<!---<cfif fileexists("#dir_go#/photo.jpg")>
					<cffile action="delete" file="#dir_go#/photo.jpg">
				</cfif>--->
				<cffile action="rename" 
				source = "#dir_go#/#cffile.ClientFile#" 
				destination = "#dir_go#/photo.jpg" 
				attributes="normal"> 
			</cfif>
		</cfif>
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		user_gender = <cfif isdefined("user_gender") AND user_gender neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#"><cfelse>null</cfif>,
		user_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
		user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lastname#">,
		<cfif user_phone neq "">
			user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
			user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
		</cfif>
		<cfif user_phone_2 neq "">
			user_phone_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2#">,
			user_phone_2_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2_code#">,
		</cfif>
		user_email_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_2#">		
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
		
		
		





		
		
		
		
		
		
		
	<cfelseif isdefined("updt_status") AND isdefined("user_status_id") AND isdefined("user_type_id") AND isdefined("profile_cor_id")>
	
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		<cfif user_status_id eq "4">
			user_steps = '',
		<cfelseif user_status_id eq "3">
			user_steps = '1,2',
		</cfif>
		user_status_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_status_id#">,
		user_type_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_type_id#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		<cfif listlen(profile_cor_id) neq "0">
			<cfquery name="del_cor" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_profile_cor WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfquery>

			<cfloop list="#profile_cor_id#" index="pf_id">
				<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_profile_cor
				(
				user_id,
				profile_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#pf_id#">
				)
				</cfquery>
			</cfloop>
			

		</cfif>

		
		
		
		
		
	
	<cfelseif isdefined("updt_account_group")>
	
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_id#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		
		
		
		





	
		
		
		
		
		
		
		
	<cfelseif isdefined("updt_quick_steps")>
		
		<cfquery name="get_step" datasource="#SESSION.BDDSOURCE#">
		SELECT user_steps FROM user WHERE user_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
			
		<cfif isdefined("close_quick_steps")>
		
			<cfset user_steps_new = get_step.user_steps>
			<cfset user_steps_new = listappend(user_steps_new,updt_quick_steps)>
			
			<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
			UPDATE user SET user_steps = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_steps_new#"> WHERE user_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfquery>
			
			
			
		<cfelse>
			
			<cfset user_steps_new = "">
			
			<cfif get_step.user_steps neq "">
			
				<cfloop list="#get_step.user_steps#" index="cor">
					<cfif cor neq updt_quick_steps>
					<cfset user_steps_new = listappend(user_steps_new,cor)>
					</cfif>
				</cfloop>
				
				<cfoutput>old list = #get_step.user_steps# // new list = #user_steps_new#</cfoutput>
				
				<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET user_steps = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_steps_new#"> WHERE user_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
				</cfquery>
				
			</cfif>
		
		</cfif>


		
	<cfelseif isdefined("updt_steps")>
		
		<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET 
		
		<!---- IF TP VISIO / LAUNCHING AUTO WITH 'LAUNCHING' STATUS FOR L / DISPLAY PT FOR LANG EN+DE+FR ---->
		<cfif isdefined("access_visio")>
		<cfif formation_id eq "1" OR formation_id eq "2" OR formation_id eq "3"> 
		user_steps = '1,2,3',
		<cfelse>
		user_steps = '1,3',
		</cfif>
		user_status_id = 3,
		<!---- IF ANYTHING ELSE WITHOUT VISIO / CLASSIC HP --->
		<cfelse>
		user_steps = '1,2', <!--- null --->
		user_status_id = 4,
		</cfif>
		
		<!--- <cfif listlen(user_steps) neq "0"> --->
		<!--- user_steps	= <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_steps#">, --->
		<!--- user_status_id = 3, --->
		<!--- <cfelse> --->
		<!--- user_steps = null, --->
		<!--- user_status_id = 4, --->
		<!--- </cfif> --->
		user_setup = 1,
		user_charter = 0
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>		
		
		<cfif isdefined("send_reset")>
		
			<cfset temp = RandRange(100000, 999999)>
			
			<cfquery name="updt_pwd" datasource="#SESSION.BDDSOURCE#">
			UPDATE user
			SET 
			user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
			user_pwd_chg = 0,		
			user_charter = 0
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfquery>
			
			<cfset user_pwd = temp>

		</cfif>
		
		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_gender, user_name, user_firstname, user_email, user_lang
		FROM user u
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
		
		<cfset user_gender = get_user.user_gender>
		<cfset user_firstname = get_user.user_firstname>
		<cfset user_lastname = get_user.user_name>
		<cfset user_email = get_user.user_email>
		<cfset user_lang = get_user.user_lang>
		
		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1")>
		
		<cfif isdefined("send_email")>
		
			<cfif isdefined("updt_learner")>
			
				<cfif user_lang eq "fr">
					<cfset subject = "WEFIT | Votre formation linguistique est prête à démarrer">
				<cfelseif user_lang eq "en">
					<cfset subject = "WEFIT | Your training is ready to start">
				<cfelseif user_lang eq "de">
					<cfset subject = "WEFIT | Ihr Training kann beginnen">
				<cfelseif user_lang eq "es">
					<cfset subject = "WEFIT | Tu entrenamiento está listo para comenzar">
				<cfelseif user_lang eq "it">
					<cfset subject = "WEFIT | Your training is ready to start">
				</cfif>			
				
				<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="service@wefitgroup.com,finance@wefitgroup.com,rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
					<cfset new_formation = 1>
					<cfset lang = user_lang>
					<cfinclude template="./email/email_new_formation.cfm">
				</cfmail>
				
				<!--------------------- INSERT TASK ----------------->		
				<cfset insert_task = obj_task_post.insert_task(task_type_id="73",u_id="#u_id#",task_channel_id="6")>

			<cfelseif isdefined("updt_test")>
			
				<cfif user_lang eq "fr">
					<cfset subject = "WEFIT | Découvrez nos services">
				<cfelseif user_lang eq "en">
					<cfset subject = "WEFIT | Discover our services">
				<cfelseif user_lang eq "de">
					<cfset subject = "WEFIT | Lernen Sie unser Angebot kennen">
				<cfelseif user_lang eq "es">
					<cfset subject = "WEFIT | Descubra nuestros servicios">
				<cfelseif user_lang eq "it">
					<cfset subject = "WEFIT | Discover our services">
				</cfif>	
							
				<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
					<cfset new_test = 1>
					<cfset lang = user_lang>
					<cfinclude template="./email/email_new_formation.cfm">
				</cfmail>
				
				<!--------------------- INSERT TASK ----------------->		
				<cfset insert_task = obj_task_post.insert_task(task_type_id="75",u_id="#u_id#",task_channel_id="6")>

			</cfif>

		</cfif>
		
		<!------------- AUTO LAUNCH TP ELEARNING-------->
		<cfoutput query="get_tps">
			<cfif method_id eq "3">
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp
				SET tp_status_id = 2
				WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
				</cfquery>
			</cfif>
		</cfoutput>
		
	






	<!---------------------------- REINIT MDP BY CS ------------------------->
		
	<cfelseif isdefined("updt_mdp")>
	
		<cfset temp = RandRange(100000, 999999)>
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
		user_pwd_chg = 0
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
	
		<cfset user_pwd = temp>

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_gender, user_name, user_firstname, user_email, user_lang
		FROM user u
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
				
		<cfset user_gender = get_user.user_gender>
		<cfset user_firstname = get_user.user_firstname>
		<cfset user_lastname = get_user.user_name>
		<cfset user_email = get_user.user_email>
		<cfset user_lang = get_user.user_lang>
		

		<cfif user_lang eq "fr">
			<cfset subject = "WEFIT | Vos identifiants de connexion">
		<cfelseif user_lang eq "en">
			<cfset subject = "WEFIT | Your connection identifier">
		<cfelseif user_lang eq "de">
			<cfset subject = "WEFIT | Ihre Zugangsdaten">
		<cfelseif user_lang eq "es">
			<cfset subject = "WEFIT | Your connection identifier">
		<cfelseif user_lang eq "it">
			<cfset subject = "WEFIT | Your connection identifier">
		</cfif>	
					
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" subject="#subject#" type="html" server="localhost">
			<cfset lang = user_lang>
			<cfinclude template="./email/email_new_pwd.cfm">
		</cfmail>

		
		
		
		
	<!---------------------------- CHANGE EMAIL BY CS ------------------------->
		
	<cfelseif isdefined("updt_newmail")>
		
		<cfquery name="get_email" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id
		FROM user u
		WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
		</cfquery>
		
		<cfif get_email.recordcount neq "0">
		
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&e=1">
		
		<cfelse>
			
			<cfif isdefined("send_email") AND send_email eq 1>

				<cfset temp = RandRange(100000, 999999)>
			
				<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
				UPDATE user 
				SET 
				user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
				user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
				user_pwd_chg = 0
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
				</cfquery>
			
				<cfset user_pwd = temp>

				<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
				SELECT user_gender, user_name, user_firstname, user_email, user_lang
				FROM user u
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
				</cfquery>
						
				<cfset user_gender = get_user.user_gender>
				<cfset user_firstname = get_user.user_firstname>
				<cfset user_lastname = get_user.user_name>
				<cfset user_email = get_user.user_email>
				<cfset user_lang = get_user.user_lang>
				

				<cfif user_lang eq "fr">
					<cfset subject = "WEFIT | Nouvel identifiant de connexion">
				<cfelseif user_lang eq "en">
					<cfset subject = "WEFIT | New connection identifier">
				<cfelseif user_lang eq "de">
					<cfset subject = "WEFIT | Neue Zugangsdaten">
				<cfelseif user_lang eq "es">
					<cfset subject = "WEFIT | New connection identifier">
				<cfelseif user_lang eq "it">
					<cfset subject = "WEFIT | New connection identifier">
				</cfif>	
				
				<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" subject="#subject#" type="html" server="localhost">
					<cfset lang = user_lang>
					<cfinclude template="./email/email_new_email.cfm">
				</cfmail>

			<cfelse>

				<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
					UPDATE user 
					SET 
					user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
					WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
				</cfquery>

			</cfif>

			
		</cfif>
		
		
	
	</cfif>
	
	
	
	
	
	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1">
	<cfelse>
		<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1">
	</cfif>

	
	
	
	
	
<cfelseif isdefined("ins_learner") AND isdefined("FORM")>

	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
		<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
		</cfquery>
		
		<cfif check_user.recordcount neq "0">
		
			<cflocation addtoken="no" url="cs_learners.cfm?e=1">
			
		<cfelse>

			<cfif not isDefined("user_pwd")>
				<cfset user_pwd = RandRange(100000, 999999)>
			</cfif>
		
			<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#" result="insert_user">
			INSERT INTO user
			(
			account_id,
			timezone_id,
			user_gender,
			user_firstname,
			user_name,
			user_email,
			user_email_2,
			user_password,
			<cfif user_phone neq "">
				user_phone,
				user_phone_code,
			</cfif>
			<cfif user_phone_2 neq "">
				user_phone_2,
				user_phone_2_code,
			</cfif>
			user_create,
			user_lang,
			user_status_id,
			user_type_id,
			user_remind_1d,
			user_remind_3h
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
			6,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_lastname)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email_2)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
			<cfif user_phone neq "">
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
			</cfif>
			<cfif user_phone_2 neq "">
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2_code#">,
			</cfif>
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,			
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_status_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_type_id#">,
			1,
			1
			)
			</cfquery>
			
			<!--- <cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(user_id) as id FROM user
			</cfquery> --->

			<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_profile_cor
			(
			user_id,
			profile_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#profile_id#">
			)
			</cfquery>
			
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#insert_user.generatedkey#&k=2">

			
		</cfif>

	</cfif>
	
	
	
	
<cfelseif isdefined("init") AND isdefined("FORM") AND isdefined("user_pwd")>
	
	<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user 
	SET 
	user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
	user_pwd_chg = 1
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>
	
	<cfset SESSION.USER_PWD_CHG = 1>
		
	<cfif SESSION.USER_PROFILE eq "learner">
		<cflocation addtoken="no" url="learner_index.cfm?k=2">
	<cfelseif SESSION.USER_PROFILE eq "GUEST">
		<cflocation addtoken="no" url="learner_index.cfm?k=2">
	<cfelseif SESSION.USER_PROFILE eq "test">
		<cflocation addtoken="no" url="learner_index.cfm?k=2">
	<cfelseif SESSION.USER_PROFILE eq "trainer">
		<cflocation addtoken="no" url="trainer_index.cfm">
	<cfelseif SESSION.USER_PROFILE eq "tm">
		<cflocation addtoken="no" url="tm_index.cfm">
	<!--- <cfelseif SESSION.USER_PROFILE eq "SchoolMNG">
		<cflocation addtoken="no" url="cm_index.cfm"> --->
	<cfelseif SESSION.USER_PROFILE eq "sales">
		<cflocation addtoken="no" url="cs_index.cfm">
	</cfif>
	
</cfif>



</cfprocessingdirective>