<cfsilent>

<cfif isdefined("get_tp.tp_id") AND get_tp.recordcount neq "0">
	<cfset tpcor = get_tp.tp_id>
<cfelse>
	<cfset tpcor = 0>
</cfif>

<cfoutput query="get_lesson_status">

<cfquery name="get_lesson_#status_id#" datasource="#SESSION.BDDSOURCE#">
SELECT u.user_firstname, u.user_name, u.user_id, 
up.profile_name, 
u2.user_alias, u2.user_id as planner_id, 
l.lesson_id, l.method_id, l.tp_id, l.lesson_start, l.lesson_duration, l.status_id,
sm.sessionmaster_name, sm.sessionmaster_ressource,
tp.*, tp.method_id, 
ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name, 
lm.method_name_#SESSION.LANG_CODE# as method_name, 
lt.type_name_#SESSION.LANG_CODE# as type_name, 
f.formation_code,
ln.note_id
FROM lms_lesson2 l
INNER JOIN lms_tpsession s ON s.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
INNER JOIN lms_lesson_type lt ON lt.type_id = l.type_id
INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
INNER JOIN user u ON u.user_id = l.user_id
INNER JOIN user u2 ON u2.user_id = l.planner_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
LEFT JOIN lms_lesson_location ll ON ll.location_id = l.location_id
LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL

<cfif SESSION.USER_PROFILE_ID eq "3">
	AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
<cfelseif SESSION.USER_PROFILE_ID eq "4">
	AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
<cfelse>
	<cfif isdefined("u_id")>AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"></cfif>
</cfif>

<!---<cfif tpcor neq "0">AND tp.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#tpcor#"></cfif>--->


<cfif status_id neq "0">AND l.status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#status_id#"></cfif> 
</cfquery>
</cfoutput>

</cfsilent>

<cfif show_tab eq "0">
<ul class="nav nav-tabs" role="tablist" id="tabs_lessons">

	<cfoutput query="get_lesson_status">
	<cfif isdefined("get_tp.tp_id")>
	<li class="nav-item">
		<a class="nav-link <cfif status_id eq "0">active</cfif>" href="##tab_#tpcor#_#status_id#" role="tab" data-toggle="tab" id="title_#status_id#">#status_name#</a>
	</li>
	<cfelse>
	<li class="nav-item">
		<a class="nav-link <cfif status_id eq "0">active</cfif>" href="##tab_#tpcor#_#status_id#" role="tab" data-toggle="tab" id="title_#status_id#">#status_name#</a>
	</li>
	</cfif>
	</cfoutput>

</ul>
</cfif>

<div class="tab-content" id="myTabContent">

	<cfloop query="get_lesson_status">
	<cfif show_tab eq "0">
	<div class="tab-pane fade <cfif get_lesson_status.status_id eq "0">show active</cfif>" <cfoutput>id="tab_#tpcor#_#get_lesson_status.status_id#"</cfoutput> role="tabpanel" aria-labelledby="home-tab" id="title_#status_id#">
	</cfif>
		<cfif show_tab eq get_lesson_status.status_id OR show_tab eq "0">
		<cfif evaluate("get_lesson_#status_id#.recordcount") neq "0">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
		
			
			<table class="table table-hover">
				<tbody>
				<tr bgcolor="#F3F3F3">
					<cfif not isdefined("u_id")>
					<th><label>ID</label></th>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_name')#</cfoutput></label></th>
					<th><label><cfoutput>#obj_translater.get_translate('profile')#</cfoutput></label></th>
					</cfif>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_trainer')#</cfoutput></label></th>
					<th><label>TP</label></th>
					<th><label><cfoutput>#obj_translater.get_translate('el_txt_lesson')#</cfoutput></label></th>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label></th>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_duration_short')#</cfoutput></label></th>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
					<th><label><cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput></label></th>
				</tr>
				
				<cfoutput query="get_lesson_#status_id#">
				<tr>
					<cfif not isdefined("u_id")>
					<td>#obj_lms.get_thumb(user_id="#user_id#",size="24",responsive="no")#</td>
					<td><a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a></td>
					<td>#profile_name#</td>
					</cfif>
					<td><!---#obj_lms.get_thumb(user_id="#planner_id#",size="24",responsive="no")# --->#user_alias#</td>
					<td>#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#</td>
					<td><img src="./assets/img/picto_methode_#method_id#.png" width="20" style="margin-right:2px"> #sessionmaster_name#</td>
					<!---<td>#type_name#</td>--->
					<td>#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#</td>
					<td>#lesson_duration# min</td>
					<td>
						<span class="badge badge-#status_css#">#status_name#</span>
					</td>
					<td align="right">
						<a class="btn btn-sm btn-outline-info btn_note_lesson" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature"></i></a>
						<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-bookmark"></i> LN</a>
							
						<cfif SESSION.USER_PROFILE eq "learner">
							<cfif status_id eq "5">
								<a class="btn btn-sm btn-outline-info btn_sign_lesson" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature"></i></a>
							</cfif>	
							<a class="btn btn-sm btn-outline-info btn_view_lesson" id="l_#lesson_id#" href="##"><i class="far fa-eye"></i> #obj_translater.get_translate('btn_trainer_view')#</a>
							#obj_lms.get_ressource(sessionmaster_ressource,'WS',"short")#
						<cfelseif SESSION.USER_PROFILE_ID eq "trainer">
							<!---#obj_lms.get_ressource(sessionmaster_ressource,'WS',"short")#--->
							#obj_lms.get_ressource(sessionmaster_ressource,'WSK',"short")#
							<a class="btn btn-sm btn-outline-info btn_view_lesson" id="l_#lesson_id#" href="##"><i class="far fa-eye"></i> #obj_translater.get_translate('btn_trainer_view')#</a>
							<cfif status_id eq "2">
								<a class="btn btn-sm btn-outline-info btn_note_lesson" id="l_#lesson_id#" href="##"><i class="fas fa-file-signature"></i></a>
							<cfelseif status_id eq "1">
								<cfif lesson_start lte dateadd("n",+60,now())>
									<a class="btn btn-sm btn-outline-danger btn_view_lesson" id="l_#lesson_id#" href="##" target="_blank" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('btn_launch_lesson')#"><i class="fas fa-play"></i></a>
								<cfelse>
									<a class="btn btn-sm btn-outline-danger disabled" id="l_#lesson_id#" href="##" target="_blank"><i class="fas fa-play"></i></a>
								</cfif>
							</cfif>
							<cfif note_id neq "">
							<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-bookmark"></i> LN</a>
							</cfif>
						</cfif>
					</td>
				</tr>
				</cfoutput>
				</tbody>
				
			</table>
		
			</div>
		</div>
		<cfelse>
		<div class="row justify-content-md-center" style="margin-top:15px">

			<div class="col-md-6">
				<div class="alert alert-secondary" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_course')#</cfoutput></em></div>
				</div>
			</div>

		</div>
		</cfif>
		</cfif>
	<cfif show_tab eq "0">
	</div>
	</cfif>
	</cfloop>

</div>

	