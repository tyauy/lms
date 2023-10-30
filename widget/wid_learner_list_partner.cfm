<ul class="nav nav-tabs" id="tp_list" role="tablist">
	<cfoutput query="get_user_status">
	<li class="nav-item">		
	<a href="##f_#user_status_id#" id="div_#user_status_id#" class="nav-link <cfif user_status_id eq "4">active</cfif>" role="tab" data-toggle="tab">
	#user_status_name#
	</a>
	</li>
	</cfoutput>
</ul>


<div class="tab-content">
						
	<cfloop query="get_user_status">
	<div role="tabpanel" class="tab-pane <cfif user_status_id eq "4">active show</cfif>" id="f_<cfoutput>#user_status_id#</cfoutput>" style="margin-top:15px;">

	<cfset get_learner = obj_query.oget_learner(ust_id="#user_status_id#",st_id="100",m_id="100",list_account="#al_id#")>
						
	<!---<table width="2000" class="table bg-white">
		<tbody>--->
		<!---<tr class="bg-light">
			<!---<th><label>ID</label></th>--->
			<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_progress')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_trainer')#</cfoutput></label></th>
			<th colspan="4"><label><cfoutput>#obj_translater.get_translate('table_th_activity')#</cfoutput></label></th>
			<th><label><cfoutput>#obj_translater.get_translate('table_th_program_end')#</cfoutput></label></th>
			<!---<th><label>COMP/IN P</label></th>
			<th><label>MANQU&Eacute;</label></th>
			<th><label>PLANIFI&Eacute;</label></th>
			<th><label>RESTANT</label></th>
			<th><label>1ER COURS</label></th>
			<th><label>DERNIER COURS</label></th>
			<th><label>PROCHAIN COURS</label></th>
			<th><label>FIN DE PROGRAMME</label></th>
			<th><label>ACTION</label></th>--->
		</tr>--->

		<cfif get_learner.recordcount neq "0">
		<cfoutput query="get_learner">
			<cfset u_id = user_id>

		<div class="row bg-light p-2 m-1 mt-3 border">
		
		<cfset get_log_feedback = obj_task_get.oget_log(u_id="#user_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
				
		<cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
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
		</cfquery>

		
			<!---<tr>
				<td width="5%"><span class="badge badge-pill text-white badge-#user_status_css#">#user_status_name#</span></td>
				<td width="20%"> <a href="#user_id#" class="text-dark font-weight-bold">#user_firstname# #ucase(user_name)#</a></td>
				<td></td>
			</tr>--->
			<div class="col-md-2">
				
				<a href="##" class="text-dark font-weight-bold">#user_firstname# #ucase(user_name)#</a>
				<br>
				<span class="badge badge-pill badge-#profile_css# text-white">#profile_name#</span>
				&nbsp;
				<span class="badge badge-pill text-white badge-#user_status_css#">#user_status_name#</span>
				
			</div>
			<div class="col-md-9">
				
				
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">					
						<a href="##show_tp_#user_id#" id="tab_tp_#user_id#"  class="nav-link tabtp <cfif display eq "tp">active</cfif>" role="tab" data-toggle="tab">
						<i class="fal fa-webcam fa-lg"></i> #__table_th_program_short#
						</a>
						</li>
						
					</ul>


					<div class="tab-content">
					
						<div role="tabpanel" class="tab-pane border-left border-right border-bottom bg-white p-2 <cfif display eq "tp">active show</cfif>" id="show_tp_#user_id#">

							<cfif display eq "tp">
								<cfset get_tp = obj_tp_get.oget_tp(u_id="#user_id#",display_remain="1")>

								<cfloop query="get_tp">

									<cfif listFindNoCase("1,2,11", method_id)>
											
										<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
										<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
										<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
										<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
										<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
										
										<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
										<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
										
										<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
										
										<div class="row">
											
											<div class="col-md-1 my-auto">
												<span class="badge badge-pill badge-#get_tp.tp_status_css# text-white">#status_name#</span>
											</div>
											<div class="col-md-2 my-auto"><cfif get_tp.tp_id neq "">
												#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#<cfelse>-</cfif>
											</div>
											<div class="col-md-1 my-auto">
												<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
												#temp#
											</div>
											<div class="col-md-2 my-auto">
												<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
												<cfloop query="tp_trainer">
													<cfif currentrow GT 1> - </cfif>
													#obj_lms.get_thumb(user_id="#planner_id#",size="30")#
													#ucase(planner)#
												</cfloop>
											</div>
											<div class="col-md-4 my-auto">
										
												<span class="badge badge-pill badge-warning p-2 text-white" style="width:60px"><i class="far fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif> </span>
											
												<span class="badge badge-pill badge-success p-2" style="width:60px"><i class="far fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#<cfelse>-</cfif> </span>
											
												<span class="badge badge-pill badge-danger p-2" style="width:60px"><i class="far fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></span>
												
												<span class="badge badge-pill badge-info p-2" style="width:60px"><i class="fas fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></span>
												
												<button type="button" class="btn btn-sm btn-outline-info btn_view_tp" style="padding:3px !important" id="tp_#tp_id#_#user_id#"><i class="fal fa-eye"></i></button>
											
												<cfif  get_tp.tp_status_id neq "1">
												<cfif get_tp.method_id eq "1" OR get_tp.method_id eq "2">
												<cfquery name="get_lesson_not_signed" datasource="#SESSION.BDDSOURCE#">
												SELECT l2.lesson_id FROM lms_lesson2 l2
												LEFT JOIN lms_lesson2_attendance lla ON lla.lesson_id = l2.lesson_id
												WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
												AND (l2.status_id = 4 OR l2.status_id = 5)
												AND (l2.lesson_signed = 0 OR (lla.lesson_signed <> 1 OR lla.lesson_signed IS NULL)) 
												AND l2.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
												</cfquery>
												
												<cfif get_lesson_not_signed.recordcount neq "0">
												<a target="_blank" class="btn btn-sm btn-outline-danger" style="padding:3px !important" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#user_id#" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('sidemenu_learner_wait_signature')# : #get_lesson_not_signed.recordcount#"><i class="fal fa-ballot-check"></i></a>
												<cfelse>
												<a target="_blank" class="btn btn-sm btn-outline-success" style="padding:3px !important" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#user_id#"><i class="fal fa-ballot-check"></i></a>
												</cfif>

												<cfelseif get_tp.method_id eq "11">
												<!---	for group class we don't check missed signature	--->
													<a target="_blank" class="btn btn-sm btn-outline-success" style="padding:3px !important" href="./tpl/as_group_container.cfm?t_id=#tp_id#"><i class="fal fa-ballot-check"></i></a>
												</cfif>
												</cfif>
											</div>
										
											<div class="col-md-2 my-auto">
												#obj_dater.get_dateformat(tp_date_end)#
											</div>
										
										</div>
									</cfif>
								
								</cfloop>				
							<cfelse>
								<div id="tp_container_#user_id#"></div>
							</cfif>
					
						</div>
						
						
						
					</div>
					
					
				</div>
				<div class="col-md-1">
					<cfif get_log_feedback.recordcount neq "0">
					<a class="btn btn-sm btn-warning btn_view_log" id="u_#user_id#" href="##"><i class="fal fa-sticky-note"></i> #get_log_feedback.recordcount#</a>
					<cfelse>
					<a class="btn btn-sm btn-warning btn_view_log" id="u_#user_id#" href="##"><i class="fal fa-sticky-note"></i> -</a>
					</cfif>
				</div>
			
			</div>
		</cfoutput>
		<cfelse>
		<tr>
			<td colspan="20">
				<br>
				<div class="alert alert-secondary" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput></em></div>
				</div>
			</td>		
		</tr>
		</cfif>
		
		
	</table>

	</div>
	
	</cfloop>

</div>
