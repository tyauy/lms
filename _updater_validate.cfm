<cfparam name="user_email">
<cfparam name="user_password_tmp">
<cfparam name="_type" default="login">


<cftry>

<cfdump var="#_type#">

<cfhttp url="https://www.google.com/recaptcha/api/siteverify" result="response_account">
	<cfhttpparam type="Formfield" name="secret" value="6Lfw5XEaAAAAAAEizqsoV2L0NUNUUtahm8LIvWPV"> 
	<cfhttpparam type="Formfield" name="response" value="#recaptcha_response_account#">
</cfhttp>


<!--- <cfif isJSON(response_account.filecontent)>
<cfset response_account = DeserializeJSON(response_account.filecontent)>
<cfif structKeyExists(response_account,"success")>
<cfif response_account.success eq "YES" AND response_account.score gte 0.5> --->

INSIDE

<cfif _type eq "login">
	
<cfelseif _type eq "register">

	<cfparam name="user_email">
	<cfparam name="user_gender" default="">
	<cfparam name="user_firstname">
	<cfparam name="user_name">
	<cfparam name="user_password_tmp">
	<cfparam name="user_phone">
	<cfparam name="user_phone_code">
	<cfparam name="user_company" default="">
	<cfparam name="user_school" default="">
	<cfparam name="user_adress">
	<cfparam name="user_postal">
	<cfparam name="user_city">
	<cfparam name="user_country">
	<cfparam name="same_adress">

	yo

	<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
	</cfquery>

	<cfdump var="#check_user#">
	<cfif check_user.recordcount eq "0">

		<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#" result="insert_user">
			INSERT INTO user
			(
			profile_id,
			account_id,
			user_status_id,
			user_type_id,
			<cfif isdefined('user_gender')>user_gender,</cfif>
			user_firstname,
			user_name,
			user_email,
			user_password,
			user_pwd_chg,
			user_phone,
			user_phone_code,
			user_create,
			user_lang,
			user_company,
			user_school,
			user_adress,
			user_postal,
			user_city,
			country_id,
			user_adress_inv,
			user_postal_inv,
			user_city_inv,
			country_id_inv
			)
			VALUES
			(
			7,
			346,
			4,
			3,
			<cfif isdefined('user_gender')><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,</cfif>
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_password_tmp)#">,
			1,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
			now(),
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.LANG_CODE#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_company#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_school#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_adress#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_postal#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_city#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_country#">,
			<cfif same_adress eq "oui">
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_adress#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_postal#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_city#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#user_country#">
			<cfelse>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_adress_inv#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_postal_inv#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_city_inv#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#user_country_inv#">
			</cfif>
			)
		</cfquery>

		<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_profile_cor
			(
			user_id,
			profile_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			7
			)
		</cfquery>

		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_md5 = '#hash(insert_user.generatedkey)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">
		</cfquery>
				
		<cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tp
		(
		user_id,
		tp_status_id,
		formation_id,
		method_id,
		tp_date_start,
		tp_date_end,
		tp_rank,
		elearning_id,
		elearning_duration,
		tp_duration,
		order_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
		2,
		2,
		3,
		now(),
		#DateAdd("h",6,now())#,
		1,
		1,
		1,
		0,
		1
		)
		</cfquery>
		
		<!---  --->
		<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Creation de compte GUEST SSO" type="html" server="localhost">
			<table>
				<tr>
					<td>Contact</td>
					<td>#user_firstname# #user_name#</td>
				</tr>
				<tr>
					<td>Email</td>
					<td>#user_email#</td>
				</tr>
				<tr>
					<td>T&eacute;l&eacute;phone</td>
					<td>#user_phone#</td>
				</tr>
				<tr>
					<td>Société</td>
					<td>#user_company#</td>
				</tr>
			</table>
		</cfmail>

	
	</cfif>

</cfif>


<cfset temp = hash(user_password_tmp)>

<cfquery name="get_user" dataSource="#SESSION.BDDSOURCE#"> 
SELECT 
u.user_id, u.account_id, u.user_ismanager, u.user_status_id, u.user_type_id, u.timezone_id, u.contact_id, u.user_gender, u.user_firstname, u.user_name, u.user_alias, u.user_temp_alias, u.user_email, u.user_email_2, u.user_phone, u.user_phone_2, u.user_phone_code, u.user_phone_2_code, u.user_password, u.user_pwd_chg, u.user_create, u.user_color, u.user_css, u.user_lang, u.user_charter, u.situation_id, u.interest_id, u.function_id, u.business_id, u.method_id, u.speciality_id, u.country_id, u.avail_id, u.perso_id, u.expertise_id, u.techno_id, u.certif_id, u.user_jobtitle, u.user_birthday, u.user_based, u.user_adress, u.user_postal, u.user_city, u.user_company, u.user_school, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, u.country_id_inv, u.user_news, u.user_needs, u.user_needs_course, u.user_needs_trainer, u.user_needs_frequency, u.user_needs_nbtrainer, u.user_needs_learn, u.user_needs_complement, u.user_needs_trainer_complement, u.user_needs_theme, u.user_needs_duration, u.user_needs_speaking_id, u.user_needs_expertise_id, u.user_remind_1d, u.user_remind_3h, u.user_remind_1h, u.user_remind_15m, u.user_remind_missed, u.user_remind_cancelled, u.user_remind_scheduled, u.user_notification_late_canceled, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h, u.user_remind_sms_15m, u.user_remind_sms_missed, u.user_remind_sms_scheduled, u.user_hide_report_all, u.user_hide_report_free_remain, u.user_steps, u.user_level, u.user_access_tp, u.user_el_list, u.user_shortlist, u.user_elapsed, u.user_lastconnect, u.user_md5, u.user_blocker, u.user_visio_rate, u.user_f2f_rate, u.user_add_course, u.user_add_learner, u.user_paid_global, u.user_paid_missed, u.user_paid_tva, u.user_resume, u.user_video, u.user_video_link, u.user_signature, u.user_abstract, u.user_account_right_id, u.user_session_right_id, u.user_widget, u.user_pref_task_group, u.user_appointlet, u.user_ref, u.user_ref2, u.user_ctc_cpf, u.user_ctc_formation, u.user_optin, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr, u.user_setup, u.user_gymglish_link, u.user_pt_mandatory,
up.*, 
tz.*, a.account_id, a.account_name, a.group_id, a.provider_id,
s.user_status_name_fr as user_status_name,
t.user_type_name_fr as user_type_name,
ac.contact_id
FROM user u
LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
LEFT JOIN user_type t ON t.user_type_id = u.user_type_id
INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
INNER JOIN user_profile up ON upc.profile_id = up.profile_id
LEFT JOIN account a ON a.account_id = u.account_id
LEFT JOIN settings_timezone tz ON tz.timezone_id = u.timezone_id
LEFT JOIN account_contact ac ON ac.user_id = u.user_id
WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
AND user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#temp#">
AND u.user_status_id <> 5
LIMIT 1
</cfquery> 

<cfdump var="#get_user#">
	
<!--- AT LEAST 1 USER EXISTS WITH THIS EMAIL / PASSWORD --->
<cfif get_user.recordcount NEQ "0">

	<!--- LINKING ACCOUNT --->
	<cfif isDefined("SESSION.GOOGLE_ID")>
		<cfquery name="up_learner" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO `user_sso` (`user_id`, `sso_name`, `sso_id`, `sso_user_name`) VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_user.user_id#">,
				"GOOGLE",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.GOOGLE_ID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.HIDDEN_NAME#">
			)
		</cfquery>
	</cfif>

	<cfif isDefined("SESSION.MICROSOFT_ID")>
		<cfquery name="up_learner" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO `user_sso` (`user_id`, `sso_name`, `sso_id`, `sso_user_name`) VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_user.user_id#">,
				"MICROSOFT",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.MICROSOFT_ID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.HIDDEN_NAME#">
			)
		</cfquery>
	</cfif>



	<!--- NORMAL SETUP --->
	<cfset SESSION.USER_PROFILE_ID = get_user.profile_id>
	<cfset SESSION.USER_PROFILE = get_user.profile_name>
	<cfset SESSION.USER_PROFILE_CSS = get_user.profile_css>

	<!--- For Multi select --->
	<cfset SESSION.booking_array = {}>

	
	<cfinclude template="Application_vars.cfm">

	<cflocation addtoken="no" url="index.cfm">
		
</cfif>


<!--- </cfif>
</cfif>
</cfif> --->

<cfcatch type="any">
</cfcatch>
</cftry>

<cfset error="4">
<cflocation addtoken="no" url="connect_out.cfm?error=4">




<!--- <cfif isdefined("form.user_email_demo") 
AND isdefined("form.user_password_demo") 
AND isdefined("form.user_name_demo") 
AND isdefined("form.user_firstname_demo") 
AND isdefined("form.user_phone_demo")
AND isdefined("form.situation_id_demo")
AND isdefined("form.user_cpf_demo")
AND isdefined("form.user_company_demo")
AND isdefined("form.user_search_demo")
AND isdefined("form.contact_demo")
AND isdefined("form.recaptcha_response_demo")
>






<cfif isJSON(response_demo.filecontent)>
	<cfset response_demo = DeserializeJSON(response_demo.filecontent)>
	
	<cfif structKeyExists(response_demo,"success")>
	
		<cfif response_demo.success eq "YES" AND response_demo.score gte 0.5>
		
			<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
			SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_demo#">
			</cfquery>

			<cfif check_user.recordcount eq "0">

				<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user
				(
				profile_id,
				account_id,
				user_status_id,
				user_type_id,
				user_firstname,
				user_name,
				user_email,
				user_password,
				user_pwd_chg,
				user_phone,
				user_create,
				user_lang,
				situation_id,
				user_ctc_cpf,
				user_ctc_formation
				)
				VALUES
				(
				7,
				<cfif situation_id_demo eq "3">239<cfelse>47</cfif>,
				4,
				3,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name_demo)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email_demo)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_password_demo)#">,
				1,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_demo#">,
				now(),
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_cpf_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_search_demo#">
				)
				</cfquery>

				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				SELECT MAX(user_id) as id FROM user
				</cfquery>

				<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_profile_cor
				(
				user_id,
				profile_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				7
				)
				</cfquery>

				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
				</cfquery>

				<cfquery name="get_situation" datasource="#SESSION.BDDSOURCE#">
				SELECT situation_name_fr FROM user_situation WHERE situation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_demo#">
				</cfquery>
						
				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_tp
				(
				user_id,
				tp_status_id,
				formation_id,
				method_id,
				tp_date_start,
				tp_date_end,
				tp_rank,
				elearning_id,
				elearning_duration,
				tp_duration,
				order_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				2,
				2,
				3,
				now(),
				#DateAdd("h",6,now())#,
				1,
				1,
				1,
				0,
				1
				)
				</cfquery>
				
				<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Creation de compte GUEST B2C" type="html" server="localhost">
				<table>
					<tr>
						<td>Contact</td>
						<td>#user_firstname_demo# #user_name_demo#</td>
					</tr>
					<tr>
						<td>Situation</td>
						<td>#get_situation.situation_name_fr#</td>
					</tr>
					<tr>
						<td>Email</td>
						<td>#user_email_demo#</td>
					</tr>
					<tr>
						<td>T&eacute;l&eacute;phone</td>
						<td>#user_phone_demo#</td>
					</tr>
					<tr>
						<td>Société</td>
						<td>#user_company_demo#</td>
					</tr>
					<tr>
						<td>Dispose de droits</td>
						<td><cfif isdefined("user_cpf_demo")>#user_cpf_demo#<cfelse>NC</cfif></td>
					</tr>
					
					<tr>
						<td>Recherche d'une formation</td>
						<td><cfif isdefined("user_search_demo")>#user_search_demo#<cfelse>NC</cfif></td>
					</tr>
					
					
				</table>
				</cfmail>

				<cflocation addtoken="no" url="https://lms.wefitgroup.com?user_name=#user_email_demo#&upass=#hash(user_password_demo)#">
				
			<cfelse>
					
				<cfif findnocase("page_contact",CGI.HTTP_REFERER)>
				
					<cflocation addtoken="no" url="page_contact.cfm?e=1">
					
				<cfelseif findnocase("page_el",CGI.HTTP_REFERER)>
				
					<cflocation addtoken="no" url="page_el.cfm?e=1">
					
				</cfif>
			
			</cfif>

		<cfelse>
		
			<cfif findnocase("page_contact",CGI.HTTP_REFERER)>
				
				<cflocation addtoken="no" url="page_contact.cfm?e=2">
				
			<cfelseif findnocase("page_el",CGI.HTTP_REFERER)>
			
				<cflocation addtoken="no" url="page_el.cfm?e=2">
				
			</cfif>
		
		</cfif>
		
	</cfif>
</cfif>

</cfif> --->
