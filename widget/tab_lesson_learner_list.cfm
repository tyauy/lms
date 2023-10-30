<cfif table_display eq "header">
<tr bgcolor="#F3F3F3">
	<cfoutput>
	<th width="7%"><label>#obj_translater.get_translate('table_th_status')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_trainer')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label></th>
	<th width="17%"><label>#obj_translater.get_translate('table_th_course')#</label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_date')#</label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
	<th width="4%"></th>
	<th width="4%"></th>
	</cfoutput>
</tr>
<cfelseif table_display eq "header_mini">
<!---<tr bgcolor="#F3F3F3">
	<cfoutput>
	<th width="7%"><label>#obj_translater.get_translate('table_th_status')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_trainer')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label></th>
	<th width="10%"><label>#obj_translater.get_translate('table_th_date')#</label></th>
	<th width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
	<th width="4%"></th>
	<th width="4%"></th>
	</cfoutput>
</tr>--->
<cfelseif table_display eq "body">
<cfoutput>
<tr>
	<td>
		<span class="badge badge-#status_css#">#status_name#</span>
	</td>
	<td>
		#planner_firstname# <!---#obj_lms.get_thumb(user_id="#planner_id#",size="24",responsive="no")# --->
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
		<a href="##" class="btn btn-sm btn-outline-info btn_view_session" id="sm_#sessionmaster_id#" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"><i class="fas fa-book"></i> <span class="d-none d-xl-block">#__btn_support_short#</span></a>
	</td>
	<td>
		<cfif status_id eq "5" OR status_id eq "6">
			<cfif note_id neq "" AND lesson_lock eq "1">
				<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_view_ln#"><i class="fas fa-bookmark"></i> <span class="d-none d-xl-block">#__btn_notes_short#</span></a>
			</cfif>
		</cfif>
	</td>
</tr>
</cfoutput>
<cfelseif table_display eq "body_mini">
<cfoutput>
<tr>
	<td>
		<img src="./assets/img/picto_methode_#method_id#.png" width="20" style="margin-right:2px">
	</td>
	<td>
		<span class="badge badge-#status_css#">#status_name#</span>
	</td>
	<td>
		<small>#planner_firstname#</small> <!---#obj_lms.get_thumb(user_id="#planner_id#",size="24",responsive="no")# --->
	</td>
	<!---<td class="d-none d-xl-block">
		<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id,tp_rank,formation_code,method_id,tp_duration)#<cfelse>-</cfif></a>
	</td>--->
	<td>
		#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#
	</td>
	<td>
		<small>#lesson_duration#m</small>
	</td>
	<td width="5%">
		<a href="##" class="btn btn-sm btn-outline-info btn_view_session" id="sm_#sessionmaster_id#" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"><i class="fas fa-eye"></i></a>
	</td>
	<td>
		<cfif status_id eq "5" OR status_id eq "6">
			<cfif note_id neq "" AND lesson_lock eq "1">
				<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_view_ln#"><i class="fas fa-bookmark"></i> <span class="d-none d-xl-block">#__btn_notes_short#</span></a>
			</cfif>
		</cfif>
	</td>
</tr>
</cfoutput>
</cfif>