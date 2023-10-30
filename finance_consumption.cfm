<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="s_id" default="3">

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>

<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Order">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row" style="margin-top:10px">
			
				<div class="col-md-6">
				<cfloop from="2018" to="#year(now())#" index="y">
				<cfoutput>
				<a class="btn btn-lg btn-info <cfif ysel eq y>active</cfif>" href="finance_consumption.cfm?ysel=#y#">#y#</a>
				</cfoutput>
				</cfloop> 
				</div>
			</div>
			
			
			
			<div class="row">
			
				<div class="col-md-12">


				<cfset get_orders = obj_query.oget_orders(y_id="#mid(ysel,3,2)#")>
					
		
<cfparam name="view_order" default="full">

<div class="table-responsive">
<table class="table table-sm">
	<tbody>
		<tr class="bg-light">
			<th>ID</th>
			<!---<th>Status CS</th>--->
			<th>STATUS</th>
			<th>CONTEXTE</th>
			<cfif view_order eq "full"><th>MANAGER</th></cfif>
			<cfif view_order eq "full"><th>CLOSED</th></cfif>
			<th>APPRENANT</th>
			<th>ACCOUNT</th>
			<th>LANG</th>
			<th>PACK</th>
			<th>START</th>
			<th>END</th>
			<th>COMMENTS</th>
		</tr>
		<cfset counter = 0>
		<cfoutput query="get_orders" group="order_id">
		<cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(log_id) as nb_log
		FROM logs WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
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
			<cfif view_order eq "full"><td><span class="badge badge-pill text-white" style="background-color:###manager_color#">#manager_firstname#</span></td></cfif>
			<cfif view_order eq "full"><td>#dateformat(order_date,'dd/mm/yyyy')#</td></cfif>
			<td><a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_firstname# #user_name#</strong></a></td>
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
				
					
			</td>

			<td>#dateformat(order_start,'dd/mm/yyyy')#</td>
			<td><cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif></td>
			<td>
			<button type="button" class="btn <cfif get_log.nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="u_#user_id#">
			<i class="fas fa-sticky-note"></i> #get_log.nb_log#
			</button>
			</td>
		</tr>		
		</cfoutput>
	</tbody>

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

	$('.btn_upl_conv').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion convention");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_conv", function() {});
	});
	$('.btn_upl_bdc').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion Bon de Commande / Devis");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_bdc", function() {});
	});
	$('.btn_upl_apc').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion APC");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_apc", function() {});
	});
	$('.btn_upl_avn').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion Avenant");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_avn", function() {});
	});
	$('.btn_upl_aff').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion Attestation Fin de Formation");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_aff", function() {});
	});
	$('.btn_upl_cert').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Gestion Certification");
		$('#modal_body_lg').load("modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&u_id="+u_id+"&from=order&act=upl_cert", function() {});
	});
	
	
	$('.btn_generate_aff').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("G\u00e9n\u00e9rer document pour signature");
		$('#modal_body_lg').load("modal_window_generator.cfm?d_aff=1&o_id="+idtemp, function() {});
	});
	
	$('.btn_generate_aff').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("G\u00e9n\u00e9rer document pour signature");
		$('#modal_body_lg').load("modal_window_generator.cfm?d_aff=1&o_id="+idtemp, function() {});
	});
	$('.btn_generate_af').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("G\u00e9n\u00e9rer document pour signature");
		$('#modal_body_lg').load("modal_window_generator.cfm?d_af=1&o_id="+idtemp, function() {});
	});
	$('.btn_generate_al').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("G\u00e9n\u00e9rer document pour signature");
		$('#modal_body_lg').load("modal_window_generator.cfm?d_al=1&o_id="+idtemp, function() {});
	});
</script>

</body>
</html>