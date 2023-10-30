<!DOCTYPE html>

<cfsilent>

	<!--- <cfset SESSION.USER_ID = 2847> --->

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<!--------------- DEFAULT DATE & VIEW  ------------->
<cfparam name="ysel" default="#year(now())#">
<cfset y = mid(ysel,3,2)>

<cfparam name="prov_id" default="0">

<cfset prov_pos = listContainsNoCase(SESSION.SELECTED_PROVIDER, prov_id)>

<cfif prov_id neq 0 AND prov_pos eq 0>
	<cfset SESSION.SELECTED_PROVIDER = listAppend(SESSION.SELECTED_PROVIDER, prov_id)>
<cfelseif prov_id neq 0 AND prov_pos neq 0>
	<cfset SESSION.SELECTED_PROVIDER = listDeleteAt(SESSION.SELECTED_PROVIDER, prov_pos)>
</cfif>

<cfif SESSION.SELECTED_PROVIDER eq "">
	<cfset SESSION.SELECTED_PROVIDER = "1">
</cfif>
<!--------------- DEFAULT DATE & VIEW  ------------->

<!------------------ GET ACCOUNT TYPE --------------->
<cfquery name="get_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type WHERE type_id <> 4 ORDER BY field(type_id,1,2,8,3,9,5,7,10,6)
</cfquery>

<cfparam name="o_by" default="account_name">
<cfparam name="t_id" default="1">
<cfparam name="pv_id" default="all">
<cfparam name="manager_id" default="all">


<!--- <cfparam name="view" default="reg"> --->





<cfquery name="get_count_account_type_all" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a WHERE type_id <> 4
</cfquery>


<!------------------ GLOBAL --------------->
<cfquery name="get_ca_account_global" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(oi.item_inv_total) as ca
FROM orders o
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN account a ON o.account_id = a.account_id
INNER JOIN account_group ag ON ag.group_id = a.group_id
INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#">
AND o.order_status_id IN (3,4,5,10,11)
AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
</cfquery>

<cfquery name="get_pipe_account_global" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(oi.item_inv_total) as ca
FROM orders o
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN account a ON o.account_id = a.account_id
INNER JOIN account_group ag ON ag.group_id = a.group_id
INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

WHERE o.order_status_id IN (1,2)

<!------ EXCLUDE B2C WEB ------>
AND a.account_id <> 346

AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
</cfquery>









<!------------------ MONTH --------------->
<cfquery name="get_ca_account_month" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(oi.item_inv_total) as ca
FROM orders o
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN account a ON o.account_id = a.account_id
INNER JOIN account_group ag ON ag.group_id = a.group_id
INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

WHERE DATE_FORMAT(order_date,'%Y_%m') = '#ysel#_#listgetat(SESSION.LISTMONTHS_CODE,month(now()))#'
AND o.order_status_id IN (3,4,5,10,11)
AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
</cfquery>



<!--- GET DATA BY ACCOUNT TYPE --->

<cfquery name="get_count_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.nb FROM account_type a
LEFT JOIN (

	SELECT COUNT(account_id) as nb, a.type_id
	FROM account a
	WHERE a.type_id <> 4
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)
</cfquery>

<cfquery name="get_ca_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, a.type_color, b.ca FROM account_type a
LEFT JOIN (

	SELECT SUM(oi.item_inv_total) as ca, a.type_id
	FROM orders o
	INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
	INNER JOIN account a ON o.account_id = a.account_id
	INNER JOIN account_group ag ON ag.group_id = a.group_id
	INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

	WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#">

	<!---WHERE SUBSTRING(order_ref,1,2) = '#y#'--->

	AND o.order_status_id IN (3,4,5,10,11)
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)

</cfquery>

<cfquery name="get_pipe_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.ca FROM account_type a
LEFT JOIN (

	SELECT SUM(oi.item_inv_total) as ca, a.type_id
	FROM orders o
	INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
	INNER JOIN account a ON o.account_id = a.account_id
	INNER JOIN account_group ag ON ag.group_id = a.group_id
	INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

	<!--- WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#"> --->

	<!-----WHERE SUBSTRING(order_ref,1,2) = '#y#' ---->

	WHERE o.order_status_id IN (1,2)
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
	
	<!------ EXCLUDE B2C WEB ------>
	AND a.account_id <> 346

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)
</cfquery>

<cfquery name="get_count_account_type_solo" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.nb FROM account_type a
LEFT JOIN (

	SELECT COUNT(account_id) as nb, a.type_id
	FROM account a
	WHERE a.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)
</cfquery>


<cfquery name="get_pipe_account_type_solo" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.ca FROM account_type a
LEFT JOIN (

	SELECT SUM(oi.item_inv_total) as ca, a.type_id
	FROM orders o
	INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
	INNER JOIN account a ON o.account_id = a.account_id
	INNER JOIN account_group ag ON ag.group_id = a.group_id
	INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

	<!---WHERE SUBSTRING(order_ref,1,2) = '#y#'--->

	WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#">

	AND o.order_status_id IN (1,2)
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
	AND a.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

	<!------ EXCLUDE B2C WEB ------>
	AND a.account_id <> 346

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)

</cfquery>

<cfquery name="get_ca_account_type_solo" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.ca FROM account_type a
LEFT JOIN (

	SELECT SUM(oi.item_inv_total) as ca, a.type_id
	FROM orders o
	INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
	INNER JOIN account a ON o.account_id = a.account_id
	INNER JOIN account_group ag ON ag.group_id = a.group_id
	INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

	WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#">

	<!---WHERE SUBSTRING(order_ref,1,2) = '#y#'---->

	AND o.order_status_id IN (3,4,5,10,11)
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
	AND a.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)
</cfquery>

<cfquery name="get_ca_account_type_owner" datasource="#SESSION.BDDSOURCE#">
SELECT a.type_name, b.ca FROM account_type a
LEFT JOIN (

	SELECT SUM(oi.item_inv_total) as ca, a.type_id
	FROM orders o
	INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
	INNER JOIN account a ON o.account_id = a.account_id
	INNER JOIN account_group ag ON ag.group_id = a.group_id
	INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

	WHERE DATE_FORMAT(order_date,'%Y') = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ysel#">

	AND o.order_status_id IN (3,4,5,10,11)
	AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.SELECTED_PROVIDER#" list="true">)
	AND a.owner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

	GROUP BY a.type_id

) b ON b.type_id = a.type_id

WHERE a.type_id <> 4 
ORDER BY field(a.type_id,1,2,8,3,9,5,7,10,6)

</cfquery>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "GROUP LIST WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">

			<cfset urlgo = "sales_index.cfm">
			<cfinclude template="./incl/incl_nav_sales.cfm">
						
			<!--- <cfhttp method="get" url="https://api.aircall.io/v1/calls" result="call_calls" username="421a9f577fcd753f5808d73f9f1e1d38" password="d166ff241d1119931a0edcf91f977f5f">
			</cfhttp> 
		
		
			<cfset struct_calls = DeserializeJSON(call_calls["Filecontent"])>
			<cfset array_calls = struct_calls['calls'][1]["contact"]["phone_numbers"]>
		
		--->


			<div class="row">

				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">

							<h6>Répartition</h6>

							<div class="d-flex justify-content-center">
								<div class="w-75">
								<canvas id="chart_activity"></canvas>
								</div>
							</div>
						</div>

					</div>

				</div>

				<script>
					const chart_activity = document.getElementById('chart_activity');
					
					new Chart(chart_activity, {
						type: 'doughnut',
						data: {
							labels: [<cfoutput query="get_ca_account_type">'#type_name#',</cfoutput>],
							datasets: [{
								label: 'CA',
								data: [<cfoutput query="get_ca_account_type"><cfif get_ca_account_type.ca neq "0" AND get_ca_account_type.ca neq "">'#round((get_ca_account_type.ca/get_ca_account_global.ca)*100)#'<cfelse>0</cfif>,</cfoutput>],
								borderWidth: 1,
								backgroundColor: [
								<cfoutput query="get_ca_account_type">
								'###type_color#',
								</cfoutput>

								// 'rgba(107, 208, 152, 0.2)',
								// 'rgba(251, 198, 88, 0.2)',
								// 'rgba(239, 129, 87, 0.2)',
								// 'rgba(178, 87, 125, 0.2)'
								 ]
								// borderColor: [
								// 'rgba(107, 208, 152, 1)',
								// 'rgba(251, 198, 88, 1)',				
								// 'rgba(239, 129, 87, 1)',				
								// 'rgba(178, 87, 125, 1)'

								// ]
								
							}]
							
							// ,
							// backgroundColor: [
							// 	'rgba(107, 208, 152, 0.2)',
							// 	'rgba(251, 198, 88, 0.2)',
							// 	
							// ],
							// borderColor: [
							// 	'rgba(107, 208, 152, 1)',
							// 	'rgba(251, 198, 88, 1)',				
							// 	'rgba(239, 129, 87, 1)'
							// ]
						}
						,
						options: {
							plugins: {
								legend: {
									display: false
								}
							}
						}
					});
				</script>


	<!--- <script>
		var chart_activity_ = document.getElementById('chart_activity');
		var chart_activity = new Chart(chart_activity, {
			
			type: 'doughnut',	
			data: {
				labels: ['FARMING : xxx', 'HUNTING : xxx', 'SHOP : xxx'],
				datasets: [{
					
					data: ['30','20','50'],
					backgroundColor: [
						'rgba(107, 208, 152, 0.2)',
						'rgba(251, 198, 88, 0.2)',
						'rgba(239, 129, 87, 0.2)'
					],
					borderColor: [
						'rgba(107, 208, 152, 1)',
						'rgba(251, 198, 88, 1)',				
						'rgba(239, 129, 87, 1)'
					],
					borderWidth: 1
				}]
			},
			options: {
				responsive:'false'
			}
		});
	</script> --->


				<div class="col-md-6">

					<div class="card border mb-3">

						<div class="card-body">
							<table class="table table-sm">
								<tr class="text-nowrap bg-light">
									<td colspan="2">
										<strong>YEAR</strong>
									</td>
								</tr>
								<tr>
									<td class="text-nowrap">GLOBAL PIPE</td>
									<td><cfoutput>#obj_number.get_space_number(get_pipe_account_global.ca)#</cfoutput> &euro;</td>
								</tr>
								<tr>
									<td class="text-nowrap">OBJECTIF CA</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-nowrap">GLOBAL CA</td>
									<td><cfoutput>#obj_number.get_space_number(get_ca_account_global.ca)#</cfoutput> &euro;</td>
								</tr>
								<tr class="text-nowrap bg-light">
									<td colspan="2">
										<strong>MONTH</strong>
									</td>
								</tr>
								<tr>
									<td class="text-nowrap">OBJECTIF CA</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-nowrap">GLOBAL CA</td>
									<td><cfoutput>#obj_number.get_space_number(get_ca_account_month.ca)#</cfoutput> &euro;</td>
								</tr>
							</table>

						</div>

					</div>

				</div>

				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">
							

							<table class="table table-sm">
								<tr class="text-nowrap bg-light">
									<td>
										<strong>CALLS</strong>
									</td>
									<td>
										OBJ
									</td>
									<td>
										REAL
									</td>
								</tr>

								<tr>
									<td class="text-nowrap">JOUR</td>
									<td></td>
									<td><!---<cfoutput>#arraylen(array_calls)#</cfoutput>---></td>
								</tr>

								<tr>
									<td class="text-nowrap">MOIS</td>
									<td></td>
									<td><!---<cfoutput>#arraylen(array_calls)#</cfoutput>---></td>
								</tr>

								<tr class="text-nowrap bg-light">
									<td>
										<strong>WEBMEETING</strong>
									</td>
									<td>
										OBJ 
									</td>
									<td>
										REAL
									</td>
								</tr>
								<tr>
									<td class="text-nowrap">JOUR</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-nowrap">MOIS</td>
									<td></td>
								</tr>

							</table>
						</div>

					</div>

				</div>


			</div>

			<div class="card border mb-3">

				<div class="card-body">
			
					<h6>Canal</h6>

					<div class="d-flex justify-content-around">
						

						<table class="table table-sm">
							<tr>
								<td></td>
								<cfoutput query="get_account_type">
									<td width="180">
										<h5 class="my-0">
										<label><span class="badge badge-pill text-white bg-#type_css#">#type_name#
										</h5>
									</td>
								</cfoutput>
								<td width="180">
									<h5 class="my-0">
									<label><span class="badge badge-pill text-white bg-success">TOTAL
									</h5>
								</td>
							</tr>
							<tr bgcolor="#FAFAFA">
								<td class="text-nowrap">GLOBAL COMPTES</td>
								<cfset total = 0>
								<cfoutput query="get_count_account_type">
									<cfif nb neq ""><cfset total = total + nb></cfif>
									<td>
										<cfif nb neq "">
											#nb#
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#total#</cfoutput>
								</td>
							</tr>
							<tr bgcolor="#FAFAFA">
								<cfset total = 0>
								<td class="text-nowrap">GLOBAL PIPE</td>
								<cfoutput query="get_pipe_account_type">
									<cfif ca neq ""><cfset total = total + ca></cfif>
									<td>
										<cfif ca neq "">
											#obj_number.get_space_number(ca)# &euro;
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#obj_number.get_space_number(total)# &euro;</cfoutput>
								</td>
							</tr>
							<tr bgcolor="#FAFAFA">
								<cfset total = 0>
								<td class="text-nowrap">GLOBAL CA</td>
								<cfoutput query="get_ca_account_type">
									<cfif ca neq ""><cfset total = total + ca></cfif>
									<td>
										<cfif ca neq "">
											#obj_number.get_space_number(ca)# &euro;
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#obj_number.get_space_number(total)# &euro;</cfoutput>
								</td>
							</tr>
							<tr>
								<td class="text-nowrap"><cfoutput>#ucase(SESSION.USER_ALIAS)#</cfoutput> - COMPTES</td>
								<cfset total = 0>
								<cfoutput query="get_count_account_type_solo">
									<cfif nb neq ""><cfset total = total + nb></cfif>
									<td>
										<cfif nb neq "">
											#obj_number.get_space_number(nb)#
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#total#</cfoutput>
								</td>
							</tr>
							<tr>
								<td class="text-nowrap"><cfoutput>#ucase(SESSION.USER_ALIAS)#</cfoutput> - PIPE MANAGER</td>
								<cfset total = 0>
								<cfoutput query="get_pipe_account_type_solo">
									<cfif ca neq ""><cfset total = total + ca></cfif>
									<td>
										<cfif ca neq "">
											#obj_number.get_space_number(ca)# &euro;
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#obj_number.get_space_number(total)# &euro;</cfoutput>
								</td>
							</tr>
							<tr>
								<td class="text-nowrap"><cfoutput>#ucase(SESSION.USER_ALIAS)#</cfoutput> - CA MANAGER</td>
								<cfset total = 0>
								<cfoutput query="get_ca_account_type_solo">
									<cfif ca neq ""><cfset total = total + ca></cfif>
									<td>
										<cfif ca neq "">
											#obj_number.get_space_number(ca)# &euro;
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#obj_number.get_space_number(total)# &euro;</cfoutput>
								</td>
							</tr>
							<tr>
								<td class="text-nowrap"><cfoutput>#ucase(SESSION.USER_ALIAS)#</cfoutput> - CA OWNER</td>
								<cfset total = 0>
								<cfoutput query="get_ca_account_type_owner">
									<cfif ca neq ""><cfset total = total + ca></cfif>
									<td>
										<cfif ca neq "">
											#obj_number.get_space_number(ca)# &euro;
										<cfelse>
											-
										</cfif>
									</td>
								</cfoutput>
								<td>
									<cfoutput>#obj_number.get_space_number(total)# &euro;</cfoutput>
								</td>
							</tr>

						</table>
						
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

})


</script>

</body>
</html>