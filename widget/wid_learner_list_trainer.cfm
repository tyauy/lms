<cfset __tooltip_head_trainer = obj_translater.get_translate('tooltip_head_trainer')>
<cfset __tooltip_secondary_trainer = obj_translater.get_translate('tooltip_secondary_trainer')>

<cfset __tooltip_hours_planned = obj_translater.get_translate('tooltip_hours_planned')>
<cfset __tooltip_hours_completed = obj_translater.get_translate('tooltip_hours_completed')>

<cfset __tooltip_hours_missed = obj_translater.get_translate('tooltip_hours_missed')>
<cfset __tooltip_hours_remain = obj_translater.get_translate('tooltip_hours_remain')>

<cfset __tooltip_nnl = obj_translater.get_translate('tooltip_nnl')>
<cfset __tooltip_bl = obj_translater.get_translate('tooltip_bl')>

<ul class="nav nav-tabs" id="learner_list" role="tablist">
	<li class="nav-item">		
		<a href="#solo_learners" class="nav-link active" role="tab" data-toggle="tab">
			<i class="fa-light fa-user"></i> Solo Learners
		</a>
	</li>
	<li class="nav-item">
		<a href="#group_learners" class="nav-link" role="tab" data-toggle="tab">
			<i class="fa-light fa-users"></i> Group Learners
		</a>
	</li>
	<cfif get_tps_virtual_learners.recordCount GT 0>
		<li class="nav-item">
			<a href="#virtual_learners" class="nav-link" role="tab" data-toggle="tab">
				<i class="fa-light fa-users"></i> Virtual Classroom
			</a>
		</li>
	</cfif>
</ul>


<div class="tab-content">

	<cfloop list="solo_learners,group_learners,virtual_learners" index="cor">
	<div role="tabpanel" class="tab-pane <cfif cor eq "solo_learners">active show</cfif> mt-2" id="<cfoutput>#cor#</cfoutput>">


		<div class="table-responsive">
		<table class="table table-hover">
			<tbody>
			<tr class="bg-light">
				<th><label><cfoutput>#obj_translater.get_translate('table_th_trainers')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></label></th>
				<!--- <th><label><cfoutput>#obj_translater.get_translate('table_th_progress')#</cfoutput></label></th> --->
				<th><label><cfoutput>#obj_translater.get_translate('table_th_repartition')#</cfoutput></label></th>
				<!---<th><label><cfoutput>#obj_translater.get_translate('table_th_nextlesson')#</cfoutput></label></th>--->
				<th><label><cfoutput>#obj_translater.get_translate('table_th_program_end')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_last_lesson')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_next_lesson')#</cfoutput></label></th>
				<th><label><cfoutput>#obj_translater.get_translate('table_th_alert')#</cfoutput></label></th>
				<th><label>NOTES</label></th>
			</tr>
			<cfset get_tps = evaluate("get_tps_#cor#")>
			<!--- <cfdump var="#get_tps#"> --->
			<cfif get_tps.recordcount neq "0">
			<cfoutput query="get_tps">
				
			<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
			<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
			<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
			<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
			<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
			<cfif tp_signed eq ""><cfset tp_signed_go = "0"><cfelse><cfset tp_signed_go = tp_signed></cfif>
			
			<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
			<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go-tp_signed_go>
			
			<cfset tp_done_go = tp_completed_go+tp_inprogress_go+tp_signed_go>
				
			<tr>
				<td>
					<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
					<cfloop query="tp_trainer">
						#obj_lms.get_thumb(planner_id,40)#
					</cfloop>

				</td>
				<td>
					<cfif method_id eq 11>
						<span class="badge badge-pill bg-warning border font-weight-normal p-2 cursored btn_edit_tpgroup" id="group_#tp_id#"><strong>Group</strong><br><i class="fal fa-users"></i></span>
					<cfelseif method_id eq 10>
						<span class="badge badge-pill bg-info border font-weight-normal p-2 cursored btn_edit_tpgroup" id="class_#tp_id#"><strong>VClass</strong><br><i class="fal fa-users"></i></span>
					<cfelse>
						<a href="common_learner_account.cfm?u_id=#user_id#"><strong>#user_contact#</strong></a>
					</cfif>
				</td>
				<td> 
				<button type="button" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#account_name#"><i class="fas fa-building"></i></button>
				</td>
				<td align="center">
				<a class="btn btn-sm btn-outline-info m-0 p-0 px-1 mb-2" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">
					<cfif method_id eq "11"><i class="fa-light fa-users fa-lg" aria-hidden="true"></i></cfif>
					<cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#<cfelse>-</cfif>
				</a>
				<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_signed="#tp_signed_go#",tp_duration="#tp_duration#")>
				<cfif method_id neq "3">#temp#</cfif>
				</td>
				<td width="220">
					<div class="btn-group">
					<cfif method_scheduler eq "scheduler">
					<button type="button" class="btn btn-warning" style="width:58px; padding:3px !important" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_hours_planned#"><i class="fa-light fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>
					</cfif>
				<!--- </td>
				<td width="2%"> --->
					<cfif method_scheduler eq "scheduler">
					<button type="button" class="btn btn-success" style="width:58px; padding:3px !important" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_hours_completed#"><i class="fa-light fa-thumbs-up"></i> <cfif tp_done_go neq "">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
					</cfif>
				<!--- </td>
				<td width="2%">	 --->
					<cfif method_scheduler eq "scheduler">
					<button type="button" class="btn btn-danger" style="width:58px; padding:3px !important" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_hours_missed#"><i class="fa-light fa-thumbs-down"></i> <cfif tp_missed_go neq "">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
					</cfif>
				<!--- </td>
				<td width="2%">	 --->
					<cfif method_scheduler eq "scheduler">
					<button type="button" class="btn btn-info" style="width:58px; padding:3px !important" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_hours_remain#"><i class="fa-light fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
					</cfif>
					</div>
				</td>
				<td>#dateformat(tp_date_end,'dd/mm/yyyy')#</td>
				<td>
					<cfif method_scheduler eq "scheduler">
					<a class="btn btn-sm btn-outline-info btn-block" href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#user_id#&p_id=#SESSION.USER_ID#"><i class="fa-light fa-edit"></i> #obj_translater.get_translate('table_th_build')#</a>
					<!--- <cfelse> --->
					<!--- <a class="btn btn-sm btn-outline-info disabled" href=""><i class="far fa-edit"></i> #obj_translater.get_translate('table_th_build')#</a> --->
					<!--- </cfif> --->
					<cfif tp_close eq "1">
					<a class="btn btn-sm btn-outline-info btn-block" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#&p_id=#SESSION.USER_ID#"><i class="fa-light fa-calendar-alt"></i> #obj_translater.get_translate('table_th_book')#</a>
					<cfelse>
					<a href="##" class="btn btn-sm btn-outline-info disabled btn-block"><i class="fa-light fa-calendar-alt"></i> #obj_translater.get_translate('table_th_book')#</a>
					</cfif>
					</cfif>
				</td>
				<td><cfif last_lesson neq "">#dateformat(last_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
				<td><cfif next_lesson neq "">#dateformat(next_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
				<td>
				<cfif next_lesson eq "" AND (method_id eq "1" OR method_id eq "2") AND (tp_status_id eq "2" OR tp_status_id eq "7")>
					<cfif last_lesson lt DateAdd("m",-2,now())>
					<a class="btn btn-sm btn-danger text-white" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_bl#"><i class="fa-light fa-exclamation-triangle"></i> BL</a>
					<cfelse>
					<a class="btn btn-sm btn-warning text-white" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_nnl#"><i class="fa-light fa-exclamation-triangle"></i> NNL</a>
					</cfif>
				</cfif>
				</td>
				<td>
					<cfif user_id neq "">
					<cfset get_log_feedback = obj_task_get.oget_log(u_id="#user_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
					<a class="btn btn-sm <cfif get_log_feedback.recordcount neq "0">btn-danger<cfelse>btn-secondary</cfif> btn_view_log" id="u_#user_id#" href="##"><i class="fas fa-sticky-note"></i> #get_log_feedback.recordcount#</a>
					</cfif>
				</td>
			</tr>
			</cfoutput>
			<cfelse>
			<tr>
				<td colspan="14">
					<br>
					<div class="alert alert-secondary" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput></em></div>
					</div>
				</td>
			</tr>
			</cfif>
			
			
		</table>
		</div>

	</div>
	</cfloop>

</div>