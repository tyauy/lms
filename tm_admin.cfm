<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8,2,5,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.USER_ACCOUNT_RIGHT_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>
<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.AL_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.AL_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.AL_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>

<cfquery name="get_tp_status" datasource="#SESSION.BDDSOURCE#">
SELECT tp_status_id, tp_status_name_#SESSION.LANG_CODE# as status_name FROM lms_tpstatus
</cfquery>

<cfquery name="get_tp_method" datasource="#SESSION.BDDSOURCE#">
SELECT method_id, method_alias_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method
</cfquery>

<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
SELECT user_status_id, user_status_name_#SESSION.LANG_CODE# as user_status_name FROM user_status
</cfquery>

<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

<cfparam name="al_id" default="#SESSION.AL_ID#">
<cfset display_all_selected = false>
<cfif al_id eq "" OR al_id eq 0>
	<cfset al_id = SESSION.USER_ACCOUNT_RIGHT_ID>
	<cfset display_all_selected = true>
<cfelse>
	<cfset SESSION.AL_ID = al_id>
</cfif>
<cfset SESSION.ACCOUNT_ID = listgetat(al_id,1)>


<!--- <cfif not isdefined('a_id') and isdefined('SESSION.ACCOUNT_ID') and #SESSION.ACCOUNT_ID# neq "">
	<cfset a_id = #SESSION.ACCOUNT_ID#>
</cfif>
<cfparam name="a_id" default="#listgetat(SESSION.USER_ACCOUNT_RIGHT_ID,1)#">
<cfset SESSION.ACCOUNT_ID = a_id> --->

<cfquery name="get_orders_lrn" datasource="#SESSION.BDDSOURCE#">
SELECT 
a.account_name, 
o.order_id, o.order_ref, o.pack_id, o.formation_id, o.account_id, o.provider_id, o.order_status_id, o.status_tm_id, o.task_id, o.contact_id, o.context_id, o.order_md, o.order_date, o.order_start, o.order_end, o.order_sign, o.order_ref2, o.order_conv, o.order_apc, o.order_bdc, o.order_avn, o.order_avn2, o.order_aff, o.order_cert, o.order_cda, o.order_bf,
oc.*,
Year(o.order_date) as start_year,
u.user_id, u.user_firstname as ufn_col, u.user_name as un_col, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
oim.order_item_mode_name, 
ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_tm_#SESSION.LANG_CODE# as status_finance_tm,
<!--- otm.status_tm_name, otm.status_tm_css,  --->
oi.*, 
a2.account_name as opca_name, 
u.user_firstname, u.user_name,
u2.user_firstname as manager_firstname, u2.user_color as manager_color,
f.formation_id, f.formation_code

FROM orders o

INNER JOIN account a ON a.account_id = o.account_id
INNER JOIN orders_users ou ON o.order_id = ou.order_id
INNER JOIN user u ON u.user_id = ou.user_id

LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
<!--- LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id --->

LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id

LEFT JOIN order_context oc ON oc.context_id = o.context_id

INNER JOIN account a2 ON o.account_id = a2.account_id
INNER JOIN account_group ag ON ag.group_id = a2.group_id
LEFT JOIN user u2 ON u2.user_id = ag.manager_id
LEFT JOIN lms_formation f ON f.formation_id = o.formation_id


WHERE 1 = 1
<cfif listLen(al_id) GT 1>
AND o.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true">)
<cfelse>
AND o.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>

<cfif isdefined("u_id")>
AND o.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfif>

<cfif isdefined("y_id")>
AND SUBSTRING(o.order_ref, 1, 2) = <cfqueryparam cfsqltype="cf_sql_integer" value="#y_id#">
</cfif>

AND o.order_status_id <> 6

ORDER BY o.order_ref ASC
</cfquery>	

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
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
		
			
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			<div class="row justify-content-md-center">
				<div class="col-md-6">
					<cfif ListLen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						<!--- <select class="form-control" name="a_id" id="a_id" onchange="document.location.href='tm_admin.cfm?a_id='+$(this).val()">
						<cfoutput query="get_account_tm">
						<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
						</cfoutput>
						<cfoutput>
						<option value="0" <cfif a_id eq 0>selected</cfif>>#Ucase('#obj_translater.get_translate("table_th_all_accounts")#')#</option>
						</cfoutput>
						</select>		 --->
						<div class="row">
							<div class="col-lg-12">
							<button type="button" class="btn btn-sm btn-default form-control dropdown-toggle" style="text-align: left;overflow:hidden; white-space:nowrap; text-overflow:ellipsis;" data-toggle="dropdown">
								<span class="account-display" style="">
									<cfif al_id eq 0 OR display_all_selected eq true>
										<cfoutput>
											#obj_translater.get_translate('table_th_all_accounts')#
										</cfoutput>
									<cfelse>
										<cfoutput query="get_account_tm">
											<cfif ListContains(al_id,account_id) GT 0> &nbsp;#account_name#,&nbsp;
											</cfif>
										</cfoutput>
									</cfif>
								</span>
							</button>
								<ul id="tm_account_select" class="dropdown-menu form-control">
									<cfoutput>
									<li><a href="##" class="form-control" data-value="0" tabIndex="-1">
										-&nbsp;#obj_translater.get_translate('table_th_all_accounts')#
									</a></li>
									</cfoutput>

									<cfoutput query="get_account_tm">
										<li><a href="##" class="form-control" data-value="#account_id#" tabIndex="-1">
											<input type="checkbox" <cfif ListContains(al_id,account_id) GT 0> checked </cfif>/>
											&nbsp;#account_name#
										</a></li>
									</cfoutput>
								</ul>
							</div>
					   </div>				
					</cfif>
				</div>
			</div>
			
			
				
			<div class="row mt-4">
				<div class="col-md-12">
					<div class="card border-top border-info">						
						<div class="card-body">
								
							
							<div class="row">
							
								<div class="col-md-12">
									<h5><cfoutput>#obj_translater.get_translate("table_th_training_records")#</cfoutput></h5>
								</div>
								
							</div>
								
							<div class="row mt-2">
								<div class="col-md-12">											
									<form id="form-global_search" name="global_search">
										<div class="typeahead__container">
											<div class="typeahead__field">
												<div class="typeahead__query">
													<input class="js_typeahead_lrn" name="search_lrn" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
												</div>
											</div>
										</div>
									</form>
								</div>		
							</div>
							
							<div class="row mt-2">
							
								<div class="col-md-12">
									
									

<cfif ! isdefined("lrn_id")>											
<ul class="nav nav-tabs" id="year_list" role="tablist">
<cfloop from="2018" to="#year(now())#" index="y">
<cfoutput>
<!---<cfif isdefined("o_ref")>
<li class="nav-item">
<a href="##y_#y#" class="nav-link <cfif mid(o_ref,1,2) eq mid(y,3,2)>active</cfif>" role="tab" data-toggle="tab">#y# </a>
</li>
<cfelse>--->	
<li class="nav-item">	
<a href="##y_#y#" class="nav-link <cfif y eq year(now())>active</cfif>" role="tab" data-toggle="tab">#y#</a>
</li>
<!---</cfif>--->
</cfoutput>
</cfloop> 
</ul>
</cfif>




<div class="tab-content">

<cfloop from="2018" to="#year(now())#" index="y">
<cfif ! isdefined("lrn_id")>
	
	<cfset get_orders = obj_query.oget_orders(list_account="#al_id#",y_id="#mid(y,3,2)#")>
	
	<cfoutput>
	<div role="tabpanel" class="tab-pane <cfif y eq year(now())>active show</cfif>" id="y_#y#" style="margin-top:15px;">
	
		<div id="acc_#y#">
	</cfoutput>

</cfif>
<cfif isdefined("lrn_id")>
	<cfset get_orders = obj_query.oget_orders(list_account="#al_id#", u_id="#lrn_id#")>
	
</cfif>

	<cfif get_orders.recordcount eq "0">
		<div class="alert alert-secondary" align="center">
		<em><cfoutput>#obj_translater.get_translate("alert_tm_no_records")#</cfoutput></em>
		</div>
	<cfelse>

		<cfoutput query="get_orders" group="order_id">

		<!--- <cfset get_tps = obj_tp_get.oget_tps(o_id="#order_id#")> --->
		

<cfif isDefined("user_id") AND user_id neq "">

<!--- <cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
SELECT ue.*
FROM user u 
INNER JOIN user_elapsed ue ON ue.user_id = u.user_id
WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="get_mock" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz_user qu 
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
WHERE (q.quiz_type = "toeic" OR q.quiz_type like "%bright%")
AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz_user qu 
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
WHERE (q.quiz_type = "exercice" OR q.quiz_type = "unit")
AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery> --->
</cfif>
			<div class="card border bg-light">
				
					
				<button class="btn btn-link" data-toggle="collapse" data-target="##o_#order_id#" aria-expanded="true" aria-controls="u_#order_id#">
				<div class="card-header text-left" id="h_#order_id#">
					<span class="lang-lg pull-left mt-1 mr-2" lang="#lcase(formation_code)#"></span>
					<!---<span class="badge badge-pill text-white badge-info"> #user_status_name#</span>---> 
					<div class="pull-left font-weight-normal">#obj_dater.get_dateformat(order_date)#<br><h6 class="d-inline" style="font-size:14px">#user_firstname# #ucase(user_name)#</h6></div>
					<div class="pull-right"><span class="badge text-white badge-default" style="font-size:12px"><strong>#order_ref#</strong> - #context_alias#</span></div>
				</div>
				</button>
				
				
				<div id="o_#order_id#" class="collapse" aria-labelledby="h_#order_id#" data-parent="##acc_#y#">
					<div class="card-body bg-white border-top">
						<div class="row">
							<div class="col-md-12">
								<!--- <div class="card border border-info p-2 h-100"> --->
									<!--- <span class="text-info"><i class="fal fa-file-alt text-info"></i> <strong>#Ucase('#obj_translater.get_translate("table_th_administrative_file")#')#</strong></span> --->
									
									
									<div class="container m-0 mt-3">
											
										<div class="row border-top" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_period")#</small></div>
											<div class="col-9" style="padding:5px;">
												<cfif order_start neq "">#obj_dater.get_dateformat(order_start)#</cfif>
												<cfif order_end neq "">
													- 
												#obj_dater.get_dateformat(order_end)#
												</cfif>
												
											</div>
										</div>
										<div class="row border-top" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_status")#</small></div>
											<div class="col-9" style="padding:5px;">
											<span class="badge badge-pill text-white badge-#status_finance_css#">#status_finance_tm#</span>
											
											</div>
										</div>
										<div class="row bg-black border-top" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_account")#</small></div>
											<div class="col-9" style="padding:5px;"><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></div>
										</div>	
										<div class="row border-top" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_financial_proposal")#</small></div>
											<div class="col-9" style="padding:5px;">
												<table class="table table-condensed table-bordered bg-white" style="margin:0px">
														<cfset total = 0>
														<cfoutput group="order_item_mode_id">
														<tr>
															<td width="25%">#order_item_mode_name#</td>
															<td width="25%"><span class='lang-sm' lang='#lcase(formation_code)#'></span> <strong><!---#obj_lms.get_method_from_list(m_id="#method_id#",short="1")#---> <cfif item_inv_hour neq "0">#numberformat(item_inv_hour,'____')#h<cfelse>-</cfif></strong></td>
															<td width="25%"><cfif item_inv_unit_price neq "0">#item_inv_unit_price#&euro;<cfelse>-</cfif></td>
															<td width="25%">#item_inv_total#&euro;</td>
														</tr>
														<cfif item_inv_total neq "" AND item_inv_total neq "0">
														<cfset total = total+item_inv_total>
														</cfif>
														</cfoutput>
														<tr class="bg-light">
															<td colspan="3" align="right"></td>
															<td width="25%"><strong>#numberformat(total,'____.__')#&euro;</strong></td>
														</tr>
													</table>
											</div>
										</div>
											
											
											
										<cfif order_conv neq "" OR order_bdc neq "" OR order_apc neq "" OR order_avn neq "" OR order_aff neq "" OR order_cert neq "">
										<div class="row  border-top" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_attachments")#</small></div>
											<div class="col-9" style="padding:5px;">
												<cfif order_conv neq "" AND fileexists("#SESSION.BO_ROOT#/admin/conv/#order_conv#")>
												<a class="btn_view_file text-info" id="conv_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_devis")#</a><br>
												</cfif>
												
												<cfif order_bdc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bdc/#order_bdc#")>
												<a class="btn_view_file text-info" id="bdc_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_convention")#</a><br>
												</cfif>
												
												<cfif order_apc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/apc/#order_apc#")>
												<a class="btn_view_file text-info" id="apc_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_apc")#</a><br>
												</cfif>
													
												<cfif order_avn neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn/#order_avn#")>
												<a class="btn_view_file text-info" id="avn_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_avenant")#</a><br>
												</cfif>
													
												<cfif order_aff neq "" AND fileexists("#SESSION.BO_ROOT#/admin/aff/#order_aff#")>
												<a class="btn_view_file text-info" id="aff_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_aff")#</a><br>
												</cfif>
												
												<cfif order_cert neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cert/#order_cert#")>
												<a class="btn_view_file text-info" id="cert_#order_md#" target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #obj_translater.get_translate("btn_certification")#</a>
												</cfif>
											</div>
										</div>
										</cfif>
											
										<div class="row border-top facture_#order_id#" style="border-color:grey;">
											<div class="col-3 bg-light" style="padding:5px;"><small>#obj_translater.get_translate("table_th_factures")#</small></div>
											<div class="col-9" style="padding:5px;">
												<cfset get_invoice = obj_order_get.oget_invoice(o_id="#order_id#")>
												<cfset dir_go = "/home/www/wnotedev1/admin/inv">
												<cfset countidoc = 0>
														
												<cfloop query="get_invoice">
													<cfif invoice_ref neq "" AND fileexists("#dir_go#/#invoice_ref#.pdf")>
														<cfset countidoc = countidoc + 1>
														<a class="btn_view_inv text-warning" id="#get_invoice.invoice_ref#" <!---href="./admin/inv/#get_invoice.invoice_id#"---> target="_blank" style="cursor:pointer"><i class="fal fa-file-pdf"></i> #get_invoice.invoice_ref#</a><br>
													</cfif>
												</cfloop>
													
											
											</div>
										</div>

										<!--- Hide div if no invoice to display --->
										<cfif countidoc eq 0>
											<style>
												.facture_#order_id# {
													display: none;
												}
											</style>
										</cfif>
											
									</div>
											
								<!--- </div>	 --->
							</div>	
							
							
							<!--- <div class="col-md-5"> --->
								<!--- <div class="card border border-warning p-2 h-100"> --->
										
									<!--- <span class="text-warning"><i class="fal fa-tasks fa-lg text-warning"></i> <strong>#Ucase('#obj_translater.get_translate("table_th_activity")#')#</strong></span> --->
									<!--- <div class="container bg-white m-0 mt-3"> --->
											
											<!--- <div class="row border-top" style="border-color:grey;"> --->
												<!--- <div class="col-4 bg-light" style="padding:5px;"><i class="fal fa-history text-warning"></i> <small>#obj_translater.get_translate("table_th_last_connect")#</small></div> --->
											
												<!--- <div class="col-8" style="padding:5px;"> --->
												<!--- <cfif user_lastconnect neq ""> --->
													<!--- #dateformat(user_lastconnect,'dd/mm/yyyy')# --->
												<!--- <cfelse> --->
													<!--- - --->
												<!--- </cfif> --->
												<!--- </div> --->
											<!--- </div> --->
											<!--- <div class="row border-top" style="border-color:grey;"> --->
												<!--- <div class="col-4 bg-light" style="padding:5px;"><i class="fal fa-clock text-warning"></i> <small><cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput></small></div> --->
											
												<!--- <div class="col-8" style="padding:5px;"> --->
													<!--- <cfif user_elapsed neq "0"> --->
													<!--- #obj_lms.get_format_hms(toformat="#user_elapsed#")# --->
													<!--- <cfelse> --->
													<!--- - --->
													<!--- </cfif> --->
												<!--- </div> --->
											<!--- </div> --->
									<!--- </div> --->
										
										
									
									
									
								<!--- </div> --->
							<!--- </div> --->
						<!--- </div> --->
						<!--- <br> --->
						
						<!--- <cfif get_tps.recordcount neq "0"> --->
						<!--- <div class="row"> --->
							<!--- <div class="col"> --->
								<!--- <div class="card border border-success p-2 h-100"> --->
					
									<!--- <div><span class="text-success"><i class="fal fa-road fa-lg text-success"></i> <strong>#ucase(obj_translater.get_translate("table_th_program"))#</strong></span></div> --->
									
										<!--- <table class="table table-sm m-0 mt-3"> --->
								
											<!--- <tr class="bg-light">	 --->
												<!--- <td><small><strong>#obj_translater.get_translate("table_th_tp")#</strong></small></td> --->
												<!--- <td><small><strong>#obj_translater.get_translate("table_th_trainer")#</strong></small></td> --->
												<!--- <td colspan="4"><small><strong>#obj_translater.get_translate("table_th_time")#</strong></small></td> --->
												<!--- <td><small><strong>#obj_translater.get_translate("table_th_last")#</strong></small></td> --->
												<!--- <td><small><strong>#obj_translater.get_translate("table_th_next")#</strong></small></td> --->
											<!--- </tr> --->
											<!--- <cfloop query="get_tps"> --->
													
												<!--- <cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif> --->
												<!--- <cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif> --->
												<!--- <cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif> --->
												<!--- <cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif> --->
												<!--- <cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif> --->
												
												<!--- <cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif> --->
												<!--- <cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go> --->
												
												<!--- <cfset tp_done_go = tp_completed_go+tp_inprogress_go> --->
													
												<!--- <tr class="border-top"> --->
													
													<!--- <cfset tp_total = "#'#tp_completed_go#' + '#tp_missed_go#'#"> --->
													<!--- <cfif tp_duration neq 0><cfset tmp = "#'#tp_total#' * 100 / '#tp_duration#'#"><cfelse><cfset tmp=0></cfif> --->
													<!--- <td class="border-0" width="15%"> --->
													<!--- <span class="badge badge-pill badge-#tp_status_css#">#status_name#<cfif #tmp# neq 0>  (#Round('#tmp#')#%)</cfif></span><br> --->
													<!--- #obj_lms.get_tp_icon(tp_id="#tp_id#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")# --->
													<!--- </td>	 --->
																										
													<!--- <td class="border-0" width="2%"> --->
														<!--- <cfif method_scheduler eq "scheduler"> --->
														<!--- <button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="fal fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button> --->
														<!--- </cfif> --->
													<!--- </td> --->
													<!--- <td class="border-0" width="2%"> --->
														<!--- <cfif method_scheduler eq "scheduler"> --->
														<!--- <button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button> --->
														<!--- </cfif> --->
													<!--- </td> --->
													<!--- <td class="border-0" width="2%">	 --->
														<!--- <cfif method_scheduler eq "scheduler"> --->
														<!--- <button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fal fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button> --->
														<!--- </cfif> --->
													<!--- </td> --->
													<!--- <td class="border-0" width="2%">	 --->
														<!--- <cfif method_scheduler eq "scheduler"> --->
														<!--- <button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fal fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button> --->
														<!--- </cfif> --->
													<!--- </td> --->
													<!--- <td class="border-0" width="7%"> --->
														<!--- <cfif last_lesson neq ""> --->
														<!--- #dateformat(last_lesson,'dd/mm/yyyy')# --->
														<!--- <cfelse> --->
														<!--- - --->
														<!--- </cfif> --->
													<!--- </td> --->
													<!--- <td class="border-0" width="7%"> --->
														<!--- <cfif next_lesson neq ""> --->
														<!--- #dateformat(next_lesson,'dd/mm/yyyy')# --->
														<!--- <cfelse> --->
														<!--- - --->
														<!--- </cfif> --->
													<!--- </td> --->
													
											<!--- </tr> --->
											<!--- </cfloop> --->
										<!--- </table> --->
									<!--- </div> --->
							<!--- </div> --->
						<!--- </div> --->
						<!--- </cfif> --->
										
						<!--- <div class="row">	 --->
							<!--- <div class="col"> --->
								<!--- <div class="card border border-success mt-3 p-2 h-100"> --->
									<!--- <span class="text-success"><i class="fal fa-laptop fa-lg text-success"></i> <strong>E-LEARNING</strong></span> --->
										
									<!--- <div class="container bg-white m-0 mt-3"> --->
										<!--- <div class="row border border-top"> --->
											<!--- <div class="col-3 bg-light" style="padding:5px;"><i class="fal fa-books text-success"></i> <small>#obj_translater.get_translate('table_th_courses_launched')#</small></div> --->
										
											<!--- <div class="col-9" style="padding:5px;"> --->
												<!--- <cfif get_activity.recordcount neq "0">#get_activity.recordcount#<cfelse>-</cfif> --->
											<!--- </div> --->
										<!--- </div> --->
										
										<!--- <div class="row border border-top"> --->
											<!--- <div class="col-3 bg-light" style="padding:5px;"><i class="fal fa-tasks text-success"></i> <small>#obj_translater.get_translate('table_th_quizzes')#</small></div> --->
										
											<!--- <div class="col-9" style="padding:5px;"> --->
												<!--- <cfif get_quiz.recordcount neq "0">#get_quiz.recordcount#<cfelse>-</cfif> --->
											<!--- </div> --->
										<!--- </div> --->
										
										<!--- <div class="row border border-top"> --->
											<!--- <div class="col-3 bg-light" style="padding:5px;"><i class="fal fa-medal text-success" aria-hidden="true"></i> <small>#obj_translater.get_translate('table_th_mock_tests')#</small></div> --->
										
											<!--- <div class="col-9" style="padding:5px;"> --->
												<!--- <cfif get_mock.recordcount neq "0"> --->
												<!--- <cfloop query="get_mock"> --->
													<!--- <cfif get_mock.quiz_user_end eq ""> --->
														<!--- #ucase(quiz_type)# : Non fini --->
													<!--- <cfelse> --->
														<!--- #ucase(quiz_type)# : ok --->
													<!--- </cfif> --->
													<!--- </cfloop> --->
												<!--- <cfelse> --->
													<!--- - --->
												<!--- </cfif> --->
											<!--- </div> --->
										<!--- </div> --->
									<!--- </div> --->
									
								<!--- </div> --->
					
							<!--- </div> --->
						</div>
					</div>
				</div>
			</div>
			
						
	
	</cfoutput>
	</cfif>
<cfif ! isdefined("lrn_id")>	

	</div></div>
<cfelse>
	<cfbreak>
</cfif>
	</cfloop> 

</div>
										
							
									
					
											
										</div>
										
									</div>
						</div>
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

	$('.btn_view_file').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var o_type = idtemp[0];		
		var o_md = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Apercu document");
		$('#modal_body_lg').load("modal_window_viewer.cfm?o_md="+o_md+"&o_type="+o_type, function() {});
	});

	$('.btn_view_inv').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		// var idtemp = idtemp.split("_");
		// var o_type = idtemp[0];		
		// var o_md = idtemp[1];
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Apercu document");
		$('#modal_body_lg').load("modal_window_viewer.cfm?invoice_ref="+idtemp, function() {});
	});


	var options = [<cfoutput>#al_id#</cfoutput>];

	$( '#tm_account_select a' ).on( 'click', function( event ) {

	var target = $( event.currentTarget );
	var val = target.attr( 'data-value' ) * 1;
	var inp = target.find( 'input' );

	if (val == 0) {
		options = [];
		document.location.href="tm_admin.cfm?al_id=0";
		return false;
	}

	if ( ( idxall = options.indexOf( 0 ) ) > -1 ) {
		options.splice( idxall, 1 );
	}

	if ( ( idx = options.indexOf( val ) ) > -1 ) {
		options.splice( idx, 1 );
		setTimeout( function() { inp.prop( 'checked', false ) }, 0);
	} else {
		options.push( val );
		setTimeout( function() { inp.prop( 'checked', true ) }, 0);
	}
		
	document.location.href="tm_admin.cfm?al_id="+(options == [] ? ['0'] : options);
	return false;
	});
	
	$.typeahead({
		input: '.js_typeahead_lrn',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',

		/*matcher: function(item) {
			return true
		}*/
		
		dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
		
		group: {
			template: "{{group}}"
		},
		
		source: {
			
			<cfoutput query="get_orders_lrn" group="start_year">
			"#start_year#" : {
				display:["lrn_name", "lrn_firstname"],
				href:"",
				data:[
					<cfoutput>
						{
						"lrn_firstname": "#user_firstname#",
						"lrn_name": "#user_name#",
						"lrn_id": #user_id#
						},
					</cfoutput>
				]
			},
			
			</cfoutput>
			
			
		},
		
		
		callback: {
		
			onClickAfter: function (node, a, item, event) {
	 
				event.preventDefault;
				document.location.href="tm_admin.cfm?al_id="+(options == [] ? ['0'] : options) + "&lrn_id="+item.lrn_id;
			}			
		}
	});

});

</script>


</body>
</html>