<!DOCTYPE html>

<cfsilent>

<cfset get_tp = obj_tp_get.oget_tp(t_id)>

<cfset __lesson = obj_translater.get_translate('lesson')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __with = obj_translater.get_translate('with')>
<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfset __card_tp_description = obj_translater.get_translate('card_tp_description')>
<cfset __card_tp_lessonnote = obj_translater.get_translate('card_tp_lessonnote')>
<cfset __card_tp_exercice = obj_translater.get_translate('card_tp_exercice')>
<cfset __card_tp_note = obj_translater.get_translate('card_tp_note')>


<cfset __modal_supports = obj_translater.get_translate('modal_supports')>
<cfset __modal_link_ws = obj_translater.get_translate('modal_link_ws')>
<cfset __modal_link_wsk = obj_translater.get_translate('modal_link_wsk')>
<cfset __modal_link_video = obj_translater.get_translate('modal_link_video')>
<cfset __modal_link_audio = obj_translater.get_translate('modal_link_audio')>

<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset __btn_note = obj_translater.get_translate('btn_note')>

<cfdirectory directory="#SESSION.BO_ROOT#/assets/attachment/" name="dirQuery" action="LIST">

<cfif not isDefined("u_id")>
	<cfset u_id = SESSION.USER_ID>
</cfif>
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>


								<cfloop query="get_tp">
								
								<div role="tabpanel" class="tab-pane fade <cfif tp_id eq t_id>active show</cfif>" <cfoutput>id="tp_#tp_id#"</cfoutput> style="margin-top:15px">
								
									<cfif get_tp.method_scheduler eq "scheduler">
									<cfoutput>
									<!---- TP WITH SCHEDULER METHOD --->
																		
									<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
									<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
									<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
									<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
									<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
									
									<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
									<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
									
									<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
									
									<div class="row">

										<cfif get_tp.method_id eq "7">
										<!---- TP CERTIFICATION --->
										
										<div class="col-md-4">
											<div class="card border-top border-info h100">
												<div class="card-body">
													<h4 class="card-title">#obj_translater.get_translate('card_tp_resume')#</h4>
													<br><br>
													<cfinclude template="./widget/wid_tp_recap.cfm">
												</div>
											</div>
										</div>
										
										<cfelse>
										
										<div class="col-md-12">
											<div class="card border h-100">
												<div class="card-body">
													<h4 class="card-title">#obj_translater.get_translate('card_tp_resume')#</h4>
													<br><br>													
													<table class="table table-sm">
														<tbody>
														<tr class="bg-light">
															<th><label>#obj_translater.get_translate('table_th_program_short')#</label></th>
															<th><label>#obj_translater.get_translate('table_th_progress')#</label></th>
															<th><label>#obj_translater.get_translate('table_th_trainer')#</label></th>
															<th><label>#obj_translater.get_translate('table_th_start')#</label></th>
															<th><label>#obj_translater.get_translate('table_th_end')#</label></th>
														</tr>

														<tr>
															<td><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></td>
															<td>
															<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
															<cfif method_id neq "3">#temp#</cfif>
															</td>
															<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
															<td>
															<cfloop query="tp_trainer">
																#planner#
															</cfloop>
															</td>
															<!---<td>#dateformat(first_lesson,'dd/mm/yyyy')#</td>
															<td>#dateformat(last_lesson,'dd/mm/yyyy')#</td>--->
															<td>#obj_dater.get_dateformat(tp_date_start)#</td>
															<td>
																<cfif tp_date_end lte now()>
																<strong class="text-danger"><i class="fas fa-exclamation-triangle"></i> #obj_dater.get_dateformat(tp_date_end)#</strong>
																<cfelse>
																#obj_dater.get_dateformat(tp_date_end)#
																</cfif>
															</td>
														</tr>
														
													</table>
													<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
														<cfif tp_duration neq session_duration>
														<div class="alert alert-danger" role="alert">
															<div class="text-center"><em>#obj_translater.get_translate('alert_tp_anomaly')#</em></div>
														</div>
														</cfif>
													</cfif>
													<cfif tp_date_end lte now() AND tp_vip eq "0">
														<div class="alert alert-danger" role="alert">
															<div class="text-center"><em>#obj_translater.get_translate('alert_tp_deadline')#</em></div>
														</div>
													</cfif>
													
												</div>
											</div>
										</div>
										
										<!--- <div class="col-md-6"> --->
											<!--- <div class="card border h-100"> --->
												<!--- <div class="card-body"> --->
													<!--- <h4 class="card-title">#obj_translater.get_translate('card_tp_hours')#</h4> --->
													<!--- <br><br> --->
													
													<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
														<!--- <button type="button" class="btn btn btn-warning p-2" onclick="location.href='cs_lessons.cfm?st_id=1&u_id=#u_id#'"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-primary p-2" onclick="location.href='cs_lessons.cfm?st_id=2&u_id=#u_id#'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_inprogress')#<br><h3 class="m-0 text-capitalize"><cfif tp_inprogress_go neq "0">#obj_lms.get_format_hms(toformat="#tp_inprogress_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-success p-2" onclick="location.href='cs_lessons.cfm?st_id=5&u_id=#u_id#'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_completed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_completed_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-danger p-2" onclick="location.href='cs_lessons.cfm?st_id=4&u_id=#u_id#'"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-danger p-2" onclick="location.href='cs_lessons.cfm?st_id=3&u_id=#u_id#'"><i class="fas fa-times"></i> #obj_translater.get_translate('badge_cancelled_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_cancelled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_cancelled_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-info p-2"><i class="fas fa-hourglass-half"></i> #obj_translater.get_translate('badge_remaining_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
													<!--- <cfelseif SESSION.USER_PROFILE eq "trainer"> --->
														<!--- <button type="button" class="btn btn btn-warning p-2"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-success p-2"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_done_go neq "0">#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-danger p-2"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-info p-2"><i class="fas fa-hourglass-half"></i> #obj_translater.get_translate('badge_remaining_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
													<!--- <cfelseif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test"> --->
														<!--- <button type="button" class="btn btn btn-warning p-2" onclick="location.href='learner_lessons.cfm?st_id=1'"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-success p-2" onclick="location.href='learner_lessons.cfm?st_id=5'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_done_go neq "0">#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-danger p-2" onclick="location.href='learner_lessons.cfm?st_id=4'"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
														<!--- <button type="button" class="btn btn btn-info p-2" onclick="location.href='learner_lessons.cfm'"><i class="fas fa-hourglass-half"></i> #obj_translater.get_translate('badge_remaining_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></h3></button> --->
													<!--- <cfelseif SESSION.USER_PROFILE eq "tm"> --->
														<!--- <span class="badge badge-warning p-2 text-white"><i class="far fa-calendar-alt" aria-hidden="true"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#<cfelse>-</cfif></h3></span> --->
														<!--- <span class="badge badge-success p-2 text-white"><i class="far fa-thumbs-up" aria-hidden="true"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></h3></span> --->
														<!--- <span class="badge badge-danger p-2 text-white"><i class="far fa-thumbs-down" aria-hidden="true"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></h3></span> --->
														<!--- <span class="badge badge-info p-2 text-white"><i class="far fa-hourglass-half" aria-hidden="true"></i> #obj_translater.get_translate('badge_remaining_f_p')#<br><h3 class="m-0 text-capitalize"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></h3></span> --->
													<!--- </cfif> --->
													
													
												<!--- </div> --->
											<!--- </div> --->
										<!--- </div> --->
										
										</cfif>
									</div>
									</cfoutput>
									<cfelse>
									<!---- TP WITH SIMPLE METHOD --->
									
									<div class="row">
										<cfoutput>
													
										<cfif get_tp.method_id eq "6">
										<!---- TP IMMERSION --->
										
										<div class="col-md-4">
											<div class="card border-top border-info h100">
												<div class="card-body">
													<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_tp_resume')#</cfoutput></h4>
													<br><br>
													<cfinclude template="./widget/wid_tp_recap.cfm">						
													
												</div>
											</div>
										</div>
										<div class="col-md-8">
											<div class="card border-top border-info h100">
												<div class="card-body">
													
													<h4 class="card-title">Informations d&eacute;taill&eacute;es </h4>
													<br><br>
													<div class="row">						
														<div class="col-md-2">
															#obj_lms.get_tpdestination_icon(destination_id,150)#
														</div>
														<div class="col-md-10">
															<table class="table table-sm">
																<tr>
																	<td>#obj_translater.get_translate('table_th_destination')#</td>
																	<td>#destination_name#</td>
																</tr>
																<tr>
																	<td>#obj_translater.get_translate('table_th_address')#</td>
																	<td>#destination_details#</td>
																</tr>
															</table>
														</div>
													</div>
													
												</div>
											</div>
										</div>
										
										<cfelseif get_tp.method_id eq "3">
										<!---- TP ELEARNING --->
										
										<div class="col-md-4">
											<div class="card border-top border-info h100">
												<div class="card-body">
													<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_tp_resume')#</cfoutput></h4>
													<br><br>
													<cfinclude template="./widget/wid_tp_recap.cfm">
													
												</div>
											</div>
										</div>
										
										</cfif>
													
												
										</cfoutput>
									</div>
									</cfif>
									
									<cfif get_tp.method_scheduler eq "scheduler">
									<!---- TP WITH SCHEDULER METHOD --->
									
									<cfset get_session = obj_tp_get.oget_session(t_id="#get_tp.tp_id#")>
									
									<div class="row mt-3">
										<div class="col-md-12">
									
											<div class="card border h-100">
												<div class="card-body">
												
													<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_tp_details')#</cfoutput></h4>
													
														<cfoutput>
															<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
															<div class="float-right"><a href="common_learner_account.cfm?u_id=#u_id#&tab=3" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-edit"></i> EDIT</a></div>
														</cfif>
														<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
															<div class="float-right"><a href="common_tp_builder.cfm?t_id=#t_id#&u_id=#u_id#" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-edit"></i> BUILD</a></div>
															<div class="float-right"><a href="common_learner_account.cfm?u_id=#u_id#" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-edit"></i> #obj_translater.get_translate('btn_view_profile')#</a></div>
														</cfif>
														</cfoutput>
													
													<!---<div class="row">	
			
														<div class="col-md-12" align="center">

															<div class="btn-group btn-group-toggle" data-toggle="buttons">
																<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">
																<label class="btn btn-info active" onClick="document.location.href='common_tp_details.cfm'">
																	<input type="radio" autocomplete="off" checked> <i class="fas fa-tasks mr-1"></i> <cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput>
																</label>
																<label class="btn btn-info" onclick="document.location.href='learner_calendar.cfm'">
																	<input type="radio" autocomplete="off"> <i class="far fa-calendar-alt mr-1"></i> <cfoutput>#obj_translater.get_translate('card_tp_calendar')#</cfoutput>
																</label>
																<cfelse>
																<cfoutput>
																<label class="btn btn-info active" onClick="document.location.href='common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#'">
																	<input type="radio" autocomplete="off" checked> <i class="fas fa-tasks mr-1"></i> <cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput>
																</label>
																<label class="btn btn-info" onclick="document.location.href='learner_calendar.cfm?t_id=#t_id#&u_id=#u_id#'">
																	<input type="radio" autocomplete="off"> <i class="far fa-calendar-alt mr-1"></i> <cfoutput>#obj_translater.get_translate('card_tp_calendar')#</cfoutput>
																</label>
																<label class="btn btn-info" onclick="document.location.href='common_learner_account.cfm?u_id=#u_id#'">
																	<input type="radio" autocomplete="off"> <i class="fas fa-user mr-1"></i></i> <cfoutput>#obj_translater.get_translate('btn_view_profile')#</cfoutput>
																</label>
																</cfoutput>
																</cfif>
															</div>
															
														</div>
														
													</div>--->
												
													<br><br>

													<div class="accordion" id="tpgo">
													
														<cfoutput query="get_session" group="session_id">

															<cfif session_name neq "">
																<cfset format_title = "#session_name#">
															<cfelse>
																<cfset format_title = "#sessionmaster_name#">
															</cfif>
															
																<div class="mt-3 border p-2 w-100 bg-light">
																
																	<div id="heading_#session_id#" class="row">

																		<div class="col-md-3">	
																		
																			<div class="media">
																				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
																				<img src="../assets/img_material/#sessionmaster_code#.jpg" class="btn_view_session mr-2" id="s_#session_id#" width="50">
																				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
																				<img src="../assets/img_material/#sessionmaster_id#.jpg" class="btn_view_session mr-2" id="s_#session_id#" width="50">
																				<cfelse>
																				<img src="../assets/img/wefit_lesson.jpg" class="btn_view_session mr-2" id="s_#session_id#" width="50">
																				</cfif>
																				<div class="media-body">
																				<h6 class="mt-0">#__lesson#&nbsp;#session_rank# : #format_title#</h6>
																				<span class="badge badge-secondary" style="font-size:14px">#session_duration# min</span>
																				</div>
																			</div>


																		</div>
																		<div class="col-md-2">
																			<cfif get_tp.method_id eq "10" AND status_id eq "1">
																				<cfif subscribed eq 1>
																					<button class="btn btn-info btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#"> Booked</button>
																				<cfelse>
																					<button class="btn btn-success btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#"> Join class</button>
																				</cfif>
																			</cfif>
																		</div>

																		<div class="col-md-6">
																			<div class="row">
																			<cfif lesson_id neq "">
																			
																				<cfset note_id = "">
																				
																				<cfif lesson_unbookable eq "1">
																					<cfset need_book = "0">
																				<cfelse>
																					<cfset need_book = "1">
																				</cfif>
																				
																				<cfoutput group="lesson_id">
																				
																				<!-------- DONT DISPLAY CANCELLED ---->
																				<cfif status_id neq "3" AND (lesson_ghost neq "1" OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
																				<div class="col-md-6">
																					<div class="bg-white rounded border p-2 h-100">
																						<div class="row">
																							<div class="col-md-8 col-sm-12">
																								<span class="badge badge-#status_css# btn_view_lesson" id="lesson_#lesson_id#" style="cursor:pointer" title="#lesson_id#">#__lesson# #status_name#</span>
																								<br>
																								<strong>#dateformat(lesson_start,'dd/mm/yyyy')#</strong>
																								#timeformat(lesson_start,'HH:mm')#-#timeformat(lesson_end,'HH:mm')#
																								<br>
																								#__with# #planner_firstname#
																							</div>
																							<cfif status_id neq "4" AND status_id neq "3" AND status_id neq "1" AND note_id neq "">
																								<cfset note_id = note_id>
																							<!--- TEST LESSON NOT CANCELLABLE --->
																							<cfelseif status_id eq "1" AND get_tp.method_id neq "10" AND sessionmaster_id neq "769">
																							<div class="col-md-4 col-sm-12">
																								<a class="btn btn-sm btn-outline-danger btn_view_lesson float-right" role="button" data-toggle="tooltip" data-placement="top" title="#__cancel#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i></a>
																							</div>
																							</cfif>
																						</div>
																							
																					</div>
																					
																				</div>	
																				</cfif>
																				<!-------- DONT ALLOW BOOKING IF LESSON ---->
																				<cfif status_id neq "3">
																					<cfset need_book = "0">
																				</cfif>												
																				</cfoutput>
																				
																			</cfif>
																			
																			<!-------- ALLOW BOOKING IF LESSON, NOT CANCELLABLE, AND TP NOT OUTDATED, OR TP VIP ---->
																			<cfif (get_tp.tp_date_end gt now() OR get_tp.tp_vip eq "1") AND ((isdefined("need_book") AND need_book eq "1") OR lesson_id eq "")> 
																			<div class="col-md-6">
																				<div class="border rounded bg-white p-2 h-100" style="border-style: dashed !important" align="center">
																				<cfif SESSION.USER_PROFILE eq "learner">
																					<!--- <cfif sessionmaster_id eq "694" OR sessionmaster_id eq "695" OR method_id eq "2"> --->
																						<!--- <cfif get_tp.tp_status_id eq "2" OR get_tp.tp_status_id eq "10"> --->
																						<!--- <a href="##" class="btn btn-sm btn-outline-info btn_edit_calendar" href="##" disabled id="s_#session_id#_#session_duration#_#method_id#_#tp_id#"><i class="fas fa-plus-circle"></i> #__btn_book_short#</a> --->
																						<!--- </cfif> --->
																					<!--- <cfelse> --->
																						<cfif (get_tp.tp_status_id eq "2" OR get_tp.tp_status_id eq "10") and get_tp.method_id neq "10">
																						<a href="##" class="btn btn-sm btn-outline-info btn_edit_calendar" id="s_#session_id#_#session_duration#_#method_id#_#tp_id#"><i class="fas fa-plus-circle"></i> #__btn_book_short#</a>
																						<cfelseif get_tp.method_id eq "10">
																							<p>coming soon</p>
																						</cfif>
																					<!--- </cfif> --->
																				<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																					<a href="##" class="btn btn-sm btn-outline-info btn_edit_calendar" id="s_#session_id#_#session_duration#_#method_id#_#tp_id#"><i class="fas fa-plus-circle"></i> #__btn_book_short#</a>
																				<cfelseif SESSION.USER_PROFILE eq "trainer">
																					<cfif <!---sessionmaster_id eq "694" OR --->sessionmaster_id eq "695">
																						<a href="##" class="btn btn-sm btn-outline-info btn_edit_calendar" href="##" disabled id="s_#session_id#_#session_duration#_#method_id#_#tp_id#"><i class="fas fa-plus-circle"></i> #__btn_book_short#</a>
																					<cfelse>
																						<a href="##" class="btn btn-sm btn-outline-info btn_edit_calendar" id="s_#session_id#_#session_duration#_#method_id#_#tp_id#"><i class="fas fa-plus-circle"></i> #__btn_book_short#</a>
																					</cfif>
																				</cfif>
																				</div>			
																			</div>
																			</cfif>
																			</div>
																		</div>
										
																		<!------- NO DISPLAY FOR CERTIFICATION --->
																		<cfif sessionmaster_id neq "1112">
																		<div class="col-md-1">
																			<button class="btn btn-sm btn-outline-info" role="button" data-toggle="collapse" data-target="##collapse_#session_id#" aria-expanded="true" aria-controls="collapse_#session_id#">
																			<i class="fas fa-chevron-down"></i>
																			</button>
																		</div>
																		</cfif>
																		
																	</div>
																	 
																	  
																	<div class="row collapse mt-2 pt-3" id="collapse_#session_id#" aria-labelledby="heading_#session_id#" data-parent="##tpgo">
																	
																		<div class="col-md-3">
																			<div class="border-top border-info p-2 bg-white h-100">
																				<h6 class="text-info"><i class="fas fa-plus-circle"></i> #__card_tp_description#</h6>
																				<small>#sessionmaster_description#</small>
																			</div>
																		</div>
																		<div class="col-md-3">
																			<div class="border-top border-danger p-2 bg-white h-100">
																				<h6 class="text-danger"><i class="fas fa-plus-circle"></i> #__modal_supports#</h6>
																				<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
																					<a href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank" class="text-danger"><i class="fas fa-file-pdf"></i> #__modal_link_ws#</a><br>
																				</cfif>
																				<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
																					<a href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-danger"><i class="fas fa-file-pdf"></i> #__modal_link_wsk#</a><br>
																				</cfif>	
																				<cfloop from="1" to="3" index="cor">
																					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
																						<cfset video = "1">
																						<a href="./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4" target="_blank" class="text-danger"><i class="fas fa-video"></i> #__modal_link_video# #cor#</a><br>
																					</cfif>
																				</cfloop>
																				<cfloop from="1" to="3" index="cor">
																					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
																						<cfset audio = "1">
																						<a href="./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" target="_blank" class="text-danger"><i class="fas fa-volume-up"></i> #__modal_link_audio# #cor#</a><br>
																					</cfif>
																				</cfloop>	
																			</div>
																		</div>
																		<div class="col-md-2">
																			<div class="border-top border-success p-2 bg-white h-100">
																				<h6 class="text-success"><i class="fas fa-plus-circle"></i> #__card_tp_exercice#</h6>
																				
																				<cfif quiz_id neq "">
																					<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
																					SELECT qu.quiz_user_id
																					FROM lms_quiz_user qu
																					INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
																					WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
																					</cfquery>
																					
																					<cfif get_quiz_id.recordcount neq "0">
													
																						<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
																						SELECT SUM(ans_gain) as score
																						FROM lms_quiz_result
																						WHERE quiz_user_id = #get_quiz_id.quiz_user_id#
																						</cfquery>
																																						
																						<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
																						SELECT SUM(ans_gain) as quiz_score
																						FROM lms_quiz_answer a 
																						INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
																						INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
																						WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
																						</cfquery>
																						
																						<cfif get_result_score.score neq "">
																							<cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
																						<cfelse>
																							<cfset global_note = "0">
																						</cfif>

																						<cfif global_note gte 80>
																							<cfset cssgo = "success">
																						<cfelseif global_note gt 20 AND global_note lt 80>
																							<cfset cssgo = "warning">
																						<cfelseif global_note lte 20>
																							<cfset cssgo = "danger">
																						</cfif>
																					
																						<div class="row">
																							<div class="col-md-12">
																								<div align="center" class="mt-2">
																									<h5 class="m-0"><span class="badge badge-pill badge-#cssgo# text-white">Quiz : #global_note# %<!--- / #get_quiz_score.quiz_score#----></span></h5>
																								</div>
																								
																								<div align="center">
																									<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_quiz_id.quiz_user_id#"><i class="fas fa-tasks"></i> #__btn_results#</a>
																								</div>
																								
																							</div>
																						</div>
																								
																					</cfif>				
																				</cfif>
																			</div>
																		</div>
																		<cfif SESSION.LANG_CODE eq "fr">
																		<div class="col-md-2">
																			<div class="border-top border-secondary p-2 bg-white h-100">
																				<h6 class="text-secondary"><i class="fas fa-plus-circle"></i> #__card_tp_lessonnote#</h6>
																				<cfoutput group="lesson_id">																				
																				<cfif note_id neq "">
																					<a target="_blank" class="text-secondary" href="./tpl/ln_container.cfm?l_id=#lesson_id#"><i class="fas fa-file-pdf"></i> Lesson Notes</a>
																				</cfif>
																				</cfoutput>
																				
																				<cfif lesson_id neq "">
																					<cfset counter = 0>
																					<cfloop query="dirQuery">
																					<cfif findnocase("#get_session.lesson_id#_",#dirQuery.name#)>
																					<cfset counter ++>
																					<a target="_blank" class="text-secondary" href="./assets/attachment/#dirQuery.name#"><i class="fas fa-file-pdf"></i> Attachment #counter#</a><br>																					
																					</cfif>																					
																					</cfloop>
																				</cfif>
																				
																				<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND method_id eq "2">
																				<a class="btn btn-sm btn-outline-info btn_ln_upload" id="l_#lesson_id#" href="##"><i class="fas fa-file-upload" title="#__tooltip_fill_ln#"></i> #__btn_upload_notes#</a>
																				</cfif>
																				
																			</div>
																		</div>
																		</cfif>
																		<!---
																		<cfif lesson_id neq "">
																		<div class="col-md-2">
																			<div class="border-top border-warning p-2 bg-white h-100">
																				<h6 class="text-warning"><i class="fas fa-plus-circle"></i> #__card_tp_note#</h6>
																				<div align="center">
																				<a href="##" class="btn btn-sm btn-outline-warning btn_note_lesson" id="l_#lesson_id#"><i class="fad fa-star"></i> #__btn_note#</a>
																				</div>
																			</div>
																		</div>
																		</cfif>--->

																	</div>
																	

																</div>

																
														</cfoutput>
														
													</div>
														
												</div>
												
											</div>
											
										</div>
										
									</div>
									</cfif>

								</div>
								
								</cfloop>
								
							</div>


							
					
					</div>
		
				</div>
				
			</div>
      
	  
	</div>
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">


<script>
$(document).ready(function() {
	
<cfoutput>
	$('.btn_view_quiz').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})
</cfoutput>

$('.btn_join_class').click(function(event) {
		event.preventDefault();		

        $.ajax({				 
			url: './api/virtualclass/virtualclass_post.cfc?method=book_class',
			type: 'POST',
			data: {t_id: event.target.dataset.tid, l_id: event.target.dataset.lid},
			success : function(result, status){
				// console.log(result);
				// window.location.reload(true);
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
				$('#modal_body_xl').load("modal_window_tpview_tm.cfm?t_id=<cfoutput>#t_id#</cfoutput>", function() {});
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});
})
</script>

</body>
</html>
