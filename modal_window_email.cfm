<cfif listFindNoCase("CS,SALES,TRAINERMNG,FINANCE", SESSION.USER_PROFILE)>

	<cfparam name="send_email">
	<cfparam name="u_id">
	<cfparam name="o_id" default="0">
	<cfparam name="t_id" default="0">

	<cfif !listFindNoCase("FINANCE", SESSION.USER_PROFILE) AND SESSION.USER_ID neq 202>
		<cfif listFindNoCase("send_status,send_deadline", send_email)>
			<cfset send_email = "send_followup_1">
		</cfif>
	</cfif>
	
	<!------------------------- GET USER ---------------------------->
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>

	<cfset user_email = get_user.user_email>
	<cfset lang = get_user.user_lang>
	<cfset provider_id = get_user.provider_id>

	
	<!------------------------- GET ORDERS ---------------------------->
	<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
		SELECT o.order_id, o.order_ref, u.user_firstname, u.user_name
		FROM orders o
		LEFT JOIN orders_users ou ON o.order_id = ou.order_id
		LEFT JOIN user u ON u.user_id = ou.user_id
		WHERE ou.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		ORDER BY o.order_ref ASC
	</cfquery>

	<!------------------------- GET TP LIST ---------------------------->
	<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",o_id="#o_id#",m_id="1,2,3")>

	<cfif t_id eq 0 AND get_tps.recordCount GT 0>
		<cfset data = QueryGetRow(get_tps, 1) >
		<cfset t_id = data.tp_id>
	</cfif>

	<!------------------------- GET TP SOLO ---------------------------->
	<cfinvoke component="api/tp/tp_get" method="oget_tp" returnvariable="get_tp">
		<cfinvokeargument name="t_id" value="#t_id#">
		<cfinvokeargument name="u_id" value="#u_id#">
		<cfinvokeargument name="lang" value="#lang#">
	</cfinvoke>

	<!------------------------- GET TRAINER ATTACHED ---------------------------->
	<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>


	<div class="row">

		<div class="col-md-12">

			<div class="card border shadow-sm">

				<div class="bg-light">
					<h6 align="center" class="m-2">Settings</h6>
				</div>

				<div class="card-body">
					<table class="table table-sm" align="left">
						<tr>
							<td width="120">Template</td>
							<td>
								<select name="mail_category" class="mail_category form-control">

									<cfif listFindNoCase("FINANCE", SESSION.USER_PROFILE) OR SESSION.USER_ID eq 202>
										<option value="send_status" <cfif send_email eq "send_status">selected</cfif>>send status</option>
										<option value="send_deadline" <cfif send_email eq "send_deadline">selected</cfif>>send deadline</option>
									</cfif>
									<option value="b2c_prospect" <cfif send_email eq "b2c_prospect">selected</cfif>>b2c_prospect</option>

									
									<option value="send_followup_1" <cfif send_email eq "send_followup_1">selected</cfif>>send followup 1</option>
									<option value="send_followup_2" <cfif send_email eq "send_followup_2">selected</cfif>>send followup 2</option>
									<option value="send_followup_3" <cfif send_email eq "send_followup_3">selected</cfif>>send followup 3</option>
									<!--- <option value="send_test" <cfif send_email eq "send_test">selected</cfif>>send send_test</option> --->
									<option value="send_launching_1" <cfif send_email eq "send_launching_1">selected</cfif>>send launching 1</option>
									<!--- <option value="send_launching_2" <cfif send_email eq "send_launching_2">selected</cfif>>send launching 2</option>
									<option value="send_launching_3" <cfif send_email eq "send_launching_3">selected</cfif>>send launching 3</option> --->
									<!--- <option value="send_linguaskill_register_b2b" <cfif send_email eq "send_linguaskill_register_b2b">selected</cfif>>send Linguaskill register b2b</option>
									<option value="send_linguaskill_register_cpf" <cfif send_email eq "send_linguaskill_register_cpf">selected</cfif>>send Linguaskill register cpf</option>
									<option value="send_bright_register_cpf" <cfif send_email eq "send_bright_register_cpf">selected</cfif>>send bright register cpf</option>
									<option value="send_toeic" <cfif send_email eq "send_toeic">selected</cfif>>send toeic</option>
									<option value="send_linguaskill_confirm_b2b" <cfif send_email eq "send_linguaskill_confirm_b2b">selected</cfif>>send Linguaskill confirm</option> --->
								</select>
							</td>
						</tr>
						<tr>
							<td>TP</td>
							<td>
								<select class="mail_tp form-control" id="tp_id" name="tp_id">
									<cfif u_id neq 0>
										<cfoutput query="get_tps">
											<option value="#tp_id#" <cfif tp_id eq t_id>selected</cfif>>
												#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
													- DEADLINE #lsDateFormat(tp_date_end,'yyyy-mm-dd', 'fr')#
											</option>
										</cfoutput>	
									</cfif>
									<option value="3" <cfif o_id eq "">selected</cfif>>FREE REMAIN</option>
									<option value="2" <cfif o_id eq "">selected</cfif>>OLD</option>
									<option value="1" <cfif o_id eq "">selected</cfif>>OFFERT</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Order ID</td>
							<td>
								<select class="mail_order form-control" id="order_id" name="order_id">
									<cfif u_id neq 0>
										<cfoutput query="get_orders">
											<option value="#order_id#" <cfif order_id eq o_id>selected</cfif>>#replace(order_ref,'-','')# - #user_firstname# #user_name#</option>
										</cfoutput>	
									</cfif>
									<option value="3" <cfif o_id eq "">selected</cfif>>FREE REMAIN</option>
									<option value="2" <cfif o_id eq "">selected</cfif>>OLD</option>
									<option value="1" <cfif o_id eq "">selected</cfif>>OFFERT</option>
								</select>
							</td>
						</tr>

					</table>
					

				</div>
			</div>
		</div>

	</div>

	<form method="post" action="updater_sendmail_lms.cfm">	


	<div class="row">
		<div class="col-md-12">
			<div class="card border shadow-sm">
				<div class="bg-light">
					<h6 align="center" class="m-2">ADD TASK</h6>
				</div>

				<div class="card-body">

					<!------------ TASK ADDER -------->
					<cfset get_to = obj_task_get.oget_to()>		
					<cfset get_task_list_todo = obj_task_get.oget_task_list(task_type="cs",category="TO DO")>
					<cfset get_task_list_feedback = obj_task_get.oget_task_list(task_type="cs",category="FEEDBACK")>
					<cfinclude template="./widget/wid_todo.cfm">

				</div>
			</div>
		</div>
	</div>

		<div class="row">
			<div class="col-md-12">
				<div class="card border shadow-sm">
					<div class="bg-light">
						<h6 align="center" class="m-2">Email details</h6>
					</div>

					<div class="card-body">
						<table class="table table-sm" align="left">
							<tr>
								<td width="120">TO :</td>
								<td>
									<cfoutput>#user_email#</cfoutput>
								</td>
							</tr>
							<tr>
								<td>CC :</td>
								<td>
									<input type="text" id="" name="mail_cc" class="form-control"> <small>*séparer par des virgules</small>
								</td>
							</tr>
							<tr>
								<td>BCC :</td>
								<td>
									<input type="text" id="" name="mail_bcc" class="form-control" value="service@wefitgroup.com"> <small>*séparer par des virgules</small>
								</td>
							</tr>
							<!--- <tr>
								<td>SUBJECT :</td>
								<td>
								
								</td>
							</tr> --->
							<tr>
								<td colspan="2">
								
								<!------------ TEMPLATE EMAIL -------->
		
									
								
								</td>
							</tr>
						</table>


						<cftry>
						<cfswitch expression="#send_email#">
							<cfcase value="send_status">
								Objet : <cfoutput>WEFIT | Votre formation arrive bientôt à échéance</cfoutput><br>

								<cfinclude template="./email/email_admin_followup.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_deadline">
								Objet : <cfoutput>WEFIT | Votre formation est arrivée à son terme</cfoutput><br>

								<cfinclude template="./email/email_admin_deadline.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_followup_1">
								
								<cfset email_header_img = "header_email_launching_regular.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 1>
								<cfset lang = get_user.user_lang>
								
								Objet : <cfoutput>#obj_translater.get_translate(id_translate="email_subject_followup_1",lg_translate="#lang#")#</cfoutput><br>

								<cfinclude template="./email/email_cs_followup.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_followup_2">
								<cfinvoke component="components/translater" method="get_translate" returnVariable="subject_followup_2">
									<cfinvokeargument name="id_translate" value="email_subject_followup_2">
									<cfinvokeargument name="lg_translate" value="#lang#">
								</cfinvoke>
								
								<cfset email_header_img = "header_email_launching_regular.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 2>
								<cfset lang = get_user.user_lang>

								Objet : <cfoutput>#obj_translater.get_translate(id_translate="email_subject_followup_2",lg_translate="#lang#")#</cfoutput><br>

								<cfinclude template="./email/email_cs_followup.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_followup_3">
								
								<cfset email_header_img = "header_email_launching_regular.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 3>
								<cfset lang = get_user.user_lang>
								
								Objet : <cfoutput>#obj_translater.get_translate(id_translate="email_subject_followup_3",lg_translate="#lang#")#</cfoutput><br>


								<cfinclude template="./email/email_cs_followup.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_launching_1">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_launching_1')#</cfoutput><br>

								<cfset email_header_img = "header_email_guest.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 1>

								<cfinclude template="./email/email_cs_launching.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_launching_2">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_launching_2')#</cfoutput><br>

								<cfset email_header_img = "header_email_launching_regular.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 2>

								<cfinclude template="./email/email_cs_launching.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_launching_3">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_launching_3')#</cfoutput><br>

								<cfset email_header_img = "header_email_reminder.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = 3>

								<cfinclude template="./email/email_cs_launching.cfm">
							</cfcase>

							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_linguaskill_register_b2b">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_linguaskill_register_b2b')#</cfoutput><br>

								<cfset email_header_img = "header_email_prospect.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = "linguaskill_b2b">

								<cfinclude template="./email/email_cs_test_register.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_linguaskill_register_cpf">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_linguaskill_register_cpf')#</cfoutput><br>

								<cfset email_header_img = "header_email_launching_test.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = "linguaskill_cpf">

								<cfinclude template="./email/email_cs_test_register.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_bright_register_cpf">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_bright_register_cpf')#</cfoutput><br>

								<cfset email_header_img = "header_email_reminder.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = "bright_cpf">

								<cfinclude template="./email/email_cs_test_register.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_toeic">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_toeic')#</cfoutput><br>

								<cfset email_header_img = "header_email_reminder.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = "toeic">

								<cfinclude template="./email/email_cs_test_register.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="send_linguaskill_confirm_b2b">
								Objet : <cfoutput>#obj_translater.get_translate('email_subject_linguaskill_confirm_b2b')#</cfoutput><br>

								<cfset email_header_img = "header_email_lesson_booked.jpg">
								<cfset email_icon = "icon_reminder.png">
								<cfset btn_lms = "Accéderà mon parcours">
								<cfset btn_href = "https://lms.wefitgroup.com">
								<cfset template = "linguaskill_confirm">

								<cfinclude template="./email/email_cs_test_confirm.cfm">
							</cfcase>
							<!--- !!!!!!!!!!!!!!!!!! --->
							<cfcase value="b2c_prospect">
								Objet : <cfoutput>WEFIT Formation en Langues | Qu'en pensez-vous ?</cfoutput><br>

								<cfset user_email = get_user.user_email>
								<cfset user_firstname = get_user.user_firstname>
								<cfset user_lastname = get_user.user_name>
								<cfset lang = get_user.user_lang>

								<cfset subject = "WEFIT Formation en Langues | Qu'en pensez-vous ?">

								<cfinclude template="./email/email_prospect.cfm">
							</cfcase>
							<cfcase value="send_test">
								Objet : <cfoutput>send_test</cfoutput><br>

								<cfset user_email = get_user.user_email>
								<cfset user_firstname = get_user.user_firstname>
								<cfset user_lastname = get_user.user_name>
								<cfset lang = get_user.user_lang>

								<cfset subject = "send_test">
								<cfset email_header_img = "header_email_na_done.jpg">

								<cfinclude template="./email/email_new_launch_learner.cfm">
							</cfcase>
						</cfswitch>
						<cfcatch type="any">
							Error : Mail could not be loaded
						</cfcatch>
						</cftry>

					</div>

			
			<cfoutput>
			<input type="hidden" name="o_id" value="#o_id#">
			<input type="hidden" name="u_id" value="#u_id#">
			<input type="hidden" name="t_id" value="#t_id#">
			<input type="hidden" id="add_todo" name="add_todo" value="false">
			<input type="hidden" name="send_email" value="#send_email#">
			
			<div align="center" class="mt-5">
				<input type="submit" class="btn btn-info" value="Envoyer email">
			</div>
			</cfoutput>
		</form>
	

	<script>
		$(document).ready(function() {

			var add_todo_b = 0;
			$(".activatetodo").change(function(event) {		
				event.preventDefault();		
				add_todo_b = !add_todo_b;
				$('#add_todo').val(add_todo_b);
			});
		
			$('.mail_category').change(function(event) {		
				event.preventDefault();		
				$('#modal_body_lg').empty();		
				$('#modal_body_lg').load("modal_window_email.cfm?<cfoutput>u_id=#u_id#&o_id=#o_id#&t_id=#t_id#</cfoutput>&send_email=" + $(this).val(), function() {});
			});
		
			$('.mail_order').change(function(event) {		
				event.preventDefault();		
				$('#modal_body_lg').empty();		
				$('#modal_body_lg').load("modal_window_email.cfm?<cfoutput>u_id=#u_id#&send_email=#send_email#&t_id=#t_id#</cfoutput>&o_id=" + $(this).val(), function() {});
			});

			$('.mail_tp').change(function(event) {		
				event.preventDefault();		
				$('#modal_body_lg').empty();		
				$('#modal_body_lg').load("modal_window_email.cfm?<cfoutput>u_id=#u_id#&send_email=#send_email#&o_id=#o_id#</cfoutput>&t_id=" + $(this).val(), function() {});
			});
		})
	</script>

</cfif>