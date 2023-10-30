<!DOCTYPE html>
<cfsilent>

<cfparam name="tab" default="1">

<cfif (isdefined("u_id") OR isdefined("token_code")) AND (listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
	
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_fullname, u.*, 
	up.profile_name, up.profile_css,
	a.account_name,  
	ag.group_name, 
	ap.*,
	u2.user_firstname as account_manager, u2.user_color as account_manager_color, 
    u3.user_firstname as account_owner, u3.user_color as account_owner_color,
	s.user_status_name_fr as user_status_name, user_status_css, user_type_name_#SESSION.LANG_CODE# as user_type_name, ut.user_type_css,	
	st.timezone_text
	FROM user u

	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
	LEFT JOIN user_type ut ON ut.user_type_id = u.user_type_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON upc.profile_id = up.profile_id
	LEFT JOIN settings_timezone st ON st.timezone_id = u.timezone_id

	LEFT JOIN account a ON a.account_id = u.account_id
	LEFT JOIN account_group ag ON ag.group_id = a.group_id 	
	LEFT JOIN account_type t ON t.type_id = a.type_id
	LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id 
	LEFT JOIN user u2 ON u2.user_id = a.user_id
    LEFT JOIN user u3 ON u3.user_id = a.owner_id	

	
	<cfif isdefined("u_id")>
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	<cfelseif isdefined("token_code")>
    	LEFT JOIN lms_list_token lt ON lt.user_id = u.user_id	
		WHERE lt.token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_code#">
	</cfif>

	GROUP BY u.user_id
	</cfquery>
	
	<!--- <cfif get_user.account_id neq "">
		<cfset get_contact = obj_account_get.get_contact(a_id="#get_user.account_id#",contact_lead="1")>
	</cfif> --->
	
	<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
	SELECT up.profile_name, up.profile_id
	FROM user_profile up 
	INNER JOIN user_profile_cor upc ON upc.profile_id = up.profile_id
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cfset profile_list = "">

	<cfoutput query="get_profile">
		<cfset profile_list = listappend(profile_list,profile_id)>
	</cfoutput>
	
	<cfset u_id = get_user.user_id>
	<cfset user_gender = get_user.user_gender>
	<cfset user_name = get_user.user_fullname>
	<cfset user_firstname = get_user.user_firstname>
	<cfset user_lastname = get_user.user_name>
	
	<cfset user_create = get_user.user_create>
	<cfset user_elapsed = get_user.user_elapsed>

	<cfset account_id = get_user.account_id>	
	<cfset group_name = get_user.group_name>
	<cfset account_name = get_user.account_name>
	<cfset account_manager_color = get_user.account_manager_color>
	<cfset account_manager = get_user.account_manager>
	<cfset account_owner_color = get_user.account_owner_color>
	<cfset account_owner = get_user.account_owner>
	<cfset provider_name = get_user.provider_name>
	<cfset provider_code = get_user.provider_code>
	<cfset provider_id = get_user.provider_id>
	
	<cfset user_steps = get_user.user_steps>
	
	<cfloop list="#SESSION.LIST_PT#" index="cor">
	<cfset "user_qpt_#cor#" = evaluate("get_user.user_qpt_#cor#")>
	<cfset "user_qpt_lock_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>
	</cfloop>
	
	<cfset user_lst = get_user.user_lst>
	<cfset user_lst_lock = get_user.user_lst_lock>
	
	<cfset user_lang = get_user.user_lang>
	
	<cfset user_profile = get_user.profile_name>
	<cfset user_profile_css = get_user.profile_css>
	<cfset user_email = get_user.user_email>
	<cfset user_email_2 = get_user.user_email_2>
	<cfset user_phone = get_user.user_phone>
	<cfset user_phone_code = get_user.user_phone_code>
	<cfset user_phone_2 = get_user.user_phone_2>
	<cfset user_phone_2_code = get_user.user_phone_2_code>
	<cfset user_alias = get_user.user_alias>	
			
	<cfset user_jobtitle = get_user.user_jobtitle>
	<cfset avail_id = get_user.avail_id>
	<cfset interest_id = get_user.interest_id>
	<cfset user_needs = get_user.user_needs>
	<cfset user_needs_course = get_user.user_needs_course>
	<cfset user_needs_frequency = get_user.user_needs_frequency>
	<!--- <cfset user_needs_trainer = get_user.user_needs_trainer> --->
	<!--- <cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer> --->
	<cfset user_needs_learn = get_user.user_needs_learn>
	<!--- <cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement> --->
	<cfset user_needs_complement = get_user.user_needs_complement>
	<!--- <cfset user_needs_theme = get_user.user_needs_theme> --->
	<cfset user_needs_duration = get_user.user_needs_duration>	
	<cfset user_needs_expertise_id = get_user.user_needs_expertise_id>
	<cfset user_needs_speaking_id = get_user.user_needs_speaking_id>

	<cfset user_pt_mandatory = get_user.user_pt_mandatory>

	<cfset user_remind_1d = get_user.user_remind_1d>
	<cfset user_remind_3h = get_user.user_remind_3h>
	<cfset user_remind_15m = get_user.user_remind_15m>	
	<cfset user_remind_missed = get_user.user_remind_missed>
	<cfset user_remind_cancelled = get_user.user_remind_cancelled>
	<cfset user_remind_scheduled = get_user.user_remind_scheduled>
	<cfset user_notification_late_canceled = get_user.user_notification_late_canceled>
	
	<cfset user_remind_sms_15m = get_user.user_remind_sms_15m>
	<cfset user_remind_sms_missed = get_user.user_remind_sms_missed>
	<cfset user_remind_sms_scheduled = get_user.user_remind_sms_scheduled>
	
	<cfset user_hide_report_all = get_user.user_hide_report_all>
	<cfset user_hide_report_free_remain = get_user.user_hide_report_free_remain>

	<cfset user_timezone_text = get_user.timezone_text>
		
	<cfset user_type_name = get_user.user_type_name>
	<cfset user_type_css = get_user.user_type_css>
	<cfset user_status_name = get_user.user_status_name>
	<cfset user_status_id = get_user.user_status_id>
	<cfset user_status_css = get_user.user_status_css>

	
	<cfset user_type_id = get_user.user_type_id>
	
	<cfset user_password = get_user.user_password>

<cfelseif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
	
	<cfset u_id = SESSION.USER_ID>
	<cfset user_gender = SESSION.USER_GENDER>
	<cfset user_name = SESSION.USER_NAME>
	<cfset user_firstname = SESSION.USER_FIRSTNAME>
	<cfset user_lastname = SESSION.USER_LASTNAME>
	
	<cfset user_steps = SESSION.STEPS>
		
	<cfloop list="#SESSION.LIST_PT#" index="cor">
	<cfif isdefined("SESSION.USER_QPT_#cor#")>
	<cfset "user_qpt_#cor#" = evaluate("SESSION.USER_QPT_#cor#")>
	<cfset "user_qpt_lock_#cor#" = evaluate("SESSION.USER_QPT_LOCK_#cor#")>
	</cfif>
	</cfloop>
	
	<cfset user_lst = SESSION.USER_LST>
	<cfset user_lst_lock = SESSION.USER_LST_LOCK>
	
	<cfset user_lang = SESSION.USER_LANG>
	
	<cfset user_profile = SESSION.USER_PROFILE>
	<cfset user_profile_css = SESSION.USER_PROFILE>
	<cfset user_email = SESSION.USER_EMAIL>
	<cfset user_email_2 = SESSION.USER_EMAIL_2>
	<cfset user_phone = SESSION.USER_PHONE>
	<cfset user_phone_code = SESSION.USER_PHONE_CODE>
	<cfset user_phone_2 = SESSION.USER_PHONE_2>
	<cfset user_phone_2_code = SESSION.USER_PHONE_2_CODE>
	<cfset user_alias = SESSION.USER_ALIAS>	
	
	<cfset avail_id = SESSION.AVAIL_ID>
	<cfset interest_id = SESSION.INTEREST_ID>
		
	<cfset user_jobtitle = SESSION.USER_JOBTITLE>
	
	<cfset user_needs = SESSION.USER_NEEDS>
	<cfset user_needs_course = SESSION.USER_NEEDS_COURSE>
	<cfset user_needs_frequency = SESSION.USER_NEEDS_FREQUENCY>
	<!--- <cfset user_needs_trainer = SESSION.USER_NEEDS_TRAINER> --->
	<!--- <cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER> --->
	<cfset user_needs_learn = SESSION.USER_NEEDS_LEARN>
	<!--- <cfset user_needs_trainer_complement = SESSION.USER_NEEDS_TRAINER_COMPLEMENT> --->
	<cfset user_needs_complement = SESSION.USER_NEEDS_COMPLEMENT>
	<!--- <cfset user_needs_theme = SESSION.USER_NEEDS_THEME> --->
	<cfset user_needs_duration = SESSION.USER_NEEDS_DURATION>
	<cfset user_needs_expertise_id = SESSION.USER_NEEDS_EXPERTISE_ID>
	<cfset user_needs_speaking_id = SESSION.USER_NEEDS_SPEAKING_ID>
	
	<cfset user_remind_1d = SESSION.USER_REMIND_1D>
	<cfset user_remind_3h = SESSION.USER_REMIND_3H>
	<cfset user_remind_15m = SESSION.USER_REMIND_15M>
	<cfset user_remind_missed = SESSION.USER_REMIND_MISSED>
	<cfset user_remind_cancelled = SESSION.USER_REMIND_CANCELLED>
	<cfset user_remind_scheduled = SESSION.USER_REMIND_SCHEDULED>
	<cfset user_notification_late_canceled = SESSION.USER_NOTIFICATION_LATE_CANCELED>
	
	<cfset user_remind_sms_15m = SESSION.USER_REMIND_SMS_15M>
	<cfset user_remind_sms_missed = SESSION.USER_REMIND_SMS_MISSED>
	<cfset user_remind_sms_scheduled = SESSION.USER_REMIND_SMS_SCHEDULED>
	
	<cfset user_hide_report_all = SESSION.USER_HIDE_REPORT_ALL>
	<cfset user_hide_report_free_remain = SESSION.USER_HIDE_REPORT_FREE_REMAIN>

	<cfset user_timezone_text = SESSION.USER_TIMEZONE>
	
	<cfset user_status_name = SESSION.USER_STATUS_NAME>
	<cfset user_type_id = SESSION.USER_TYPE_ID>

<cfelse>

	<cflocation addtoken="no" url="index.cfm">

</cfif>

<cfif SESSION.USER_PROFILE eq "TRAINER">
	<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#SESSION.USER_ID#",ust_id="2,3,4")>
</cfif>

<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
SELECT user_status_id, UCASE(user_status_name_fr) AS user_status_name FROM user_status
</cfquery>

<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 3
</cfquery>

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",o_by="id")>
<cfset get_order = obj_order_get.oget_orders(u_id="#u_id#",o_by="id",group_by="order_id")>
<!--- <cfset get_trainer_learner = obj_query.oget_trainer_learner(u_id="#u_id#")> --->
<cfset get_todo = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
<cfset get_feedback = obj_task_get.oget_log(u_id="#u_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>

</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>
	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	
	<style>
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	.nav-link {
		color: #999 !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}
	</style>

</head>


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
     
		<cfif SESSION.USER_PROFILE eq "learner">
			<cfset title_page = "#obj_translater.get_translate('title_page_common_learner_account_learner')#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_common_learner_account_trainer')# #user_name#">
		</cfif>

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif isdefined("k")>		
				<cfif k eq "1">
					<div class="alert alert-success" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
					</div>
				<cfelseif k eq "2">
					<div class="alert alert-success" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_user_created')#</cfoutput></em></div>
					</div>
				<cfelseif k eq "3">
					<div class="alert alert-success" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_status_mail_send')#</cfoutput></em></div>
					</div>
				</cfif>
			</cfif>
			
			<cfif isdefined("e")>		
				<cfif e eq "1">
					<div class="alert alert-danger" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_user_already_exist')#</cfoutput></em></div>
					</div>
				</cfif>
			</cfif>
						
			<cfinclude template="./incl/incl_nav_tp.cfm">
		
			<div class="row">
		
				<div class="col-md-12">
					<cfoutput>
					<cfif  listFindNoCase("LEARNER,TEST", SESSION.USER_PROFILE)>
						<cfset user_profile_css = "info">
					</cfif>
					
					<div class="card border">
						<div class="card-body">
							
							<cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-address-card fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_account')#</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>
							</cfif>

							<div class="row">
			
								<div class="col-lg-4" align="center">
						
									
									<!---#obj_lms.get_thumb(user_id="#u_id#",size="50")#--->
									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
									
									<h5 class="title m-0"><span class="lang-lg" lang="#lcase(provider_code)#" style="top:4px"></span> #user_name# [<a href="index.cfm?user_name=#user_email#&upass=#user_password#">GO</a>]</h5>											
									<cfelse>
									<h5 class="title m-0">#user_name#</h5>
									</cfif>											
									
									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										Creation : #dateformat(user_create,'dd/mm/yyyy')#	<cfif user_elapsed neq ""><br><small><strong>#replace(obj_lms.get_format_hms(toformat="#user_elapsed#")," ","","ALL")#</strong></small><cfelse>-</cfif>
										<br>
										<span class="badge badge-secondary">#provider_name#</span>
										<br>
									</cfif>

									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
										
										<!--- <a href="##" class="btn btn_learner_edit_status btn-#user_profile_css#">
										PROFILE OLD :<br>
										#user_profile#
										</a> --->

										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										<a href="##" class="btn btn_learner_edit_status btn-info">
										PROFILE(S) :<br>
										<cfloop query="get_profile">#get_profile.profile_name#<br></cfloop>
										</a>
										</cfif>
										
										<a href="##" class="btn btn_learner_edit_status btn-#user_status_css#">
										STATUS :<br>
										#user_status_name#
										</a>
										
										<a href="##" class="btn btn_learner_edit_status btn-#user_type_css#">
										RANKING :<br>
										#user_type_name#
										</a>
										
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>										
												<!--- <img src="./assets/img/training_#lcase(country_alpha)#.png" width="30" height="30"> --->
												<!--- <cfif country_alpha eq "fr"> --->
												<!--- <h6 style="font-size:16px" class="mt-3"><span class="lang-lg" lang="#lcase(provider_code)#"></span> #provider_name#</h6><br> --->
												<!--- <cfelse> --->
												<!--- <h6 style="font-size:16px" class="mt-3"><span class="lang-lg" lang="de"></span> GERMANY TEAM</h6><br> --->
												<!--- </cfif> --->
												
												<cfif u_id eq "411" 
												OR u_id eq "2030" 
												OR u_id eq "11743"
												OR u_id eq "11744"
												OR u_id eq "25911"
												OR u_id eq "25913"
												OR u_id eq "11745"
												OR u_id eq "11746"
												OR u_id eq "11747"
												OR u_id eq "4348"
												OR u_id eq "4841"
												
												OR u_id eq "11683"
												OR u_id eq "11682"
												OR u_id eq "28538"
												OR u_id eq "27578"
												OR u_id eq "30384"
												>
												<a class="btn" href="updater_reinit_demo.cfm?u_id=#u_id#&reinit=1">REINIT LEARNER DEMO LAUNCHING</a>
												</cfif>
											</cfif>
											
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
											
											<div align="center">
												<cfoutput>
													<a class="btn <cfif get_todo.recordcount neq "0">btn-warning<cfelse>btn-danger</cfif> btn_view_log" id="u_#u_id#" href="##"><i class="fal fa-edit"></i> #get_todo.recordcount# TO DO</a>
													<a class="btn <cfif get_feedback.recordcount neq "0">btn-info<cfelse>btn-danger</cfif> btn_view_log" id="u_#u_id#" href="##"><i class="fal fa-book"></i> #get_feedback.recordcount# FEEDBACK</a>
													<!--- <a class="btn btn_view_log2" id="u_#u_id#" href="##"><i class="fal fa-sticky-note"></i></a> --->
															<!--- <a class="btn btn-info btn_meet_wefit" id="u_#u_id#" href="##"><i class="fa fa-calendar"></i> RDV SETUP</a> --->
												</cfoutput>
											</div>
											
										</cfif>
										
										<!--- <cfif user_profile eq "GUEST"> --->
											<!--- <a href="##" class="btn btn_learner_edit_status btn-#user_profile_css# py-3" >#user_profile#</a> --->
										<!--- <cfelse> --->
											<!--- <a href="##" class="btn btn_learner_edit_status btn-#user_profile_css#" >#user_type_name#<br>#user_profile#</a> --->
											<!--- <a href="##" class="btn btn_learner_edit_status btn-#user_status_css#">Statut<br>#user_status_name#</a> --->
										<!--- </cfif>											 --->
									</cfif>		
										
								</div>
								
								<div class="col-lg-4">
								
									<div class="table-responsive-sm mt-2">
									<table class="table table-sm border">
										<tr>
											<th colspan="2" class="bg-light">
												<label>#obj_translater.get_translate('table_th_details')#</label>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<div class="float-right"><button class="btn btn-success btn-sm btn_learner_edit_account my-0"><i class="fal fa-edit"></i></button></div>
												</cfif>
											</th>
										</tr>
										<tr>
											<td width="25%"><label>#obj_translater.get_translate('table_th_genre')#</label></td>
											<td>#user_gender#</td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_firstname')#</label></td>
											<td>#user_firstname#</td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_lastname')#</label></td>
											<td>#user_lastname#</td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_phone')#</label></td>
											<td>
												<cfif user_phone_code neq "" AND listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>+#user_phone_code#</cfif> 
												 #user_phone#
											</td>
										</tr>
										<cfif user_phone_2 neq "">
										<tr>
											<td><label>#obj_translater.get_translate('table_th_phone')#2</label></td>
											<td>
												<cfif user_phone_2_code neq "" AND listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>+#user_phone_2_code#</cfif> 
												 #user_phone_2#
											</td>
										</tr>
										</cfif>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_email')#</label></td>
											<td>#user_email#</td>
										</tr>
										<cfif user_email_2 neq "">
										<tr>
											<td><label>#obj_translater.get_translate('table_th_email')# 2</label></td>
											<td>#user_email_2#</td>
										</tr>
										</cfif>
										
									</table>
									</div>
								</div>
								
								
								
								<div class="col-lg-4">
								
									<div class="table-responsive-sm mt-2">
									<table class="table table-sm border">
										<tr>
											<th colspan="2" class="bg-light">
												<label>#obj_translater.get_translate('table_th_login')#</label>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<div class="float-right"><button class="btn btn-success btn-sm btn_newmail_launch my-0"><i class="fal fa-edit"></i></button></div>
												</cfif>
											</th>
										</tr>
										<tr>
											<td width="25%"><label>#obj_translater.get_translate('table_th_email')#</label></td>
											<td>#user_email#</td>
										</tr>
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,LEARNER,TEST", SESSION.USER_PROFILE)>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_password')#</label></td>
											<td>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<a href="##" class="btn_mdp_launch">[#obj_translater.get_translate('btn_reset')# ]</a>
												<cfelseif  listFindNoCase("LEARNER,TEST", SESSION.USER_PROFILE)>
												<a href="##" class="btn_edit_mdp">[#obj_translater.get_translate('btn_reset')# ]</a>
												</cfif>
											</td>
										</tr>
										</cfif>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_lms_language')#</label></td>
											<td><span class="lang-sm lang-lbl" lang="#lcase(user_lang)#"></span>
											</td>
										</tr>
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
										<tr>
											<th colspan="2" class="bg-light">
												<label>COMPTE</label>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<div class="float-right"><button class="btn btn-success btn-sm btn_learner_edit_account_group my-0"><i class="fal fa-edit"></i></button></div>
												</cfif>
											</th>
										</tr>										
										<tr>
											<td width="20%"><label>Account</label></td>
											<td colspan="4">
											<cfoutput>
												<img src="./assets/img/training_#provider_code#.png" width="25">
												<a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#</a>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> 
													<span class="badge badge-pill text-white ml-2" style="background-color:###account_manager_color#">#account_manager#</span>
												</cfif>
											</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="20%"><label>Group</label></td>
											<td colspan="4">
											<cfoutput>#group_name#</cfoutput>
											</td>
										</tr>	
										<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> 
										<tr>
											<td width="20%"><label>TM référent<br>NOT UPDATED !</label></td>
											<td colspan="4">
												<cfloop query="get_contact">
													#contact_email#<br>
												</cfloop>
											</td>
										</tr>
										</cfif>																							 --->
										
										</cfif>	
													
										
									</table>
									</div>
									
								</div>
								
							</div>
							
						</div>
						
					</div>
					</cfoutput>
					
				</div>
				
			</div>
					
			<div class="row">
				
				<div class="col-md-12">
				
					<div class="card border">
					
						<div class="card-body">

							<cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-gears fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('accordion_settings')#</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>
							</cfif>
							
							<div id="accordion_learner">
				
								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#tps" aria-expanded="true" aria-controls="tps">
									<span style="font-size:14px"><i class="fal fa-road"></i> <cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput> </span>
									<cfif get_tps.recordcount eq "0">
									<span class="badge badge-danger badge-pill float-right" style="font-size:12px"><cfoutput> #get_tps.recordcount# </cfoutput></span>
									<cfelse>
									<span class="badge badge-success badge-pill float-right" style="font-size:12px"><cfoutput> #get_tps.recordcount# </cfoutput></span>
									</cfif>
									</button>
								</div>
								
								<div id="tps" class="collapse show" data-parent="#accordion_learner">

									<!--- <cfdump var="#get_order#"> --->
									
										<!--- <cfloop query="get_order">
											<cfoutput>

											<table class="table border table-sm">	
												<tr>
													<th colspan="12" class="bg-light">
														<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
															<a class="btn btn-sm btn-#status_finance_css# text-white btn_read_order" id="o_#order_id#" style="cursor:pointer"><cfif order_id eq "1">OFFERT<cfelse>#order_ref# - #status_finance_name# - <span class="badge badge-pill <cfif order_end lt now()>badge-danger<cfelse>badge-success</cfif>">#dateformat(order_end,'dd/mm/yyyy')#</span> <span class="badge badge-pill badge-secondary">#context_name#</span></cfif></a>
															
															<cfif order_end lte now()>
															<a href="##" class="float-right btn-outline-danger btn btn-sm btn_order_email_deadline ml-2" id="orderd_#order_id#"><i class="fal fa-paper-plane"></i> EMAIL DEADLINE</a>
															<cfelse>
															<a href="##" class="float-right btn-outline-danger btn btn-sm btn_order_email_status ml-2" id="orders_#order_id#"><i class="fal fa-paper-plane"></i> EMAIL STATUS</a>
															</cfif>
															<!--- <a href="./tpl/aff_container.cfm?o_id=#order_id#" target="_blank" class="float-right btn-outline-danger btn btn-sm">AFF</a> --->
														<!--- <cfelse> --->
															Deadline : <span class="badge badge-pill <cfif order_end lt now()>badge-danger<cfelse>badge-success</cfif>">#dateformat(order_end,'dd/mm/yyyy')#</span>
														</cfif>
													</th>
												</tr>

											</cfoutput>

											<cfset get_tp = obj_tp_get.oget_tps(o_id="#get_order.order_id#", o_by="method_id")>

											<cfif get_tp.recordcount neq "0">											
												<cfoutput query="get_tp">												
		
												<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
												<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
												<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
												<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
												<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
												
												<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
												<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go>
												<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
												<tr>
													<td width="15%">
														#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
														
														<div class="clearfix"></div>
														<cfif tp_vip eq "1"><i class="fas fa-star text-warning fa-lg"></i></cfif>
														<cfif method_id eq "1" OR method_id eq "2" OR method_id eq "8">
															<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>
															<cfloop query="tp_trainer">
																#obj_lms.get_thumb(planner_id,30)#
															</cfloop>
														</cfif>	
		
													</td>
																										
													<cfif method_id eq "1" OR method_id eq "2" OR method_id eq "8">
													
														<td width="7%" align="center">
															<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
														</td>
														<td width="7%" align="center">
															<cfif tp_group eq "1">
																<span class="badge badge-pill bg-warning border font-weight-normal p-2 cursored btn_edit_tpgroup" id="group_#tp_id#"><strong>Group</strong><br><i class="fal fa-users"></i></span>
															<cfelse>
																<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>Solo</strong><br><i class="fal fa-user"></i></span>
															</cfif>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>Techno</strong><br><cfif techno_alias neq "">#techno_alias#<cfelse>-</cfif></span>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_type_small_desc#"><strong>Type</strong><br><cfif tp_type_alias neq "">#tp_type_alias#<cfelse>-</cfif></span>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_formula_nbcourse# course a week"><strong>Rythm</strong><br><cfif tp_formula_name neq "">#tp_formula_name#<cfelse>-</cfif></span>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_orientation_desc#"><strong>#formation_name#</strong><br><cfif tp_orientation_name neq "">#tp_orientation_name#<cfelse>-</cfif></span>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored btn_read_keyword" id="tpkeyword_#tp_id#"><strong>Themes</strong><br><cfif tp_interest_id neq "" OR tp_function_id neq ""><i class="fal fa-star text-warning"></i><cfelse>-</cfif></span>
														</td>
														<td width="7%" align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>L duration</strong><br><cfif tp_session_duration neq "">#tp_session_duration##obj_translater.get_translate('short_minute')#<cfelse>-</cfif></span>
														</td>
														<td width="10%">	
															<div class="btn-group" role="group">												
																<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="fal fa-calendar-alt"></i><br><cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>	
																<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-up"></i><br><cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
																<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-down"></i><br><cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
																<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fal fa-hourglass-half"></i><br><cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
															</div>
															<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
														#temp#	
														</td>
													<cfelseif method_id eq "3">
														<td width="7%" align="center">
															<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
														</td>
														<td align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2"><strong>eLearning</strong><br>#elearning_name#</span>
														</td>
														<td colspan="7">
														
														</td>
													<cfelseif method_id eq "6">
														<td width="7%" align="center">
															<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
														</td>
														<td align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2">#destination_name#</span>
														</td>
														<td colspan="7">
														
														</td>
													<cfelseif method_id eq "7">
														<td width="7%" align="center">
															<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
														</td>
														<td align="center">
															<span class="badge badge-pill bg-light border font-weight-normal p-2"><strong>Code Entry</strong><br>#token_code#</span>
														</td>
														<td colspan="7">
														
														</td>
													</cfif>
													<td>
														<div class="pull-right">
															
															<div class="btn-group" role="group">
															<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																														
																<!-------------- VISIO / F2F / CERTIF / AUDIT -------------------->
																<cfif method_id eq "1" OR method_id eq "2" OR method_id eq "8" OR method_id eq "7">
																	<cfif method_id eq "1" OR method_id eq "2">
																	<a href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="BUILD" class="btn btn-success btn-sm my-0 <cfif tp_status_id eq "3">disabled</cfif>"><i class="fal fa-wrench"></i></a>
																	</cfif>
																	
																	<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="BOOK" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
																	
																	<cfif method_id eq "1" OR method_id eq "2">
																	<cfquery name="get_lesson_not_signed" datasource="#SESSION.BDDSOURCE#">
																	SELECT lesson_id FROM lms_lesson2 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
																	AND (status_id = 4 OR status_id = 5) AND lesson_signed = 0 AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
																	</cfquery>
																	
																	<cfif get_lesson_not_signed.recordcount neq "0">
																	<a target="_blank" class="btn btn-sm btn-danger" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="#get_lesson_not_signed.recordcount# signatures en attente">AS</a>
																	<cfelse>
																	<a target="_blank" class="btn btn-sm btn-success" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#u_id#">AS</a>
																	</cfif>
																	</cfif>
																
																</cfif>
																
																<button id="tp_#tp_id#_#order_id#" class="btn btn-success btn-sm btn_learner_edit_tp my-0" data-toggle="tooltip" data-placement="top" title="EDIT"><i class="fal fa-edit"></i></button>	
																
																<cfif tp_scheduled_go eq "0" AND tp_done_go eq "0" AND tp_missed_go eq "0" AND tp_cancelled_go eq "0">
																	<a href="updater_tp.cfm?del_tp=1&t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm btn_learner_del_tp my-0"><i class="fal fa-trash-alt"></i></a>
																<cfelse>
																	<a href="##" disabled class="btn btn-success btn-sm btn_learner_del_tp my-0"><i class="fal fa-trash-alt"></i></a>
																</cfif>
																
															<cfelseif SESSION.USER_PROFILE eq "trainer">
																<cfif method_id eq "1" OR method_id eq "2">
																<a href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm my-0"><i class="fal fa-wrench"></i></a>
																<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
																</cfif>
															</cfif>		
															</div>
														</div>
														
														
													</td>
		
												</tr>		
												</cfoutput>


												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
													<cfif user_profile eq "learner" OR user_profile eq "test">
													<tr>
														<td colspan="12" align="right"><button class="btn btn-success btn-sm btn_learner_add_tp" id="add_<cfoutput>#order_id#</cfoutput>"><i class="fal fa-plus"></i></button></td>
													</tr>
													</cfif>
												</cfif>

											<cfelse>
										
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<table class="table table-sm">
												<cfif user_profile eq "learner" OR user_profile eq "test" OR user_profile eq "GUEST">
												<tr>
													<td colspan="12" align="right"><button class="btn btn-success btn-sm btn_learner_add_tp" id="add_<cfoutput>#order_id#</cfoutput>"><i class="fal fa-plus"></i></button></td>
												</tr>
												</cfif>
												</table>
												</cfif>
											
											</cfif>
										</table>

										</cfloop> --->
									

										<!--- ! OLD METHOD AFF TP --->
										
										<!--- --------------------------------------------------------------------------------------------------- --->
										<cfif get_tps.recordcount neq "0">	
											
											
										<cfoutput query="get_tps" group="order_id">
										<table class="table border table-sm">	
										<tr>
											<th colspan="12" class="bg-light">
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
													<a class="btn btn-sm btn-#status_finance_css# text-white btn_read_order" id="o_#order_id#" style="cursor:pointer"><cfif order_id eq "1">OFFERT<cfelseif order_id eq "2">OLD<cfelse>#order_ref# - #status_finance_name# - <span class="badge badge-pill <cfif order_end lt now()>badge-danger<cfelse>badge-success</cfif>">#dateformat(order_end,'dd/mm/yyyy')#</span> <span class="badge badge-pill badge-secondary">#context_name#</span></cfif></a>
													
													<cfif order_end lte now()>
													<a href="##" class="float-right btn-outline-danger btn btn-sm btn_order_email_deadline ml-2" id="orderd_#order_id#"><i class="fal fa-paper-plane"></i> EMAIL DEADLINE</a>
													<cfelse>
													<a href="##" class="float-right btn-outline-danger btn btn-sm btn_order_email_status ml-2" id="orders_#order_id#"><i class="fal fa-paper-plane"></i> EMAIL STATUS</a>
													</cfif>
													<!--- <a href="./tpl/aff_container.cfm?o_id=#order_id#" target="_blank" class="float-right btn-outline-danger btn btn-sm">AFF</a> --->
												<cfelse>
													<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>	Deadline : <span class="badge badge-pill <cfif order_end lt now()>badge-danger<cfelse>badge-success</cfif>">#dateformat(order_end,'dd/mm/yyyy')#</span></cfif>
												</cfif>
											</th>
										</tr>

										

										<cfoutput>

										<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
										<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
										<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
										<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
										<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
										
										<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
										<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go>
										<cfset tp_done_go = tp_completed_go+tp_inprogress_go>

										<tr>
											<td width="15%">
												#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
												<!--- <cfif order_id eq 3 OR order_id eq 2 OR order_id eq 1>
													#lsDateFormat(tp_date_end,'dd/mm/yyyy', 'fr')#
												</cfif> --->
												
												<div class="clearfix"></div>
												<cfif tp_vip eq "1"><i class="fas fa-star text-warning fa-lg"></i></cfif>
												<cfif listFindNoCase("1,2,8,10,11", method_id)>
													<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
													<cfloop query="tp_trainer">
														#obj_lms.get_thumb(planner_id,30)#
													</cfloop>
												</cfif>	
												<cfif listFindNoCase("10", method_id)>
													<img src="./assets/img_level/#tplevel_alias#.svg" width="30">
												</cfif>

											</td>
																								
											<cfif listFindNoCase("1,2,8,10,11", method_id)>
											
												
													<td width="7%" align="center">
														<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
													</td>
													<td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>Start</strong><br>#lsDateFormat(tp_date_start,'dd/mm/yyyy', 'fr')#</span>
													</td>
													<td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>End</strong><br>#lsDateFormat(tp_date_end,'dd/mm/yyyy', 'fr')#</span>
													</td>
											
												<td width="7%" align="center">
													<cfif listFindNoCase("10,11", method_id)>
														<span class="badge badge-pill bg-info border font-weight-normal p-2 cursored btn_edit_tpgroup" id="group_#tp_id#"><strong>#method_name#</strong><br><i class="fal fa-users"></i></span>
													<cfelse>
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>Solo</strong><br><i class="fal fa-user"></i></span>
													</cfif>
												</td>
												<cfif not listFindNoCase("10", method_id)>
													<td width="7%" align="center">
														<span  id="tp_#tp_id#_#u_id#" class="badge badge-pill bg-light border font-weight-normal p-2 cursored">
															<strong>Techno</strong>
														<cfif SESSION.USER_PROFILE eq "trainer"> <button  id="tp_#tp_id#_#u_id#" class="btn btn-success btn_trainer_learner_edit_tp p-1 m-0 " style="min-width: initial !important;" data-toggle="tooltip" data-placement="top" title="EDIT"><i class="fal fa-edit"></i></button> </cfif> 
														<br><cfif techno_alias neq "">#techno_alias#
														<cfelse>-</cfif></span>
															
													</td>
													<!--- <td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_type_small_desc#"><strong>Type</strong><br><cfif tp_type_alias neq "">#tp_type_alias#<cfelse>-</cfif></span>
													</td> --->
													<!--- <td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_formula_nbcourse# course a week"><strong>Rythm</strong><br><cfif tp_formula_name neq "">#tp_formula_name#<cfelse>-</cfif></span>
													</td>
													<td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored" data-toggle="tooltip" data-placement="top" title="#tp_orientation_desc#"><strong>#formation_name#</strong><br><cfif tp_orientation_name neq "">#tp_orientation_name#<cfelse>-</cfif></span>
													</td> --->
													<!--- <td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored btn_read_keyword" id="tpkeyword_#tp_id#"><strong>Themes</strong><br><cfif tp_interest_id neq "" OR tp_function_id neq ""><i class="fal fa-star text-warning"></i><cfelse>-</cfif></span>
													</td> --->
													<td width="7%" align="center">
														<span class="badge badge-pill bg-light border font-weight-normal p-2 cursored"><strong>L duration</strong><br><cfif tp_session_duration neq "">#tp_session_duration##obj_translater.get_translate('short_minute')#<cfelse>-</cfif></span>
													</td>
												<cfelse>
													<td width="7%" align="center"></td>
													<!--- <td width="7%" align="center"></td> --->
													<td width="7%" align="center"></td>
													<!--- <td width="7%" align="center"></td> --->
													<!--- <td width="7%" align="center"></td> --->
													<!--- <td width="7%" align="center"></td> --->
												</cfif>
												<td width="10%">	
													<div class="btn-group" role="group">												
														<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="fal fa-calendar-alt"></i><br><cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>	
														<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-up"></i><br><cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
														<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-down"></i><br><cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
														<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fal fa-hourglass-half"></i><br><cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
													</div>
													<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
												#temp#	
												</td>
											<cfelseif method_id eq "3">
												<td width="7%" align="center">
													<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
												</td>
												<td align="center">
													<span class="badge badge-pill bg-light border font-weight-normal p-2"><strong>eLearning</strong><br>#elearning_name#</span>
												</td>
												<td colspan="5">
												
												</td>
											<cfelseif method_id eq "6">
												<td width="7%" align="center">
													<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
												</td>
												<td align="center">
													<span class="badge badge-pill bg-light border font-weight-normal p-2">#destination_name#</span>
												</td>
												<td colspan="5">
												
												</td>
											<cfelseif method_id eq "7">
												<td width="7%" align="center">
													<span class="badge badge-pill badge-#tp_status_css# font-weight-normal p-2"><strong>Status</strong><br>#status_name#</span>
												</td>
												<td align="center">
													<span class="badge badge-pill bg-light border font-weight-normal p-2"><strong>Code Entry</strong><br>#token_code#</span>
												</td>
												<td colspan="5">
												
												</td>
											</cfif>
											<td>
												<div class="pull-right">
													
													<div class="btn-group" role="group">
													<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																												
														<!-------------- AS MANAGEMENT -------------------->
														<cfif listFindNoCase("1,2,7,8,10,11", method_id)>
															<cfif listFindNoCase("1,2,11", method_id)>
															<a href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="BUILD" class="btn btn-success btn-sm my-0 <cfif tp_status_id eq "3">disabled</cfif>"><i class="fal fa-wrench"></i></a>
															</cfif>
															
															<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="BOOK" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
															
															<cfif (method_id eq "1" OR method_id eq "2") AND (provider_id eq "" OR provider_id neq 2)>
															<cfquery name="get_lesson_not_signed" datasource="#SESSION.BDDSOURCE#">
															SELECT l2.lesson_id FROM lms_lesson2 l2
															LEFT JOIN lms_lesson2_attendance lla ON lla.lesson_id = l2.lesson_id
															WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
															AND (l2.status_id = 4 OR l2.status_id = 5) 
															AND (l2.lesson_signed = 0 OR (lla.lesson_signed <> 1 OR lla.lesson_signed IS NULL)) 
															AND l2.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
															</cfquery>
															
															<cfif get_lesson_not_signed.recordcount neq "0">
															<a target="_blank" class="btn btn-sm btn-danger" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#u_id#" data-toggle="tooltip" data-placement="top" title="#get_lesson_not_signed.recordcount# signatures en attente">AS</a>
															<cfelse>
															<a target="_blank" class="btn btn-sm btn-success" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#u_id#">AS</a>
															</cfif>
															</cfif>
														
														</cfif>
														
														<!----------- EDIT TP ------------->
														<button id="tp_#tp_id#_#order_id#" class="btn btn-success btn-sm btn_learner_edit_tp my-0" data-toggle="tooltip" data-placement="top" title="EDIT"><i class="fal fa-edit"></i></button>	
														
														<!----------- FREE REMAIN ------------->
														<cfif isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
															<cfif listFindNoCase("1,2", method_id)>
															<button id="tp_#tp_id#" class="btn btn-success btn-sm btn_free_remain_tp my-0" data-toggle="tooltip" data-placement="top" title="FREE REMAIN"><i class="fal fa-recycle"></i></button>
															</cfif>
														</cfif>
														
														<!----------- EMAIL ------------->
														<cfif listFindNoCase("1,2", method_id)>
															<cfif tp_status_id eq "2">
														<!--- <cfif listFindNoCase("1,2", method_id) AND isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1"> --->
															<button id="tp_#tp_id#_#order_id#" class="btn btn-success btn-sm btn_followup_email my-0" data-tid="#tp_id#" data-oid="#order_id#" data-uid="#user_id#" data-toggle="tooltip" data-placement="top" title="SEND EMAIL"><i class="fa-thin fa-envelope"></i></button>	
														<!--- </cfif> --->
															</cfif>
														</cfif>

														<!----------- TRASH ------------->
														<cfif tp_scheduled_go eq "0" AND tp_done_go eq "0" AND tp_missed_go eq "0" AND tp_cancelled_go eq "0">
															<a href="updater_tp.cfm?del_tp=1&t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm btn_learner_del_tp my-0"><i class="fal fa-trash-alt"></i></a>
														<cfelse>
															<a href="##" disabled class="btn btn-success btn-sm btn_learner_del_tp my-0"><i class="fal fa-trash-alt"></i> </a>
														</cfif>



														<!--- </cfif> --->
														
													<cfelseif SESSION.USER_PROFILE eq "trainer">
														<cfif listFindNoCase("1,2,11", method_id)>
														
														<a href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm my-0"><i class="fal fa-wrench"></i></a>
														<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#u_id#" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
														</cfif>
													</cfif>		
													</div>
												</div>
												
												
											</td>

										</tr>
										</cfoutput>
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										<cfif user_profile eq "learner" OR user_profile eq "test">
										<tr>
											<td colspan="12" align="right"><button class="btn btn-success btn-sm btn_learner_add_tp" id="add_#order_id#"><i class="fal fa-plus"></i></button></td>
										</tr>
										</cfif>
										</cfif>
										
										</table>
									</cfoutput> 
										
										
									<cfelse>
										
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										<table class="table table-sm">
										<cfif user_profile eq "learner" OR user_profile eq "test" OR user_profile eq "GUEST">
										<tr>
											<tdalign="right"><button class="btn btn-success btn-sm btn_learner_add_tp" id="add_#order_id#"><i class="fal fa-plus"></i></button></td>
										</tr>
										</cfif>
										</table>
										</cfif>
									
									</cfif>
									
								</div>
								</cfif>
								
								
								
								
								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#launch" aria-expanded="true" aria-controls="launch">
									<span style="font-size:14px"><i class="fal fa-rocket"></i> Action / Lancement </span>
									</button>
								</div>
								
								<div id="launch" class="collapse" data-parent="#accordion_learner">
									
									<a href="" class="btn btn-success btn_learner_launch <cfif (user_profile neq "learner" AND user_profile neq "GUEST") OR user_status_id neq "2" OR user_type_id eq "7">disabled</cfif>" role="button">
									Lancer<br>Formation
									</a>
									
									<a href="" class="btn btn-success btn_test_launch <cfif user_profile neq "test" OR user_status_id neq "2">disabled</cfif>" role="button">
									Lancer<br>Test
									</a>
									
									<a href="" class="btn btn-success btn_learner_launch <cfif user_profile neq "learner" OR user_status_id neq "2" OR user_type_id neq "7">disabled</cfif>" role="button">
									Lancer<br>Gymglish
									</a>

									<a href="" class="btn btn-success btn_tm_launch <cfif !listfind(profile_list,'8') OR user_type_id neq "4">disabled</cfif>" role="button">
									Lancer<br>TM
									</a>

									<a href="" class="btn btn-success btn_sms_launch <cfif !listfind(profile_list,'11') OR user_status_id neq "2">disabled</cfif>" role="button">
										Lancer<br>SMS
									</a>

									<a href="" class="btn btn-success btn_partner_launch <cfif user_profile neq "PARTNER" OR !(user_type_id eq "7" OR user_type_id eq "4") >disabled</cfif>" role="button">
										Lancer<br>PARTNER
									</a>

									<div class="row">
									<div class="col-md-6">
									<cfoutput>
									<table class="table table-bordered">
										<!--- <tr>
											<td>Step NA</td>
											<td><cfif not listfind(user_steps,"1")>Done<cfelse>Not done</cfif></td>
											<td><cfif not listfind(user_steps,"1")><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=1&close_quick_steps=1" class="btn btn-warning btn-sm">Unclose step</a><cfelse><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=1" class="btn btn-info btn-sm">Close step</a></cfif></td>
										</tr> --->
										<tr>
											<td>Step PT</td>
											<td><cfif not listfind(user_steps,"2")>Done<cfelse>Not done</cfif></td>
											<td><cfif not listfind(user_steps,"2")><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=2&close_quick_steps=1" class="btn btn-warning btn-sm">Unclose step</a><cfelse><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=2" class="btn btn-info btn-sm">Close step</a></cfif></td>
										</tr>
										<tr>
											<td>Step LST</td>
											<td><cfif not listfind(user_steps,"3")>Done<cfelse>Not done</cfif></td>
											<td><cfif not listfind(user_steps,"3")><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=3&close_quick_steps=1" class="btn btn-warning btn-sm">Unclose step</a><cfelse><a href="updater_learner.cfm?u_id=#u_id#&updt_learner=1&updt_quick_steps=3&" class="btn btn-info btn-sm">Close step</a></cfif></td>
										</tr>
									</table>
									</cfoutput>
									</div>
									</div>
									<!---<a href="" class="btn btn-success disabled" role="button">
									Email<br>Progression
									</a>
									<a href="" class="btn btn-success disabled" role="button">
									Email<br>Relance
									</a>--->
									
								</div>										
								</cfif>
								
								
								
								
								
								
								<!--- <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#access" aria-expanded="true" aria-controls="access">
									<span style="font-size:14px"><i class="fal fa-key"></i> <cfoutput>#obj_translater.get_translate('table_th_access')#</cfoutput> </span>
									<cfif get_trainer_learner.recordcount eq "0" OR get_tpmaster_access.recordcount eq "0">
									<span class="badge badge-danger badge-pill float-right" style="font-size:12px"><i class="fal fa-exclamation-triangle"></i></span>
									<cfelse>
									<span class="badge badge-success badge-pill float-right" style="font-size:12px"><i class="fal fa-check"></i></span>
									</cfif>
									</button>
								</div>
								
								<div id="access" class="collapse" data-parent="#accordion_learner">
									
									<table class="table table-sm">
									
										<tr>
											<th colspan="5" class="bg-light">
											<label><cfoutput>#obj_translater.get_translate('table_th_access')#</cfoutput></label>
											<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
											<div class="float-right"><button class="btn btn-info btn-sm btn_learner_edit_abo my-0"><i class="fal fa-edit"></i></button></div>
											</cfif>
											</th>
										</tr>
										<tr>
											<td width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_syllabus')#</cfoutput></label></td>
											<td colspan="4">
												<cfoutput query="get_tpmaster_access">					
												<h6><span class="badge badge-success badge-pill">[#tpmaster_level#] #tpmaster_name#</span></h6>
												</cfoutput>												
											</td>
										</tr>
										<tr>
											<td width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_trainers')#</cfoutput></label></td>
											<td colspan="4">
												<cfoutput query="get_trainer_learner">												
												#obj_lms.get_thumb(user_id="#user_id#",size="30")# #user_firstname#<br>
												</cfoutput>
											</td>
										</tr>
										
									</table>	
									
								</div>
								</cfif> --->
								
						
																	
								
								
								<cfif user_type_id neq "7">
									<div>
										<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#avails">
										<span style="font-size:14px">
											<i class="fal fa-calendar-alt"></i>
											<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<cfoutput>#obj_translater.get_translate('accordion_availabilities')#</cfoutput> 
											<cfelse>
												<cfoutput>#obj_translater.get_translate('accordion_my_availabilities')#</cfoutput>
											</cfif>
										</span>
										<cfif avail_id eq "">
											<span class="badge badge-danger badge-pill float-right" style="font-size:12px"><i class="fal fa-exclamation-triangle"></i></span>
										<cfelse>
											<span class="badge badge-success badge-pill float-right" style="font-size:12px"><i class="fal fa-check"></i></span>
										</cfif>
										</button>
									</div>
									
									<div id="avails" class="collapse" data-parent="#accordion_learner">
										<cfinclude template="./widget/wid_user_availability.cfm">
									</div>
								</cfif>
								




								
								
								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#tests">
									<span style="font-size:14px"><i class="fal fa-theater-masks"></i> <cfoutput>#obj_translater.get_translate('table_th_tests')#</cfoutput> </span>
									</button>
								</div>
								
								<div id="tests" class="collapse" data-parent="#accordion_learner">


								<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#")>
								<cfset _lg_rep = "">

								<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
									<cfdump var="#get_pt#">
								</cfif> --->

									<!--- <cfdump var="#get_pt#"> --->
									<cfloop query="get_pt">

										<cfif get_pt.quiz_global_score eq "">

											<!--- <p>Hello ##</p> --->
											<cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
												<cfinvokeargument name="u_id" value="#u_id#">
												<cfinvokeargument name="quiz_user_group_id" value="#get_pt.quiz_user_group_id#">
											</cfinvoke>
							
											<cfset reload_pt = true>
										</cfif>
							
									</cfloop>

									<cfif isDefined("reload_pt")>
										<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#")>
									</cfif>
								
						<!--- <cfdump var="#get_pt#"> --->


								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
									<cfquery name="get_levels" datasource="#SESSION.BDDSOURCE#">
										SELECT formation_id, formation_code, level_id, level_code, level_sub_id, level_sub_code, level_verified, level_date
										FROM user_level
										WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
										AND skill_id = 0
									</cfquery>
									
									<cfif get_levels.recordCount GT 0>
										
									<h6>
									CURRENT GLOBAL LEVEL
									</h6>

									<div class="row">
										<div class="col-md-12">
											<div class="card border">

												<div class="d-flex align-items-center">

												<!--- ! here loopin on PT --->
												<cfoutput query="get_levels">

													<cfif get_levels.currentRow GT 1>
														<div class="m-2">
															-
														</div>
													</cfif>

													<div class="m-3" align="center">
														<img src="./assets/img_formation/#formation_id#.png" width="50">

														<cfif level_sub_id neq "">
															<img src="./assets/img_sublevel/#level_sub_id#_plain.svg" width="50">
														<cfelse>
															<img src="./assets/img_level/#level_code#.svg" width="50">
														</cfif>
														<!--- <br>
														<span>
															#lsDateFormat(level_date, "yyyy-mm-dd", 'fr')#
														</span> --->
														<br>
														<span>
															<cfif level_verified>
																Verified
															<cfelse>
																Unverified
															</cfif>
														</span>
														<br>
														#obj_function.get_dateformat(level_date)#
													</div>
														
												</cfoutput>
												</div>

												</div>
											</div>
										</div>
									</cfif>									
								</cfif>

								<h6>
									PLACEMENT TESTS
								</h6>
								
								<div class="row">
									<div class="col-md-12">
										<div class="card border">

											<!--- ! here loopin on PT --->
											<cfoutput query="get_pt" group="quiz_user_group_id">

												<cfif quiz_user_group_id neq "">
												<div class="d-flex align-items-center">
													<div class="m-2">
														<img src="./assets/img/training_#lCase(get_pt.formation_code)#.png" width="50"></span>
													</div>
													<div class="m-2">
														#obj_dater.get_dateformat(get_pt.quiz_user_start)#
													</div>
													<div class="m-2">
														<cfif pt_speed eq "fpt">
															<!--- FULL PLACEMENT TEST --->
															<span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
														<cfelseif pt_speed eq "qpt">
															<!--- QUICK PLACEMENT TEST --->
															<span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
														</cfif>
													</div>
													<div class="m-2">

														<cfset _lg_rep = listAppend(_lg_rep, formation_code)>
														<cfinclude template="./incl/incl_pt_result.cfm">
														
													</div>	
													<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
														<div class="m-2">
															<cfoutput group="tp_id">
																<!--- <cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#tp_id#")> --->
																<cfif tp_duration neq "">
																	#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#

																</cfif>

																<cfif type eq "start">
																	<!--- <br> --->
																	#obj_translater.get_translate('text_start_level')#
																	<!--- (Start level) --->
																<cfelseif type eq "end">
																	<!--- <br> --->
																	#obj_translater.get_translate('text_end_level')#
																	<!--- (End level) --->
																</cfif>
																</br>
															</cfoutput>
														</div>
														<div class="m-2">
															<cfif isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
																<a href="updater_quiz.cfm?del_qpt_#lCase(get_pt.formation_code)#=1&u_id=#u_id#&quiz_user_group_id=#quiz_user_group_id#" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-trash-alt"></i></a>
															</cfif>
															<a href="##" target="_blank" class="btn btn-outline-success btn-sm my-0 btn_swap_quiz_id" id="quiz_#quiz_user_group_id#"><i class="fal fa-repeat"></i></a>
														</div>	
													</cfif>																	
												</div>
												</cfif>

											</cfoutput>

										</div>
									</div>
								</div>
								<!--- <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
									<cfdump var="#_lg_rep#">
								</cfif> --->
								<!--- <cfloop list="#SESSION.LIST_PT#" index="lang_select">
									<cfif not listFindNoCase(_lg_rep, lang_select)>
										<cfif evaluate("user_qpt_#lang_select#") neq "" AND (evaluate("user_qpt_lock_#lang_select#") eq "0" OR evaluate("user_qpt_lock_#lang_select#") eq "")>
											<div class="row">
												<div class="col-md-12">
													<div class="card border">
														<cfoutput>
															<cfif findnocase("A0",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "success">
															<cfelseif findnocase("A1",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "success">
															<cfelseif findnocase("A2",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "primary">
															<cfelseif findnocase("B1",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "info">
															<cfelseif findnocase("B2",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "warning">
															<cfelseif findnocase("C1",evaluate("user_qpt_#lang_select#"))>
																<cfset css = "danger">
															<cfelse>
																<cfset css = "danger">
															</cfif>
															<div class="d-flex align-items-center">
																<div class="m-2">
																	<img src="./assets/img/training_#lang_select#.png" width="50"></span>
																</div>
																<div class="m-2">
																	#obj_translater.get_translate('text_not_verified')#
																</div>
																<div class="m-2">
																	<a class="badge badge-#css# badge-pill p-3 mt-2 font-weight-normal text-white" style="font-size:14px">
																		#obj_translater.get_translate('table_th_global_level')#
																	<br>
																	<h6 class="mt-1 mb-0">#evaluate("user_qpt_#lang_select#")#</h6>
																	</a>
																</div>
																<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>															
																	<cfoutput>
																		<a href="updater_quiz.cfm?del_qpt_#lang_select#=1&u_id=#u_id#" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-trash-alt"></i></a>	
																	</cfoutput>															
																</cfif>	 --->
															</div>
														</cfoutput>		
													</div>
												</div>
											</div>
										</cfif>
									</cfif>
								</cfloop> --->
									
								
									<table class="table table-sm">
									
										<tr>
											<td width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_mini_lst')#</cfoutput></label></td>
											<cfif user_lst neq "">
												<cfif get_result_lst.recordcount neq "0">
													<td>
													<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
														<cfoutput><a href="##" target="_blank" class="btn btn-sm btn-success btn_view_quiz" id="quser_#get_result_lst.quiz_user_id#">#obj_translater.get_translate('btn_results_test')#</a></cfoutput>
													<cfelseif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end eq "">
														<cfif listFindNoCase("GUEST,TEST,LEARNER", SESSION.USER_PROFILE)>
														<cfoutput><a href="./quiz.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-danger">#obj_translater.get_translate('btn_continue')# test</a></cfoutput>
														</cfif>																
													</cfif>	
													</td>	
													<td align="right">
													<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>															
														<cfoutput>
														<a href="updater_quiz.cfm?del_lst=1&u_id=#u_id#" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-trash-alt"></i></a>
														</cfoutput>															
													</cfif>	
													</td>															
												</cfif>
											<cfelse>
												<td colspan="2">
												<cfif listFindNoCase("GUEST,TEST,LEARNER", SESSION.USER_PROFILE)>
													<a href="quiz_start.cfm?t=lst" class="btn btn-sm btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
												</cfif>
												</td>
											</cfif>
										</tr>
									</table>
										
								</div>
								</cfif>
								
								
								
								<cfif user_type_id neq "7">
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#needs">
									<span style="font-size:14px"><i class="fal fa-question"></i> 
									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										<cfoutput>#obj_translater.get_translate('accordion_needs')#</cfoutput>
									<cfelse>
										<cfoutput>#obj_translater.get_translate('accordion_my_needs')#</cfoutput>
									</cfif>
									</span>
									<cfif user_needs eq "">
									<span class="badge badge-danger badge-pill float-right" style="font-size:12px"><i class="fal fa-exclamation-triangle"></i></span>
									<cfelse>
									<span class="badge badge-success badge-pill float-right" style="font-size:12px"><i class="fal fa-check"></i></span>
									</cfif>
									</button>
								</div>
								
								<div id="needs" class="collapse" data-parent="#accordion_learner">
									<cfinclude template="widget/wid_learner_needs.cfm">
								</div>
								</cfif>
								
								
								
								
								
								
								
								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,LEARNER,TEST", SESSION.USER_PROFILE)>
								<!--- <cfif user_type_id neq "7"> --->
								<div>
									<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#settings">
									<span style="font-size:14px"><i class="fal fa-cog"></i>
									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
										<cfoutput>#obj_translater.get_translate('accordion_settings')#</cfoutput>
									<cfelse>
										<cfoutput>#obj_translater.get_translate('accordion_my_settings')#</cfoutput>
									</cfif>
									</span>
									</button>
								</div>
								
								<div id="settings" class="collapse" data-parent="#accordion_learner">
									<cfoutput>
									<table class="table table-sm">
										<tr>
											<th colspan="4" class="bg-light">
												<label>#obj_translater.get_translate('table_th_notifications')#</label>
												<div class="float-right"><button class="btn btn-info btn-sm btn_learner_edit_settings my-0"><i class="fal fa-edit"></i></button></div>
											</th>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_24h')#</label></td>
											<td><cfif user_remind_1d eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
											<td><label>#obj_translater.get_translate('table_th_scheduled_lesson')#</label></td>
											<td><cfif user_remind_scheduled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_3h')#</label></td>
											<td><cfif user_remind_3h eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
											<td><label>#obj_translater.get_translate('table_th_cancelled_lesson')#</label></td>
											<td><cfif user_remind_cancelled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_15m')#</label></td>
											<td><cfif user_remind_15m eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
											<td><label>#obj_translater.get_translate('table_th_missed_lesson')#</label></td>
											<td><cfif user_remind_missed eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_notif_cancel')#</label></td>
											<td><cfif user_notification_late_canceled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										<cfif user_lang eq "fr">
										<tr>
											<th colspan="4" class="bg-light">
												<label>#obj_translater.get_translate('table_th_notifications_sms')#</label>
											</th>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_15m')#</label></td>
											<td><cfif user_remind_sms_15m eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
											<td><label>#obj_translater.get_translate('table_th_missed_lesson')#</label></td>
											<td><cfif user_remind_sms_missed eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td><label>#obj_translater.get_translate('table_th_scheduled_lesson')#</label></td>
											<td><cfif user_remind_sms_scheduled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
										</tr>
										</cfif>
										<tr>
											<th colspan="4" class="bg-light">
												<label>#obj_translater.get_translate('table_th_params')#</label>
											</th>
										</tr>
										<!--- <tr>
											<td><label>#obj_translater.get_translate('table_th_timezone')#</label></td>
											<td colspan="3">#user_timezone_text#</td>
										</tr> --->
										<tr>
											<td><label>#obj_translater.get_translate('table_th_lms_language')#</label></td>
											<td>
												<span class="lang-sm lang-lbl" lang="#lcase(user_lang)#"></span>
											</td>
										</tr>
										<tr>
											<td><label>#obj_translater.get_translate('table_th_mini_course_duration')#</label></td>
											<td colspan="3">
											<cfif user_needs_duration eq "">
												NC
											<cfelse>													
												#user_needs_duration# min
											</cfif>
											</td>
										</tr>
										<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
											<tr>
												<td><label>PT Mandatory</label></td>
												<td><cfif user_pt_mandatory eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
											</tr>
											<tr>
												<th colspan="4" class="bg-light">
													<!--- <label>#obj_translater.get_translate('table_th_params')#</label> --->
													<label>PARAMETRES ADMIN</label>
												</th>
											</tr>
											<tr>
												<!--- <td><label>#obj_translater.get_translate('table_th_timezone')#</label></td> --->
												<td><label>Report Hide ALL</label></td>
												<td colspan="3">
													<input type="checkbox" class="m-1 form-check-input" id="user_hide_report_all" <cfif user_hide_report_all eq 1>checked</cfif>>
												</td>
											</tr>
											<tr>
												<td><label>Report Hide Free Remain</label></td>
												<td colspan="3">
													<input type="checkbox" class="m-1 form-check-input" id="user_hide_report_free_remain" <cfif user_hide_report_free_remain eq 1>checked</cfif>>
												</td>

											</tr>
										</cfif>
									</table>
									</cfoutput>
								</div>
								<!--- </cfif> --->
								</cfif>
								
								<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
									<div>
										<button class="btn btn-outline-<cfoutput>#user_profile_css#</cfoutput> btn-block text-left" data-toggle="collapse" data-target="#orders">
										<span style="font-size:14px"><i class="fal fa-cart-plus"></i> Orders</span>
										</button>
									</div>
								
									<div id="orders" class="collapse" data-parent="#accordion_learner">
										<cfset get_orders = obj_order_get.oget_orders(u_id="#u_id#")>	
										<!--- <cfdump var="#get_orders#">	 --->
										<cfset view_order = "full">
										<cfinclude template="./widget/wid_order_list.cfm">	
									</div>
								</cfif>
								
								
							</div>
						
						</div>
					</div>
					
					
				</div>

			</div>
			
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {
	$('.btn_trainer_learner_edit_tp').click(function(event) {	
			
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];

			$('#modal_title_xl').text("Editer parcours");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_trainer_tool_edit.cfm?t_id="+t_id+"&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
	
	<cfoutput>
	$('.btn_view_qpt').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_group_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('btn_results_test'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&u_id=#u_id#", function() {});
	})
	
	
	$('.btn_read_keyword').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_keywords'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_tp_keyword.cfm?t_id="+t_id, function() {});
	})
	
	$('.btn_view_quiz').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})

	$('.btn_swap_quiz_id').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_swap'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz_tp.cfm?quiz_id="+quiz_id+"&u_id=#u_id#", function() {});
	})
	
	
	</cfoutput>
	
	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,LEARNER,TEST", SESSION.USER_PROFILE)>
		

		
		$('.btn_edit_order').click(function(event) {
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var a_id = idtemp[2];
			var o_id = idtemp[3];

			console.log(a_id, o_id)
			$('#window_item_xl').modal({keyboard: true, backdrop: "static"});
			$('#modal_title_xl').text("Order - " + o_id);
			$('#modal_body_xl').empty();
			$('#modal_body_xl').load("modal_window_order_create.cfm?a_id="+a_id+"&o_id="+o_id, function() {});
		});

		$('.btn_learner_edit_avail').click(function(event) {
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_avail_edit')#</cfoutput>");		
			$('#modal_body_lg').load("u..cfm?display=avail&u_id=<cfoutput>#u_id#</cfoutput>");
		});
		
		
		$('.btn_learner_edit_account').click(function(event) {
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_account_edit')#</cfoutput>");		
			$('#modal_body_lg').load("modal_window_learner.cfm?display=account&u_id=<cfoutput>#u_id#</cfoutput>");
		});
		
		$('.btn_learner_edit_settings').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_settings_edit')#</cfoutput>");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_settings&u_id=<cfoutput>#u_id#</cfoutput>");
		});
		
		$('.btn_meet_wefit').click(function(event) {
		
			event.preventDefault();		
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("Meet WEFIT");
			$('#modal_body_lg').load("modal_window_calendar_cs.cfm?u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
	</cfif>
	
	<cfif listFindNoCase("LEARNER,TEST", SESSION.USER_PROFILE)>
	
		
		/******************** EDIT PASSWORD *****************************/
		$('.btn_edit_mdp').click(function(event) {	
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");
			$('#modal_body_lg').load("_modal_window_mdp_reset.cfm?reinit=1", function() {
			
				
			});

		});
	
		
		
		
	
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
		

	
	
		$('.btn_generate_aff').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var o_id = idtemp[1];
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("G\u00e9n\u00e9rer document pour signature");
			$('#modal_body_lg').load("modal_window_generator.cfm?d_aff=1&o_id="+o_id, function() {
			
				
			});
		});
	
		$('.btn_learner_edit_profile').click(function(event) {
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("Editer profil");		
			$('#modal_body_lg').load("modal_window_needs.cfm?u_id=<cfoutput>#u_id#</cfoutput>", function() {
				$('[data-toggle="tooltip"]').tooltip({
				html:true,
				animation:false,
				trigger:"click"
				});
			});
		});
		
		$('.btn_learner_edit_account_group').click(function(event) {
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("Editer compte");		
			$('#modal_body_lg').load("modal_window_learner.cfm?display=account_group&u_id=<cfoutput>#u_id#</cfoutput>");
		});
		
		$('.btn_learner_add_tp').click(function(event) {
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var o_id = idtemp[1];
			$('#modal_title_lg').text("Cr\u00e9er parcours");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_tp.cfm?create_tp=1&u_id=<cfoutput>#u_id#</cfoutput>&o_id="+o_id, function() {});
		});				
		
		$('.btn_order_email_status').click(function(event) {
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var o_id = idtemp[1];
			$('#modal_title_lg').text("Envoyer Email");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').empty();
			$('#modal_body_lg').load("modal_window_email.cfm?send_email=send_status&u_id=<cfoutput>#u_id#</cfoutput>&o_id="+o_id, function() {});
		});	
		
		$('.btn_order_email_deadline').click(function(event) {
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var o_id = idtemp[1];
			$('#modal_title_lg').text("Envoyer Email");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').empty();
			$('#modal_body_lg').load("modal_window_email.cfm?send_email=send_deadline&u_id=<cfoutput>#u_id#</cfoutput>&o_id="+o_id, function() {});
		});	

		$('.btn_followup_email').click(function(event) {
			event.preventDefault();
			$('#modal_title_lg').text("Envoyer Email");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').empty();
			$('#modal_body_lg').load("modal_window_email.cfm?send_email=send_followup_2&u_id="+$(this).data('uid')+"&t_id="+$(this).data('tid')+"&o_id="+$(this).data('oid'), function() {});
		});	
		
		$('.action_tp').change(function(event) {		
			event.preventDefault();			
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var u_id = idtemp[1];
			var t_id = idtemp[2];
			var o_id = idtemp[3];
			var act = $(this).val();
			if(act == "BUILD")
			{
				document.location.href="common_tp_builder.cfm?t_id="+t_id+"&u_id="+u_id;
			}
			else if (act == "BOOK")
			{
				document.location.href="common_tp_details.cfm?t_id="+t_id+"&u_id="+u_id;
			}
			else if (act == "EDIT")
			{
				$('#modal_title_lg').text("Editer parcours");
				$('#window_item_lg').modal({keyboard: true});
				$('#modal_body_lg').load("modal_window_tp.cfm?t_id="+t_id+"&u_id="+u_id+"&o_id="+o_id, function() {});
			}
			else if (act == "DELETE")
			{
				document.location.href="updater_tp.cfm?del_tp=1&t_id="+t_id+"&u_id="+u_id;
			}
			else if (act == "AS")
			{
				window.open("./tpl/as_container.cfm?t_id="+t_id+"&u_id="+u_id)
			}
			
			
			
		});
		
		$( "#user_hide_report_all" ).change(function(event) {
			$.ajax({
				url : './api/users/user_post.cfc?method=switch_user_hide_report',
				type : 'POST',
				data : {
					u_id: <cfoutput>#u_id#</cfoutput>,
					all: 1
				},				
				success : function(result, status) {
					console.log("yes")
				}
			});
		});

		$( "#user_hide_report_free_remain" ).change(function(event) {
			$.ajax({
				url : './api/users/user_post.cfc?method=switch_user_hide_report',
				type : 'POST',
				data : {
					u_id: <cfoutput>#u_id#</cfoutput>,
					fr: 1
				},				
				success : function(result, status) {
					console.log("yes")
				}
			});
		});
		
		$('.btn_edit_tpgroup').click(function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("TP group");
			$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id, function() {});
		});
		

		$('.btn_free_remain_tp').click(function(event) {		
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			$('#modal_title_xl').text("Free Remain");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_tp_remove_tp_free_remain.cfm?t_id="+t_id+"&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
		$('.btn_learner_del_tp').click(function(event) {
			if(!confirm("Confirmer suppression du TP ?"))
			{
			return false;
			}
		});
		
		$('.btn_learner_edit_tp').click(function(event) {		
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var o_id = idtemp[2];
			/*alert(t_id);
			alert(o_id);*/
			$('#modal_title_xl').text("Editer parcours");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_tp.cfm?t_id="+t_id+"&u_id=<cfoutput>#u_id#</cfoutput>&o_id="+o_id, function() {});
		});

		$('.btn_learner_del_tp').click(function(event) {
			if(!confirm("Confirmer suppression du TP ?"))
			{
			return false;
			}
		});
		
		// $('.btn_learner_edit_abo').click(function(event) {		
		// 	event.preventDefault();
		// 	$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_access_edit')#</cfoutput>");
		// 	$('#window_item_lg').modal({keyboard: true});
		// 	$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_abo&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		// });
		
		$('.btn_learner_launch').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Lancer Learner");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_launch.cfm?learner_launch=1&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
		$('.btn_test_launch').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Lancer Test");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_launch.cfm?test_launch=1&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});

		$('.btn_tm_launch').click(function(event) {
			event.preventDefault();

			if(confirm("Confirmer l'envoi de mail ?")) {
		
				$.ajax({
					url : 'api/users/user_post.cfc?method=updt_send_access',
					type : 'POST',
					data : {
						user_id:<cfoutput>#u_id#</cfoutput>
					},				
					success : function(result, status) {
						// console.log(result)
						if (result == "1") {
							alert("Mail envoyé.")
						} else {
							alert("Attention ! une erreur est survenue.");
						}
					}
				});
			}
		});

		$('.btn_sms_launch').click(function(event) {
			event.preventDefault();

			if(confirm("Confirmer l'envoi de mail ?")) {
		
				$.ajax({
					url : 'api/users/user_post.cfc?method=updt_send_access',
					type : 'POST',
					data : {
						user_id:<cfoutput>#u_id#</cfoutput>,
						is_sms:1
					},				
					success : function(result, status) {
						// console.log(result)
						if (result == "1") {
							alert("Mail envoyé.")
						} else {
							alert("Attention ! une erreur est survenue.");
						}
					}
				});
			}
		});

		<!--- new option is_partner for other email --->
		$('.btn_partner_launch').click(function(event) {
			event.preventDefault();

			if(confirm("Confirmer l'envoi de mail ?")) {
		
				$.ajax({
					url : 'api/users/user_post.cfc?method=updt_send_access',
					type : 'POST',
					data : {
						user_id:<cfoutput>#u_id#</cfoutput>,
						is_partner:1
					},				
					success : function(result, status) {
						// console.log(result)
						if (result == "1") {
							alert("Mail envoyé.")
						} else {
							alert("Attention ! une erreur est survenue.");
						}
					}
				});
			}
		});
		
		$('.btn_migration_launch').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Lancer Migration");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_launch.cfm?migration_launch=1&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});

		$('.btn_mdp_launch').click(function(event) {	
			event.preventDefault();
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("R\u00e9initialiser mot de passe");
			$('#modal_body_lg').load("modal_window_launch.cfm?mdp_launch=1&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
		$('.btn_newmail_launch').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Changer email principal");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_launch.cfm?newmail_launch=1&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
		$('.btn_learner_edit_status').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Changer statut learner");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_status&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
		
		$('.btn_learner_edit_type').click(function(event) {		
			event.preventDefault();
			$('#modal_title_lg').text("Changer type learner");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_type&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
		});
	
	<cfelseif SESSION.USER_PROFILE eq "trainer">
	
	$('.btn_edit_tpgroup').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("TP group");
		$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id, function() {});
	});

	// $('.btn_learner_edit_abo').click(function(event) {		
	// 	event.preventDefault();
	// 	$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_access_edit')#</cfoutput>");
	// 	$('#window_item_lg').modal({keyboard: true});
	// 	$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_abo&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
	// });
	
	$('.action_tp').change(function(event) {		
			event.preventDefault();			
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var u_id = idtemp[1];
			var t_id = idtemp[2];
			var o_id = idtemp[3];
			var act = $(this).val();
			if(act == "BUILD")
			{
				document.location.href="common_tp_builder.cfm?t_id="+t_id+"&u_id="+u_id;
			}
			else if (act == "BOOK")
			{
				document.location.href="common_tp_details.cfm?t_id="+t_id+"&u_id="+u_id;
			}
		});
	
		$('.change_learner').change(function(){
			document.location.href="common_learner_account.cfm?u_id="+$(this).val();	
		})


	</cfif>
	
})
</script>	

</body>
</html>