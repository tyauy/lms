<cfif isdefined("rtype")>

<cfif rtype eq "income_group">

<cfset month_obj = {}>
<!------------------- CREATE TOTAL BY MONTH -------------->
<cfloop list="#SESSION.LISTMONTHS_CODE#" index="cor">
	<!--- <cfset "total_#cor#" = 0> --->
	<cfset month_obj[cor] = 0>
</cfloop>


<div class="card">
	
	<div class="card-body">

		<h6>Rapport par Group</h6>

		<table class="table table-bordered table-sm">								
			<tr>
				<td width="15%">Group</td>
				<td>Pipe Total</td>
				<cfloop from="1" to="12" index="cor">
				<!--- <cfset "total_#cor#" = 0> --->
				<cfoutput>
				<td width="6%">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</td>										
				</cfoutput>
				</cfloop>
				<!--- <td>Pipe</td>
				<td>obj</td> --->
				<td>Total</td>
			</tr>
				
			<cfquery name="get_ca_group" datasource="#SESSION.BDDSOURCE#">
			SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.item_inv_total) as ca, ag.group_id, ag.group_name, a.account_id, a.account_name, o.order_status_id
			
			FROM orders o
			INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
			INNER JOIN account a ON o.account_id = a.account_id
			INNER JOIN account_group ag ON ag.group_id = a.group_id
			
			WHERE DATE_FORMAT(order_date,'%Y') = '#ysel#'

			<cfif ca_id eq "2">
				AND o.order_status_id IN (1,2)
			<cfelseif listfind(ca_id,1) AND listfind(ca_id,2)>
				AND o.order_status_id IN (1,2,3,4,5,10,11)
			<cfelse> 
				AND o.order_status_id IN (3,4,5,10,11)
			</cfif>
			<!---  AND o.order_status_id IN (3,4,5,10,11) --->

			AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
			<cfif SESSION.SELECTED_MANAGER neq "">
				AND a.user_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_MANAGER#" list="true">)
			</cfif>
			<cfif SESSION.SELECTED_TYPE neq "">
				AND a.type_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_TYPE#" list="true">)
			</cfif>

			GROUP BY account_id, monthgo, order_status_id
			ORDER BY group_name, account_name, monthgo
			</cfquery>

			<cfquery name="get_pipe_group" datasource="#SESSION.BDDSOURCE#">
				SELECT SUM(oi.item_inv_total) as pipe, ag.group_id, ag.group_name, a.account_id, a.account_name
				FROM orders o
				INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
				INNER JOIN account a ON o.account_id = a.account_id
				INNER JOIN account_group ag ON ag.group_id = a.group_id
				
				WHERE o.order_status_id IN (1,2)
				
				AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
				<cfif SESSION.SELECTED_MANAGER neq "">
					AND a.user_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_MANAGER#" list="true">)
				</cfif>
				<cfif SESSION.SELECTED_TYPE neq "">
					AND a.type_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_TYPE#" list="true">)
				</cfif>

				<!------ EXCLUDE B2C WEB ------>
				AND a.account_id <> 346

				GROUP BY account_id
				ORDER BY group_name, account_name
			</cfquery>

			<cfset total_total = 0>
			<cfset pipe_obj = {}>
			<cfset account_pipe_obj = {}>
			<cfset total_pipe = 0>

			<!--- <cfdump var="#get_pipe_group#"> --->


			<cfoutput query="get_pipe_group">

				<cfif !StructKeyExists(pipe_obj,group_id)>
					<cfset pipe_obj[group_id] = 0>
				</cfif>
				<cfif !StructKeyExists(account_pipe_obj,account_id)>
					<cfset account_pipe_obj[account_id] = 0>
				</cfif>

				<cfset pipe_obj[group_id] = pipe_obj[group_id] + pipe>

				<cfset account_pipe_obj[account_id] = pipe>

				<cfset total_pipe = total_pipe + pipe>

			</cfoutput>

			<!--- <cfdump var="#account_pipe_obj#"> --->


			<cfoutput query="get_ca_group" group="group_id">


				<cfset account_obj = {}>
				<cfset group_obj = {}>
				<cfset count = 0>
				<cfset total_group = 0>


				<cfoutput>

					<cfif order_status_id neq 1 AND order_status_id neq 2>

					<cfset total_group = total_group+ca>
					<cfset total_total = total_total+ca>

					<cfif !StructKeyExists(account_obj,account_id)>
						<cfset count++>

						<cfset account_obj[account_id] = {
							'account_name' = account_name,
							'account_id' = account_id,
							'ca' = {}
						}>
					</cfif>
					<cfif !StructKeyExists(account_obj[account_id].ca,monthgo)>
						<cfset account_obj[account_id].ca[monthgo] = 0>
					</cfif>
					<cfset account_obj[account_id].ca[monthgo] = account_obj[account_id].ca[monthgo] + ca>

					<cfif !StructKeyExists(group_obj,monthgo)>
						<cfset group_obj[monthgo] = 0>
					</cfif>
					<cfset group_obj[monthgo] = group_obj[monthgo] + ca>
					<cfset month_obj[monthgo] = month_obj[monthgo] + ca>

					</cfif>

				</cfoutput>

				<!--- <cfdump var="#account_obj#"> --->


				<tr>
					<td><cfif count gt 1>[+]</cfif> <strong><a href="crm_account_edit.cfm?a_id=#account_id#" <cfif count gt 1>role="button" data-toggle="collapse" data-target=".g_#group_id#"</cfif>>#group_name#</a></strong></td>
					
					<td align="right" style="white-space: nowrap; color:##CCCCCC">
						<cfif StructKeyExists(pipe_obj,group_id)>
							<strong>#obj_number.get_space_number(pipe_obj[group_id])#&nbsp;&euro;</strong>
						</cfif>
					</td>

					<cfloop from="1" to="12" index="cor">
					<cfif cor LT 10><cfset cor = '0' & cor></cfif>
					<td align="right" style="white-space: nowrap;">
						<cfif StructKeyExists(group_obj,cor)>
							<strong>#obj_number.get_space_number(group_obj[cor])#&nbsp;&euro;</strong>
						</cfif>
					</td>		
					</cfloop>
					<!--- <td></td>
					<td></td> --->
					<td align="right"><strong class="text-danger">#obj_number.get_space_number(total_group)#&nbsp;&euro;</strong></td>		
					
				</tr>

				<cfif count gt 1>
					<cfloop collection="#account_obj#" item="ac_ca">
						<!--- <cfdump var="#account_obj[ac_ca].ca#"> --->
						<tr class="collapse g_#group_id#">
							<td><a href="crm_account_edit.cfm?a_id=#account_obj[ac_ca].account_id#">#account_obj[ac_ca].account_name#</a></td>
							<td align="right" style="white-space: nowrap; color:##CCCCCC">
								<cfif StructKeyExists(account_pipe_obj,account_obj[ac_ca].account_id)>
									<strong>#obj_number.get_space_number(account_pipe_obj[account_obj[ac_ca].account_id])#&nbsp;&euro;</strong>
								</cfif>
							</td>
							<cfloop from="1" to="12" index="cor">
							<cfif cor LT 10><cfset cor = '0' & cor></cfif>
							<!--- <cfdump var="#cor#"> --->
							<td align="right" style="white-space: nowrap;">
								<cfif StructKeyExists(account_obj[ac_ca].ca,cor)>
									#obj_number.get_space_number(account_obj[ac_ca].ca[cor])#&nbsp;&euro;
								<cfelse>
									-
								</cfif>
							</td>		
							</cfloop>
							<!--- <td></td>
							<td></td> --->
							<td></td>
						</tr>

					</cfloop>
				</cfif>
				
			</cfoutput>


			<!--- <cfdump var="#month_obj#"> --->
			<tr>
				<td><strong>TOTAL</strong></td>
				<td align="right" style="white-space: nowrap; color:#CCCCCC"><strong><cfoutput>#obj_number.get_space_number(total_pipe)#&nbsp;&euro;</cfoutput></strong></td>
				<cfset total_total = 0>
				<cfloop list="#SESSION.LISTMONTHS_CODE#" index="cor">
					<cfset total_total = total_total + month_obj[cor]>
					<td align="right" style="white-space: nowrap;"><strong><cfoutput>#obj_number.get_space_number(month_obj[cor])#&nbsp;&euro;</cfoutput></strong></td>
				</cfloop>
				<td align="right" style="white-space: nowrap;"><strong><cfoutput>#obj_number.get_space_number(total_total)#&nbsp;&euro;</cfoutput></strong></td>
				<!--- <td></td>
				<td></td> --->
			</tr>


		</table>

	</div>
</div>
</cfif> 
<!--- <cfelseif rtype eq "income_group">

<!------------------- CREATE TOTAL BY MONTH -------------->
<cfloop list="#SESSION.LISTMONTHS_CODE#" index="cor">
	<cfset "total_#cor#" = 0>
</cfloop>




<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Rapport par Group</h6>
	</div>
	<div class="card-body">
		
		<table class="table table-bordered table-sm">								
			<tr>
				<td></td>
				<td></td>
				<cfloop from="1" to="12" index="cor">
					
				<cfset "total_#cor#" = 0>
				<cfoutput>
				<td width="6%">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</td>										
				</cfoutput>
				</cfloop>
				<td>Pipe</td>
				<td>Account_obj</td>
				<td>Total</td>
			</tr>
				
			<cfquery name="get_ca_group" datasource="#SESSION.BDDSOURCE#">
			SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.item_inv_total) as ca, ag.group_id, ag.group_name, a.account_id
			FROM orders o
			INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
			INNER JOIN account a ON o.account_id = a.account_id
			INNER JOIN account_group ag ON ag.group_id = a.group_id
			
			WHERE DATE_FORMAT(order_date,'%Y') = '#ysel#'

			AND o.order_status_id IN (3,4,5,10,11)
			GROUP BY group_id, monthgo
			ORDER BY group_name, monthgo
			</cfquery>							


			<cfset total_total = 0>
			
			<cfoutput query="get_ca_group" group="group_id">

			<cfset total_group = 0>
			<cfset total_group = total_group+ca>
			<cfset total_total = total_total+ca>
			<cfset "total_#monthgo#" = evaluate("total_#monthgo#") + ca>

			<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
			SELECT a.account_id, a.account_name
			FROM account a
			WHERE a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
			</cfquery>	

			<tr>
				<td><cfif get_account.recordcount gt 1>[+]</cfif></td>
				<td><strong><a href="crm_account_edit.cfm?a_id=#account_id#" <cfif get_account.recordcount gt 1>role="button" data-toggle="collapse" data-target=".g_#group_id#"</cfif>>#group_name#</a></strong></td>
				
				<cfloop from="1" to="12" index="cor">
				<td align="right"><cfoutput><cfif monthgo eq cor><strong>#obj_number.get_space_number(ca)# &euro;</strong></cfif></cfoutput></td>		
				</cfloop>
				<td></td>
				<td></td>
				<td align="right"><strong class="text-danger"><cfoutput>#obj_number.get_space_number(total_group)# &euro;</cfoutput></strong></td>		
				
			</tr>

			<cfif get_account.recordcount gt 1>
			
			<cfloop query="get_account">
			
			
			<cfquery name="get_ca_account" datasource="#SESSION.BDDSOURCE#">
			SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.item_inv_total) as ca, a.account_id, a.account_name
			FROM orders o
			INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
			INNER JOIN account a ON o.account_id = a.account_id
			INNER JOIN account_group ag ON ag.group_id = a.group_id
			WHERE DATE_FORMAT(order_date,'%Y') = "#ysel#" 
			AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_account.account_id#">
			GROUP BY account_id, monthgo
			ORDER BY account_name, monthgo
			</cfquery>
			
			<tr class="collapse g_#get_ca_group.group_id#">
				<td></td>
				<td><a href="crm_account_edit.cfm?a_id=#get_ca_account.account_id#">#get_account.account_name#</a></td>
				<cfloop from="1" to="12" index="cor">
				<td align="right"><cfif get_ca_account.monthgo eq cor>#obj_number.get_space_number(get_ca_account.ca)# &euro;<cfelse>-</cfif></td>		
				</cfloop>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			</cfloop>
			
			</cfif>
			</cfoutput>



			<tr>
				<td></td>
				<td><strong>TOTAL</strong></td>
				<cfloop list="#SESSION.LISTMONTHS_CODE#" index="cor">
				<td align="right"><strong><cfoutput>#obj_number.get_space_number(evaluate("total_#cor#"))# &euro;</cfoutput></strong></td>		
				</cfloop>
				<td></td>
				<td></td>
				<td></td>
			</tr>


		</table>

	</div>
</div> --->













<!--- <cfelseif rtype eq "income_account">

<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Rapport par Account</h6>
	</div>
	<div class="card-body">
			
							
							
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT a.account_id, a.account_name FROM account a WHERE type_id <> 4 ORDER BY a.account_name
</cfquery>

<table class="table table-sm">								
	<tr>
		<td></td>
		<cfloop from="1" to="12" index="cor">
		<cfoutput>
		<td width="6%">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</td>										
		</cfoutput>
		</cfloop>
		<td>Total</td>
	</tr>
	
	<cfset table_order = arraynew(1)>
	<cfoutput query="get_account">
	
	<cfquery name="get_ca" datasource="#SESSION.BDDSOURCE#">
	SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.order_item_amount) as ca
	FROM orders o
	INNER JOIN order_item oi ON oi.order_id = o.order_id
	WHERE o.account_id = #account_id# AND DATE_FORMAT(order_date,'%Y') = "#ysel#"
	GROUP BY monthgo
	</cfquery>								

	<tr>
		<td><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#</a></td>
		<cfloop from="1" to="12" index="cor">
		<td><cfif get_ca.monthgo eq cor>#get_ca.ca#<cfelse>-</cfif></td>		
		</cfloop>
		<td></td>
	</tr>
	</cfoutput>
</table>

	</div>
</div>
		
</cfif>













<cfif rtype eq "income_supplier">
<h3>CA par produit</h3>
<hr>

<cfquery name="get_product" datasource="#SESSION.BDDSOURCE#">
SELECT p.product_id, p.product_name, a.account_name, a.account_id FROM product p 
INNER JOIN account a ON a.account_id = p.account_id
ORDER BY a.account_id
</cfquery>


<table class="table table-condensed table-striped table-bordered">								
	<tr>
		<td></td>
		<cfloop from="1" to="12" index="cor">
		<cfoutput>
		<td width="6%">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</td>										
		</cfoutput>
		</cfloop>
		<td>Total</td>
	</tr>
	
	<cfset table_order = arraynew(1)>
	<cfoutput query="get_product" group="account_id">
	<tr>
		<td colspan="14"><strong>#account_name#</strong></td>
	</tr>
	<cfoutput>
	<cfquery name="get_ca" datasource="#SESSION.BDDSOURCE#">
	SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(item_price_total) as test
	FROM orders_item oi 
	INNER JOIN orders o ON o.order_id = oi.order_id
	WHERE oi.product_id = #product_id#
	GROUP BY monthgo
	</cfquery>
	<tr>
		<td>#product_name#</td>
		<cfloop from="1" to="12" index="cor">
		<td><cfif get_ca.monthgo eq cor>#get_ca.test#<cfelse>-</cfif></td>		
		</cfloop>
	</tr>
	</cfoutput>
	</cfoutput>
</table>
</cfif>



















<cfif rtype eq "income_catalog">
<h3>CA par produit</h3>
<hr>

<cfquery name="get_product" datasource="#SESSION.BDDSOURCE#">
SELECT p.product_id, p.product_name, c.catalog_name, c.catalog_id FROM product p 
INNER JOIN product_catalog c ON c.catalog_id = p.catalog_id
ORDER BY p.catalog_id
</cfquery>


<table class="table table-condensed table-striped table-bordered">								
	<tr>
		<td></td>
		<cfloop from="1" to="12" index="cor">
		<cfoutput>
		<td width="6%">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</td>										
		</cfoutput>
		</cfloop>
		<td>Total</td>
	</tr>
	
	<cfset table_order = arraynew(1)>
	<cfoutput query="get_product" group="catalog_id">
	<tr>
		<td colspan="14"><strong>#catalog_name#</strong></td>
	</tr>
	<cfoutput>
	<cfquery name="get_ca" datasource="#SESSION.BDDSOURCE#">
	SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(item_price_total) as test
	FROM orders_item oi 
	INNER JOIN orders o ON o.order_id = oi.order_id
	INNER JOIN product p ON p.product_id = oi.product_id
	WHERE oi.product_id = #product_id#
	GROUP BY monthgo
	</cfquery>
	<tr>
		<td>#product_name#</td>
		<cfloop from="1" to="12" index="cor">
		<td><cfif get_ca.monthgo eq cor>#get_ca.test#<cfelse>-</cfif></td>		
		</cfloop>
	</tr>
	</cfoutput>
	</cfoutput>
</table>
</cfif> --->








</cfif> 