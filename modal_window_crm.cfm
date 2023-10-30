<!----------------------EDITION / CREATION DE TASK / OPPORT----------------------->
<cfif isdefined("task_edit") OR isdefined("task_create") OR isdefined("opport_edit") OR isdefined("opport_create")>

	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
	SELECT a.account_id, a.account_name, at.type_name
	FROM account a INNER JOIN account_type at ON a.type_id = at.type_id
	WHERE at.type_invoice = "true" 
	<cfif isdefined("a_id")> AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"></cfif>
	ORDER BY at.type_name, a.account_name
	</cfquery>

	<cfquery name="get_task_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM task_type WHERE task_group = "task"
	</cfquery>

	<cfquery name="get_opport_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM task_type WHERE task_group = "opport"
	</cfquery>

	<cfset get_user = obj_task_get.oget_to(pf_id="2")>

	<!--- <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM user u
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON up.profile_id = upc.profile_id  
	WHERE u.user_status_id = 4 
	AND upc.profile_id IN (2,5,6)  
	ORDER BY user_firstname
	</cfquery> --->

	<cfif isdefined("a_id")> 
	<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_id, CONCAT(contact_firstname, " ", UCASE(contact_name)) as contact 
	FROM account_contact 
	WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
	UNION (SELECT 0 as contact_id, "---Selectionner Contact---" as contact)
	</cfquery>
	</cfif>

	
	<!----------------------EDITION DE TASK / OPPORT----------------------->
	<cfif isdefined("task_id") AND (isdefined("task_edit") OR isdefined("opport_edit"))>
		
		<cfquery name="get_account_id" datasource="#SESSION.BDDSOURCE#">
		SELECT account_id FROM task WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
		</cfquery>
		
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_id, a.account_name FROM account a
		WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_account_id.account_id#">
		</cfquery>

		<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
		SELECT contact_id, CONCAT(contact_firstname, " ", UCASE(contact_name)) as contact 
		FROM account_contact 
		WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_account_id.account_id#">
		UNION (SELECT 0 as contact_id, "---Selectionner Contact---" as contact)
		</cfquery>

		<cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*,tt.task_group FROM task t
		INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
		WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">	
		</cfquery>	
				
		<cfquery name="get_logs" datasource="#SESSION.BDDSOURCE#">
		SELECT log_date, log_text, u.user_alias FROM logs l
		INNER JOIN user u ON u.user_id = l.user_id
		WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">	
		</cfquery>	
		
		<cfoutput query="get_task">
			<cfset parent_id = parent_id>
			<cfset contact_id = contact_id>
			<cfset a_id = account_id>
			<cfset user_id = user_id>
			<cfset invoice_id = invoice_id>
			<cfset task_type_id = task_type_id>
			<cfset task_name = task_name>
			<cfset task_date_creation = task_date_creation>
			<cfset task_date_remind = task_date_remind>
			<cfset task_date_close = task_date_close>
			<cfset task_date_start = task_date_start>
			<cfset task_date_end = task_date_end>
			<cfset task_date_deadline = task_date_deadline>
			<cfset task_alert = task_alert>
			<cfset task_description = task_description>
			<cfset task_amount = task_amount>
			<cfset task_probability = task_probability>
		</cfoutput>

	<cfelse>
	
	
	<!----------------------CREATION DE TASK / OPPORT----------------------->
		
		<cfparam name="parent_id" default="0">
		<cfparam name="contact_id" default="0">
		<cfparam name="user_id" default="#SESSION.USER_ID#">
		<cfparam name="invoice_id" default="0">
		<cfparam name="task_type_id" default="1">
		<cfparam name="task_name" default="">	
		<cfparam name="task_date_creation" default="#now()#">
		<cfparam name="task_date_remind" default="#now()#">
		<cfparam name="task_date_close" default="#now()#">
			
		<cfparam name="task_alert" default="0">
		<cfparam name="task_description" default="">
		<cfparam name="task_amount" default="">
		<cfparam name="task_probability" default="0">
		
		<cfif isdefined("task_date_start")>
			<cfset task_date_start = "#listgetat(task_date_start,1,'_')# #replace(listgetat(task_date_start,2,'_'),'-',':','ALL')#">
			<cfset task_date_deadline = dateformat(task_date_start,'dd/mm/yyyy')>	
			<cfset task_date_remind = dateformat(task_date_start,'dd/mm/yyyy')>	
		<cfelse>
			<cfset task_date_start = dateformat(now(), 'yyyy-mm-dd 08:00:00')>
			<cfset task_date_deadline = dateformat(now(), 'dd/mm/yyyy')>
			<cfset task_date_remind = dateformat(now(), 'dd/mm/yyyy')>
		</cfif>
		<cfif isdefined("task_date_end")>
			<cfset task_date_end = "#listgetat(task_date_end,1,'_')# #replace(listgetat(task_date_end,2,'_'),'-',':','ALL')#">
		<cfelse>
			<cfset task_date_end = dateformat(now(), 'yyyy-mm-dd 09:00:00')>
		</cfif>	
		
	</cfif>


	
	<cfif isdefined("task_edit") OR isdefined("task_create")>
	
			<!------------------------------- TASK ---------------------------------------->
			<cfform action="updater_crm.cfm">
			<cfoutput>
			<div class="row" style="margin-top:20px">
				<div class="col-md-6">
					<table class="table borderless">
						<tr>
							<td><label><strong>Intitul&eacute;</strong></label></td>
							<td>
								<input name="task_name" type="text" class="form-control" placeholder="Intitul&eacute; de t&acirc;che (facultatif)" value="#task_name#">
							</td>
						</tr>
						<tr>
							<td><label><strong>Compte</strong></label><cfif isdefined("a_id")>&nbsp;<a type="button" class="btn btn-default btn-sm" href="crm_account_edit.cfm?a_id=#a_id#"><i class="far fa-eye"></i></a></cfif></td>
							<td>
							<cfif isdefined("a_id")>
								<cfselect id="account_select_task" query="get_account" display="account_name" value="account_id" class="form-control" name="account_id" selected="#a_id#" disabled="disabled"></cfselect>
							<cfelse>
								<cfselect id="account_select_task" name="account_id" class="form-control input-sm" query="get_account" display="account_name" value="account_id" group="type_name">
								<option value="0" selected="selected">S&eacute;lectionner un client</option>
								</cfselect>
							</cfif>
							</td>
						</tr>
						<tr>
							<td><label><strong>Contact</strong></label></td>
							<td>
							<cfif isdefined("a_id")>
							<cfselect query="get_contact" display="contact" value="contact_id" class="form-control" name="contact_id" selected="#contact_id#"></cfselect>
							<cfelse>
							<select id="contact_select_task" class="form-control" name="contact_id" disabled="disabled"></select>
							</cfif>
							</td>
						</tr>
						<tr>
							<td><label><strong>Manager</strong></label></td>
							<td>
							<cfselect query="get_user" value="user_id" class="form-control" display="user_firstname" name="manager_id" selected="#user_id#"></cfselect>
							</td>
						</tr>
						<tr>
							<td><label><strong>Owner</strong></label></td>
							<td>
							<cfselect query="get_user" value="user_id" class="form-control" display="user_firstname" name="owner_id" selected="#owner_id#"></cfselect>
							</td>
						</tr>
						<tr>
							<td><label><strong>Type</strong></label></td>
							<td><cfselect query="get_task_type" display="task_type_name" value="task_type_id" class="form-control" name="task_type_id" selected="#task_type_id#"></cfselect></td>
						</tr>	
						<tr>
							<td><label><strong>&Eacute;ch&eacute;ance</strong></label></td>
							<td id="test">
							<div class="form-inline">
							<div class="input-group">
								<input id="task_date_deadline" name="task_date_deadline" type="text" class="datepicker form-control" value="#dateformat(task_date_deadline,'dd/mm/yyyy')#" />
								<label for="task_date_deadline" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
							</div>
							</div>			
							</td>
						</tr>
						<tr>
							<td><label><strong>Dur&eacute;e</strong></label></td>
							<td>
								<div class="form-inline">
								<select name="task_date_start" class="form-control">
								<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
								<option value="#hour#" <cfif hour eq timeformat(task_date_start,'HH:mm')>selected="selected"</cfif>>#hour#</option>
								</cfloop>
								</select>
								&nbsp;&agrave;&nbsp;
								<select name="task_date_end" class="form-control">
								<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
								<option value="#hour#" <cfif hour eq timeformat(task_date_end,'HH:mm')>selected="selected"</cfif>>#hour#</option>
								</cfloop>
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="task_alert" id="task_alert" <cfif task_alert eq "1">checked="checked"</cfif>><label><strong>Reminder</strong></label></td>
							<td>
							<div class="form-inline">							
							<div class="input-group">						
								<input id="task_date_remind" <cfif task_alert neq "1">disabled="disabled"</cfif> name="task_date_remind" type="text" class="datepicker form-control" value="#dateFormat(task_date_remind, 'dd/mm/yyyy')#" />
								<label for="task_date_remind" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
							</div>
							</div>
							</td>
						</tr>
						
					</table>					
				
				</div>	
				<div class="col-md-6">	
					<cfif isdefined("task_id")>
					<div style="height:260px;overflow-y:scroll;">
					<table class="table table-bordered table-condensed">
						<cfloop query="get_logs">
						<tr>
							<td width="100"><label>#dateformat(get_logs.log_date,'dd/mm/yyyy')#<br>par #user_alias#</label></td>
							<td>
								<div class="input-group">
									#get_logs.log_text#
								</div>
							</td>
						</tr>
						</cfloop>
					</table>	
					</div>
					</cfif>					
				</div>	
			</div>
			<div class="row">
				<div class="col-md-12">
					<label><strong>Ajouter commentaire</strong></label>
					<textarea class="form-control" name="log_text" rows="2" placeholder="Ajouter un commentaire le #dateformat(now(),'dd/mm/yyyy')#" style="resize:none"></textarea> 
				</div>
			</div>			
			<div class="modal-footer" style="text-align:center">
				<cfif isdefined("task_id")>
					<input type="hidden" name="updt_task" value="1">
					<input type="hidden" name="task_id" value="#task_id#">
					<cfif isdefined("a_id")><input type="hidden" name="account_id" value="#a_id#"></cfif>
					<input type="button" class="btn btn-default" onclick="if(confirm('Confirmer fermeture de task ?')){window.location.href='updater_crm.cfm?updt_close=1&task_id=#task_id#'}" value="Fermer task">
					<input type="button" class="btn btn-default" onclick="if(confirm('Confirmer fermeture de task et rattacher une nouvelle task ?')){alert('ok');}" value="Fermer et rattacher task">
				<cfelse>
					<input type="hidden" name="ins_task" value="1">
					<cfif isdefined("a_id")><input type="hidden" name="account_id" value="#a_id#"></cfif>
					<input type="button" class="btn btn-default" value="Fermer task" disabled="disabled">
					<input type="button" class="btn btn-default" value="Fermer et rattacher task" disabled="disabled">
				</cfif>
				
				<input type="submit" class="btn btn-success" value="Enregistrer">
			</div>
			</cfoutput>
			</cfform>	
		
		
	<cfelseif isdefined("opport_edit") OR isdefined("opport_create")>	
		
		
			<!------------------------------- OPPORT ---------------------------------------->
			<cfform action="updater_crm.cfm">
			<cfoutput>
			<div class="row" style="margin-top:20px">
				<div class="col-md-6">
					<table class="table table-sm">
						<tr>
							<td><label><strong>Intitul&eacute;</strong></label></td>
							<td>
								<input name="task_name" type="text" class="form-control" placeholder="Intitul&eacute; d'opportunit&eacute; (facultatif)" value="#task_name#">
							</td>
						</tr>
						<tr>
							<td><label><strong>Compte</strong></label><cfif isdefined("a_id")>&nbsp;<a type="button" class="btn btn-default btn-sm" href="crm_account_edit.cfm?a_id=#a_id#"><i class="far fa-eye"></i></a></cfif></td>
							<td>
							<cfif isdefined("a_id")>
								<cfselect id="account_select_opport" query="get_account" display="account_name" value="account_id" class="form-control" name="account_id" selected="#a_id#" disabled="disabled"></cfselect>
							<cfelse>
								<cfselect id="account_select_opport" name="account_id" class="form-control input-sm" query="get_account" display="account_name" value="account_id" group="type_name">
								<option value="0" selected="selected">S&eacute;lectionner un client</option>
								</cfselect>
							</cfif>
							</td>
						</tr>
						<tr>
							<td><label><strong>Contact</strong></label></td>
							<td>
							<cfif isdefined("a_id")>
							<cfselect query="get_contact" display="contact" value="contact_id" class="form-control" name="contact_id" selected="#contact_id#"></cfselect>
							<cfelse>
							<select id="contact_select_opport" class="form-control" name="contact_id" disabled="disabled"></select>
							</cfif>
							</td>
						</tr>
						<tr>
							<td><label><strong>Manager</strong></label></td>
							<td>
							<cfselect query="get_user" display="user_firstname" value="user_id" class="form-control" name="user_id" selected="#user_id#"></cfselect>
							</td>
						</tr>
						<tr>
							<td><label><strong>Owner</strong></label></td>
							<td>
							<cfselect query="get_user" display="user_firstname" value="user_id" class="form-control" name="owner_id" selected="#owner_id#"></cfselect>
							</td>
						</tr>
						<tr>
							<td><label><strong>&Eacute;tape</strong></label></td>
							<td>
							

							<!---<div class="btn-group" role="group" aria-label="...">
							<cfloop query="get_opport_type">							
							<button type="button" class="btn btn-default btn-xs">#task_type_name#</button>
							</cfloop>
							</div>--->
							
							<cfselect query="get_opport_type" display="task_type_name" value="task_type_id" class="form-control" name="task_type_id" selected="#task_type_id#"></cfselect></td>
						</tr>
						<!---<tr>
							<td><label>Nom opportunit&eacute;</label></td>
							<td><input class="form-control" name="task_name" placeholder="Nom opportunit&eacute;" value="#task_name#"></td>
						</tr>--->
						<tr>
							<td><label><strong>Montant</strong></label></td>
							<td>
								<div class="input-group">
								   <input type="text" class="form-control" placeholder="Montant" value="#task_amount#" name="task_amount">		
								  <div class="input-group-append">
									<span class="input-group-text">&euro;</span>
								  </div>
								</div>
							</td>
						</tr>
						<tr>
							<td><label><strong>Probabilit&eacute;</strong></label></td>
							<td>
								<div class="input-group">
									<select name="task_probability" class="form-control">		
										<option value="0" <cfif task_probability eq "0">selected</cfif>>---</option>
										<option value="20" <cfif task_probability eq "20">selected</cfif>>20%</option>
										<option value="50" <cfif task_probability eq "50">selected</cfif>>50%</option>
										<option value="70" <cfif task_probability eq "70">selected</cfif>>70%</option>
										<option value="100" <cfif task_probability eq "100">selected</cfif>>100%</option>
									</select>
								</div>				
							</td>
						</tr>
						<tr>
							<td><label><strong>&Eacute;ch&eacute;ance</strong></label></td>
							<td>
							<div class="form-inline">
							<div class="input-group">
								<input id="task_date_deadline_opport" name="task_date_deadline" type="text" class="datepicker form-control" value="#dateformat(task_date_deadline,'dd/mm/yyyy')#" />
								<label for="task_date_deadline_opport" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
							</div>
							</div>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="task_alert" id="task_alert_opport" <cfif task_alert eq "1">checked="checked"</cfif>> <label><strong>Reminder</strong></label></td>
							<td>
							<div class="form-inline">							
							<div class="input-group">						
								<input id="task_date_remind_opport" <cfif task_alert neq "1">disabled="disabled"</cfif> name="task_date_remind" type="text" class="datepicker form-control" value="#dateFormat(task_date_remind, 'dd/mm/yyyy')#" />
								<label for="task_date_remind_opport" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
							</div>
							</div>
							</td>
						</tr>			
					</table>				
				</div>
				
				<div class="col-md-6">	
					<cfif isdefined("task_id")>
					<div style="height:260px;overflow-y:scroll;">
					<table class="table table-bordered table-sm">
						<cfloop query="get_logs">
						<tr>
							<td width="100"><label>#dateformat(get_logs.log_date,'dd/mm/yyyy')#<br>par #user_alias#</label></td>
							<td>
								<div class="input-group">
									#get_logs.log_text#
								</div>
							</td>
						</tr>
						</cfloop>
					</table>	
					</div>
					</cfif>						
				</div>	
			</div>
			
			<div class="row">
				<div class="col-md-12">

					<label><strong>Ajouter commentaire</strong></label>
					<textarea class="form-control" name="log_text" rows="2" placeholder="Ajouter un commentaire le #dateformat(now(),'dd/mm/yyyy')#" style="resize:none"></textarea> 

				</div>
			</div>
			
			<div class="modal-footer" style="text-align:center">
				<cfif isdefined("task_id")>
					<input type="hidden" name="updt_opport" value="1">
					<input type="hidden" name="task_id" value="#task_id#">
					<cfif isdefined("a_id")><input type="hidden" name="account_id" value="#a_id#"></cfif>
					<!---<button type="button" class="btn btn-default" onclick="if(confirm('Confirmer fermeture d\'opportunit\xE9 ?')){window.location.href='updater_crm.cfm?updt_close=1&updt_close_lost=1&task_id=#task_id#'}"><span class="glyphicon glyphicon-thumbs-down"></span> Passer en Close/Perdu</button>
					<button type="button" class="btn btn-default" onclick="if(confirm('Confirmer fermeture d\'opportunit\xE9 ?')){window.location.href='updater_crm.cfm?updt_close=1&updt_close_won=1&task_id=#task_id#'}"><span class="glyphicon glyphicon-thumbs-up"></span> Passer en Close/Gagn&eacute;</button>--->
				<cfelse>
					<input type="hidden" name="ins_opport" value="1">
					<cfif isdefined("a_id")><input type="hidden" name="account_id" value="#a_id#"></cfif>
					<!---<button type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-thumbs-down"></span> Passer en Close/Perdu</button>
					<button type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-thumbs-up"></span> Passer en Close/Gagn&eacute;</button>--->
				</cfif>
				<input type="submit" class="btn btn-success" value="Enregistrer">
			</div>
			</cfoutput>
			</cfform>
		
		
	</cfif>

</cfif>






















<!----------------------EDITION ACCOUNT ----------------------->
<cfif isdefined("account_edit") OR isdefined("account_create")>
<cfif isdefined("account_id")>
	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">	
	</cfquery>
	<cfoutput query="get_account">
		<cfset type_id = type_id>
		<cfset status_id = status_id>
		<cfset provider_id = provider_id>
		<cfset group_id = group_id>
		<cfset delay_id = delay_id>
		<cfset order_mode_id = order_mode_id>
		<cfset tva_id = tva_id>
		<cfset sector_id = sector_id>
		<cfset size_id = size_id>
		<cfset user_id = user_id>
		<cfset owner_id = owner_id>
		<cfset account_name = account_name>
		<cfset account_address = account_address>
		<cfset account_postal = account_postal>
		<cfset account_city = account_city>
		<cfset account_country = account_country>
		<cfset account_f_name = account_f_name>
		<cfset account_f_address = account_f_address>
		<cfset account_f_postal = account_f_postal>
		<cfset account_f_city = account_f_city>
		<cfset account_f_country = account_f_country>
		<cfset account_date = account_date>
		<cfset account_details_1 = account_details_1>
		<cfset account_details_2 = account_details_2>
		<cfset account_tva_num = account_tva_num>
		<cfset account_site = account_site>
		<cfset account_phone = account_phone>
		<cfset account_pt_mandatory = account_pt_mandatory>
	</cfoutput>
<cfelseif isdefined("del_account")>
	<cfoutput query="get_account">
		<cfset type_id = type_id>
		<cfset provider_id = provider_id>
		<cfset group_id = group_id>
		<cfset delay_id = delay_id>
		<cfset order_mode_id = order_mode_id>
		<cfset tva_id = tva_id>
		<cfset sector_id = sector_id>
		<cfset size_id = size_id>
		<cfset user_id = user_id>
		<cfset owner_id = owner_id>
		<cfset account_name = account_name>
		<cfset account_address = account_address>
		<cfset account_postal = account_postal>
		<cfset account_city = account_city>
		<cfset account_country = account_country>
		<cfset account_f_name = account_f_name>
		<cfset account_f_address = account_f_address>
		<cfset account_f_postal = account_f_postal>
		<cfset account_f_city = account_f_city>
		<cfset account_f_country = account_f_country>
		<cfset account_date = account_date>
		<cfset account_details_1 = account_details_1>
		<cfset account_details_2 = account_details_2>
		<cfset account_tva_num = account_tva_num>
		<cfset account_site = account_site>
		<cfset account_phone = account_phone>
		<cfset account_pt_mandatory = account_pt_mandatory>
	</cfoutput>
<cfelse>
	<cfparam name="type_id" default="1">
	<cfparam name="status_id" default="1">
	<cfparam name="provider_id" default="1">
	<cfparam name="group_id" default="">
	<cfparam name="delay_id" default="1">
	<cfparam name="order_mode_id" default="1">
	<cfparam name="tva_id" default="1">
	<cfparam name="sector_id" default="0">
	<cfparam name="size_id" default="0">
	<cfparam name="user_id" default="1">
	<cfparam name="owner_id" default="1">
	<cfparam name="account_name" default="">
	<cfparam name="account_address" default="">
	<cfparam name="account_postal" default="">
	<cfparam name="account_city" default="">
	<cfparam name="account_country" default="">
	<cfparam name="account_f_name" default="">
	<cfparam name="account_f_address" default="">
	<cfparam name="account_f_postal" default="">
	<cfparam name="account_f_city" default="">
	<cfparam name="account_f_country" default="">
	<cfparam name="account_date" default="">
	<cfparam name="account_details_1" default="">
	<cfparam name="account_details_2" default="">
	<cfparam name="account_tva_num" default="">
	<cfparam name="account_site" default="">
	<cfparam name="account_phone" default="">
	<cfparam name="account_pt_mandatory" default="0">
</cfif>

<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
SELECT group_id, group_name FROM account_group
ORDER BY group_name ASC 
</cfquery>

<cfset get_user = obj_task_get.oget_to(pf_id="2,5")>

	<!--- <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM user u
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON up.profile_id = upc.profile_id  
	WHERE u.user_status_id = 4 
	AND upc.profile_id IN (2,5,6)  
	ORDER BY user_firstname
	</cfquery> --->

<cfquery name="get_size" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_size ORDER BY size_id ASC
</cfquery>

<cfquery name="get_delay" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_delay
</cfquery>

<cfquery name="get_mode" datasource="lms-1">
	SELECT * FROM order_mode
</cfquery>

<cfquery name="get_tva" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_tva
</cfquery>

<cfquery name="get_sector" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_sector ORDER BY sector_id ASC
</cfquery>

<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type
</cfquery>

<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_status
</cfquery>

<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_provider
</cfquery>

<cfquery name="get_country" datasource="#SESSION.BDDSOURCE#">
	SELECT country_id, country_code, country_alpha, country_name_#SESSION.LANG_CODE# as country_name 
	FROM settings_country 
	ORDER BY country_name_#SESSION.LANG_CODE#
</cfquery>

<cfform action="updater_crm.cfm">
<cfoutput>

	<div class="row">
		<div class="col-md-12">
			
			<h6>Compte</h6>
			<hr style="border-color:##999999">
			<table class="table borderless">
				<tr>
					<td width="15%"><label>Nom</label></td>
					<td width="30%"><input class="form-control" name="account_name" required="yes" placeholder="Nom" value="#account_name#"></td>
					<td width="15%"><label>T&eacute;l Std</label></td>
					<td width="40%"><input class="form-control" name="account_phone" placeholder="Standard" value="#account_phone#"></td>
				</tr>
				<tr>
					<td><label>Groupe</label></td>
					<td><cfselect class="form-control" name="group_id" query="get_group" display="group_name" value="group_id" selected="#group_id#"></cfselect></td>
					<td><label>Site web</label></td>
					<td><input class="form-control" name="account_site" placeholder="Site web" value="#account_site#"></td>
				</tr>
				<tr>
					<td><label>Manager</label></td>
					<td><cfselect class="form-control" name="user_id" query="get_user" display="user_firstname" value="user_id" selected="#user_id#"></cfselect></td>
					<td rowspan="4"><label>Description</label></td>
					<td rowspan="4"><textarea class="form-control" rows="5" name="account_details_1" placeholder="Description" value="#account_details_1#">#account_details_1#</textarea></td>
				</tr>
				<tr>
					<td><label>Owner</label></td>
					<td><cfselect class="form-control" name="owner_id" query="get_user" display="user_firstname" value="user_id" selected="#owner_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Type</label></td>
					<td><cfselect class="form-control" name="type_id" query="get_type" display="type_name" value="type_id" selected="#type_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Provider</label></td>
					<td><cfselect class="form-control" name="provider_id" query="get_provider" display="provider_name" value="provider_id" selected="#provider_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Status</label></td>
					<td><cfselect class="form-control" name="status_id" query="get_status" display="status_name" value="status_id" selected="#status_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Taille</label></td>
					<td><cfselect class="form-control" name="size_id" query="get_size" display="size_name" value="size_id" selected="#size_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Secteur</label></td>
					<td><cfselect class="form-control" name="sector_id" query="get_sector" display="sector_name" value="sector_id" selected="#sector_id#"></cfselect></td>
				</tr>
			</table>

		</div>
		
	</div>	
		
	<div class="row">
		<div class="col-md-6">
			<h6>Adresse si&egrave;ge</h6>
			<hr style="border-color:##999999">
			<table class="table borderless">
				<tr>
					<td><label>Adresse</label></td>
					<td><input class="form-control" name="account_address" placeholder="Adresse" value="#account_address#"></td>
				</tr>
				<tr>
					<td><label>CP / Ville</label></td>
					<td>
					<div class="form-inline">
					<input class="form-control" name="account_postal" placeholder="Code postal" value="#account_postal#">
					<input class="form-control" name="account_city" placeholder="Ville" value="#account_city#">
					</div>
					</td>
				</tr>
				<tr>
					<td><label>Pays</label></td>
					<td>
						<!--- <input class="form-control" name="account_country" placeholder="Pays" value="#account_country#"> --->
						<cfif account_country eq ""><cfset account_country = 75></cfif>
						<select id="account_country" name="account_country" class="form-control form-control-sm">
							<cfloop query="get_country">
							<option value="#get_country.country_id#" <cfif get_country.country_id eq account_country>selected</cfif>>#get_country.country_name#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</div>	
		<div class="col-md-6">
			<h6>Adresse facturation</h6>
			<hr style="border-color:##999999">
			<table class="table borderless">
				<tr>
					<td><label>Account Invoice</label></td>
					<td><input class="form-control" name="account_f_name" placeholder="Adresse" value="#account_f_name#"></td>
				</tr>
				<tr>
					<td><label>Adresse</label></td>
					<td><input class="form-control" name="account_f_address" placeholder="Adresse" value="#account_f_address#"></td>
				</tr>
				<tr>
					<td><label>CP / Ville</label></td>
					<td>
					<div class="form-inline">
					<input class="form-control" name="account_f_postal" placeholder="Code postal" value="#account_f_postal#">
					<input class="form-control" name="account_f_city" placeholder="Ville" value="#account_f_city#">
					</div>
					</td>
				</tr>
				<tr>
					<td><label>Pays</label></td>
					<td>
						<!--- <input class="form-control" name="account_f_country" placeholder="Pays" value="#account_f_country#"> --->
						<cfif account_f_country eq ""><cfset account_f_country = 75></cfif>
						<select id="account_f_country" name="account_f_country" class="form-control form-control-sm">
							<cfloop query="get_country">
							<option value="#get_country.country_id#" <cfif get_country.country_id eq account_f_country>selected</cfif>>#get_country.country_name#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</div>		
	</div>
	<div class="row">
		<div class="col-md-6">
			<h6>R&eacute;glages</h6>
			<hr style="border-color:##999999">
			<table class="table borderless">
				<tr>
					<td><label>TVA (par d&eacute;faut)</label></td>
					<td><cfselect class="form-control" name="tva_id" query="get_tva" display="tva_rate" value="tva_id" selected="#tva_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Mode Facturation (par d&eacute;faut)</label></td>
					<td><cfselect class="form-control" name="order_mode_id" query="get_mode" display="order_mode_name" value="order_mode_id" selected="#order_mode_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>R&eacute;glement (par d&eacute;faut)</label></td>
					<td><cfselect class="form-control" name="delay_id" query="get_delay" display="delay_name" value="delay_id" selected="#delay_id#"></cfselect></td>
				</tr>
				<tr>
					<td><label>Num TVA</label></td>
					<td><input class="form-control" name="account_tva_num" placeholder="N&deg; TVA" value="#account_tva_num#"></td>
				</tr>
				<tr>
					<td><label>PT mandatory</label></td>
					<td><input type="checkbox" name="account_pt_mandatory" value="1" <cfif account_pt_mandatory eq "1">checked</cfif>></td>
				</tr>
			</table>	
		</div>		
	</div>
	<div class="modal-footer">
		<cfif isdefined("account_id") and isdefined("account_edit")>
			<input type="hidden" name="updt_account" value="1">
			<input type="hidden" name="account_id" value="#account_id#">
			<input type="submit" class="btn btn-default" value="Enregistrer">
		<cfelseif isdefined ("account_id") and isdefined ("del_account")>
			<input type="hidden" name="account_id" value="#account_id#">
			<input type="hidden" name="del_account" value="1">
			<input type="submit" class="btn btn-default" value="Delete Account">
		<cfelseif isdefined ("account_id") and isdefined ("copy_account")>
			<input type="hidden" name="account_id" value="#account_id#">
			<input type="hidden" name="ins_account" value="1">
			<input type="submit" class="btn btn-default" value="Copy Account">
		<cfelse>
			<input type="hidden" name="ins_account" value="1">
			<input type="submit" class="btn btn-default" value="Save Account">

		</cfif>
	</div>
</cfoutput>
</cfform>
</cfif>


<!------------------------------------------------------------------------>
<!------------------------------------------------------------------------>
<!------------------------------------------------------------------------>

<cfif isdefined("price_edit") and isdefined("account_id")>
<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
 SELECT group_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
</cfquery>
<cfset group_id = #get_group.group_id#>

<cfquery name="get_group_price" datasource="#SESSION.BDDSOURCE#">
	SELECT *
	FROM account_group_price
	WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
	LIMIT 1
</cfquery>
<cfform action="updater_crm.cfm">
<cfoutput query="get_group_price">
	<div>
			
		<h6>Grille tarifaire</h6>
		<hr style="border-color:##999999">
		<table class="table borderless">
			<tr>
				<td><label>Réduction (%)</label></td>
				<td><input class="form-control" name="price_reduction" placeholder="reduction" value="#price_reduction#"></td>
			</tr>
			<cfloop from="1" to="#evaluate('ListLen(SESSION.LIST_LANGUAGES)')#" index="cur_lg">
			<cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#">
				SELECT formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_lg#">
			</cfquery>
			<tr>
				<th class="bg-light"><span class="lang-sm" lang="#get_formation_solo.formation_code#"></span> #get_formation_solo.formation_name#</th>
				<td><input class="form-control" name="price_#cur_lg#" placeholder="price" value="#evaluate('price_#cur_lg#')#"></td>
			</tr>
			</cfloop>
			
		</table>
		
	</div>	
	<div class="modal-footer">
		<input type="hidden" name="nb_languages" value="#evaluate('ListLen(SESSION.LIST_LANGUAGES)')#">
		<input type="hidden" name="updt_group_price" value="#account_id#">
		<input type="hidden" name="group_id" value="#group_id#">
		<input type="submit" class="btn btn-default" value="Enregistrer">
	</div>

</cfoutput>
</cfform>

</cfif>















<!----------------------EDITION GROUP ----------------------->
<cfif isdefined("group_edit") AND isdefined("group_id") OR isdefined("group_create")>

	<cfif isdefined("group_id")>

		
<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
SELECT group_id, group_name, group_type, manager_id, group_type_id FROM account_group
WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">	
</cfquery>

<!--- <cfquery name="get_group_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_group_type
</cfquery>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_color
FROM user u 
WHERE user_id IN (SELECT DISTINCT(manager_id) as id FROM account_group)
</cfquery> --->

<cfoutput>
	<cfset group_name = get_group.group_name>
	<!--- <cfset group_type = get_group.group_type>
	<cfset manager_id = get_group.manager_id>
	<cfset group_type_id = get_group.group_type_id> --->
</cfoutput>

<cfform action="updater_crm.cfm">
<cfoutput>

	<div class="row">
		<div class="col-md-12">
			
			<h6>Group</h6>
			<hr style="border-color:##999999">
			<table class="table borderless">
				<tr>
					<td width="15%"><label>Groupe</label></td>
					<td width="30%"><input class="form-control" name="group_name" required="yes" placeholder="Nom" value="#group_name#"></td>
				</tr>
				<!--- <tr>
					<td width="15%"><label>Assigné</label></td>
					<td width="30%">
					<select name="manager_id" class="form-control">
					<cfloop query="get_user">
					<option value="#user_id#">#ucase(user_firstname)#</option>					
					</cfloop>					
					</select>
					</td>
				</tr>
				<tr>
					<td width="15%"><label>Catégorie</label></td>
					<td width="30%">
					<cfselect class="form-control" name="group_type_id" query="get_group_type" display="group_type_name" value="group_type_id" selected="#group_type_id#"></cfselect>
					</td>
				</tr> --->
			</table>

		</div>
		
	</div>	
	<div class="modal-footer">
		<input type="hidden" name="updt_group" value="1">
		<input type="hidden" name="group_id" value="#group_id#">
		<input type="hidden" name="a_id" value="#a_id#">
		<input type="submit" class="btn btn-default" value="Enregistrer">
	</div>
	
</cfoutput>
</cfform>

<cfoutput>
	<cfform action="updater_group.cfm" class="form-inline" method="post" enctype="multipart/form-data">
								
		<cfif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.jpg")>
			<img src="./assets/img_group/#group_id#.jpg" class="mx-auto d-block border p-2" height="100">
			<input type="hidden" name="up_img" value="jpg">
		<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.jpeg")>
			<img src="./assets/img_group/#group_id#.jpeg" class="mx-auto d-block border p-2" height="100">
			<input type="hidden" name="up_img" value="jpeg">
		<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.png")>
			<img src="./assets/img_group/#group_id#.png" class="mx-auto d-block border p-2" height="100">
			<input type="hidden" name="up_img" value="png">
		</cfif>

		<cfinput type="file" class="form-control form-control-sm" name="image">
		<input type="hidden" name="a_id" value="<cfoutput>#a_id#</cfoutput>">
		<input type="hidden" name="g_id" value="<cfoutput>#group_id#</cfoutput>">
		<cfinput type="submit" value="Save" class="btn btn-sm btn-info" name="Submit">
	</cfform>
</cfoutput>



	<cfelse>
		

		<cfform action="updater_crm.cfm">
			<cfoutput>
			
				<div class="row">
					<div class="col-md-12">
						
						<h6>Group</h6>
						<hr style="border-color:##999999">
						<table class="table borderless">
							<tr>
								<td width="15%"><label>Groupe</label></td>
								<td width="30%"><input class="form-control" name="group_name" required="yes" placeholder="Nom" value=""></td>
							</tr>
						</table>
			
					</div>
					
				</div>	
				<div class="modal-footer">
					<input type="hidden" name="ins_group" value="1">
					<input type="submit" class="btn btn-default" value="Enregistrer">
				</div>
				
			</cfoutput>
			</cfform>

			
	</cfif>

</cfif>

















<!----------------------EDITION CONTACT ----------------------->
<cfif isdefined("ctc_edit") OR isdefined("ctc_create")>

<cfif listlen(a_id) gt 1>
	<cfquery name="get_account_group" datasource="#SESSION.BDDSOURCE#">
	SELECT account_id, account_name FROM account WHERE group_id = (SELECT DISTINCT(group_id) FROM account WHERE account_id IN (#a_id#)) ORDER BY account_name ASC 
	</cfquery>
<cfelse>
	<cfquery name="get_account_group" datasource="#SESSION.BDDSOURCE#">
	SELECT account_id, account_name FROM account WHERE group_id = (SELECT group_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">) ORDER BY account_name ASC 
	</cfquery>
</cfif>

<cfquery name="get_function" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_function ORDER BY function_name ASC 
</cfquery>

<!--- <cfoutput>
a_id ====== #a_id#
</cfoutput> --->

<cfif isdefined("contact_id")>
	
	<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM account_contact ac
	LEFT JOIN user u ON u.user_id = ac.user_id
	WHERE ac.contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">	
	</cfquery>
	
	<cfoutput query="get_contact">
		<cfset ctc_account_id = account_id>
		
		<cfset contact_firstname = contact_firstname>
		<cfset contact_name = contact_name>
		<cfset contact_tel1 = contact_tel1>
		<cfset contact_tel2 = contact_tel2>
		<cfset contact_email = contact_email>
		<cfset contact_title = contact_title>
		<cfset contact_details = contact_details>
		<cfset contact_lead = contact_lead>
		<cfset contact_invoice = contact_invoice>
		<cfset function_id = function_id>
		<cfset contact_active = contact_active>
		<cfset user_id = user_id>
		<cfset user_account_right_id = user_account_right_id>
	</cfoutput>
	
<cfelse>

	<cfparam name="ctc_account_id" default="">
	<cfparam name="contact_firstname" default="">
	<cfparam name="contact_name" default="">
	<cfparam name="contact_tel1" default="">
	<cfparam name="contact_tel2" default="">
	<cfparam name="contact_email" default="">
	<cfparam name="contact_title" default="">
	<cfparam name="contact_details" default="">
	<cfparam name="contact_lead" default="1">
	<cfparam name="contact_invoice" default="0">
	<cfparam name="function_id" default="1">
	<cfparam name="contact_active" default="1">
	<cfparam name="user_id" default="">
	<cfparam name="user_account_right_id" default="">
	
</cfif>

<cfoutput>
	<div class="row">
		<div class="col-md-12">		
			
			<cfform action="updater_crm.cfm">
			<table class="table table-sm table-bordered mb-0">
				<tr>
					<td colspan="3" class="bg-info text-white" height="45"><strong>CONTACT CRM</strong></td>
				</tr>
				<tr>
					<td class="bg-light" width="30%"><label><strong>Ctc actif</strong></label></td>
					<td>
					<input id="cl_1" type="radio" name="contact_active" value="1" <cfif contact_active eq "1">checked="checked"</cfif>> <label for="cl_1">Actif</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="cl_0" type="radio" name="contact_active" value="0" <cfif contact_active eq "0">checked="checked"</cfif>> <label for="cl_0">Inactif</label>
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>Référent formation</strong><br>(cc email)</label></td>
					<td>
					<input id="cl_1" type="radio" name="contact_lead" value="1" <cfif contact_lead eq "1">checked="checked"</cfif>> <label for="cl_1">Oui</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="cl_0" type="radio" name="contact_lead" value="0" <cfif contact_lead eq "0">checked="checked"</cfif>> <label for="cl_0">Non</label>
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>Ctc factu</strong></label></td>
					<td>
					<input id="ci_1" type="radio" name="contact_invoice" value="1" <cfif contact_invoice eq "1">checked="checked"</cfif>> <label for="ci_1">Oui</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="ci_0" type="radio" name="contact_invoice" value="0" <cfif contact_invoice eq "0">checked="checked"</cfif>> <label for="ci_0">Non</label>
					</td>
				</tr>
				
				
				<tr>
					<td class="bg-light"><label><strong>Soci&eacute;t&eacute;</strong></label></td>
					<td>
					<cfloop query="get_account_group">
					<label><input type="checkbox" name="acor_id" value="#get_account_group.account_id#" <cfif listfind(ctc_account_id,get_account_group.account_id)>checked</cfif>> #get_account_group.account_name#</label><br>
					</cfloop>
					</td>
				</tr>
				
				<!---<tr>
					<td><label><strong>Soci&eacute;t&eacute;</strong></label></td>
					<td>
					<cfselect query="get_account" display="account_name" value="account_id" class="form-control" name="account_id" selected="#a_id#" disabled="disabled"></cfselect>
					</td>
				</tr>--->
				<tr>
					<td class="bg-light"><label><strong>Titre</strong></label></td>
					<td>
					<input class="form-control" name="contact_title" placeholder="M. / Mme / Mlle" value="#contact_title#" style="width:120px">
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>Pr&eacute;nom / Nom</strong></label></td>
					<td>
					<div class="form-inline">
					<input class="form-control" name="contact_firstname" placeholder="Pr&eacute;nom" value="#contact_firstname#">
					&nbsp;
					<input class="form-control" name="contact_name" required="yes" placeholder="Nom" value="#contact_name#">
					</div>
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>Fonction</strong></label></td>
					<td>
					<cfselect class="form-control form-control-sm" name="function_id" query="get_function" display="function_name" value="function_id" selected="#function_id#">
					<option value="0" <cfif function_id eq "" OR function_id eq "0">selected</cfif>>---</option>
					</cfselect>
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>T&eacute;l&eacute;phone 1</strong></label></td>
					<td>
					<input class="form-control" name="contact_tel1" placeholder="T&eacute;l&eacute;phone 1" value="#contact_tel1#">
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>T&eacute;l&eacute;phone 2</strong></label></td>
					<td>
					<input class="form-control" name="contact_tel2" placeholder="T&eacute;l&eacute;phone 2" value="#contact_tel2#">
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>Email</strong></label></td>
					<td>
					<input class="form-control" name="contact_email" placeholder="Email" value="#contact_email#">
					</td>
				</tr>
				<tr>
					<td class="bg-light"><label><strong>D&eacute;tails</strong></label></td>
					<td>
					<textarea class="form-control" name="contact_details" placeholder="D&eacute;tails" value="#contact_details#"></textarea>
					</td>
				</tr>
			</table>
			
			<div align="center">
				<cfif isdefined("contact_id")>
					<input type="hidden" name="updt_contact" value="1">
					<input type="hidden" name="a_id" value="#a_id#">
					<input type="hidden" name="contact_id" value="#contact_id#">
				<cfelse>
					<input type="hidden" name="ins_contact" value="1">
					<input type="hidden" name="a_id" value="#a_id#">
				</cfif>
				<input type="submit" class="btn btn-info" value="UPDATE CONTACT">
			</div>
			</cfform>
			
			
		</div>		
	</div>
</cfoutput>	


</cfif>