<cfif get_orders.recordcount eq "0">

	

<cfelse>

	<cfoutput query="get_orders" group="order_id">

	<cfset get_tps = obj_tp_get.oget_tps(o_id="#order_id#")>

	<div class="bg-light p-2 m-1 mt-3 border">

		<table class="table table-borderless m-0">
			<tr>
				<td width="5%"><span class="badge badge-pill text-white badge-default"><strong>#order_ref#</strong> - #context_alias#</span></td>
				<td width="5%"><span class="badge badge-pill text-white badge-default"></span></td>
				<cfif order_status_id eq "1" OR order_status_id eq "2">
				<td width="5%"><span class="badge badge-pill text-white badge-warning">En attente</span></td>
				<cfelseif order_status_id eq "3" OR order_status_id eq "4">
				<td width="5%"><span class="badge badge-pill text-white badge-success">Valid&eacute;</span></td>
				<cfelseif order_status_id eq "5" OR order_status_id eq "10">
				<td width="5%"><span class="badge badge-pill text-white badge-secondary">Cl&ocirc;tur&eacute;</span></td>
				<cfelseif order_status_id eq "6">
				<td width="5%"><span class="badge badge-pill text-white badge-secondary">Annul&eacute;</span></td>
				</cfif>
				
				<td width="7%">#dateformat(order_date,'dd/mm/yyyy')#</td>
				<td width="15%"><a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_firstname# #user_name#</strong></a></td>
				<td width="10%"><strong><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></strong></td>
				<td width="10%">
					<table class="table table-condensed table-bordered bg-white" style="margin:0px">
						<cfoutput>
						<tr>
							<td width="50%"><span class='lang-sm' lang='#lcase(formation_code)#'></span> <strong><!---#obj_lms.get_method_from_list(m_id="#method_id#",short="1")#----> #numberformat(item_inv_hour,'____')#h</strong></td>
							
							<!---<td width="10%">#item_inv_unit_price#</td>
							<td width="15%"><strong>#item_inv_total#&euro;</strong></td>--->
							<td width="50%">#order_item_mode_name#</td>
							<!---<td width="20%"><small><cfif opca_id eq "0">DIRECT<cfelse>#opca_name#</cfif> </small></td>--->
						</tr>
						</cfoutput>
					</table>			
				</td>
				
				<td align="center" width="5%">
					<cfif order_conv neq "" AND fileexists("#SESSION.BO_ROOT#/admin/conv/#order_conv#")>
					<a class="btn btn-sm btn-success btn_view_conv text-white" id="conv_#order_md#" href="./admin/conv/#order_conv#" target="_blank"  data-toggle="tooltip" data-placement="top" title="Convention de formation">CONV</a>
					<cfelse>
					-
					</cfif>
				</td>
				<td align="center" width="5%">
					<cfif order_bdc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bdc/#order_bdc#")>
					<a class="btn btn-sm btn-success btn_view_conv text-white" id="bdc_#order_md#" href="./admin/bdc/#order_bdc#" target="_blank"  data-toggle="tooltip" data-placement="top" title="Bon de Commande / Devis">BDC</a>
					<cfelse>
					-
					</cfif>
				</td>
				<td align="center" width="5%">
					<cfif order_apc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/apc/#order_apc#")>
					<a class="btn btn-sm btn-success btn_view_conv text-white" id="apc_#order_md#" href="./admin/apc/#order_apc#" target="_blank"  data-toggle="tooltip" data-placement="top" title="Accord de Prise en Charge">APC</a>
					<cfelse>
					-
					</cfif>
				</td>
				<td align="center" width="5%">
					<cfif order_avn neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn/#order_avn#")>
					<a class="btn btn-sm btn-success btn_view_conv text-white" id="avn_#order_md#" href="./admin/avn/#order_avn#" target="_blank"  data-toggle="tooltip" data-placement="top" title="Avenant">AVN</a>
					<cfelse>
					-
					</cfif>
				</td>
				<td align="center" width="5%">
					<cfif order_aff neq "" AND fileexists("#SESSION.BO_ROOT#/admin/aff/#order_aff#")>
					<a class="btn btn-sm btn-success btn_view_conv text-white" id="aff_#order_md#" href="./admin/aff/#order_aff#" target="_blank"  data-toggle="tooltip" data-placement="top" title="Attestation de fin de formation">AFF</a>
					<cfelse>
					-
					</cfif>
				</td>
				<td width="3%">
					<cfif get_tps.recordcount neq "0">
					<button class="btn btn-sm btn-outline-info" role="button" data-toggle="collapse" data-target="##o_#order_id#" aria-expanded="true" aria-controls="o_#order_id#">
					<i class="far fa-clipboard-list"></i>
					</button>
					</cfif>
				</td>
			</tr>
			<cfif get_tps.recordcount neq "0">
			<tr class="collapse" id="o_#order_id#">
				<td colspan="12">
					
						<table class="table table-sm m-0 mt-4">
			
							<tr class="bg-light">
							<th><label><em>STATUT</em></label></th>
							<th><label><em>PARCOURS</em></label></th>
							<th><label><em>PROGRESSION</em></label></th>
							<th><label><em>FORMATEUR</em></label></th>
							<th colspan="4"><label><em>HEURES</em></label></th>
							<th><label><em>DERNIER COURS</em></label></th>
							<th><label><em>PROCHAIN COURS</em></label></th>
							</tr>
						<cfloop query="get_tps">
								
								<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
								<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
								<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
								<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
								<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
								
								<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
								<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
								
								<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
								
								<tr>
								<td class="border-0" width="10%"><span class="badge badge-pill badge-#tp_status_css#">#status_name#</span></td>
								<td class="border-0" width="25%">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</td>
								<td class="border-0" width="10%">
								<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
									#temp#
								
								</td>
								<td class="border-0" width="10%">
									<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
									<cfloop query="tp_trainer">
										<cfif currentrow GT 1>,</cfif>
										#planner#
									</cfloop>
								</td>
								
								<td class="border-0" width="2%">
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="far fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>
									</cfif>
								</td>
								<td class="border-0" width="2%">
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="far fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
									</cfif>
								</td>
								<td class="border-0" width="2%">	
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="far fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
									</cfif>
								</td>
								<td class="border-0" width="2%">	
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fas fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
									</cfif>
								</td>
								<td class="border-0" width="7%">
									<cfif last_lesson neq "">
									#dateformat(last_lesson,'dd/mm/yyyy')#
									<cfelse>
									-
									</cfif>
								</td>
								<td class="border-0" width="7%">
									<cfif next_lesson neq "">
									#dateformat(next_lesson,'dd/mm/yyyy')#
									<cfelse>
									-
									</cfif>
								</td>
								<!---<td class="border-0" width="150">#dateformat(tp_date_end,'dd/mm/yyyy')#</td>--->
								
								<!---<td class="border-0" width="10%">FL : #dateformat(get_tp.first_lesson,'dd/mm/yyyy')#</td>
								<td class="border-0">LL : #dateformat(get_tp.last_lesson,'dd/mm/yyyy')#</td>--->
								
								<!---<td class="border-0" width="190" align="right">
								<!---<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-tachometer-alt"></i></a>--->
								<!---<a href="./tpl/as_container.cfm?u_id=#user_id#" class="btn btn-sm btn-outline-info">AS</a>--->
								</td>--->
								</tr>
								</cfloop>
							</table>
				
				</td>
			</tr>
			</cfif>
		</table>
		
		


	</div>
	</cfoutput>
</cfif>