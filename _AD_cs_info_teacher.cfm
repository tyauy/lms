<!DOCTYPE html>


<!--- <cfif isdefined('st')><cfdump var="#st#"></cfif> --->
<cfsilent>

	<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	


<cfparam name="t_id" default="87">

<cfquery name="get_teacher" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, CONCAT(u.user_firstname, " ", u.user_name, " - ", u.user_id) as fullname, u.user_alias
	FROM user u 
	INNER JOIN user_ready ur ON u.user_id = ur.user_id AND ur.formation_id = 2
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = 4
	WHERE u.user_status_id = 4 ORDER BY u.user_id  DESC
</cfquery>

<cfquery name="get_tp_total" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(*) as nb FROM lms_tpplanner 
	WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	AND active = 1
</cfquery>

<cfquery name="get_tp_skill" datasource="#SESSION.BDDSOURCE#">
	SELECT s.skill_id, COUNT(*) as nb, s.skill_name
	FROM lms_tpplanner p INNER JOIN lms_skill_list lst ON lst.tp_id = p.tp_id 
	LEFT JOIN lms_skill s ON s.skill_id = lst.skill_id 
	WHERE p.planner_id = #t_id#
	GROUP BY s.skill_id
</cfquery>

<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_name, us.user_status_name_fr as user_status_name, a.account_name, a.account_id, ss.sector_name, u.user_jobtitle
		FROM user u
		INNER JOIN lms_tpuser tpu ON u.user_id = tpu.user_id AND tpu.tpuser_active = 1
		INNER JOIN lms_tpplanner p ON tpu.tp_id = p.tp_id
		LEFT JOIN account a ON u.account_id = a.account_id
		LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
        LEFT JOIN settings_sector ss ON ss.sector_id = a.sector_id
		WHERE p.planner_id = #t_id#
	ORDER BY `a`.`account_name` ASC
</cfquery>

	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "TEACHER">


		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
									
			<div class="row">	
			
				<div class="col-md-12">
					
					<cfform>
						<div class="row">
						<cfselect id="sel_fstatus" class="sel_fstatus p-2 m-1 mb-3 form-select-sm col-2" name="sel_fstatus" query="get_teacher" display="fullname" queryposition="below" selected="#t_id#" value="user_id">
						</cfselect>
						
						</div>
					</cfform>

					
	


<div class="table-responsive">
	<table class="table table-sm">
		<tbody>
			<tr class="bg-light">
				<th>NAME</th>
				<th>COUNT</th>
	
			</tr>
			<cfset counter = 0>
			<cfoutput query="get_tp_skill">
	
	

			<cfif counter/2 eq round(counter/2)>
				<cfset colorgo = "FAFAFA">
			<cfelse>
				<cfset colorgo = "FFF">
			</cfif>
			<tr bgcolor=###colorgo#>
				<td><span>#skill_name#</span></td>
				<td><span>#nb#</span></td>
			</tr>		
			</cfoutput>
			<cfoutput query="get_tp_total">
	
	

				<cfif counter/2 eq round(counter/2)>
					<cfset colorgo = "FAFAFA">
				<cfelse>
					<cfset colorgo = "FFF">
				</cfif>
				<tr bgcolor=###colorgo#>
					<td><span>TOTAL TP</span></td>
					<td><span>#nb#</span></td>
				</tr>		
				</cfoutput>
		</tbody>
	</table>

	<table class="table table-sm">
		<tbody>
			<tr class="bg-light">
				<th>ID</th>
				<th>FIRSTNAME</th>
				<th>NAME</th>
				<th>STATUS</th>
				<th>JOB TITLE</th>
				<th>ACCOUNT ID</th>
				<th>ACCOUNT</th>
				<th>SECTOR</th>
	
			</tr>
			<cfset counter = 0>
			<cfoutput query="get_learner">
	
	

			<cfif counter/2 eq round(counter/2)>
				<cfset colorgo = "FAFAFA">
			<cfelse>
				<cfset colorgo = "FFF">
			</cfif>
			<tr bgcolor=###colorgo#>
				<td><span><a href="common_learner_account.cfm?u_id=#user_id#">#user_id#</a></span></td>
				<td><span>#user_firstname#</span></td>
				<td><span>#user_name#</span></td>
				<td><span>#user_status_name#</span></td>
				<td><span>#user_jobtitle#</span></td>
				<td><span><a href="crm_account_edit.cfm?a_id=#account_id#">#account_id#</a></span></td>
				<td><span>#account_name#</span></td>
				<td><span>#sector_name#</span></td>
			</tr>		
			</cfoutput>

		</tbody>
	</table>
<!--- <table class="table table-sm">
	<tbody>
		<tr class="bg-light">
			<th>ID</th>
			<!---<th>Status CS</th>--->
			<th>STATUS</th>
			<th>CONTEXTE</th>
			<th>APPRENANT</th>
			<th>ACCOUNT</th>
			<th>LANG</th>
			<th>PACK</th>

			<th>START</th>
			<th>END</th>

		</tr>
		<cfset counter = 0>
		<cfoutput query="get_orders" group="order_id">

		<!--- TODO a mettre dans api quand OK --->
		<cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
			SELECT u.user_id, u.user_name, u.user_firstname
			FROM orders_users ou
			LEFT JOIN user u ON u.user_id = ou.user_id
			WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
		</cfquery>
	

		<cfset counter++>
		<cfif counter/2 eq round(counter/2)>
			<cfset colorgo = "FAFAFA">
		<cfelse>
			<cfset colorgo = "FFF">
		</cfif>
		<tr bgcolor=###colorgo#>
			<td><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
			<!---<td><a class="btn btn-xs #status_cs_css#">#status_cs_name#</a></td>--->
			<td><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#context_alias#</span></td>
			<td><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_name#</span></td>
			<td>
				<cfif get_orders_users.recordCount GT 1>
					<select>
						<cfloop query="get_orders_users">
							<option value="#user_id#">
								<!--- #user_firstname# #ucase(user_name)# --->
								<a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_firstname# #ucase(user_name)#</strong></a>
							</option>
						</cfloop>
					</select>
				<cfelse>
					<a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_firstname# #ucase(user_name)#</strong></a>
				</cfif>
				
			</td>
			<td><a href="crm_account_edit.cfm?a_id=#account_id#"><small><strong><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></strong></small></a></td>

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

			<td>#dateformat(order_start,'dd/mm/yyyy')#</td>
			<td><cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif></td>


		</tr>		
		</cfoutput>
	</tbody>

</table> --->
</div>					
					
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>
$( document ).ready(function() {

	$('.sel_fstatus').change(function(event) {
	
	<!--- var liner = '<cfset st = 4>'; --->
	<!--- $("#order_tab").before(liner); --->

	<!--- $("#order_tab").remove(); --->
	var status = $(sel_fstatus).val();

	<cfoutput>
	document.location.href="cs_info_teacher.cfm?t_id="+status;
	</cfoutput>
});


})
</script>

</body>
</html>