<cfif table_display eq "header">
<tr bgcolor="#F3F3F3">
	<cfoutput>
	<th class="th_sortable" width="7%"><label>#obj_translater.get_translate('table_th_status')#</label><label class="th_sortable_arrow"></label></th>
	<th class="th_sortable" width="13%"><label>#obj_translater.get_translate('table_th_trainer')#</label><label class="th_sortable_arrow"></label></th>
	<th class="th_sortable" width="13%"><label>#obj_translater.get_translate('table_th_learner')#</label><label class="th_sortable_arrow"></label></th>
	<th class="th_sortable" width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label><label class="th_sortable_arrow"></label></th>
	<th class="th_sortable" width="17%"><label>#obj_translater.get_translate('table_th_course')#</label><label class="th_sortable_arrow"></label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
	<th class="th_sortable" width="10%"><label>#obj_translater.get_translate('table_th_date')#</label><label class="th_sortable_arrow"></label></th>
	<th class="th_sortable" width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label><label class="th_sortable_arrow"></label></th>

	</cfoutput>
</tr>
<cfelseif table_display eq "body">
<cfoutput>
<tr>
	<td>
		<span class="badge badge-#status_css#">#status_name#</span>
	</td>
	<td>
		#planner_firstname#
	</td>
	<td>
		#user_firstname# #user_name#
	</td>
	<td>
		<!---<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">--->
		<cfif tp_id neq "">
			#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#
		<cfelse>-</cfif>
		<!---</a>--->
	</td>
	<td>
		<!---<span class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#" style="cursor:pointer">?</span>--->	
		<cfif len(sessionmaster_name) gt "25">
		#mid(sessionmaster_name,1,25)# [...]
		<cfelse>
		#sessionmaster_name#
		</cfif>
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
	<!---<td>
		<a href="##" class="btn btn-sm btn-outline-info btn_view_session" id="sm_#sessionmaster_id#" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"><i class="fas fa-book"></i></a>
	</td>
	<td>
		<cfif status_id eq "5" OR status_id eq "6">
			<cfif note_id neq "">
			<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_view_ln#"><i class="fas fa-bookmark"></i></a>
			</cfif>
		</cfif>
	</td>--->
</tr>
</cfoutput>
</cfif>