<cfoutput>
<table class="table table-sm">
	<tr>
		<th class="bg-light" width="40%"><label>#obj_translater.get_translate('table_th_language')#</label></th>
		<td>#get_tp.formation_name# </td>
	</tr>
	
	<tr>
		<th class="bg-light"><label>#obj_translater.get_translate('table_th_method')#</label></th>
		<td>#get_tp.method_name#</td>
	</tr>
	
	<tr>
		<th class="bg-light"><label>#obj_translater.get_translate('table_th_start')#</label></th>
		<td>#obj_dater.get_dateformat(get_tp.tp_date_start)#</td>
	</tr>
	
	<tr>
		<th class="bg-light"><label>#obj_translater.get_translate('table_th_end')#</label></th>
		<td>
		<cfif get_tp.tp_date_end lte now()>
		<strong class="text-danger"><i class="fas fa-exclamation-triangle"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</strong>
		<cfelse>
		#obj_dater.get_dateformat(get_tp.tp_date_end)#
		</cfif>
		</td>
	</tr>
	
	<cfif get_tp.method_id neq "3">
	<tr>
		<th class="bg-light"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
		<td><strong>#obj_lms.get_formath(get_tp.tp_duration)# h</strong></td>
	</tr>
	</cfif>
	
	<cfif get_tp.method_id neq "7">

		<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#get_tp.tp_id#")>
		<cfloop query="tp_trainer">
			<tr>
				<th class="bg-light"><label>#obj_translater.get_translate('table_th_trainer')# #currentrow#</label></th>
				<td>#planner#</td>
			</tr>

		</cfloop>

	</cfif>
	
	<cfif get_tp.method_scheduler eq "scheduler">
	
		<cfif get_tp.method_id neq "7">
		<cfif get_tp.tp_done neq "" AND get_tp.tp_duration neq "">
		<tr>
			<th class="bg-light"><label>#obj_translater.get_translate('table_th_progress_formation')#</label></th>
			<td>#obj_lms.get_tp_progress_bar(get_tp.method_id,get_tp.tp_status_id,get_tp.tp_done,get_tp.tp_duration)#</td>
		</tr>		
		</cfif>
		</cfif>
	
	<cfelse>
		<!---<tr>
			<td class="bg-light">Statut formation</td>
			<td>#obj_lms.get_tp_progress_bar(method_id,tp_status_id,tp_done,tp_duration)#</td>
		</tr>--->
		<cfif get_tp.method_id eq "3">
			<cfif get_tp.elearning_id eq "1">
			<tr>
				<th class="bg-light"><label>e-Learning</label></th>
				<td><a href="common_practice.cfm" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_connect')#</a></td>
			</tr>
			<cfelseif get_tp.elearning_id eq "2">
			<tr>
				<th class="bg-light"><label>e-Learning</label></th>
				<td><a href="http://welearning.wefitgroup.com/" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_connect')#</a></td>
			</tr>
			</cfif>
		<cfelseif get_tp.method_id eq "6">
		<tr>
			<th class="bg-light"><label>#obj_translater.get_translate('table_th_destination')#</label></th>
			<td>#get_tp.destination_name#</td>
		</tr>
		<cfelseif method_id eq "7">
		<tr>
			<th class="bg-light"><label>#obj_translater.get_translate('global_title')#</label></th>
			<td>#get_tp.certif_name#</td>
		</tr>
		</cfif>
	</cfif>
	
</table>
</cfoutput>



				

<!---
<table class="table table-sm">
							<tr>
								<td>Langue</td>
								<td>#get_tp.formation_name# </td>
							</tr>
							
							<tr>
								<td>M&eacute;thode</td>
								<td>#get_tp.method_name#</td>
							</tr>
							
							<tr>
								<td>Dur&eacute;e</td>
								<td><strong>#obj_lms.get_formath(get_tp.tp_duration)# h</strong></td>
							</tr>
							
							<tr>
								<td>Statut formation</td>
								<td>#obj_lms.get_tp_progress_bar(method_id,tp_status,tp_done,tp_duration)#</td>
							</tr>
							
							<tr>
								<td>Destination</td>
								<td>#destination_name#</td>
							</tr>

							<cfif get_tp.tp_done neq "" AND get_tp.tp_duration neq "">
							<tr>
								<td>Ma progression</td>
								<td>			
									#obj_lms.get_tp_progress_bar(method_id,tp_status,tp_done,tp_duration)#							
								</td>
							</tr>
							</cfif>						
							
						</table>--->