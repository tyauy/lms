<div class="table-responsive">
<table class="table <cfif SESSION.USER_PROFILE_ID neq "3" AND SESSION.USER_PROFILE_ID neq "4">table-sm</cfif> table-hover">
	<tbody>
	<tr class="bg-light">
		
		<th><label><cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('table_th_progress')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('table_th_trainer')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('global_completed')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('global_missed')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('global_scheduled')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('badge_remaining_m_s')#</cfoutput></label></th>

		<th><label><cfoutput>#obj_translater.get_translate('table_th_program_end')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput></label></th>
	</tr>

	<cfoutput query="get_tps">
	<tr>
		<td><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></td>

		<cfset temp = obj_lms.get_tp_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_done="#tp_done#",tp_duration="#tp_duration#")>
		<td><cfif method_id neq "3">#temp#</cfif></td>
		<td>
			<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
			<cfloop query="tp_trainer">
				<cfif currentrow GT 1>,</cfif>
				#planner#
			</cfloop>
		</td>
		<td width="2%">
		<cfif method_scheduler eq "scheduler">
			<button type="button" class="btn btn-sm btn-outline-info" style="width:50px; padding:2px !important"><cfif tp_done neq "">#obj_lms.get_formath(tp_done)# <i class="fas fa-check-circle"></i><cfelse>-</cfif> </button>
		</cfif>
		</td>
		<td width="2%">	
		<cfif method_scheduler eq "scheduler">
			<button type="button" class="btn btn-sm btn-outline-danger" style="width:50px; padding:2px !important"><cfif tp_missed neq "">#obj_lms.get_formath(tp_missed)#<cfelse>-</cfif></button>
		</cfif>
		</td>
		<td width="2%">
		<cfif method_scheduler eq "scheduler">			
			<button type="button" class="btn btn-sm btn-outline-warning" style="width:50px; padding:2px !important"><cfif tp_planned neq "">#obj_lms.get_formath(tp_planned)# <i class="far fa-calendar-alt text-warning"></i><cfelse>-</cfif> </button>
		</cfif>
		</td>
		<td width="2%">	
		<cfif method_scheduler eq "scheduler">
			<button type="button" class="btn btn-sm btn-outline-success" style="width:50px; padding:2px !important"><cfif tp_done neq ""><cfset temp = tp_duration-tp_done>#obj_lms.get_formath(temp)# <i class="fas fa-hourglass-half"></i><cfelse>-</cfif> </button>
		</cfif>
		</td>
		<!---<td>#dateformat(first_lesson,'dd/mm/yyyy')#</td>
		<td>#dateformat(last_lesson,'dd/mm/yyyy')#</td>--->
		<!---<td></td>--->
		<td>#dateformat(tp_date_end,'dd/mm/yyyy')#</td>
		<td>
			<cfif SESSION.USER_PROFILE eq "learner">
				<a class="btn btn-sm btn-outline-info" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><i class="fas fa-tachometer-alt"></i> #obj_translater.get_translate('global_details')#</a>
				<cfif method_scheduler eq "scheduler"><a class="btn btn-sm btn-outline-info" href="common_tp_calendar.cfm?t_id=#tp_id#&u_id=#user_id#"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('btn_book_short')#</a></cfif>
			</cfif>
		</td>
	</tr>
	</cfoutput>
	
</table>
</div>
