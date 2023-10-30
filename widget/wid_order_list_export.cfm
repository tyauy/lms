<cfparam name="view_order" default="full">

<div class="table-responsive">
<table class="table table-sm">
	<tbody>
		<tr class="bg-light">
			<th>ID</th>
			<th>STATUS</th>
			<th>CONTEXTE</th>
			<cfif view_order eq "full"><th>CLOSED</th></cfif>
			<th>APPRENANT</th>
			<th>ACCOUNT</th>
			<th>LANG</th>
			<th>PACK</th>
			<th>START</th>
			<th>END</th>
		</tr>
		<cfset counter = 0>
		<cfoutput query="get_orders" group="order_id">

		<cfset counter++>
		<cfif counter/2 eq round(counter/2)>
			<cfset colorgo = "FAFAFA">
		<cfelse>
			<cfset colorgo = "FFF">
		</cfif>
		<tr bgcolor=###colorgo#>
			<td>#order_ref#</td>
			<!---<td><a class="btn btn-xs #status_cs_css#">#status_cs_name#</a></td>--->
			<td>#context_alias#</td>
			<td>#status_finance_name#</td>
			<cfif view_order eq "full"><td>#dateformat(order_date,'dd/mm/yyyy')#</td></cfif>
			<td><a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_firstname# #user_name#</strong></a></td>
			<td><a href="crm_account_edit.cfm?a_id=#account_id#"><small><strong><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></strong></small></a></td>

			<td>
				#lcase(formation_code)#
			</td>
			<td>
				<table class="table table-condensed table-bordered bg-white" style="margin:0px">
					<cfoutput group="order_item_invoice_id">
					<tr bgcolor=###colorgo#><!---#order_id#--->
						<!----<td width="10%">#item_inv_unit_price#</td>
						<td width="10%">#item_inv_fee#</td>--->
						<td width="15%">#order_item_mode_name#</td>
						<td width="15%">#item_inv_total#&euro;</td>
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
			</td>
			
			<td>#dateformat(order_start,'dd/mm/yyyy')#</td>
			<td><cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif></td>
			
		</tr>		
		</cfoutput>
	</tbody>

</table>
</div>		




