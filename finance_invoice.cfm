<!DOCTYPE html>

<cfsilent>
	
<cfparam name="s_id" default="0">
<cfparam name="o_by" default="i_ref">
<cfparam name="prov_id" default="1">

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

<cfquery name="get_invoice_status" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM invoice_status
</cfquery>

<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_provider
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
      
		<cfset title_page = "INVOICE LIST">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">
	  			
			<div class="row" style="margin-top:10px">
			
				<div class="col-md-12">
					<div class="card">
						<div class="card-body">
							
						<cfform action="finance_invoice.cfm">
						<div class="form-row">
						
							<div class="col-md-8">
								<div class="btn-group" role="group">
									<cfloop from="2018" to="#year(now())#" index="y">
									<cfoutput>
										<a class="btn btn-lg btn-info <cfif ysel eq y>active</cfif>" href="finance_invoice.cfm?ysel=#y#&prov_id=#prov_id#">#y#</a>
									</cfoutput>
									</cfloop>
								</div>
							</div>

							<div class="col-md-4">
								<div class="btn-group" role="group">
									<cfoutput query="get_provider">
										<a class="btn btn-info <cfif prov_id eq provider_id>active</cfif>" href="finance_invoice.cfm?ysel=#ysel#&prov_id=#provider_id#">#provider_name#</a>
									</cfoutput>
								</div>
							</div>
							
						</div>
						</cfform>
						</div>
					</div>
				</div>
				
			</div>
				
			
			<ul class="nav nav-tabs" id="tp_list" role="tablist">
				<li class="nav-item">		
					<a href="#i_all" class="nav-link <cfif s_id eq "0">active</cfif>" role="tab" data-toggle="tab">
					ALL
					</a>
				</li>
				<cfoutput query="get_invoice_status">
				<li class="nav-item">		
					<a href="##i_#status_id#" class="nav-link <cfif status_id eq s_id>active</cfif>" role="tab" data-toggle="tab">
					#status_name#
					</a>
				</li>
				</cfoutput>
			</ul>

			<div class="tab-content">

				<div role="tabpanel" class="tab-pane fade <cfif s_id eq "0">active show</cfif>" id="i_all" style="margin-top:15px">
									
					<div class="row">
					
						<div class="col-md-12">

						<table class="table table-bordered bg-white">
							<tbody>
								<tr class="bg-light">
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_ref" class="text-dark">INV REF</a> <i class="fas fa-sort"></i></label></th>
									<th width="6%" bgcolor="#eaffea"><label>INV ST.</label></th>
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_date" class="text-dark">INV DATE <i class="fas fa-sort"></i></a></label></th>
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_paid" class="text-dark">INV PAID <i class="fas fa-sort"></i></a> </label></th>
									<th width="6%" bgcolor="#eaffea"><label><a href="?o_by=i_amount" class="text-dark">INV HT <i class="fas fa-sort"></i></a></label></th>
									<th width="5%" bgcolor="#d1eaf5"><label><a href="?o_by=o_ref" class="text-dark">ORD ID <i class="fas fa-sort"></i></a></label></th>
									<th width="7%" bgcolor="#d1eaf5"><label>ORD ST.</label></th>
									<th width="7%" bgcolor="#d1eaf5"><label><a href="?o_by=o_amount" class="text-dark">ORD HT <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=a_name" class="text-dark">CLIENT <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=d_name" class="text-dark">DESTINATAIRE <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=u_name" class="text-dark">LEARNER <i class="fas fa-sort"></i></a></label></th>
									<th width="5%"><label>PDF</label></th>
								</tr>
								<cfset get_invoice = obj_order_get.oget_invoice(ysel="#ysel#",prov_id=#prov_id#,o_by="#o_by#")>
								<cfoutput query="get_invoice">
								<tr>
									<td>#invoice_ref#</td>
									<td><span class="badge badge-pill text-white badge-#status_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_name#</span></td>
									<td>#dateformat(invoice_date,'dd/mm/yyyy')#</td>
									<td><cfif invoice_paid neq "">#dateformat(invoice_paid,'dd/mm/yyyy')#<cfelse>-</cfif></td>
									<td align="right"><strong>#numberformat(invoice_amount,'____.__')# &euro;</strong></td>
									<td><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
									<td><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_name#</span></td>
									<td align="right"><strong>#numberformat(order_amount,'____.__')# &euro;</strong></td>
									<td><a href="crm_account_edit.cfm?a_id=#a_id#"><small><strong>#mid(a_name,1,30)#</strong></small></a></td>
									<td><a href="crm_account_edit.cfm?a_id=#dest_id#"><small><strong>#mid(dest_name,1,30)#</strong></small></a></td>
									<td>
										<cfif user_id neq "">
											<a href="common_learner_account.cfm?u_id=#user_id#"><small><strong>#user_firstname# #user_name#</strong></small></a>
										</cfif>
									</td>
								</tr>
								</cfoutput>
							</tbody>
						</table>
						
								
						</div>
					</div>
				
				</div>
				
				<cfloop query="get_invoice_status">

				


				<div role="tabpanel" class="tab-pane fade" id="<cfoutput>i_#get_invoice_status.status_id#</cfoutput>" style="margin-top:15px">
							
					<div class="row">
					
						<div class="col-md-12">

						<table class="table table-bordered bg-white">
							<tbody>
								<tr class="bg-light">
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_ref" class="text-dark">INV REF</a> <i class="fas fa-sort"></i></label></th>
									<th width="6%" bgcolor="#eaffea"><label>INV ST.</label></th>
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_date" class="text-dark">INV DATE <i class="fas fa-sort"></i></a></label></th>
									<th width="7%" bgcolor="#eaffea"><label><a href="?o_by=i_paid" class="text-dark">INV PAID <i class="fas fa-sort"></i></a> </label></th>
									<th width="6%" bgcolor="#eaffea"><label><a href="?o_by=i_amount" class="text-dark">INV HT <i class="fas fa-sort"></i></a></label></th>
									<th width="5%" bgcolor="#d1eaf5"><label><a href="?o_by=o_ref" class="text-dark">ORD ID <i class="fas fa-sort"></i></a></label></th>
									<th width="7%" bgcolor="#d1eaf5"><label>ORD ST.</label></th>
									<th width="7%" bgcolor="#d1eaf5"><label><a href="?o_by=o_amount" class="text-dark">ORD HT <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=a_name" class="text-dark">CLIENT <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=d_name" class="text-dark">DESTINATAIRE <i class="fas fa-sort"></i></a></label></th>
									<th width="15%"><label><a href="?o_by=u_name" class="text-dark">LEARNER <i class="fas fa-sort"></i></a></label></th>
									<th width="5%"><label>PDF</label></th>
								</tr>
								<cfset get_invoice = obj_order_get.oget_invoice(ysel="#ysel#",o_by="#o_by#",st_id="#get_invoice_status.status_id#")>
								<cfoutput query="get_invoice">
								<tr>
									<td>#invoice_ref#</td>
									<td><span class="badge badge-pill text-white badge-#status_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_name#</span></td>
									<td>#dateformat(invoice_date,'dd/mm/yyyy')#</td>
									<td><cfif invoice_paid neq "">#dateformat(invoice_paid,'dd/mm/yyyy')#<cfelse>-</cfif></td>
									<td align="right"><strong>#numberformat(invoice_amount,'____.__')# &euro;</strong></td>
									<td><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
									<td><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_name#</span></td>
									<td align="right"><strong>#numberformat(order_amount,'____.__')# &euro;</strong></td>
									<td><a href="crm_account_edit.cfm?a_id=#a_id#"><small><strong>#mid(a_name,1,30)#</strong></small></a></td>
									<td><a href="crm_account_edit.cfm?a_id=#dest_id#"><small><strong>#mid(dest_name,1,30)#</strong></small></a></td>
									<td>
										<cfif user_id neq "">
											<a href="common_learner_account.cfm?u_id=#user_id#"><small><strong>#user_firstname# #user_name#</strong></small></a>
										</cfif>
									</td>
								</tr>
								</cfoutput>
							</tbody>
						</table>
						
								
						</div>
					</div>
				
				</div>
				</cfloop>
				
			</div>
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>

</script>

</body>
</html>