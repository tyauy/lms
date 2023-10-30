<cfif table_display eq "header">
<tr bgcolor="#F3F3F3">
	<cfoutput>
	<th width="7%"><label>#obj_translater.get_translate('table_th_status')#</label></th>
	<th width="15%"><label>#obj_translater.get_translate('table_th_learner')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label></th>
	<th width="17%"><label>#obj_translater.get_translate('table_th_course')#</label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_date')#</label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
	<th width="4%"></th>
	<th width="4%"></th>
	<th width="4%"></th>
	<th width="4%"></th>
	</cfoutput>
</tr>
<cfelseif table_display eq "body">
<cfoutput>
<tr>
	<td>
		<span class="badge badge-#status_css#">#status_name#</span>
	</td>
	<td>
		<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a> <!---#obj_lms.get_thumb(user_id="#planner_id#",size="24",responsive="no")# --->
	</td>
	<td>
		<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></a>
	</td>
	<td>
		<!---<span class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#" style="cursor:pointer">?</span>	--->
		#sessionmaster_name#
	</td>
	<td>
		<img src="./assets/img/picto_methode_#method_id#.png" width="20" style="margin-right:2px">
	</td>
	<td>
		#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#
	</td>
	<td>
		#lesson_duration# min
	</td>
	<td>
		<a href="##" class="btn btn-sm btn-outline-info btn_view_session" id="sm_#sessionmaster_id#" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"><i class="fas fa-book"></i> #obj_translater.get_translate('btn_support_short')#</a>
	</td>
	<td>
		<cfif status_id eq "5" OR status_id eq "6">
			<cfif note_id neq "">
			<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_view_ln#"><i class="fas fa-bookmark"></i> #obj_translater.get_translate('btn_notes_short')#</a>
			</cfif>
		</cfif>
	</td>
	<td>
		<cfif status_id eq "2">
			<cfif method_id neq "2">
				<cfif sessionmaster_id eq "694">
				<!------- PTA -------->
					<a class="btn btn-sm btn-outline-info btn_ln_pta" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_fill_pta#"></i> #__btn_fill_notes#</a>
				<cfelseif sessionmaster_id eq "695">
				<!------- NA -------->
					<a class="btn btn-sm btn-outline-info btn_ln_na" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_fill_na#"></i> #__btn_fill_notes#</a>
				<cfelse>
					<a class="btn btn-sm btn-outline-info btn_ln_lesson" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_fill_ln#"></i> #__btn_fill_notes#</a>
				</cfif>
			<cfelse>
				<a class="btn btn-sm btn-outline-info btn_ln_upload" id="l_#lesson_id#" href="##"><i class="fas fa-file-upload" title="#__tooltip_fill_ln#"></i> #__btn_upload_notes#</a>
				
			</cfif>
		</cfif>
	</td>
	<td>
		<cfif status_id eq "1">
			<a class="btn btn-sm btn-outline-danger btn_view_lesson"  role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_cancel_lesson#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i> #__btn_cancel_short#</a>
		</cfif>
	</td>
	<!---<td>
		<cfif status_id eq "1">
			<cfif now() gte dateadd("n",-15,lesson_start) AND now() lte dateadd("n",+15,lesson_start)>
			<a class="btn btn-sm btn-outline-success btn_view_lesson" id="l_#lesson_id#" href="##" target="_blank" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('tooltip_launch_lesson')#"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_launch_short')#</a>
			</cfif>
		</cfif>
	</td>--->
</tr>
</cfoutput>
</cfif>