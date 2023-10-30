<cfsilent>

<cfparam name="a_id" default="326">
<cfparam name="update_form" default="0">

<cfset update_account_v = 1>
<cfset d_order_pack_id = 0>
<cfset d_formation_id = 0>
<cfset d_elearning_id = 0>
<cfset d_destination_id = 0>
<cfset d_certif_id = 0>
<cfset d_nbh_visio = 0>
<cfset d_activate_visio = "disabled">
<cfset d_nbh_f2f = 0>
<cfset d_activate_f2f = "disabled">
<cfset d_nbh_el = 0>
<cfset d_activate_el = "disabled">
<cfset d_nbh_imm = 0>
<cfset d_activate_imm = "disabled">
<cfset d_activate_certif = "disabled">


<cfif isdefined("o_id")>
	<cfset update_form = 1>
	
	<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
	SELECT o.*, ap.provider_tva FROM orders o 
	LEFT JOIN account_provider ap ON ap.provider_id = o.provider_id
	WHERE o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>

	<cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_id, u.user_name, u.user_firstname
		FROM orders_users ou
		LEFT JOIN user u ON u.user_id = ou.user_id
		WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>
	

	<cfquery name="get_item_package" datasource="#SESSION.BDDSOURCE#">
	SELECT hour_qty, date_begin, date_end, elearning_id, destination_id, certif_id, method_id 
	FROM order_item_package 
	WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>	

	<cfoutput query="get_item_package">

	<cfswitch expression="#method_id#"> 
		<!--- Visio --->
		<cfcase value="1">

			<cfset d_nbh_visio = hour_qty>
			<cfset d_start_visio = date_begin>
			<cfset d_end_visio = date_end>

			<cfset d_activate_visio = "">

		</cfcase>
		<!--- F2F --->
		<cfcase value="2">

			<cfset d_nbh_f2f = hour_qty>
			<cfset d_start_f2f = date_begin>
			<cfset d_end_f2f = date_end>
			
			<cfset d_activate_f2f = "">

		</cfcase> 
		<!--- Elearning --->
		<cfcase value="3">
			<cfif elearning_id neq "">
				<cfset d_elearning_id = elearning_id>
			<cfelse>
				<cfset d_elearning_id = 0>
			</cfif>
			

			<cfset d_nbh_el = hour_qty>
			<cfset d_start_el = date_begin>
			<cfset d_end_el = date_end>

			<cfset d_activate_el = "">

		</cfcase>
		<!--- Immersion --->
		<cfcase value="6">
			<cfif destination_id neq "">
				<cfset d_destination_id = destination_id>
			<cfelse>
				<cfset d_destination_id = 0>
			</cfif>

			<cfset d_nbh_imm = hour_qty>
			<cfset d_start_imm = date_begin>
			<cfset d_end_imm = date_end>

			<cfset d_activate_imm = "">

		</cfcase>
		<cfcase value="7">
			<cfset d_certif_id = certif_id>

			<cfset d_activate_certif = "">

		</cfcase>
	</cfswitch>

	</cfoutput>

	<!--- TODO ho boy
	ajouter une boucle sur order_item_package
	remplir - nbh_el - nbh_start - nbh_end - etc--->
	
	<cfoutput query="get_order">
	<cfset a_id = account_id>
	<cfset order_ref = order_ref>
	<cfset order_date = dateformat(order_date,'dd/mm/yyyy')>
	<cfset order_status_id = order_status_id>
	<cfset context_id = context_id>
	<cfset init_provider_id = provider_id>
	<cfset init_tva = provider_tva neq "" ? provider_tva : 0>
	<cfset init_tva = order_tva neq "" ? order_tva : init_tva>
	<cfset u_id = user_id>
	<cfset order_start = dateformat(order_start,'dd/mm/yyyy')>
	<cfset order_end = dateformat(order_end,'dd/mm/yyyy')>
	<!--- <cfset order_close = dateformat(order_close,'dd/mm/yyyy')> --->
	<cfset order_comment = order_comment>

	
	<cfset order_conv = order_conv>
	<cfset order_bdc = order_bdc>
	<cfset order_apc = order_apc>
	<cfset order_avn = order_avn>
	<cfset order_avn2 = order_avn2>
	<cfset order_aff = order_aff>
	<cfset order_cert = order_cert>
	<!--- <cfset order_cda = order_cda> --->
	<cfset order_bf = order_bf>
	
	<cfset order_ref2 = order_ref2>
	<cfset order_heritage_id_list = order_heritage_id_list>
	<cfset d_order_pack_id = pack_id>
	<cfset d_formation_id = formation_id>
	</cfoutput>

	<cfloop from="1" to="5" index="cor">
	
		<cfquery name="get_item_invoice_#cor#" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM order_item_invoice WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#"> AND order_item_mode_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfquery>	
		
		
		<cfset "f_account_id_#cor#" = evaluate("get_item_invoice_#cor#").f_account_id>
		<cfset "item_inv_nb_users_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_nb_users>
		<cfset "item_inv_hour_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_hour>
		<cfset "item_inv_unit_price_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_unit_price>
		<cfset "item_inv_fee_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_fee>
		<cfset "item_inv_total_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_total>
		<cfset "item_inv_total_ttc_#cor#" = (evaluate("get_item_invoice_#cor#").item_inv_total neq "" ? evaluate("get_item_invoice_#cor#").item_inv_total : 0) * (1+(init_tva/100))>
		<cfset "user_id_#cor#" = evaluate("get_item_invoice_#cor#").user_id>
		<cfset "order_item_mode_id_#cor#" = evaluate("get_item_invoice_#cor#").order_item_mode_id>
		
	</cfloop>

	
	<cfquery name="get_order_invoice" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT invoice_id FROM invoice WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>

	<cfif get_order_invoice.recordCount GT 0>
		<cfset update_account_v = 0>
	</cfif>
	
<cfelse>


	<cfquery name="get_current_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT account_name, account_id, a.provider_id, p.provider_tva FROM account a 
		LEFT JOIN account_provider p ON a.provider_id = p.provider_id
		WHERE a.account_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
	</cfquery>

	<cfset init_provider_id = get_current_account.provider_id>
	<cfset init_tva = get_current_account.provider_tva>


	<cfset order_ref = "En création">
	<cfset order_date = dateformat(now(),'dd/mm/yyyy')>
	<cfset order_status_id = "0">
	<cfset context_id = "1">
	<cfset u_id = "0">
	<cfset order_start = "#dateformat(now(),'dd/mm/yyyy')#">
	<cfset order_end = "#dateformat(dateadd('yyyy',1,now()),'dd/mm/yyyy')#">
	<!--- <cfset order_close = "#dateformat(now(),'dd/mm/yyyy')#"> --->
	<cfset order_comment = "">

	<cfset order_conv = "">
	<cfset order_bdc = "">
	<cfset order_apc = "">
	<cfset order_avn = "">
	<cfset order_avn2 = "">
	<cfset order_aff = "">
	<cfset order_cert = "">
	<!--- <cfset order_cda = ""> --->
	<cfset order_bf = "">
	
	<cfset order_ref2 = "">
	<cfset order_heritage_id_list = "">
	
	<cfloop from="1" to="5" index="cor">

		<cfset "f_account_id_#cor#" = "">
		<cfset "item_inv_nb_users_#cor#" = "">
		<cfset "item_inv_hour_#cor#" = "">
		<cfset "item_inv_unit_price_#cor#" = "">
		<cfset "item_inv_fee_#cor#" = "">
		<cfset "item_inv_total_#cor#" = "">
		<cfset "item_inv_total_ttc_#cor#" = "">
		<cfset "user_id_#cor#" = "">
		<cfset "order_item_mode_id_#cor#" = "">
		
	</cfloop>
	
</cfif>

<cfquery name="get_order_context" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_context
</cfquery>

<cfquery name="get_order_status_finance" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
(
SELECT status_finance_id, status_finance_name, status_finance_css FROM order_status_finance
)
UNION
(
SELECT "0" as status_finance_id, "---SELECTION---" as status_finance_name,  "secondary" as status_finance_css
)
</cfquery>

<!--- <cfquery name="get_order_status_cs" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT * FROM order_status_cs
</cfquery> --->

<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT provider_id, provider_name FROM account_provider
</cfquery>

<cfquery name="get_order_item_mode" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_item_mode
</cfquery>

<cfquery name="get_opca" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
(
SELECT account_name, account_id
FROM account a WHERE type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4"> AND account_id <> 495 AND account_id <> 432 
)
UNION
(
SELECT "---SELECTION---" as account_name, "0" as account_id
)
ORDER BY account_name
</cfquery>

<cfquery name="get_edof" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT account_name, account_id FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="495">
</cfquery>

<cfquery name="get_pole" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT account_name, account_id FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="432">
</cfquery>

<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT pack_id, pack_name FROM lms_formation_pack WHERE pack_active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> AND (provider_id = 1 OR provider_id = 3) ORDER BY pack_id
</cfquery>

<!--- <cfquery name="get_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT a.account_id, a.account_name FROM account a INNER JOIN account a2 ON a.group_id = a2.group_id WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfquery> --->

<!--- WHERE status_id = 3, half the account have no status --->
<cfquery name="get_all_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT account_name, account_id FROM account a ORDER BY account_name ASC
</cfquery>
	
<cfquery name="get_elearning" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_list_elearning
</cfquery>

<cfquery name="get_certification" datasource="#SESSION.BDDSOURCE#">
SELECT certif_id, certif_name FROM lms_list_certification WHERE certif_active = 1 ORDER BY certif_name
</cfquery>

<cfquery name="get_destination" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_list_destination
</cfquery>	

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT formation_id, formation_code, formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation ORDER BY formation_name
</cfquery>

<cfquery name="get_settings_tva" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT `tva_id`, `tva_rate` FROM settings_tva
</cfquery>



<!--- <cfset get_learner_account = obj_query.oget_learner(list_account="#a_id#",o_by="account_id")> --->

</cfsilent>




<cfform action="updater_order.cfm">

<div class="row">
								
	<div class="col-md-12">
		
		<div class="bg-light p-2 m-1 border border-red">
			<h6 align="center" class="text-red">1- Dossier</h6>
			<br>

			<div class="row">
								
				<div class="col-md-6">
						
					<table class="table table-sm table-bordered bg-white">
						<tr bgcolor="#ECECEC">
							<td align="center" colspan="5"><strong>Dossier de formation</strong></td>
						</tr>
						<tr>
							<td width="25%"><label>Order</label></td>
							<td>
							<h5 class="m-0"><span class="badge badge-pill text-white badge-default"><cfoutput>#order_ref#</cfoutput></span></h5>
							</td>
						</tr>
						<tr>
							<td width="25%"><label>Convention</label></td>
							<td>
								<cfselect class="form-control form-control-sm" name="context_id" query="get_order_context" display="context_alias" value="context_id" selected="#context_id#"></cfselect>
							</td>
						</tr>
						<tr>
							<td><label>&Eacute;dition/Close</label></td>
							<td>
								<div class="controls">
									<div class="input-group">
										<input id="order_date" name="order_date" type="text" class="datepicker form-control" value="<cfoutput>#order_date#</cfoutput>" />
										<label for="order_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
									</div>
								</div>					
							
							</td>
						</tr>
						<tr>
							<td><label>Statut</label></td>
							<td>
							<select name="order_status_id" class="form-control form-control-sm">
							<cfoutput>
							<cfloop query="get_order_status_finance">
							<option value="#status_finance_id#" class="text-#status_finance_css# font-weight-bold" <cfif order_status_id eq status_finance_id>selected</cfif>>#status_finance_name#</option>
							</cfloop>
							</cfoutput>
							</select>
							</td>
						</tr>
						<!--- <tr>
							<td><label>Statut CS</label></td>
							<td>
							<select name="order_status_cs_id" class="form-control form-control-sm">
							<cfoutput>
							<cfloop query="get_order_status_cs">
							<option value="#status_cs_id#" class="text-#status_cs_css# font-weight-bold" <cfif order_status_id eq status_cs_id>selected</cfif>>#status_cs_name#</option>
							</cfloop>
							</cfoutput>
							</select>
							</td>
						</tr> --->
						
						<tr>
							<td><label>Entre le</label></td>
							<td>
								<div class="controls">
									<div class="input-group">
										<input id="order_start" name="order_start" type="text" class="datepicker form-control" value="<cfoutput>#order_start#</cfoutput>" />
										<label for="order_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
									</div>
								</div>					
							
							</td>
						</tr>										
						<tr>
							<td><label>Et le</label></td>
							<td>
								<div class="controls">
									<div class="input-group">
										<input id="order_end" name="order_end" type="text" class="datepicker form-control" value="<cfoutput>#order_end#</cfoutput>" />
										<label for="order_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
									</div>
								</div>							
							</td>
						</tr>
						<tr>
							<td>TVA</td>
							<td>
								<cfif update_account_v eq 0>
									<input type="hidden" name="order_tva" value="<cfoutput>#init_tva#</cfoutput>">
								</cfif>
								<select name="order_tva" id="order_tva" class="form-control form-control-sm order_tva" <cfif update_account_v eq 0>disabled</cfif>>
									<cfloop query="get_settings_tva">
										<cfoutput>
											<option value="#tva_rate#" <cfif tva_rate eq "#init_tva#">selected</cfif>>
												<cfif tva_rate neq "0">
													#tva_rate#
												<cfelse>
													N/A
												</cfif>
											</option>
										</cfoutput>
									</cfloop>
								</select>
							</td>
						</tr>
						<!--- <tr>
							<td><label>Cloture</label></td>
							<td>
								<div class="controls">
									<div class="input-group">
										<input id="order_close" name="order_close" type="text" class="datepicker form-control" value="<cfoutput>#order_close#</cfoutput>" />
										<label for="order_close" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
									</div>
								</div>							
							</td>
						</tr> --->
						<tr>
							<td><label>Réf/N° Client</label></td>
							<td><input type="text" name="order_ref2" class="form-control form-control-sm" value="<cfoutput>#order_ref2#</cfoutput>"></td>
						</tr>
						<tr>
							<td><label>Order Hérité<br><small>séparer par </small>,</label></td>
							<td><input type="text" name="order_heritage_id_list" class="form-control form-control-sm" value="<cfoutput>#order_heritage_id_list#</cfoutput>"></td>
						</tr>

						
						<!---<tr>
							<td width="25%"><label>R&eacute;f&eacute;rent</label></td>
							<td>
								<cfselect class="form-control" name="contact_id" query="get_contact" display="contact_name" value="contact_id" <!---selected="#contact_id#"--->>
								<option value="0" <cfif contact_id eq "0">selected="selected"</cfif>>NC</option>
								</cfselect>
							</td>
						</tr>--->
						<!---<tr>
							<td><label>Adresse Si&egrave;ge</label></td>
							<td>
								<textarea class="form-control" name="order_address" placeholder="Adresse" required="yes" rows="2"><!---<cfoutput>#order_address#</cfoutput>---></textarea>
							</td>
						</tr>	--->									
					</table>

				</div>

				<div class="col-md-6">

					<table class="table table-sm table-bordered bg-white">
						<tr bgcolor="#ECECEC">
							<td align="center" colspan="5"><strong>Provider / Account / Learners</strong></td>
						</tr>
						<tr>
							<td><label>Provider</label></td>
							<td>
								<cfif update_account_v eq 0>
									<input type="hidden" name="provider_id" value="<cfoutput>#init_provider_id#</cfoutput>">
									<cfselect class="form-control form-control-sm" disabled id="provider_id_select" name="provider_id" query="get_provider" display="provider_name" value="provider_id" selected="#init_provider_id#"></cfselect>
								<cfelse>
									<cfselect class="form-control form-control-sm" id="provider_id_select" name="provider_id" query="get_provider" display="provider_name" value="provider_id" selected="#init_provider_id#"></cfselect>
								</cfif>
							</td>
						</tr>
						<tr>
							<td><label>Account</label></td>
							<td>
								<select name="account_select" id="account_select" class="form-control form-control-sm" <cfif update_account_v eq 0>disabled</cfif>>
									<option value="0" selected>---Apprenants sans compte----</option>
									<cfoutput>
									<cfloop query="get_all_account">
										<option value="#account_id#" class="account-#account_id# font-weight-bold" <cfif account_id eq a_id>selected</cfif>>#account_name#</option>
									</cfloop>
									</cfoutput>
								</select>
							</td>
						</tr>

						<!------------------------------------- LEARNER ------------------------------------------>	
						<tr>
							<td><label>Learner</label></td>
							<td>
								<div class="row m-1 mb-3">
									<div class="col-md-5">
										<strong>Existing Learner <a type="button" class="add_existing_user" id="add_existing_user"><i class="far fa-plus-circle"></i></a></strong>
									</div>
									<div class="col-md-7" id="container_existing_user">
										
									</div>
									
								</div>
								
								<div class="row m-1 mb-2">
									<div class="col-md-5">
										<strong>OR New Learner <a type="button" class="add_new_user" id="add_new_user"><i class="far fa-plus-circle"></i></a></strong>
									</div>
									<div class="col-md-7" id="container_new_user">
									</div>
								</div>

							</td>
						</tr>
					</table>


					<table class="table table-sm table-bordered bg-white">
						<tr bgcolor="#ECECEC">
							<td align="center"><strong>Comments Order</strong></td>
						</tr>

						<tr>
							<td><textarea name="order_comment" rows="6" style="width:100%"><cfoutput>#order_comment#</cfoutput></textarea></td>
						</tr>

					</table>
				</div>
			</div>
			
		</div>
		

	</div>

</div>

<div class="row">

	<div class="col-md-12">
		
		<div class="bg-light p-2 m-1 border border-red">
		<h6 align="center" class="text-red">2- Package</h6>
		<br>
			<table class="table table-sm table-bordered">
				<tr bgcolor="#ECECEC">
					<td align="center"><strong> Catalogue CPF</strong></td>
				</tr>
				<tr>
					<td>
						<select name="pack_id" id="pack_id" class="form-control">
						<option value="0" <cfif d_order_pack_id eq "" OR d_order_pack_id eq "0">selected</cfif>>--- SUR MESURE ---</option>
						<cfoutput query="get_formation_pack">
						<option value="#pack_id#" <cfif pack_id eq d_order_pack_id>selected</cfif>>#pack_id# - #pack_name#</option>
						</cfoutput>
						</select>
					</td>
				</tr>
			</table>
		
			<table class="table table-sm bg-white border">
				<tr bgcolor="#ECECEC">
					<td colspan="5" align="center"><strong>Formation déployée</strong></td>
				</tr>
				<tr>
					<td>Formation</td>
					<td colspan="4">
					<select id="formation_id" name="formation_id" class="form-control form-control-sm">
					<option value="0" <cfif d_formation_id eq "" OR d_formation_id eq 0>selected</cfif>>---</option>
					<cfoutput query="get_formation">
					<option value="#formation_id#" <cfif formation_id eq d_formation_id>selected</cfif>>#formation_name#</option>
					</cfoutput>
					</select>
					</td>
				</tr>
				<tr>
					<td width="20%"><label><input type="checkbox" class="method_id" name="method_id" value="1" <cfif d_activate_visio neq "disabled">checked</cfif>> Visio</label></td>
					<td colspan="2"><input type="number" step="any" id="nbh_visio" name="nbh_visio" value="<cfoutput>#d_nbh_visio#</cfoutput>" class="form-control form-control-sm d-inline" style="width:80px" <cfoutput>#d_activate_visio#</cfoutput>> h</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="start_visio" name="start_visio" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_start_visio")><cfoutput>#d_start_visio#</cfoutput></cfif>"  <cfoutput>#d_activate_visio#</cfoutput>>
								<label for="start_visio" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="end_visio" name="end_visio" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_visio")><cfoutput>#d_end_visio#</cfoutput></cfif>"  <cfoutput>#d_activate_visio#</cfoutput>>
								<label for="end_visio" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
				</tr>
				<tr>
					<td><label><input type="checkbox" class="method_id" name="method_id" value="2" <cfif d_activate_f2f neq "disabled">checked</cfif>> F2F</label></td>
					<td colspan="2"><input type="number" step="any" id="nbh_f2f" name="nbh_f2f" value="<cfoutput>#d_nbh_f2f#</cfoutput>" class="form-control form-control-sm d-inline" style="width:80px" <cfoutput>#d_activate_f2f#</cfoutput>> h</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="start_f2f" name="start_f2f" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_f2f")><cfoutput>#d_end_f2f#</cfoutput></cfif>" <cfoutput>#d_activate_f2f#</cfoutput>>
								<label for="start_f2f" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="end_f2f" name="end_f2f" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_f2f")><cfoutput>#d_end_f2f#</cfoutput></cfif>" <cfoutput>#d_activate_f2f#</cfoutput>>
								<label for="end_f2f" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
				</tr>
				<tr>
					<td><label><input type="checkbox" class="method_id" name="method_id" value="3" <cfif d_activate_el neq "disabled">checked</cfif>> Elearning</label></td>
					<td>
						<select name="nbh_el" id="nbh_el" class="form-control form-control-sm" <cfoutput>#d_activate_el#</cfoutput>>
						<option value="0" <cfif d_nbh_el eq "" OR d_nbh_el eq "0">selected</cfif>>---</option>
						<cfoutput>
						<cfloop list="1,7,30,60,90,120,150,180,210,240,270,300,330,360" index="cor">
						<cfif cor lt "30">
						<option value="#cor#" <cfif cor eq d_nbh_el>selected</cfif> >#cor# jour(s)</option>		
						<cfelse>
						<option value="#cor#" <cfif cor eq d_nbh_el>selected</cfif> >#cor/30# mois</option>	
						</cfif>						
						</cfloop>
						</cfoutput>
						</select>
							
					</td>
					<td>
						<select name="elearning_id" id="elearning_id" class="form-control form-control-sm" <cfoutput>#d_activate_el#</cfoutput>>
						<option value="0" <cfif d_elearning_id eq "" OR d_elearning_id eq "0">selected</cfif>>---</option>
						<cfoutput query="get_elearning">
						<option value="#elearning_id#" <cfif elearning_id eq d_elearning_id>selected</cfif>>#elearning_name#</option>
						</cfoutput>
						</select>
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="start_el" name="start_el" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_el")><cfoutput>#d_end_el#</cfoutput></cfif>" <cfoutput>#d_activate_el#</cfoutput>>
								<label for="start_el" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="end_el" name="end_el" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_el")><cfoutput>#d_end_el#</cfoutput></cfif>" <cfoutput>#d_activate_el#</cfoutput>>
								<label for="end_el" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
				</tr>
				<tr>
					<td><label><input type="checkbox" class="method_id" name="method_id" value="6" <cfif d_activate_imm neq "disabled">checked</cfif>> Immersion</label></td>
					<td><input type="number" step="any" id="nbh_imm" name="nbh_imm" value="<cfoutput>#d_nbh_imm#</cfoutput>" class="form-control form-control-sm d-inline" style="width:80px" <cfoutput>#d_activate_imm#</cfoutput>> h</td>
					<td>
						<select name="destination_id" id="destination_id" class="form-control form-control-sm" <cfoutput>#d_activate_imm#</cfoutput>>
						<option value="0" <cfif d_destination_id eq "" OR d_destination_id eq "0">selected</cfif>>---</option>
						<cfoutput query="get_destination">
						<option value="#destination_id#" <cfif destination_id eq d_destination_id>selected</cfif>>#destination_name#</option>
						</cfoutput>
						</select>
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="start_imm" name="start_imm" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_imm")><cfoutput>#d_end_imm#</cfoutput></cfif>" <cfoutput>#d_activate_imm#</cfoutput>>
								<label for="start_imm" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>	
					</td>
					<td>
						<div class="controls">
							<div class="input-group">
								<input id="end_imm" name="end_imm" type="text" class="datepicker form-control form-control-sm" value="<cfif isDefined("d_end_imm")><cfoutput>#d_end_imm#</cfoutput></cfif>" <cfoutput>#d_activate_imm#</cfoutput>>
								<label for="end_imm" class="input-group-addon btn btn-sm"><i class="far fa-calendar-alt"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><label><input type="checkbox" class="method_id" name="method_id" value="7" <cfif d_activate_certif neq "disabled">checked</cfif>> Certif</label></td>
					<td colspan="2">
						<select name="certif_id" id="certif_id" class="form-control form-control-sm" <cfoutput>#d_activate_certif#</cfoutput>>
						<option value="0" <cfif d_certif_id eq "" OR d_certif_id eq "0">selected</cfif>>---</option>
						<cfoutput query="get_certification">
						<option value="#certif_id#" <cfif certif_id eq d_certif_id>selected</cfif>>#certif_name#</option>
						</cfoutput>
						</select>
					</td>
				</tr>
			</table>
		</div>
		
	</div>

</div>

<div class="row">

	<div class="col-md-12">
		
		<div class="bg-light p-2 m-1 border border-red">
		<h6 align="center" class="text-red">3- Financement</h6>
		<br>
	

		<table class="table table-sm table-bordered bg-white">
			<tr bgcolor="#ECECEC" id="inv_tab" class="inv_tab">
				<td><strong>Type</strong></td>
				<td><strong>Désignation</strong></td>
				<td><strong>L</strong></td>
				<td><strong>Nb h</strong></td>
				<td><strong>PU</strong></td>
				<td><strong>Fees</strong></td>
				<td><strong>ss-Total HT</strong></td>
				<td><strong>TTC</strong></td>
			</tr>
			
			
			<cfoutput query="get_order_item_mode">
			<tr>
				<td><label><input type="checkbox" name="order_item_mode_id" class="order_item_mode_id" id="order_item_mode_#order_item_mode_id#" value="#order_item_mode_id#"> #order_item_mode_name#</label></td>
				<td>
				<!--- <input type="text" name="account_#order_item_mode_id#" id="account_#order_item_mode_id#" class="form-control form-control-sm"> --->
				<cfif order_item_mode_id eq "1">
					<cfif f_account_id_1 eq ""><cfset f_account_id_1 = a_id></cfif>
					<select name="account_#order_item_mode_id#" id="account_#order_item_mode_id#" class="form-control form-control-sm">
					<!--- <cfloop query="get_account">
					<option value="#get_account.account_id#" <cfif f_account_id_1 eq get_account.account_id>selected</cfif>>#get_account.account_name#</option>
					</cfloop> --->
					</select>
				<cfelseif order_item_mode_id eq "2">
					<select name="account_#order_item_mode_id#" class="form-control form-control-sm">
					<cfloop query="get_opca">
					<option value="#get_opca.account_id#" <cfif f_account_id_2 eq get_opca.account_id>selected</cfif>>#get_opca.account_name#</option>
					</cfloop>
					</select>
				<cfelseif order_item_mode_id eq "3">
					<select name="account_#order_item_mode_id#" class="form-control form-control-sm">
					<cfloop query="get_edof">
					<option value="#get_edof.account_id#" <cfif f_account_id_3 eq get_edof.account_id>selected</cfif>>#get_edof.account_name#</option>
					</cfloop>
					</select>
				<cfelseif order_item_mode_id eq "4">
					<select name="account_#order_item_mode_id#" class="form-control form-control-sm">
					<cfloop query="get_pole">
					<option value="#get_pole.account_id#" <cfif f_account_id_4 eq get_pole.account_id>selected</cfif>>#get_pole.account_name#</option>
					</cfloop>
					</select>
				<cfelseif order_item_mode_id eq "5">
					<input type="hidden" name="account_#order_item_mode_id#" value="#a_id#">
				</cfif>
				</td>
				<td>
				<input type="number" step="any" name="order_item_nb_user_#order_item_mode_id#" id="order_item_nb_user_#order_item_mode_id#" value="#Variables["item_inv_nb_users_#order_item_mode_id#"] neq "" ? Variables["item_inv_nb_users_#order_item_mode_id#"] : 1#" class="form-control form-control-sm order_item_nb_user">
				</td>
				<td>
				<input type="number" step="any" name="order_item_qty_#order_item_mode_id#" id="order_item_qty_#order_item_mode_id#" value="#Variables["item_inv_hour_#order_item_mode_id#"]#" class="form-control form-control-sm">
				</td>
				<td>
				<input type="number" step="any" name="order_item_unit_price_#order_item_mode_id#" id="order_item_unit_price_#order_item_mode_id#" value="#Variables["item_inv_unit_price_#order_item_mode_id#"]#" class="form-control form-control-sm">
				</td>
				<td>
				<input type="number" step="any" name="order_item_fee_amount_#order_item_mode_id#" id="order_item_fee_amount_#order_item_mode_id#" value="#Variables["item_inv_fee_#order_item_mode_id#"]#" class="form-control form-control-sm">
				</td>
				<td>
				<input type="number" step="any" name="order_item_amount_#order_item_mode_id#" id="order_item_amount_#order_item_mode_id#" readonly value="#Variables["item_inv_total_#order_item_mode_id#"]#" class="form-control form-control-sm">
				</td>
				<td>
					<input type="number" step="any" name="order_item_amount_ttc_#order_item_mode_id#" id="order_item_amount_ttc_#order_item_mode_id#" readonly value="#Variables["item_inv_total_ttc_#order_item_mode_id#"]#" class="form-control form-control-sm">
				</td>
			</tr>
			</cfoutput>
			<tr id="invoice_calcul">
				<td colspan="5" align="right"><strong>Total HT/TTC</strong></td>
				<td><a class="btn btn-sm btn-info text-white" id="calcul">Calcul</a></td>
				<td><input type="number" step="any" id="total" class="form-control form-control-sm" readonly></td>
				<td><input type="number" step="any" id="total_ttc" class="form-control form-control-sm" readonly></td>
			</tr>
		</table>
		
		</div>
		
	</div>
	
</div>


<div class="row mt-3">
	<div class="col-md-12" align="center">
		<cfif isdefined("o_id")>
		<cfoutput>
		<input type="hidden" name="o_id" value="#o_id#">
		<input type="hidden" name="_maj_order" value="1">
		</cfoutput>
		</cfif>
		<cfoutput>
		<input type="hidden" name="insert_order" id="insert_order" value="#a_id#">
		<input type="hidden" name="a_id" id="a_id" value="#a_id#">
		</cfoutput>
		<input type="hidden" name="new_user_count" id="new_user_count" value="0">
		<input type="hidden" name="existing_user_count" id="existing_user_count" value="1">
		<input type="submit" class="btn btn-success" value="Enregistrer">
	</div>
</div>
</cfform>
	
<script>
$(document).ready(function() {

var new_user_count = 0;
var new_user_list = [];
var existing_user_count = 1;
var val_grp_selected = 0;
var _tva = <cfoutput>#init_tva#</cfoutput>;

function update_user_list(){

	// learner_select_all
	$.ajax({
		url: './api/users/user_get.cfc?method=oget_account_user',
		type: 'POST',
		data: { a_id: 0, g_id: val_grp_selected, learner_only: 1, o_by: "name" },
		success: function (result, status) {
			// console.log(result);
			var obj_result = jQuery.parseJSON(result);
			var target = $("#container_existing_user");
			target.empty(); // remove old options

			<cfif isDefined("o_id")>
				<cfloop query="get_orders_users">
			
				var div = $("<div></div>").attr("class", "row")
				var el = $("<select></select>")
				el.attr("class", "learner_select_all form-control form-control-sm col-md-9")
				// if (existing_user_count <= 1) el.attr("id", "learner_select")
				el.attr("name", "user_id_ex")
				// el.append($("<option></option>").attr("value", "0").text("Sélectionner"));
				
				el.append($("<option></option>").attr("value", "<cfoutput>#user_id#</cfoutput>").text("<cfoutput>#user_name# #user_firstname#</cfoutput>"));
				
				div.append(el);

				var button = $("<a><i class='fa-light fa-arrow-up-right-from-square'></i></a>").attr("class", "go_to_existing_user col-md-1").attr("id", "goto_<cfoutput>#user_id#</cfoutput>")
				div.append(button);
				var button = $("<a><i class='fal fa-trash-alt'></i></a>").attr("class", "remove_existing_user col-md-1")
				div.append(button);

				target.append(div);

				existing_user_count++;
				</cfloop>
				
			</cfif>

			update_new_learner_list();

			var div = $("<div></div>").attr("class", "row").attr("id", "learner_select")
			var el = $("<select></select>")
			el.attr("class", "learner_select_all form-control form-control-sm col-md-9")
			// el.attr("id", "learner_select")
			el.attr("name", "user_id_ex")
			el.append($("<option></option>").attr("value", "0").text("Sélectionner"));

			obj_result.forEach(element => {
				el.append($("<option></option>").attr("value", element.USER_ID).text(element.USER_NAME + " " + element.USER_FIRSTNAME));
			});

			div.append(el);

			// let button = $("<a><i class='fal fa-trash-alt'></i></a>").attr("class", "remove_existing_user col-md-2")
			// div.append(button);

			target.append(div);

			$("#existing_user_count").val(existing_user_count);

			// $(".order_item_nb_user").val(new_user_count + existing_user_count - 1);

			existing_user_count++;

			$(".remove_existing_user").off("click");
			$(".remove_existing_user").bind("click",handler_remove_existing_user);
			$(".go_to_existing_user").off("click");
			$(".go_to_existing_user").bind("click",handler_go_to_existing_user);
		}
	});
}

function update_new_learner_list() {

	var target = $("#container_new_user");
	target.empty();

	if(new_user_list[0]) {
	for (let i = 0; i < new_user_list.length; i++) {
		const element = new_user_list[i];
		var div = $("<div></div>").attr("class", "row")
		var el = $("<select></select>")
		el.attr("class", "learner_select_all form-control form-control-sm col-md-10")
		// if (existing_user_count <= 1) el.attr("id", "learner_select")
		el.attr("name", "user_id_ex")
		// el.append($("<option></option>").attr("value", "0").text("Sélectionner"));
		
		el.append($("<option></option>").attr("value", element.user_id).text(element.user_name + " " + element.user_firstname));
		
		div.append(el);

		// let button = $("<a><i class='fal fa-trash-alt'></i></a>").attr("class", "remove_existing_user col-md-2")
		// div.append(button);
		
		target.append(div);
		existing_user_count++;
	}
	}
}

function update_tva(_p_id) {

	$.ajax({
		url: './api/account/account_get.cfc?method=get_tva',
		type: 'GET',
		data: { p_id: _p_id },
		success: function (result, status) {
			// console.log(result);
			var obj_result = jQuery.parseJSON(result);
			// console.log(obj_result[0]["PROVIDER_TVA"])

			_tva = obj_result[0]["PROVIDER_TVA"];
			$("#order_tva").val(_tva + '.00').change();
			calcul();
			// alert(_tva);
	}
	});
}

function update_account_list(val_acc_selected){

	$.ajax({
		url: './api/users/user_get.cfc?method=oget_account_group',
		type: 'POST',
		data: { a_id: val_acc_selected },
		success: function (result, status) {
			// console.log(result);
			var obj_result = jQuery.parseJSON(result);
			var target = $("#account_1");
			target.empty(); // remove old options

			if (obj_result[0]) {
				obj_result.forEach(element => {
					target.append($("<option></option>").attr("value", element.ACCOUNT_ID).text(element.ACCOUNT_NAME));
				});

				$("select option[value='" + val_acc_selected +"']").attr("selected","selected");

				$("#insert_order").val(val_acc_selected);
				$("#provider_id_select").val(obj_result[0].PROVIDER_ID);

				update_tva(obj_result[0].PROVIDER_ID)

				existing_user_count = 1;
				val_grp_selected = obj_result[0].GROUP_ID;
				update_user_list();
			}
		}
	});
}

update_account_list(<cfoutput>#a_id#</cfoutput>);

$("#account_select").change(function(event) {
	// $("#pack_id option[value='0']").prop("selected", true);

	update_account_list($(event.target).val());

})


$("#provider_id_select").change(function(event) {
	// $("#pack_id option[value='0']").prop("selected", true);

	// console.log(event);
	// console.log($(event.target).val());

	update_tva($(event.target).val())
	
})

function reinit(){
	$(".method_id").prop("checked",false);
	
	$("#nbh_visio").val("");
	$("#nbh_f2f").val("");
	$("#nbh_imm").val("");
	$("#nbh_visio").prop("disabled", true);
	$("#nbh_f2f").prop("disabled", true);
	$("#nbh_imm").prop("disabled", true);
	$("#nbh_el").prop("disabled", true);
	$("#elearning_id").prop("disabled", true);
	$("#certif_id").prop("disabled", true);
		
	$(".method_id[value=1]").prop("checked",false);
	$(".method_id[value=2]").prop("checked",false);
	$(".method_id[value=3]").prop("checked",false);
	$(".method_id[value=6]").prop("checked",false);
	$(".method_id[value=7]").prop("checked",false);	
	$("#elearning_id option[value='0']").prop("selected", true);
	$("#destination_id option[value='0']").prop("selected", true);
	$("#certif_id option[value='0']").prop("selected", true);
	$("#nbh_el option[value='0']").prop("selected", true);
	
	$("#order_item_fee_amount_3").val("0");
	$("#order_item_amount_3").val("");

}
$("#formation_id").change(function(event) {
	$("#pack_id option[value='0']").prop("selected", true);
	reinit();
})


$(".method_id").change(function(event) {

	if($(this).prop('checked') == true)
	{
		if($(this).val() == "1")
		{
			$("#nbh_visio").prop("disabled", false);
			$("#start_visio").prop("disabled", false);
			$("#end_visio").prop("disabled", false);
		}
		if($(this).val() == "2")
		{
			$("#nbh_f2f").prop("disabled", false);
			$("#start_f2f").prop("disabled", false);
			$("#end_f2f").prop("disabled", false);
		}
		if($(this).val() == "3")
		{
			$("#nbh_el").prop("disabled", false);
			$("#elearning_id").prop("disabled", false);
			$("#start_el").prop("disabled", false);
			$("#end_el").prop("disabled", false);
		}
		if($(this).val() == "6")
		{
			$("#nbh_imm").prop("disabled", false);
			$("#destination_id").prop("disabled", false);
			$("#start_imm").prop("disabled", false);
			$("#end_imm").prop("disabled", false);
		}
		if($(this).val() == "7")
		{
			$("#certif_id").prop("disabled", false);
		}
		
	}
	else
	{
		if($(this).val() == "1")
		{
			$("#nbh_visio").prop("disabled", true);
			$("#start_visio").prop("disabled", true);
			$("#end_visio").prop("disabled", true);
			$("#start_visio").val("");
			$("#end_visio").val("");
		}
		if($(this).val() == "2")
		{
			$("#nbh_f2f").prop("disabled", true);
			$("#start_f2f").prop("disabled", true);
			$("#end_f2f").prop("disabled", true);
			$("#start_f2f").val("");
			$("#end_f2f").val("");
		}
		if($(this).val() == "3")
		{
			$("#nbh_el").prop("disabled", true);
			$("#elearning_id").prop("disabled", true);
			$("#start_el").prop("disabled", true);
			$("#end_el").prop("disabled", true);
			$("#start_el").val("");
			$("#end_el").val("");
			$("#nbh_el option[value='0']").prop("selected", true);
			$("#elearning_id option[value='0']").prop("selected", true);
		}
		if($(this).val() == "6")
		{
			$("#nbh_imm").prop("disabled", true);
			$("#destination_id").prop("disabled", true);
			$("#start_imm").prop("disabled", true);
			$("#end_imm").prop("disabled", true);
			$("#start_imm").val("");
			$("#end_imm").val("");
		}
		if($(this).val() == "7")
		{
			$("#certif_id").prop("disabled", true);
		}
	}
})

$("#pack_id").change(function(event) {
	
	
	<!--- REINIT --->
	reinit();	
	$("#formation_id option[value='0']").prop("selected", true);
	
	
	if($(this).val() != 0)
	{
	$.ajax({				 
		url: './api/pack/pack_get.cfc?method=oget_formation_pack',
		type: 'GET',				
		data : "pack_id="+$(this).val(),
		datatype : "html",
		success : function(resultat, statut){
			
				<!---- RETRIEVE DATA --->
				var obj = JSON.parse(resultat);
				var pack_id = obj["pack_id"];
				var pack_name = obj["pack_name"];
				var method_id = obj["method_id"];
				var formation_id = obj["formation_id"];
				var pack_hour = obj["pack_hour"];
				var elearning_id = obj["elearning_id"];
				var pack_duration = obj["pack_duration"];
				var destination_id = obj["destination_id"];
				var certif_id = obj["certif_id"];
				var pack_amount_ht = obj["pack_amount_ht"];
				var pack_amount_ttc = obj["pack_amount_ttc"];
				
				
				
				<!---- PRESELECT EDOF --->
				$(".order_item_mode_id[value=3]").prop("checked",true);
				$("#order_item_fee_amount_3").val(pack_amount_ht);
				$("#order_item_amount_3").val(pack_amount_ht);
				
				
				
				
				
				<!---- PRESELECT --->
				$("#certif_id").prop("disabled",false);
				$("#formation_id option[value='"+formation_id+"']").prop("selected", true);
				$("#certif_id option[value='"+certif_id+"']").prop("selected", true);
				$(".method_id[value=7]").prop("checked",true);
				
				if(method_id.indexOf("1") != "-1")
				{
					$(".method_id[value=1]").prop("checked",true);
					$("#nbh_visio").val(pack_hour);		
					$("#nbh_visio").prop("disabled", false);
					
				}
				if(method_id.indexOf("2") != "-1")
				{
					$(".method_id[value=2]").prop("checked",true);
					$("#nbh_f2f").val(pack_hour);
					$("#nbh_f2f").prop("disabled", false);
				}
				if(method_id.indexOf("3") != "-1")
				{
					$(".method_id[value=3]").prop("checked",true);
					$("#elearning_id option[value='"+elearning_id+"']").prop("selected", true);
					$("#elearning_id").prop("disabled", false);
					$("#nbh_el option[value='"+pack_duration+"']").prop("selected", true);
					$("#nbh_el").prop("disabled", false);
					
				}
				if(method_id.indexOf("6") != "-1")
				{
					$(".method_id[value=6]").prop("checked",true);
					$("#nbh_imm").val(pack_hour);
					$("#nbh_imm").prop("disabled", false)
					$("#destination_id option[value='"+destination_id+"']").prop("selected", true);					
					$("#destination_id").prop("disabled", false);;
				}
				
		},
		error : function(resultat, statut, erreur){
			/*console.log(resultat);*/
		},
		complete : function(resultat, statut){
			/*console.log(resultat);*/
		}	
	});
	}

})



	$("#add_new_user").click(function (event) {
		
		let go_u = 1;
		let go_o = 1;

		$('#window_item_xl').modal('hide');

		$('#window_item_xl').on('hidden.bs.modal', function (e) {
			if (go_u) {
				go_u = 0;
				$('#modal_title_lg').text("Ajouter user");
				$('#window_item_lg').modal({keyboard: true});
				$('#modal_body_lg').load("modal_window_learner.cfm?from_order=1&create=1&a_id=<cfoutput>#a_id#</cfoutput>", function() {});
			}
		});

		$('#window_item_lg').on('hidden.bs.modal', function (e) {
			if (go_o) {
				go_o = 0;
				$('#window_item_xl').modal('show');

				let newl = sessionStorage.getItem("new_order_learner");
				let obj_result = jQuery.parseJSON(newl);

				new_user_list.push(obj_result);

				sessionStorage.removeItem("new_order_learner");

				update_new_learner_list();
			}
		});

	})

		
	$("#add_existing_user").click(function (event) {

		$('#learner_select').clone()
			.attr('name', 'user_id_ex')
			.show()
			.appendTo('#container_existing_user');
		
		$(".remove_existing_user").off("click");
		$(".remove_existing_user").bind("click",handler_remove_existing_user);
		$("#existing_user_count").val(existing_user_count);

		// $(".order_item_nb_user").val(new_user_count + existing_user_count - 1);

		existing_user_count++;
	})			
					
	var handler_remove_existing_user = function (event) {
		event.preventDefault();
		event.target.parentElement.parentElement.remove();
	}

	var handler_go_to_existing_user = function (event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		u_id = idtemp[1];
		window.open("/common_learner_account.cfm?u_id="+u_id);
	}

	

	$("#order_date").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy'
	})
	$("#order_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#order_end").datepicker( "option", "minDate", selectedDate );
		},
		onSelect: function( selectedDate ) {
			// console.log(selectedDate)
			var _date = moment(selectedDate, 'DD/MM/YYYY', true).add(1,'y');
			$('#order_end').datepicker('setDate', _date.toDate());
		}
	})
	$("#order_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	})

	// $("#order_close").datepicker({	
	// 	weekStart: 1,
	// 	dateFormat: 'dd/mm/yy',
	// 	onClose: function( selectedDate ) {}	
	// })
	
	<!--------------------PARAM TP DATES---------------->
	$("#start_visio").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#end_visio").datepicker( "option", "minDate", selectedDate );
		},
		onSelect: function( selectedDate ) {
			// console.log(selectedDate)
			var _date = moment(selectedDate, 'DD/MM/YYYY', true).add(1,'y');
			$('#end_visio').datepicker('setDate', _date.toDate());
		}
	})
	$("#end_visio").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	})
	$("#start_f2f").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#end_f2f").datepicker( "option", "minDate", selectedDate );
		},
		onSelect: function( selectedDate ) {
			// console.log(selectedDate)
			var _date = moment(selectedDate, 'DD/MM/YYYY', true).add(1,'y');
			$('#end_f2f').datepicker('setDate', _date.toDate());
		}
	})
	$("#end_f2f").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	})
	$("#start_el").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#end_el").datepicker( "option", "minDate", selectedDate );
		},
		onSelect: function( selectedDate ) {
			// console.log(selectedDate)
			var _date = moment(selectedDate, 'DD/MM/YYYY', true).add(1,'y');
			$('#end_el').datepicker('setDate', _date.toDate());
		}
	})
	$("#end_el").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	})
	$("#start_imm").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#end_imm").datepicker( "option", "minDate", selectedDate );
		},
		onSelect: function( selectedDate ) {
			// console.log(selectedDate)
			var _date = moment(selectedDate, 'DD/MM/YYYY', true).add(1,'y');
			$('#end_imm').datepicker('setDate', _date.toDate());
		}
	})
	$("#end_imm").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	})
	
	
	
	
	
	
	
	$("#calcul").click(function() {
		calcul();
	})
	
	function calcul()
	{
		// function isFloat(n){
		// 	return Number(n) === n && n % 1 !== 0;
		// }

		var total = 0;
		var total_ttc = 0;
		<cfoutput query="get_order_item_mode">

		var nb_user = parseFloat(!($("##order_item_nb_user_#order_item_mode_id#").val()  == "") ? $("##order_item_nb_user_#order_item_mode_id#").val() : 0);
		var nb_hour = parseFloat(!($("##order_item_qty_#order_item_mode_id#").val()  == "") ? $("##order_item_qty_#order_item_mode_id#").val() : 0)
		var unitp = parseFloat(!($("##order_item_unit_price_#order_item_mode_id#").val()  == "") ? $("##order_item_unit_price_#order_item_mode_id#").val() : 0);
		
		var fee = parseFloat(!($("##order_item_fee_amount_#order_item_mode_id#").val() == "") ? $("##order_item_fee_amount_#order_item_mode_id#").val() : 0);

		var sub_total = ((nb_user * (nb_hour*unitp)) + fee);
		$("##order_item_amount_#order_item_mode_id#").val(sub_total.toFixed(2));
		$("##order_item_amount_ttc_#order_item_mode_id#").val((sub_total *(1+($("##order_tva").val()/100))).toFixed(2));
		total += sub_total;
		total_ttc += sub_total *(1+($("##order_tva").val()/100));

		if ( sub_total != 0 || nb_hour != 0 || unitp != 0 || fee != 0) { 
			$('##order_item_mode_#order_item_mode_id#').prop( "checked", true ) 
		} else if (sub_total == 0 && nb_hour == 0 && unitp == 0 && fee == 0) { 
			$('##order_item_mode_#order_item_mode_id#').prop( "checked", false ) 
		}

		</cfoutput>
		
		<!--- $(".total_opco").val(parseFloat($(".nbh_opco").val())*parseFloat($(".pu_opco").val())+parseFloat($(".fee_opco").val())); --->
		<!--- $(".total_edof").val(parseFloat($(".nbh_edof").val())*parseFloat($(".pu_edof").val())+parseFloat($(".fee_edof").val())); --->
		<!--- $(".total_pe").val(parseFloat($(".nbh_pe").val())*parseFloat($(".pu_pe").val())+parseFloat($(".fee_pe").val())); --->
		<!--- $(".total_perso").val(parseFloat($(".nbh_perso").val())*parseFloat($(".pu_perso").val())+parseFloat($(".fee_perso").val())); --->
		
		$("#total").val(total.toFixed(2));
		$("#total_ttc").val(total_ttc.toFixed(2));
		
	}

	calcul()

});
</script>