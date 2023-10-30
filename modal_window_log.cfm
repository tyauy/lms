
<cfset __by = obj_translater.get_translate('by')>
<cfset __for = obj_translater.get_translate('for')>

<cfif listFindNoCase("TRAINER,TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset get_to = obj_task_get.oget_to()>
	<cfset get_task_channel_todo = obj_task_get.oget_task_channel(task_channel_type="todo")>
	<cfset get_task_channel_fb = obj_task_get.oget_task_channel(task_channel_type="fb")>

	<!------------------- SET DATA DEPENDING ON ENTRY (GROUP, ACCOUNT, USER...) ------------>
	<cfif isdefined("g_id")>
	
		<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
		SELECT g.group_id, g.group_name, provider_code
		FROM account_group g
		WHERE g.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfquery>
		
		<cfset a_id = 0>
		<cfset g_name = get_group.group_name>
		<cfset u_id = 0>
		<cfset list_tab = "group|city|g_id|sales|g_name">
		<cfset view_tab = "group">
		
	<cfelseif isdefined("a_id")>
	
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_id, a.account_name, a.group_id, g.group_name, provider_code
		FROM account a
		INNER JOIN account_group g ON g.group_id = a.group_id
		LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id
		WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfquery>
		
		<cfset a_name = get_account.account_name>
		<cfset g_id = get_account.group_id>
		<cfset g_name = get_account.group_name>
		<cfset u_id = 0>
		<cfset list_tab = "group|city|g_id|sales|g_name,account|building|a_id|sales|a_name">
		<cfset view_tab = "account">
		
	<cfelseif isdefined("u_id")>
	
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT u.account_id, a.group_id, a.account_name, g.group_name, provider_code
		FROM user u
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN account_group g ON g.group_id = a.group_id
		LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
	
		<cfset get_user = obj_query.oget_learner_solo(u_id="#u_id#")>
		
		<cfset a_id = get_account.account_id>
		<cfset a_name = get_account.account_name>
		<cfset g_id = get_account.group_id>
		<cfset g_name = get_account.group_name>

		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfset list_tab = "learner|user|u_id|trainer|u_name">
		<cfelseif SESSION.USER_PROFILE eq "TM">
			<cfset list_tab = "learner|user|u_id|tm|u_name">
		<cfelse>
			<cfset list_tab = "learner|user|u_id|cs|u_name">
		</cfif>
			
		<cfset view_tab = "learner">
		<cfset u_name = "#get_user.user_firstname# #get_user.user_name#">

	</cfif>

	<!------------------- GET PROVIDER FOR HOLIDAYS DISABLING ------------>

	<cfset provider_code = get_account.provider_code neq "" ? get_account.provider_code : "fr">

	<cfquery name="get_holiday" datasource="#SESSION.BDDSOURCE#">
	SELECT holiday_date
	FROM settings_holiday
	WHERE provider_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#provider_code#">
	</cfquery>

	<cfloop list="#list_tab#" index="cor" delimiters=",">
	
		<!---- TRICK FOR FORCING TM DISPLAY ----->
		<!--- <cfif SESSION.USER_PROFILE eq "TM">
			<cfset profile_id = "5">
		<cfelse>
			<cfset profile_id = SESSION.USER_PROFILE_ID>
		</cfif> --->
		<!---- GET CONTENT FOR DATABASE ----->
		<cfif listgetat(cor,1,'|') eq "group">
			<cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="TO DO",log_status="1",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
		</cfif>
		<cfif listgetat(cor,1,'|') eq "account">
			<cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="TO DO",log_status="1",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
		</cfif>
		<cfif listgetat(cor,1,'|') eq "learner">
			<cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="1",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
			<cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
		</cfif>

		<!---- GET LISTING DROPDONWS FROM DATABASE ----->
		<cfset "get_task_list_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_task_list(task_type="#listgetat(cor,4,'|')#",category="TO DO",profile_id="#SESSION.USER_PROFILE_ID#")>
		<cfset "get_task_list_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_task_list(task_type="#listgetat(cor,4,'|')#",category="FEEDBACK",profile_id="#SESSION.USER_PROFILE_ID#")>

	</cfloop>



	
	
		<!--- TODO auto task --->
		<!--- <cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
		SELECT o.order_id, o.order_ref
		FROM orders_users ou
		INNER JOIN orders o ON o.order_id = ou.order_id
		WHERE ou.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",o_by="id",m_id="1,2,9")> --->
		<!--- <cfquery name="get_tps" datasource="#SESSION.BDDSOURCE#">
			SELECT t.tp_id
			FROM lms_tpuser tu
			INNER JOIN lms_tp t ON t.tp_id = tu.tp_id
			WHERE tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery> --->


<!--- <cfelseif SESSION.USER_PROFILE eq "trainer">

	<cfset get_log_feedback = obj_task_get.oget_log(u_id="#u_id#",category="FEEDBACK",o_by="date_desc",profile_id="4")>
	<cfset get_task_list_feedback = obj_task_get.oget_task_list(category="FEEDBACK",profile_id="4")>
	<cfset list_tab = "learner|user|u_id|cs|u_name">
	<cfset get_user = obj_query.oget_learner_solo(u_id="#u_id#")>
	<cfset view_tab = "learner">
	<cfset g_id = 0>
	<cfset a_id = 0>
	<cfset u_name = "#get_user.user_firstname# #get_user.user_name#">

<cfelseif SESSION.USER_PROFILE eq "tm">

	<cfset get_log_feedback = obj_task_get.oget_log(u_id="#u_id#",category="FEEDBACK",o_by="date_desc")>
	<cfset get_task_list_feedback = obj_task_get.oget_task_list(category="FEEDBACK")>
	<cfset list_tab = "learner|user|u_id|cs|u_name">
	<cfset get_user = obj_query.oget_learner_solo(u_id="#u_id#")>
	<cfset view_tab = "learner">
	<cfset g_id = 0>
	<cfset a_id = 0>
	<cfset u_name = "#get_user.user_firstname# #get_user.user_name#"> --->

</cfif>




<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
<ul class="nav nav-tabs" id="log_list" role="tablist">
	<cfloop list="#list_tab#" index="cor" delimiters=",">
		<cfoutput>
		<li class="nav-item">		
		<a href="###listgetat(cor,1,"|")#_view" class="nav-link <cfif listgetat(cor,1,"|") eq view_tab>active</cfif>" role="tab" data-toggle="tab">
		<i class="fal fa-#listgetat(cor,2,"|")#" class="text-red"></i> #evaluate(listgetat(cor,5,"|"))#
		</a>
		</li>
		</cfoutput>
	</cfloop>
</ul>
</cfif> --->

<div class="tab-content">
	<cfloop list="#list_tab#" index="cor" delimiters=",">
	<div role="tabpanel" class="tab-pane fade <cfif listgetat(cor,1,"|") eq view_tab>active show</cfif>" id="<cfoutput>#listgetat(cor,1,"|")#_view</cfoutput>">
		




		<!--- SHOW NAVIGATION ONLY FOR ADMIN --->
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<div align="center">
			<cfoutput>
				<!--- <cfif g_id neq "0" AND g_id neq "">
				<cfquery name="get_account_lead" datasource="#SESSION.BDDSOURCE#">
				SELECT a.account_id
				FROM account a
				INNER JOIN account_group g ON g.group_id = a.group_id
				WHERE g.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#"> LIMIT 1
				</cfquery>
				<a href="crm_account_edit.cfm?a_id=#get_account_lead.account_id#" target="_blank" class="btn btn-sm btn-outline-info"><i class="fal fa-city"></i> #g_name#</a>
				</cfif> --->
				<cfif a_id neq "0" AND a_id neq "">
				<a href="crm_account_edit.cfm?a_id=#a_id#" target="_blank" class="btn btn-sm btn-outline-info"><i class="fal fa-building"></i> #a_name#</a>
				</cfif>
				<cfif u_id neq "0">
					<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
					SELECT up.profile_name
					FROM user_profile up 
					INNER JOIN user_profile_cor upc ON upc.profile_id = up.profile_id
					WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
					</cfquery>
					
					<cfif get_profile.profile_name eq "TRAINER">
						<a href="common_trainer_account.cfm?p_id=#u_id#" target="_blank" class="btn btn-sm btn-outline-info"><i class="fal fa-user"></i> #u_name#</a>
					<cfelse>
						<a href="common_learner_account.cfm?u_id=#u_id#" target="_blank" class="btn btn-sm btn-outline-info"><i class="fal fa-user"></i> #u_name#</a>
					</cfif>


				</cfif>
				
			</cfoutput>
		</div>
		</cfif>
		














		
		<!-------------------- DISPLAY TO DO ONLY FOR ADMIN --------------->
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

			
		<cfset querygo = evaluate("get_log_todo_#listgetat(cor,1,'|')#")>
		<cfset querygo_done = evaluate("get_log_todo_done_#listgetat(cor,1,'|')#")>
			

		<div class="bg-light border border-warning p-2 mt-3">

			<div class="d-flex justify-content-between">
				<div>
					<h5 class="mt-0 text-warning"><i class="fa-light fa-lg fa-edit text-warning mr-2"></i> To do</h5>
				</div>
				<div>
					<button type="button" class="btn btn-sm btn-secondary btn_toggle_todo_done" style="min-width:20px !important">  ARCHIVES <span class="badge badge-secondary"><cfoutput>#querygo_done.recordcount#</cfoutput></span></button>
					<button type="button" class="btn btn-sm btn-warning btn_toggle_todo" style="min-width:20px !important"><i class="fal fa-plus"></i>  ADD TO DO</button>
				</div>
			</div>
			

			<div class="collapse" id="<cfoutput>table_create_todo_#listgetat(cor,1,"|")#</cfoutput>">
			<form id="form_insert_todo_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>">

				<table class="table table-sm table-bordered bg-white">
					<!--- <tr>
						<td class="bg-light" width="120"><strong>Channel</strong></td>
						<td colspan="2">
							<cfoutput>
							<cfloop query="get_task_channel_todo">
								<label><input type="radio" required name="task_channel_id" value="#task_channel_id#"> <i class="fa-light #task_channel_icon#"></i> #task_channel_name# </label>&nbsp;&nbsp;&nbsp;
							</cfloop>
							</cfoutput>
						</td>
					</tr> --->
					<tr>
						<td class="bg-light" width="120"><strong>Destinataire</strong></td>
						<td colspan="2">
							<select class="form-control form-control-sm" name="to_id">
							<option value="0">Tous</option>
							<cfoutput query="get_to">
							<option value="#user_id#">#user_firstname#</option>
							</cfoutput>
							</select>
						</td>
					</tr>
					<cfif isdefined("u_id") and u_id neq 0>
					<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
					SELECT o.order_id, o.order_ref, os.status_finance_name
					FROM user u
					LEFT JOIN orders_users ou ON u.user_id = ou.user_id
					LEFT JOIN orders o ON o.order_id = ou.order_id
					LEFT JOIN order_status_finance os ON os.status_finance_id = o.order_status_id
					WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
					</cfquery>
					<!--- <tr> --->
						<!--- <td class="bg-light" width="120"><strong>Order</strong></td> --->
						<!--- <td> --->
						<!--- <cfoutput query="get_order"> --->
						<!--- <label><input type="checkbox" name="order_id" value="#order_id#"> #order_ref# <em>(#status_finance_name#)</em> </label><br> --->
						<!--- </cfoutput> --->
						<!--- </td> --->
					<!--- </tr> --->
					</cfif>
					
					<tr>
						<td class="bg-light"><strong>Comments</strong></td>
						<td colspan="2"><textarea name="log_text" class="form-control"></textarea></td>
					</tr>

					<tr>
						<td class="bg-light"><strong>&Eacute;cheance</strong></td>
						<td width="150">
						<label><input type="checkbox" name="log_remind_ok" id="log_remind_ok" value="1" checked="checked"> Activer pour le</label>
						</td>
						<td>
						<div class="controls">
							<div class="input-group">
								<cfoutput>
								<input id="log_remind_create_#listgetat(cor,1,'|')#" name="log_remind" type="text" class="datepicker form-control" value="#dateformat(now(),'dd/mm/yyyy')# 08:00" />
								<label for="log_remind_create_#listgetat(cor,1,'|')#" class="input-group-addon btn"><i class="fal fa-calendar-alt"></i></label>
								</cfoutput>
							</div>
						</div>
						</td>
					</tr>

					
					<tr>
						<!--- <td class="bg-light"><strong><cfoutput>#obj_translater.get_translate('table_th_vocab_category')#</cfoutput></strong></td> --->
						<td colspan="3" align="center">
							<cfoutput query="get_task_list_todo_#listgetat(cor,1,'|')#" group="task_group">
								<a type="button" class="p-1 btn_display_todo" id="##displaytodo_#task_group#" style="color:###task_color#; border:2px solid ###task_color# !important; font-weight:bold; font-size:13px; text-decoration:none !important">#task_group_alias#</a>
							</cfoutput>

							<cfoutput query="get_task_list_todo_#listgetat(cor,1,'|')#" group="task_group">
								<div class="collapse p-2 mt-2 todo_container" id="todo_#task_group#" style="border:2px solid ###task_color#">
									<div class="container">
									
									<cfoutput group="task_group_sub">
										<div class="row border-bottom p-1 bg-light"><div class="col-sm-12" align="center"><strong>#task_group_sub#</strong></div></div>
										<cfoutput>
										<div class="row border-bottom p-1" align="left">
											<div class="col-sm-4"><label><input type="checkbox" name="task_type_id" value="#task_type_id#"> #task_type_name#</label></div>
											<div class="col-sm-5">#task_explanation#</div>
											<div class="col-sm-2">
												<cfif listfind(profile_id,5)><label><span class="badge badge-pill badge-danger">CS</span></h5></label></cfif>
												<cfif listfind(profile_id,2)><label><span class="badge badge-pill badge-danger">SAL</span></h5></label></cfif>
												<cfif listfind(profile_id,6)><label><span class="badge badge-pill badge-danger">FIN</span></h5></label>&nbsp;</cfif>
												<cfif listfind(profile_id,8)><label><span class="badge badge-pill badge-info">TM</span></h5></label>&nbsp;</cfif>
												<cfif listfind(profile_id,4)><label><span class="badge badge-pill badge-success">T</span></h5></label>&nbsp;</cfif>
											</div>
											<div class="col-sm-1">
												<cfif task_automation neq "">
													<a class="btn btn-sm btn-warning" data-toggle="tooltip" data-placement="top" title="#task_automation#"><i class="fal fa-cog"></i></a>
												</cfif>
											</div>
											
										</div>
										</cfoutput>
									</cfoutput>

								
									</div>
								</div>
							</cfoutput>
						</td>

					</tr>

					<tr>
						
						<td colspan="3" align="center">
							<cfoutput>
							
							<cfif listgetat(cor,1,'|') eq "group">
							<input type="hidden" name="g_id" value="#g_id#">
							</cfif>
							<cfif listgetat(cor,1,'|') eq "account">
							<input type="hidden" name="a_id" value="#a_id#">
							</cfif>
							<cfif listgetat(cor,1,'|') eq "learner">
							<input type="hidden" name="u_id" value="#u_id#">
							</cfif>
							
							<input type="hidden" name="task_category" value="TO DO">
							<input type="hidden" name="act" value="ins">
							<input type="submit" value="SAVE TO DO" class="btn btn-sm btn-warning">
							</cfoutput>
						</td>
					</tr>
	
					
				</table>
	
			</form>
			</div>













			<cfif querygo.recordcount neq "0">
				<div class="collapse show" id="table_todo_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>">
				<table class="table table-sm m-0">
					<tbody>
					<cfoutput query="querygo" group="log_id">
					<tr class="bg-light">

						<td width="35%" align="left">

							<form class="form-inline form_update">

								<input id="log_remind_#listgetat(cor,1,'|')#_#log_id#" name="log_remind" type="text" class="datepicker form-control" value="#dateformat(log_remind,'dd/mm/yyyy')# #timeformat(log_remind,'HH:mm')#" style="width:150px">
								&nbsp;
								<cfset dest_id = to_id>
								<!--- <cfif dest_id neq ""> --->
									#__for# &nbsp;
									<select class="form-control form-control-sm" name="to_id">
									<option value="0">Tous</option>
									<cfloop query="get_to">
									<option value="#get_to.user_id#" <cfif get_to.user_id eq dest_id>selected</cfif>>#get_to.user_firstname#</option>
									</cfloop>
									</select>
								<!--- <cfelse>
									-
								</cfif> --->

								<input type="hidden" name="log_id" value="#log_id#">
								<!--- <cfif g_id neq "0" AND g_id neq ""> --->
								<!--- <input type="hidden" name="g_id" value="#g_id#"> --->
								<!--- </cfif> --->
								<!--- <cfif a_id neq "0" AND a_id neq ""> --->
								<!--- <input type="hidden" name="a_id" value="#a_id#"> --->
								<!--- </cfif> --->
								<cfif u_id neq "0" AND u_id neq "">
									<input type="hidden" name="u_id" value="#u_id#">
								<cfelse>
									<cfif a_id neq "0" AND a_id neq "">
									<input type="hidden" name="a_id" value="#a_id#">
									<cfelse>
									<input type="hidden" name="g_id" value="#g_id#">
									</cfif>
								</cfif>
								<input type="hidden" name="act" value="updt">
								&nbsp;
								<input type="submit" value="UPDT" class="btn btn-sm btn-warning d-inline p-1">
							
							</form>
							
						</td>


						<!--- <td width="15%" align="center">
						
							<cfif listlen(task_channel_id) gte "1">
								<div class="border-bottom bg-white p-2">
									<cfloop query="get_task_channel_fb">
										<cfif listfind(querygo.task_channel_id,get_task_channel_fb.task_channel_id)><i class="fa-light #task_channel_icon# text-info fa-lg" aria-hidden="true" title="#task_channel_alias#"></i></cfif>
									</cfloop>
								</div>
							</cfif>
							<small><br>#__by# #sender#</small>
							
						</td> --->
			
						<td width="55%" style="font-size:12px">
							<cfoutput>
								<div class="border-bottom bg-white p-1 m-1">
									<div class="row">
										<div class="col-md-1" style="padding:0px !important; align-self: center; text-align: center;">
											<input type="checkbox" class="log_item_status_done" data-item='#task_type_id#' data-log='#log_id#' name="log_item_status_done" <cfif log_item_status eq 1> checked</cfif>>
										</div>
										<div class="col-md-5">
											<span class="badge text-white" style="background-color:###task_color#; font-size:12px; white-space:pre-wrap;">#task_type_name#</span>
											
											<cfif task_explanation_long neq "">
												<button class="btn btn-sm btn-red btn_help_task" id="t_#task_type_id#">?</button>
											</cfif>
											
											<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
											<cfif listfind(profile_id,"5")><span class="badge border" style="font-size:12px">CS</span></cfif>
											<cfif listfind(profile_id,"2")><span class="badge border" style="font-size:12px">SAL</span></cfif>
											<cfif listfind(profile_id,"6")><span class="badge border" style="font-size:12px">FIN</span></cfif>
											<cfif listfind(profile_id,"3")><span class="badge border" style="font-size:12px">L</span></cfif>
											<cfif listfind(profile_id,"4")><span class="badge border" style="font-size:12px">T</span></cfif>
											<cfif listfind(profile_id,"8")><span class="badge border" style="font-size:12px">TM</span></cfif>
											</cfif> --->
										</div>
										<div class="col-md-6">
											#task_explanation#
										</div>
									</div>
								</div>
							</cfoutput>

							<cfif log_text neq "">
								<p class="m-1"><img src="../assets/img/logo_wefit_solo_150.png" width="20" align="left" class="mr-1">#log_text#</p>
							</cfif>
						</td>
						<td align="right" width="10%">
							<cfif log_status neq "1">
							<a class="btn btn-sm btn-warning p-1 btn_close_todo" id="log_#log_id#">CL.</a>
							</cfif>
							<cfif isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
							<button class="btn btn-sm btn-danger p-1 btn_delete_todo" id="todo_#log_id#"><i class="fal fa-times"></i></button>
							</cfif>
						</td>
					</tr>
					</cfoutput>
					</tbody>
				</table>
				</div>
			</cfif>
			
			











			<cfif querygo_done.recordcount neq "0">
			<div class="collapse" id="table_todo_done_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>">
				<table class="table table-sm m-0">
					<tbody>
					<cfoutput query="querygo_done" group="log_id">
					<tr class="bg-light">
	
						<td width="40%" align="left">
	
							<form class="form-inline">
	
								<input id="log_remind_#listgetat(cor,1,'|')#_#log_id#" disabled name="log_remind" type="text" class="datepicker form-control" value="#dateformat(log_remind,'dd/mm/yyyy')# #timeformat(log_remind,'HH:mm')#" style="width:150px">
								&nbsp;
								<cfset dest_id = to_id>
								<cfif dest_id neq "">
									#__for# &nbsp;
									<select class="form-control form-control-sm" disabled name="to_id">
									<option value="0">Tous</option>
									<cfloop query="get_to">
									<option value="#get_to.user_id#" <cfif get_to.user_id eq dest_id>selected</cfif>>#get_to.user_firstname#</option>
									</cfloop>
									</select>
								<cfelse>
									-
								</cfif>
							
							</form>
							
						</td>
	
	
						<td width="10%" align="center">
							
							<cfif listlen(task_channel_id) gte "1">
								<div class="border-bottom bg-white p-2">
								<cfloop query="get_task_channel_fb">
									<cfif listfind(querygo.task_channel_id,get_task_channel_fb.task_channel_id)><i class="fa-light #task_channel_icon#" aria-hidden="true" title="#task_channel_alias#"></i> <br></cfif>
								</cfloop>
								</div>
							</cfif>
							
						</td>
			
						<td width="50%" style="font-size:12px">
							<cfoutput>
								<div class="border-bottom bg-light p-1 m-1">
									<div class="row">
										<div class="col-md-6">
											<span class="badge text-white" style="background-color:###task_color#; font-size:12px">#task_type_name#</span>
											<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
											<cfif listfind(profile_id,"5")><span class="badge border" style="font-size:12px">CS</span></cfif>
											<cfif listfind(profile_id,"2")><span class="badge border" style="font-size:12px">SAL</span></cfif>
											<cfif listfind(profile_id,"6")><span class="badge border" style="font-size:12px">FIN</span></cfif>
											<cfif listfind(profile_id,"3")><span class="badge border" style="font-size:12px">L</span></cfif>
											<cfif listfind(profile_id,"4")><span class="badge border" style="font-size:12px">T</span></cfif>
											<cfif listfind(profile_id,"8")><span class="badge border" style="font-size:12px">TM</span></cfif>
											</cfif> --->
										</div>
										<div class="col-md-6">
											#task_explanation#
										</div>
									</div>
								</div>
							</cfoutput>
							<cfif log_text neq "">
								<p class="m-1"><img src="../assets/img/logo_wefit_solo_150.png" width="20" align="left" class="mr-1">#log_text#</p>
							</cfif>
						</td>
						<td align="right" width="5%">
							<button class="btn btn-sm btn-danger p-1 btn_delete_todo" id="tododone_#log_id#"><i class="fal fa-times"></i></button>
						</td>
					</tr>
					</cfoutput>
					</tbody>
				</table>
			</div>			
			</cfif>




		</div>
		</cfif>
		
		
		
		






















		
		<div class="bg-light border border-info p-2 mt-3">
			<div class="d-flex justify-content-between">
				<div>
					<h5 class="mt-0 text-info"><i class="fal fa-book text-info fa-lg mr-2"></i> <cfoutput>#obj_translater.get_translate('table_th_feedback')#</cfoutput></h5>
				</div>
				<div>
					<button type="button" class="btn btn-sm btn-info btn_toggle_feedback" style="min-width:20px !important"><i class="fal fa-plus"></i> <cfoutput>#obj_translater.get_translate('btn_add_feedback')#</cfoutput></button>
				</div>
			</div>

			<div class="collapse" id="<cfoutput>table_create_feedback_#listgetat(cor,1,"|")#</cfoutput>">
			<form id="form_insert_feedback_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>">
				
				<table class="table table-sm table-bordered bg-white">
					<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<tr>
						<td class="bg-light" width="120"><strong>Channel</strong></td>
						<td colspan="2">
							<cfoutput>
							<cfloop query="get_task_channel_fb">
								<label><input type="checkbox" name="task_channel_id" value="#task_channel_id#"> <i class="fa-light #task_channel_icon#"></i> #task_channel_name# </label>&nbsp;&nbsp;&nbsp;
							</cfloop>
							</cfoutput>
						</td>
					</tr>
					</cfif>
					<!--- TODO auto task --->
                    <!--- <tr>
						<td class="bg-light"><strong>Options</strong></td>
						<td colspan="2">
							<div class="row">
								<div class="col-md-4">
									<select  class="form-control" name="select_order_id">
										<option value="" selected>--Order--</option>
										<cfoutput>
										<cfloop query="get_orders">
											<option value="#order_id#" class="font-weight-bold">#order_ref#</option>
										</cfloop>
										</cfoutput>
									</select>
								</div>
								<div class="col-md-4">
									<select class="form-control" name="select_tp_id">
										<option value="">--Tp--</option>
										<cfoutput query="get_tps">
										<option value="#tp_id#">
											#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
											- DEADLINE #lsDateFormat(tp_date_end,'yyyy-mm-dd', 'fr')#
										</option>
										</cfoutput>
									</select>
								</div>
							</div>
							
							
						</td>
					</tr> --->
					<tr>
						<td class="bg-light"><strong>Comments</strong></td>
						<td colspan="2"><textarea name="log_text" class="form-control"></textarea></td>
					</tr>

					<cfif listFindNoCase("TRAINER,TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<tr>
						<!--- <td class="bg-light"><strong><cfoutput>#obj_translater.get_translate('table_th_vocab_category')#</cfoutput></strong></td> --->
						<td colspan="3" align="center">
							<cfif SESSION.USER_PROFILE neq "TRAINER" AND SESSION.USER_PROFILE neq "TM">
							<cfoutput query="get_task_list_feedback_#listgetat(cor,1,'|')#" group="task_group">
								<a type="button" class="p-1 btn_display_feedback" id="##display_#task_group#" style="color:###task_color#; border:2px solid ###task_color# !important; font-weight:bold; font-size:13px; text-decoration:none !important">#task_group_alias#</a>
							</cfoutput>
							</cfif>

							<cfoutput query="get_task_list_feedback_#listgetat(cor,1,'|')#" group="task_group">
								<div class="<cfif SESSION.USER_PROFILE neq "TRAINER" AND SESSION.USER_PROFILE neq "TM">collapse</cfif> p-2 mt-2 feedback_container" id="feedback_#task_group#" style="border:2px solid ###task_color#">
									<div class="container">
									<!--- <strong style="color:###task_color#">#task_group_alias#</strong><br><br> --->
									
									<cfoutput group="task_group_sub">
										<div class="row border-bottom p-1 bg-light">
											<div class="col-sm-12" align="center"><strong>#task_group_sub#</strong>
										<input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-sm btn-info float-right">
										</div>
										</div>
										<cfoutput>
										<div class="row border-bottom p-1" align="left">
											<div class="col-sm-4"><label><input type="checkbox" name="task_type_id" value="#task_type_id#"> #task_type_name#</label></div>
											<div class="col-sm-6">#task_explanation#</div>
											<div class="col-sm-2">
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
												<cfif listfind(profile_id,5)><label><span class="badge badge-pill badge-danger">CS</span></h5></label></cfif>
												<cfif listfind(profile_id,2)><label><span class="badge badge-pill badge-danger">SAL</span></h5></label></cfif>
												<cfif listfind(profile_id,6)><label><span class="badge badge-pill badge-danger">FIN</span></h5></label>&nbsp;</cfif>
												<cfif listfind(profile_id,8)><label><span class="badge badge-pill badge-info">TM</span></h5></label>&nbsp;</cfif>
												<cfif listfind(profile_id,4)><label><span class="badge badge-pill badge-success">T</span></h5></label>&nbsp;</cfif>
												</cfif>
											</div>
											<!--- <div class="col-sm-1">
												<cfif task_automation neq "">
													<a class="btn btn-sm btn-warning" data-toggle="tooltip" data-placement="top" title="#task_automation#"><i class="fal fa-cog"></i></a>
												</cfif>
											</div> --->
											
										</div>
										</cfoutput>
									</cfoutput>

								
									</div>
								</div>
							</cfoutput>
						</td>

					</tr>
					</cfif>
					
					<tr>
						<td colspan="3" align="center">
							<cfoutput>
							<cfif listgetat(cor,1,'|') eq "group">
							<input type="hidden" name="g_id" value="#g_id#">
							</cfif>
							<cfif listgetat(cor,1,'|') eq "account">
							<input type="hidden" name="a_id" value="#a_id#">
							</cfif>
							<cfif listgetat(cor,1,'|') eq "learner">
							<input type="hidden" name="u_id" value="#u_id#">
							</cfif>
	
	
							<cfif SESSION.USER_PROFILE eq "trainer">
								<input type="hidden" name="profile_id" value="4,5">
							<cfelseif SESSION.USER_PROFILE eq "tm">
								<input type="hidden" name="profile_id" value="8,5">
							</cfif>
	
							
							<input type="hidden" name="task_category" value="FEEDBACK">
							<input type="hidden" name="act" value="ins">
							<input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-sm btn-info">
							</cfoutput>
						</td>
					</tr>

				</table>
				
			</form>
			</div>



















			<cfset querygo = evaluate("get_log_feedback_#listgetat(cor,1,'|')#")>

			<cfif querygo.recordcount neq "0">
				<div class="collapse show" id="<cfoutput>table_feedback_#listgetat(cor,1,"|")#</cfoutput>">
				<table class="table m-0">
				<tbody>
				<cfoutput query="querygo" group="log_id">
				<tr <cfif log_status eq "1">class="bg-light"</cfif>>
					<td width="15%" align="left">
					    <input type="text" class="form-control" disabled value="#dateformat(log_date,'dd/mm/yyyy')# #timeformat(log_date,'HH:mm')#" style="width:150px">
					</td>
					<td width="10%" align="center">
						
						<cfif listlen(task_channel_id) gte "1">
							<div class="border-bottom bg-white p-1">
							<cfloop query="get_task_channel_fb">
								<cfif listfind(querygo.task_channel_id,get_task_channel_fb.task_channel_id)><i class="fa-light #task_channel_icon# text-info fa-lg" aria-hidden="true" title="#task_channel_alias#"></i></cfif>
							</cfloop>
							</div>
						</cfif>
							
						<small><strong>#__by#&nbsp;#sender#&nbsp;(#profile_name#)</strong></small>
					</td>
                    <td width="70%" style="font-size:12px">
						<cfoutput>
							<div class="border-bottom bg-white p-1 m-0">
								<div class="row">
									<div class="col-md-6">
										<span class="badge text-white" style="background-color:###task_color#; font-size:12px">#task_type_name#</span>
									</div>
									<div class="col-md-6">
										#task_explanation#
									</div>
								</div>
							</div>
						</cfoutput>
						<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
							<cfif log_text neq "">
								#log_text#
							</cfif>
						</cfif>
					</td>
					
					
					<td width="5%" align="right">
						<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
							<cfif isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
							<button class="btn btn-sm btn-danger p-1 btn_delete_todo" id="feedback_#log_id#"><i class="fal fa-times"></i></button>
							</cfif>
						</cfif>
					</td>
				</tr>
				</cfoutput>
				</tbody>
				</table>
				</div>
			</cfif>






















		</div>
	
	</div>
	</cfloop>
</div>









<script>
$(function() {



    $('[data-toggle="tooltip"]').tooltip();


	// Disable a list of dates 
	var disabledDays = ["01-01-2022","04-18-2022","05-01-2020","05-08-2020","05-26-2022","06-06-2022"]; 
	function disableAllTheseDays(date) {
		var m = date.getMonth(), d = date.getDate(), y = date.getFullYear(); 
		for (i = 0; i < disabledDays.length; i++) {
			if($.inArray((m+1) + '-' + d + '-' + y,disabledDays) != -1) { 
				return [false]; 
			} 
		} 
			return [true]; 
	} 




	$(".btn_toggle_feedback").click(function() {
        $("#<cfoutput>table_create_feedback_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
		$("#<cfoutput>table_feedback_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
    })

	
    $(".btn_display_feedback").click(function() {
        $(".btn_display_feedback").removeClass("bg-secondary");
        $(this).addClass("bg-secondary");
        event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var task_group = idtemp[1]+"_"+idtemp[2];
        // alert(task_group);
        $(".feedback_container").collapse('hide');
        $("#feedback_"+task_group).collapse('show');


    })

	$(".log_item_status_done").click(function(e) {
		
		$.ajax({				 
			url: './api/task/task_post.cfc?method=updt_task_item',
			type: 'POST',
			data: {item_id: e.target.dataset.item, log_id: e.target.dataset.log, status: e.target.checked ? 1 : 0},
			success : function(result, status){

				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>


			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
    })

	
	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

		var holidays = [<cfoutput query="get_holiday"><cfif recordcount GT 0>,</cfif>'#holiday_date#'</cfoutput>];
		
		function noWeekendsOrHolidays(date) {
			var noWeekend = $.datepicker.noWeekends(date);
			if (noWeekend[0]) {
				var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
				// return nationalDays(date);
				return  [$.inArray(string, holidays) == -1];
			} else {
				return noWeekend;
			}
		}
	
		<cfloop list="#list_tab#" index="cor" delimiters=",">	
		
		<!------------- INIT FOR EXISTING TODO -------------->
		<cfset querygo = evaluate("get_log_todo_#listgetat(cor,1,'|')#")>
		<cfif querygo.recordcount neq "0">
			<cfoutput query="querygo">
			$("##log_remind_#listgetat(cor,1,'|')#_#log_id#").datetimepicker({
				defaultDate: "+1w",
				changeMonth: true,
				dateFormat:"dd/mm/yy",
				timeFormat: "HH:mm",
				hourGrid:1,
				stepMinute:15,
				hourMin:6,
				hourMax:23,
				numberOfMonths: 3,
				firstDay: 1, 
				<!---beforeShowDay: $.datepicker.noWeekends,--->
				beforeShowDay: noWeekendsOrHolidays,
				onSelect: function(dateText, inst) {
                    $.ajax({
                        url: './api/task/task_post.cfc?method=updt_date',
                        type: 'POST',
                        data: {
                            log_id: #log_id#,
                            selectedDate: dateText
                        },
                        success: function(response) {
							// Close the datetimepicker
                            $("##log_remind_#listgetat(cor,1,'|')#_#log_id#").datetimepicker('hide');
                            
                            // Display success alert
							$('<div class="alert alert-success alert-dismissible fade show" role="alert">Date changed successfully<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>').insertBefore('.tab-content');
                            console.log('Success: ' + response);
                        },
                        error: function(xhr, status, error) {
							// Close the datetimepicker
                            $("##log_remind_#listgetat(cor,1,'|')#_#log_id#").datetimepicker('hide');
                            
                            // Display error alert
                    
                            $('<div class="alert alert-danger alert-dismissible fade show" role="alert">Error: Better call Em<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>').insertBefore('.tab-content');
                            console.log('Error: ' + error);
                        }
                    });
					
                }
			});
			</cfoutput>
		</cfif>
	
		
		<!------------- INIT FOR EXISTING TODO -------------->
		<cfoutput>		
		$("##log_remind_create_#listgetat(cor,1,'|')#").datetimepicker({
			defaultDate: "+1w",
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			timeFormat: "HH:mm",
			hourGrid:1,
			stepMinute:15,
			hourMin:6,
			hourMax:23,
			numberOfMonths: 3,
			firstDay: 1, 
			<!---beforeShowDay: $.datepicker.noWeekends--->
			beforeShowDay: noWeekendsOrHolidays
		});
		</cfoutput>
		
		</cfloop>
	        
	$(".btn_display_todo").click(function() {
        $(".btn_display_todo").removeClass("bg-secondary");
        $(this).addClass("bg-secondary");
        event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var task_group = idtemp[1]+"_"+idtemp[2];
        // alert(task_group);
        $(".todo_container").collapse('hide');
        $("#todo_"+task_group).collapse('show');


    })

	$(".btn_toggle_todo").click(function() {
        $("#<cfoutput>table_create_todo_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
		$("#<cfoutput>table_todo_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
    })

	$(".btn_toggle_todo_done").click(function() {
        $("#<cfoutput>table_todo_done_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
		$("#<cfoutput>table_todo_#listgetat(cor,1,"|")#</cfoutput>").collapse("toggle");
    })

	$('.btn_delete_todo').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var log_id = idtemp[1];

		$.ajax({				 
			url: './api/task/task_post.cfc?method=delete_task',
			type: 'POST',
			data: {log_id: log_id},
			success : function(result, status){


				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>


			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});



	
	$('.btn_update_todo').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var log_id = idtemp[1];

		$.ajax({				 
			url: './api/task/task_post.cfc?method=updt_task',
			type: 'POST',
			data: {log_id: log_id},
			success : function(result, status){

				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>


			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});


	$('.btn_close_todo').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var log_id = idtemp[1];
		// alert(log_id);
		$.ajax({				 
			url: './api/task/task_post.cfc?method=close_task',
			type: 'POST',
			data: {log_id: log_id},
			success : function(result, status){

				if (result == 0) {
					alert("<cfoutput>#obj_translater.get_translate('alert_log_item_error')#</cfoutput>");
				} else {
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});

					<cfif isdefined("u_id")>
						$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
					<cfelseif isdefined("a_id")>
						$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
					<cfelseif isdefined("g_id")>
						$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
					</cfif>
				}
				


			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

	$(".form_update").submit(function( event ) {
		// alert($(this).serialize());
		event.preventDefault();
		// console.log(event.target);
		$.ajax({				 
			url: './api/task/task_post.cfc?method=updt_task',
			type: 'POST',
			data: $(event.target).serialize(),
			success : function(result, status){

				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>

				
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});

	});



	$("#form_insert_todo_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>").submit(function(event) {
		event.preventDefault();

		$.ajax({				 
			url: './api/task/task_post.cfc?method=insert_task',
			type: 'POST',
			data: $('#form_insert_todo_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>').serializeArray(),
			success : function(result, status){

				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>


			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	})
        
</cfif>


		

		$('.btn_help_task').click(function(event) {

			let go_1 = 1;
			let go_2 = 1;
			
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var tt_id = idtemp[1];	

			$('#window_item_xl').modal('hide');

			$('#window_item_xl').on('hidden.bs.modal', function (e) {
				if (go_1) {
					go_1 = 0;
					$('#window_item_lg').modal({keyboard: true});
					$('#modal_title_lg').text("Task explanation");
					$('#modal_body_lg').load("modal_window_taskinfo.cfm?tt_id="+tt_id, function() {});
				}
			});

			
			$('#window_item_lg').on('hidden.bs.modal', function (e) {
			if (go_2) {
				go_2 = 0;
				$('#window_item_xl').modal('show');
			}
			});

	});
	
	


	

	

	$("#form_insert_feedback_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>").submit(function(event) {
		event.preventDefault();
		// console.log($('#form_insert_feedback_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>').serializeArray());
		$.ajax({				 
			url: './api/task/task_post.cfc?method=insert_task',
			type: 'POST',
			data: $('#form_insert_feedback_<cfoutput>#listgetat(cor,1,"|")#</cfoutput>').serializeArray(),
			success : function(result, status){

				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});

				<cfif isdefined("u_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
				<cfelseif isdefined("a_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
				<cfelseif isdefined("g_id")>
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
				</cfif>

				
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	})
	
})
</script>