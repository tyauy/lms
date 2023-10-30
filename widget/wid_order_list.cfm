<cfparam name="view_order" default="full">
<div class="table-responsive">
<table class="table table-sm">
	<tbody>
		<tr class="bg-light">
			<th>ID</th>
			<!---<th>Status CS</th>--->
			<th>STATUS</th>
			<cfif view_order eq "full"><th>MANAGER</th></cfif>
			<cfif view_order eq "full"><th>CLOSED</th></cfif>
			<th>APPRENANT</th>
			<!--- <th>ACCOUNT</th> --->
			<th>LANG</th>
			<th>PACK</th>
			<th>START</th>
			<th>END</th>
			<!--- <th>COMMENTS</th> --->
			<!---<th>Activit&eacute;</th>--->
			
			<!---<th>AF</th>--->
			<!---<th>AL</th>--->
			<!---<th>Facturation</th>--->
				<th align="center">ACTIONS</th>
		</tr>
		<cfset counter = 0>
		<cfoutput query="get_orders" group="order_id">
		<cfif order_id neq 1>


		<!--- TODO a mettre dans api quand OK --->
		<cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
			SELECT u.user_id, u.user_name, u.user_firstname
			FROM orders_users ou
			LEFT JOIN user u ON u.user_id = ou.user_id
			WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
		</cfquery>
	
		<!--- <cfset tmp2 = QueryGetRow(get_orders_users, 1)> --->
		<!--- TODO boucler partout ou necessaire --->
		<!--- <cfoutput query="get_orders_users"> --->
		<!--- <cfset _user_id = tmp2.user_id>
		<cfset _user_firstname = tmp2.user_firstname>
		<cfset _user_name = tmp2.user_name> --->
		<!--- </cfoutput> --->

		<!--- <cfdump var="#user_id#"> --->


		<!--- <cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(log_id) as nb_log
		FROM logs WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#_user_id#">
		</cfquery> --->
		<cfset counter++>
		<cfif counter/2 eq round(counter/2)>
			<cfset colorgo = "FAFAFA">
		<cfelse>
			<cfset colorgo = "FFF">
		</cfif>
		<tr bgcolor=###colorgo#>
			<td><span class="badge badge-pill text-white badge-default" id="o_#order_id#" style="cursor:pointer">#order_ref#<br>#order_id#</span></td>
			<!---<td><a class="btn btn-xs #status_cs_css#">#status_cs_name#</a></td>--->
			<td>
			<span class="badge badge-pill text-white badge-default" id="o_#order_id#" style="cursor:pointer">#context_alias#</span>
			<br><span class="badge badge-pill text-white badge-#status_finance_css#" id="o_#order_id#" style="cursor:pointer">#status_finance_name#</span>
			</td>
			<cfif view_order eq "full"><td><span class="badge badge-pill text-white" style="background-color:###manager_color#">#manager_firstname#</span></td></cfif>
			<cfif view_order eq "full"><td>#dateformat(order_date,'dd/mm/yyyy')#</td></cfif>
			<td>
				<a href="crm_account_edit.cfm?a_id=#account_id#"><small><strong><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></strong></small></a>
				<br>
				<cfif get_orders_users.recordCount GT 1>
					<select>
						<cfloop query="get_orders_users">
							<option value="#get_orders_users.user_id#">
								<!--- #user_firstname# #ucase(user_name)# --->
								<a href="common_learner_account.cfm?u_id=#get_orders_users.user_id#"><strong>#get_orders_users.user_firstname# #ucase(get_orders_users.user_name)#</strong></a>
							</option>
						</cfloop>
					</select>
				<cfelseif get_orders_users.recordCount eq 1>
					<a href="common_learner_account.cfm?u_id=#get_orders_users.user_id#"><strong>#get_orders_users.user_firstname# #ucase(get_orders_users.user_name)#</strong></a>
				</cfif>
				
			</td>

			<td>
				<span class='lang-sm' lang='#lcase(formation_code)#'></span>
			</td>
			<td>
				<table class="table table-condensed table-bordered bg-white" style="margin:0px">
					<cfoutput group="order_item_invoice_id">
					<tr bgcolor=###colorgo#><!---#order_id#--->
						<!----<td width="10%">#item_inv_unit_price#</td>
						<td width="10%">#item_inv_fee#</td>--->
						<td width="15%">#order_item_mode_name#</td>
						<td width="15%"><strong>#item_inv_total#&euro;</strong></td>
						<!---<td width="20%"><small><cfif opca_id eq "0">DIRECT<cfelse>#opca_name#</cfif> </small></td>--->
					</tr>
					</cfoutput>
				</table>
				
				
				<!---<table class="table table-condensed table-bordered bg-white" style="margin:0px">
					<cfoutput>
					<tr bgcolor=###colorgo#>
						<td width="30%"><span class='lang-sm' lang='#lcase(formation_code)#'></span> <strong>#obj_lms.get_method_from_list(m_id="#method_id#",short="1")#</strong></td>
						<td width="10%">#order_item_qty#</td>
						<td width="10%">#order_item_unit_price#</td>
						<td width="15%"><strong>#order_item_amount#&euro;</strong></td>
						<td width="15%">#order_item_mode_name#</td>
						<!---<td width="20%"><small><cfif opca_id eq "0">DIRECT<cfelse>#opca_name#</cfif> </small></td>--->
					</tr>
					</cfoutput>
				</table>	--->		


			<td>#dateformat(order_start,'dd/mm/yyyy')#</td>
			<td><cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif></td>
			<!--- TODO update --->
			<td align="center">
				<div class="btn-group">
				<a type="button" id="o_#order_id#" class="btn_read_order btn btn-sm btn-info"><i class="fa-light fa-eye"></i></a>
				<a type="button" id="up_order_#account_id#_#order_id#" class="btn_edit_order btn btn-sm btn-info"><i class="fa-light fa-edit"></i></a>
			
				<cfif (isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1") >
					<cfif isDefined("status_finance_id") AND listFindNoCase("1,2,8", status_finance_id)>
						<a type="button" class="delete_order btn btn-sm btn-info" id="delete_order_#order_id#"><i class="fa-light fa-trash-alt"></i></a>
					</cfif>
				</cfif>
				<!--- <cfif SESSION.USER_ID eq 202>
						<a type="button" class="delete_order btn btn-sm btn-info" id="delete_order_#order_id#"><i class="fa-light fa-trash-alt"></i></a>
				</cfif>--->
				
				</div>
			</td>

			<!--- <td>
			<button type="button" class="btn <cfif get_log.nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="u_#_user_id#">
			<i class="fas fa-sticky-note"></i> #get_log.nb_log#
			</button>
			</td> --->
		</tr>		
		</cfif>

		</cfoutput>
	</tbody>

</table>
</div>		



