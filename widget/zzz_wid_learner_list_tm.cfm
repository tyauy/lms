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
						<i class="fa-thin fa-webcam fa-lg"></i> #__table_th_program_short#
						</a>
						</li>
						
						<li class="nav-item">					
						<a href="##show_activity_#user_id#" id="tab_activity_#user_id#" class="nav-link tabquiz <cfif display eq "activity">active</cfif>" role="tab" data-toggle="tab">
						<i class="fa-thin fa-road fa-lg"></i> #__table_th_activity#
						</a>
						</li>
						
						<li class="nav-item">					
						<a href="##show_el_#user_id#" class="nav-link <cfif display eq "el">active</cfif>" role="tab" data-toggle="tab">
						<i class="fa-thin fa-laptop fa-lg"></i> E-LEARNING
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
													<!--- <cfif currentrow GT 1> - </cfif> --->
													#obj_lms.get_thumb(user_id="#planner_id#",size="30")#
													<!--- #ucase(planner)# --->
												</cfloop>
											</div>
											<div class="col-md-4 my-auto">
										
												<span class="badge badge-pill badge-warning p-2 text-white" style="width:60px"><i class="fa-light fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif> </span>
											
												<span class="badge badge-pill badge-success p-2" style="width:60px"><i class="fa-light fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#<cfelse>-</cfif> </span>
											
												<span class="badge badge-pill badge-danger p-2" style="width:60px"><i class="fa-light fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></span>
												
												<span class="badge badge-pill badge-info p-2" style="width:60px"><i class="fa-light fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></span>
												
												<button type="button" class="btn btn-sm btn-outline-info btn_view_tp" style="padding:3px !important" id="tp_#tp_id#_#user_id#"><i class="fa-thin fa-eye"></i></button>
											
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
												<a target="_blank" class="btn btn-sm btn-outline-danger" style="padding:3px !important" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#user_id#" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('sidemenu_learner_wait_signature')# : #get_lesson_not_signed.recordcount#"><i class="fa-thin fa-ballot-check"></i></a>
												<cfelse>
												<a target="_blank" class="btn btn-sm btn-outline-success" style="padding:3px !important" href="./tpl/as_container.cfm?t_id=#tp_id#&u_id=#user_id#"><i class="fa-thin fa-ballot-check"></i></a>
												</cfif>

												<cfelseif get_tp.method_id eq "11">
												<!---	for group class we don't check missed signature	--->
													<a target="_blank" class="btn btn-sm btn-outline-success" style="padding:3px !important" href="./tpl/as_group_container.cfm?t_id=#tp_id#"><i class="fa-thin fa-ballot-check"></i></a>
												</cfif>
												</cfif>
											</div>
										
											<div class="col-md-2 my-auto">
												#obj_dater.get_dateformat(tp_date_end)#
											</div>
										
										
										
										
										<!---<td class="border-0" width="10%">FL : #dateformat(get_tp.first_lesson,'dd/mm/yyyy')#</td>
										<td class="border-0">LL : #dateformat(get_tp.last_lesson,'dd/mm/yyyy')#</td>--->
										
										<!---<td class="border-0" width="190" align="right">
										<!---<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-tachometer-alt"></i></a>--->
										<!---<a href="./tpl/as_container.cfm?u_id=#user_id#" class="btn btn-sm btn-outline-info">AS</a>--->
										</td>--->
										</div>
									</cfif>
								
								</cfloop>				
							<cfelse>
								<div id="tp_container_#user_id#"></div>
							</cfif>
					
						</div>
						<div role="tabpanel" class="tab-pane border-left border-right border-bottom bg-white p-2 <cfif display eq "activity">active show</cfif>" id="show_activity_#user_id#">

						
							
							<table class="table table-sm bg-white m-0 mt-3">
								<tr>
									<td width="20%" class="bg-light"><i class="fa-thin fa-trophy-alt text-dark"></i> <small><strong>#__card_learner_pt#</strong></small></td>
								
									<td>
										
										<cfif display eq "activity">
											<cfinclude template="./wid_learner_list_tm_activity.cfm">
											<!--- <cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#")>
											<cfset _lg_rep = "">

											<div class="row">
												<div class="col-md-12">
													<div class="card border">
														<cfloop query="get_pt">
															<cfif quiz_user_group_id neq "">
															<div class="d-flex align-items-center">
																<div class="m-2">
																	<img src="./assets/img/training_#lCase(get_pt.formation_code)#.png" width="50"></span>
																</div>
																<div class="m-2">
																	#obj_dater.get_dateformat(get_pt.quiz_user_start)#
																</div>
																<div class="m-2">
																	<cfif pt_speed eq "fpt">
																		<!--- FULL PLACEMENT TEST --->
																		<span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
																		<cfif get_pt.type eq "start">
																			<br>
																			#obj_translater.get_translate('text_start_level')#
																			<!--- (Start level) --->
																		<cfelseif get_pt.type eq "end">
																			<br>
																			#obj_translater.get_translate('text_end_level')#
																			<!--- (End level) --->
																		</cfif>
																	<cfelseif get_pt.pt_speed eq "qpt">
																		<!--- QUICK PLACEMENT TEST --->
																		<span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
																	</cfif>
																</div>
																<div class="m-2">
																	<cfset _lg_rep = listAppend(_lg_rep, formation_code)>
																	<cfinclude template="../incl/incl_pt_result.cfm">
																</div>																	
															</div>
															</cfif>
														</cfloop>
													</div>
												</div>
											</div>
											<cfloop list="#SESSION.LIST_PT#" index="lang_select">
												<cfif not listFindNoCase(_lg_rep, lang_select)>
													<cfif evaluate("user_qpt_#lang_select#") neq "" AND (evaluate("user_qpt_lock_#lang_select#") eq "0" OR evaluate("user_qpt_lock_#lang_select#") eq "")>
														<div class="row">
															<div class="col-md-12">
																<div class="card border">
																		<cfif findnocase("A0",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "success">
																		<cfelseif findnocase("A1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "success">
																		<cfelseif findnocase("A2",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "primary">
																		<cfelseif findnocase("B1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "info">
																		<cfelseif findnocase("B2",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "warning">
																		<cfelseif findnocase("C1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "danger">
																		</cfif>
																		<div class="d-flex align-items-center">
																			<div class="m-2">
																				<img src="./assets/img/training_#lang_select#.png" width="50"></span>
																			</div>
																			<div class="m-2">
																				#obj_translater.get_translate('text_not_verified')#
																			</div>
																			<div class="m-2">
																				<a class="badge badge-#css# badge-pill p-3 mt-2 font-weight-normal text-white" style="font-size:14px">
																					#obj_translater.get_translate('table_th_global_level')#
																				<br>
																				<h6 class="mt-1 mb-0">#evaluate("user_qpt_#lang_select#")#</h6>
																				</a>
																			</div>																			
																		</div>
																</div>
															</div>
														</div>
													</cfif>
												</cfif>
											</cfloop> --->
										<cfelse>
											<div id="activity_container_#user_id#"></div>
										</cfif>
										
									</td>
								</tr>
								<tr>
									<td class="bg-light"><i class="fa-thin fa-history text-dark"></i> <small><strong>#__table_th_last_connect#</strong></small></td>
								
									<td>
									<cfif user_lastconnect neq "">
										#obj_dater.get_dateformat(user_lastconnect)#
									<cfelse>
										-
									</cfif>
									</td>
								</tr>
								<tr>
									<td class="bg-light"><i class="fa-thin fa-clock text-dark"></i> <small><strong>#__table_th_total_lms#</strong></small></td>
								
									<td>
										<cfif user_elapsed neq "0">
										#obj_lms.get_format_hms(toformat="#user_elapsed#")#
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
								
								
								
								
							</table>
							
						</div>
						<div role="tabpanel" class="tab-pane border-left border-right border-bottom bg-white p-2 <cfif display eq "el">active show</cfif>" id="show_el_#user_id#">

							<table class="table table-sm bg-white m-0 mt-3 b-1">
								<tr>
									<td class="bg-light" width="20%"><i class="fa-thin fa-books text-dark"></i> <small><strong>#__table_th_courses_launched#</strong></small></td>
								
									<td>
										<cfif get_activity.recordcount neq "0">#get_activity.recordcount#<cfelse>-</cfif>
									</td>
								</tr>
								
								
								
								<tr>
									<td class="bg-light"><i class="fa-thin fa-tasks text-dark"></i> <small><strong>#__table_th_quizzes#</strong></small></td>
								
									<td>
										<cfif get_quiz.recordcount neq "0">#get_quiz.recordcount#<cfelse>-</cfif>
									</td>
								</tr>
								
								
								
								<tr>
									<td class="bg-light"><i class="fa-thin fa-medal text-dark" aria-hidden="true"></i> <small><strong>#__table_th_mock_tests#</strong></small></td>
								
									<td>
										<cfif get_mock.recordcount neq "0">
										<cfloop query="get_mock">
										<cfif get_mock.quiz_user_end eq "">
										#ucase(quiz_type)# : Non fini
										<cfelse>
										#ucase(quiz_type)# : ok
										</cfif>
										</cfloop>
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
							</table>
						</div>
						
					</div>
					
					
					<!---<br>
					<span class="text-success"><i class="fal fa-laptop fa-lg text-success"></i> <strong>E-LEARNING</strong></span>
					
					--->
				</div>
				<div class="col-md-1">
					<cfif get_log_feedback.recordcount neq "0">
					<a class="btn btn-sm btn-warning btn_view_log" id="u_#user_id#" href="##"><i class="fa-thin fa-sticky-note"></i> #get_log_feedback.recordcount#</a>
					<cfelse>
					<a class="btn btn-sm btn-warning btn_view_log" id="u_#user_id#" href="##"><i class="fa-thin fa-sticky-note"></i> -</a>
					</cfif>
				</div>
			<!---</td>--->
			<!---<td>
				<cfif tp_id neq "">
					<a class="btn btn-sm btn-outline-info" href="common_tp_builder.cfm?t_id=#tp_id#&u_id=#user_id#&p_id=#SESSION.USER_ID#"><i class="far fa-edit"></i> EDIT</a>
					<cfif tp_close eq "1">
					<a class="btn btn-sm btn-outline-info" href="common_tp_calendar.cfm?t_id=#tp_id#&u_id=#user_id#&p_id=#SESSION.USER_ID#"><i class="far fa-calendar-alt"></i>BOOK</a>
					<cfelse>
					<a href="##" class="btn btn-sm btn-outline-info disabled"><i class="far fa-calendar-alt"></i>BOOK</a>
					</cfif>
				</cfif>
				
				<a class="btn btn-sm btn-outline-info" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><i class="fas fa-tachometer-alt"></i></a>
				

			</td>--->
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
