<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	<cfparam name="send_email">
	<cfparam name="u_id">
	<cfparam name="o_id">
	<cfparam name="t_id">
	<cfparam name="mail_cc" default="">
	<cfparam name="mail_bcc" default="">
	<cfparam name="task_type_id" default="">
	<cfparam name="add_todo" default="false">

	<cfdump var="#form#">
	
	<!--- INIT --->
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>

	<cfset user_email = get_user.user_email>
	<cfset lang = get_user.user_lang>
	<cfset provider_id = get_user.provider_id>

	<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",o_id="#o_id#",m_id="1,2,3")>

	<cfinvoke component="api/tp/tp_get" method="oget_tp" returnvariable="get_tp">
		<cfinvokeargument name="t_id" value="#t_id#">
		<cfinvokeargument name="u_id" value="#u_id#">
		<cfinvokeargument name="lang" value="#lang#">
	</cfinvoke>

	<cfif add_todo>
		<cfif task_type_id neq "" AND send_email neq "b2c_prospect">
			<cfinvoke component="api/task/task_post" method="insert_task">
				<cfinvokeargument name="task_type_id" value="#task_type_id#">
				<cfinvokeargument name="task_category" value="TO DO">
				<cfinvokeargument name="log_remind_ok" value="#log_remind_ok#">
				<cfinvokeargument name="log_remind" value="#log_remind#">
				<cfinvokeargument name="u_id" value="#u_id#">
				<cfinvokeargument name="to_id" value="#to_id#">
				<cfinvokeargument name="profile_id" value="#profile_id#">
				<cfif o_id neq ""><cfinvokeargument name="o_id" value="#o_id#"></cfif>
				<cfinvokeargument name="task_channel_id" value="6">
			</cfinvoke>
		</cfif>
	</cfif>
	




	<cfswitch expression="#send_email#">
		<cfcase value="send_status">
			<cfset subject = "WEFIT | Votre formation arrive bientôt à échéance">
		
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="63",u_id="#u_id#",o_id="#o_id#",task_channel_id="6")>
			
			<cfif mail_bcc neq "">
				<cfset mail_bcc = mail_bcc = ",">
			</cfif>
			<cfset mail_bcc = mail_bcc = "finance@wefitgroup.com">

			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <finance@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_admin_followup.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_deadline">
			<cfset subject = "WEFIT | Votre formation est arrivée à son terme">
		
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="64",u_id="#u_id#",o_id="#o_id#",task_channel_id="6")>
			
			<cfif mail_bcc neq "">
				<cfset mail_bcc = mail_bcc = ",">
			</cfif>
			<cfset mail_bcc = mail_bcc = "finance@wefitgroup.com">

			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <finance@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_admin_deadline.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_followup_1">
			<cfset email_header_img = "header_email_launching_regular.jpg">

			<cfset template = 1>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = obj_translater.get_translate(id_translate="email_subject_followup_1",lg_translate="#lang#")>
			
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="292",u_id="#u_id#",task_channel_id="6")>
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_followup.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_followup_2">
			<cfset email_header_img = "header_email_launching_regular.jpg">

			<cfset template = 2>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = obj_translater.get_translate(id_translate="email_subject_followup_2",lg_translate="#lang#")>
			
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="293",u_id="#u_id#",task_channel_id="6")>
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="#SESSION.CFMAIL_SERVER#" username="#SESSION.CFMAIL_USERNAME#" password="#SESSION.CFMAIL_PASSWORD#" port="#SESSION.CFMAIL_PORT#">
				<cfinclude template="./email/email_cs_followup.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_followup_3">
			<cfset email_header_img = "header_email_launching_regular.jpg">

			<cfset template = 3>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset subject = obj_translater.get_translate(id_translate="email_subject_followup_3",lg_translate="#lang#")>
			
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="294",u_id="#u_id#",task_channel_id="6")>
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="#SESSION.CFMAIL_SERVER#" username="#SESSION.CFMAIL_USERNAME#" password="#SESSION.CFMAIL_PASSWORD#" port="#SESSION.CFMAIL_PORT#">
				<cfinclude template="./email/email_cs_followup.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_launching_1">
			<cfset email_header_img = "header_email_na_done.jpg">

			<cfset template = 1>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = obj_translater.get_translate('email_subject_launching_1')>
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_launching.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_launching_2">
			<cfset email_header_img = "header_email_launching_regular.jpg">

			<cfset template = 2>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = obj_translater.get_translate('email_subject_launching_2')>
			
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_launching.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_launching_3">
			<cfset email_header_img = "header_email_reminder.jpg">

			<cfset template = 3>
			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = obj_translater.get_translate('email_subject_launching_3')>
			
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_launching.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_linguaskill_register_b2b">

			<cfset email_header_img = "header_email_prospect.jpg">
			<cfset email_icon = "icon_reminder.png">
			<cfset btn_lms = "Accéderà mon parcours">
			<cfset btn_href = "https://www.google.fr">
			<cfset template = "linguaskill_b2b">
			
			<cfset subject = obj_translater.get_translate('email_subject_linguaskill_register_b2b')>

			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_test_register.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_linguaskill_register_cpf">

			<cfset email_header_img = "header_email_launching_test.jpg">
			<cfset email_icon = "icon_reminder.png">
			<cfset btn_lms = "Accéderà mon parcours">
			<cfset btn_href = "https://www.google.fr">
			<cfset template = "linguaskill_cpf">
			<cfset subject = obj_translater.get_translate('email_subject_linguaskill_register_cpf')>

			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_test_register.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_bright_register_cpf">

			<cfset email_header_img = "header_email_reminder.jpg">
			<cfset email_icon = "icon_reminder.png">
			<cfset btn_lms = "Accéderà mon parcours">
			<cfset btn_href = "https://www.google.fr">
			<cfset template = "bright_cpf">
			<cfset subject = obj_translater.get_translate('email_subject_bright_register_cpf')>

			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_test_register.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_toeic">

			<cfset email_header_img = "header_email_reminder.jpg">
			<cfset email_icon = "icon_reminder.png">
			<cfset btn_lms = "Accéderà mon parcours">
			<cfset btn_href = "https://www.google.fr">
			<cfset template = "toeic">
			<cfset subject = obj_translater.get_translate('email_subject_toeic')>

			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_test_register.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="send_linguaskill_confirm_b2b">

			<cfset email_header_img = "header_email_lesson_booked.jpg">
			<cfset email_icon = "icon_reminder.png">
			<cfset btn_lms = "Accéderà mon parcours">
			<cfset btn_href = "https://www.google.fr">
			<cfset template = "linguaskill_confirm">
			<cfset subject = obj_translater.get_translate('email_subject_linguaskill_confirm_b2b')>

			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_cs_test_confirm.cfm">
			</cfmail>
		</cfcase>
		<!--- !!!!!!!!!!!!!!!!!! --->
		<cfcase value="b2c_prospect">
			Objet : <cfoutput>WEFIT Formation en Langues | Qu'en pensez-vous ?</cfoutput><br>

			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset subject = "WEFIT Formation en Langues | Qu'en pensez-vous ?">
			
			<!--------------------- INSERT TASK ----------------->		
			<cfset insert_task = obj_task_post.insert_task(task_type_id="71",u_id="#u_id#",task_channel_id="6")>
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_prospect.cfm">
			</cfmail>		
			
			<cflocation url="cs_learners.cfm?k=1" addtoken="no">
		</cfcase>
		<cfcase value="send_test">
			Objet : <cfoutput>send_test</cfoutput><br>

			<cfset user_email = get_user.user_email>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_lastname = get_user.user_name>
			<cfset lang = get_user.user_lang>
			<cfset provider_id = get_user.provider_id>

			<cfset subject = "send_test">
			<cfset email_header_img = "header_email_guest.jpg">



			<!--- <cfset subject = obj_translater.get_translate('email_subject_launching_1')> --->
			
			<!--------------------- SEND EMAIL ------------------>
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="#mail_cc#" bcc="#mail_bcc#" subject="#subject#" type="html" server="localhost">
				<cfinclude template="./email/email_new_launch_learner.cfm">
			</cfmail>

			<!--- <cfinclude template="./email/email_new_launch_learner.cfm"> --->
		</cfcase>


	</cfswitch>

	<cflocation url="common_learner_account.cfm?u_id=#u_id#&k=3" addtoken="no">

</cfif>