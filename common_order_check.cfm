<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	


<cfquery name="get_tps" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name, 
		SUM(s.session_duration) as session_duration,
		o.order_id, o.order_ref
		
		FROM lms_tp t 

		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN orders o ON o.order_id = t.order_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE t.order_id IS NULL
		
		GROUP BY t.tp_id
		
		ORDER BY u.user_name ASC
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
      
		<cfset title_page = "Order">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
		
			
			
			
			<div class="row">
			
				<div class="col-md-12">

		<cfoutput><strong>#get_tps.recordcount# TP LEFT</strong> </cfoutput>
		<br><br>
	
<div class="table-responsive">
<table class="table">
	<tbody>
		<tr class="bg-light">

			<th width="15%">TP NAME</th>
			<th width="25%">ID</th>
			<th width="25%">Status</th>
			<th width="15%">Bind</th>
			<th></th>
		</tr>
	
	<cfoutput query="get_tps">
	
	<cfset get_orders = obj_query.oget_orders(u_id="#user_id#")>
	
	<tr>
		<td><a href="common_learner_account.cfm?u_id=#user_id#">#user_name# #user_firstname#</a></td>
		<td>#tp_id# #obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</td>
		<td>
		<a name="u_#user_id#"></a>
		<form action="updater_tp_order.cfm" method="post">
		<select name="order_id">
			<cfloop query="get_orders">
				<option value="#get_orders.order_id#">#get_orders.order_ref#</option>				
			</cfloop>
				<option value="1">Offert</option>
				<option value="2">Old</option>
			</select>
		<input type="submit" value="GO">
		<input type="hidden" name="tp_id" value="#tp_id#">
		<input type="hidden" name="u_id" value="#user_id#">
	</form>
		</td>
		<td>
		
		</td>
	
	</tr>
	
	</cfoutput>
	</tbody>
</table>

				
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


</body>
</html>