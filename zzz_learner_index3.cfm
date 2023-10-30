<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,3,5,6,7,8,9,12">
	<cfinclude template="./incl/incl_secure.cfm">
	
	<cfif not isdefined("SESSION.PROVIDER_ID")>
		<cfquery name="get_provider_user" datasource="#SESSION.BDDSOURCE#">
		SELECT a.provider_id
		FROM user u 
		INNER JOIN account a ON a.account_id = u.account_id
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		<cfif get_provider_user.provider_id neq "">
			<cfset SESSION.PROVIDER_ID = get_provider_user.provider_id>
		<cfelse>
			<cfset SESSION.PROVIDER_ID = 1>
		</cfif>
	</cfif>

	<cfset method_list = "">
	<cfset u_id = SESSION.USER_ID>
	
	<cfif SESSION.ACCESS_VISIO eq "1">
		<cfset get_next_lesson_visio = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="1")>
		<cfset method_list = listappend(method_list,"visio")>
		<cfset get_tp_visio = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1,2,10",m_id="1")>
	</cfif>

	<cfif SESSION.ACCESS_F2F eq "1">
		<cfset get_next_lesson_f2f = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="2")>
		<cfset method_list = listappend(method_list,"f2f")>
		<cfset get_tp_f2f = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1,2,10",m_id="2")>
	</cfif>

	<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">
		<cfset get_next_lesson_virtual = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="10")>
		<cfset get_tp_virtual = obj_tp_get.oget_tps(u_id="#u_id#",st_id="2,10",m_id="10")>
		<cfif get_tp_virtual.recordcount neq "0">
			<cfset get_next_lesson_virtual_not_subscribed = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="10",tp_id="#get_tp_virtual.tp_id#")>
		</cfif>
		<cfset method_list = listappend(method_list,"virtual")>
	</cfif>

	<cfif SESSION.ACCESS_GROUP eq "1">
		<cfset get_next_lesson_group = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="11")>
		<cfset method_list = listappend(method_list,"group")>
		<cfset get_tp_group = obj_tp_get.oget_tps(u_id="#u_id#",st_id="2,10",m_id="11")>
	</cfif>

	<cfif SESSION.ACCESS_EL eq "1">
		<cfset method_list = listappend(method_list,"el")>
		<cfset get_tp_el = obj_tp_get.oget_tps(u_id="#u_id#",st_id="2,10",m_id="3")>
	</cfif>

	<cfset get_tp_certif = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1,2,3,10",m_id="7")>

	<cfif get_tp_certif.recordcount neq "0">
		<cfset SESSION.ACCESS_CERTIF = "1">
	</cfif>
		
	<cfquery name="get_quizzes" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(quiz_user_id) as nb FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	AND (q.quiz_type = "unit" OR q.quiz_type = "exercice")
	</cfquery>
	
	<cfquery name="get_mock_tests" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(quiz_user_id) as nb FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	AND (q.quiz_type like "%bright%" OR q.quiz_type like "%toeic%")
	</cfquery>

	<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = 3
	</cfquery>
	
	<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
	<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
	
	<cfset __btn_support_short = obj_translater.get_translate('btn_support_short')>
	<cfset __btn_notes_short = obj_translater.get_translate('btn_notes_short')>
	
	<cfset __btn_not_scheduled = obj_translater.get_translate('global_not_scheduled')>

	<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
	<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
	<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
	<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
	<cfset __tooltip_add_favourite = obj_translater.get_translate('tooltip_add_favourite')>
	<cfset __tooltip_remove_favourite = obj_translater.get_translate('tooltip_remove_favourite')>
	
	<cfset __card_keywords = obj_translater.get_translate('card_keywords')>
	<cfset __card_grammar = obj_translater.get_translate('card_grammar')>
	<cfset __btn_details = "Details">
	<cfset __btn_remaining_seats = obj_translater.get_translate('vc_btn_remaining_seats')>
	<cfset __btn_view_series = obj_translater.get_translate('btn_view_series')>
	<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
	<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>

	<cfset __with = obj_translater.get_translate('with')>
	<cfset __min = obj_translater.get_translate('short_minute')>
	<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>
	
</cfsilent>
	
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>
	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
		<!--- <cfset help_page = "help_index"> --->
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  	
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				Vous n'avez pas acc&egrave;s &agrave; la page demand&eacute;e, vous avez &eacute;t&eacute; redirig&eacute;(e) vers votre page d'accueil
				</div>
			</cfif>
			
			<cfif isdefined("k") AND k eq "1">
				<div class="alert alert-success" role="alert" align="center">				
				<cfoutput>#obj_translater.get_translate('alert_needs_ok')#</cfoutput>
				</div>
			<cfelseif isdefined("k") AND k eq "2">
				<div class="alert alert-success" role="alert" align="center">				
				<cfoutput>#obj_translater.get_translate('alert_mdp_change_ok')#</cfoutput>
				</div>
			<cfelseif isdefined("k") AND k eq "3">
				<div class="alert alert-success" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_thx_reading')#</cfoutput>
				</div>
			</cfif>

		

            <div class="row justify-content-center">

				<div class="col-lg-9 col-md-12">

					<div class="accordion" id="div_hp">

						<cfloop list="visio,f2f,group" index="cor">			
						<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1" OR cor eq "visio">
					
						<cfif cor eq "visio">
							<cfset card_icon = "fa-webcam">
						<cfelseif cor eq "f2f">
							<cfset card_icon = "fa-handshake">
						<cfelseif cor eq "group">
							<cfset card_icon = "fa-screen-users">
						</cfif>

						<div class="accordion-item">
							<div class="card <cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">border<cfelse>bg-light</cfif>">
							
								<div class="p-3 w-100 cursored" data-toggle="collapse" data-target="#div_<cfoutput>#cor#</cfoutput>" aria-expanded="<cfif cor eq "visio">true<cfelse>false</cfif>" aria-controls="div_<cfoutput>#cor#</cfoutput>">
									<h5 class="d-inline"><i class="fa-thin <cfoutput>#card_icon#</cfoutput> <!---<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_#cor#')#</cfoutput></strong></h5>
									<hr class="<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
								</div>

								<div id="div_<cfoutput>#cor#</cfoutput>" class="collapse <cfif cor eq "visio">show</cfif>" aria-labelledby="div_<cfoutput>#cor#</cfoutput>" data-parent="#div_hp">
									
									<div class="card-body pb-3 pt-0">

										<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">

											<cfif evaluate("get_next_lesson_#cor#").recordcount neq "0">
											
												<cfoutput query="get_next_lesson_#cor#">
													<cfset display_menu_launch = "1">
													<cfset display_tab = "Next activity">
													<cfset display_icon = "fa-forward">
													<cfinclude template="./incl/incl_session_container2.cfm">
												</cfoutput>

											<cfelse>

												<!-------------------------- NO NEXT LESSON ------------------->
												<div class="d-flex justify-content-between">

													<div class="rounded-top border-top border-left border-right border-red bg-light m-0 pt-2 pb-1 px-3">
														<strong class="text-red">
														<i class="fa-light fa-forward fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('card_learner_nextlesson')#</cfoutput>
														</strong>
													</div>
												</div>
												<div class="shadow-sm rounded-bottom border border-red m-0 w-100 bg-light" style="margin-top:-1px !important">
													<div class="card-body">
														<div align="center">
															<cfoutput>#obj_translater.get_translate('alert_visio_no_nextlesson')#</cfoutput>
														<br><br>
														<a class="btn btn-red m-0" href="./common_tp_details.cfm"><cfoutput>#ucase(obj_translater.get_translate('btn_book_short'))#</cfoutput></a>
														</div>
													</div>
												</div>

											</cfif>

										<cfelse>

											<div class="d-flex flex-column w-100 mt-2 pt-3">
												<div>
													<!--- <video controls="" width="400" poster="https://lms.wefitgroup.com/assets/user/5373/photo_video.jpg" style="max-width:400px !important">
													<source src="./assets/video/test final video marketing visio.mp4" type="video/mp4">
													</video> --->
													<img src="./assets/img/1000_F_331776223_RfSsrvsBXM1yoTfj6fZmOydtk2pl9NyR_nb.jpg" class="mr-2 float-left" width="120">
												</div>
											</div>

										</cfif>

										
									</div>

									<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">
										<div class="card-footer bg-light border-top" align="right">
		
											<cfoutput query="get_tp_#cor#">
											<cfif tp_status_id neq "3" AND tp_status_id neq "">
												<cfset get_tp_trainer = obj_tp_get.oget_tp_trainer(evaluate("get_tp_#cor#").tp_id)>
		
												<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
												<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
												<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
												<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
												<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
		
												<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
												<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
		
												<div class="d-flex justify-content-between align-items-end">
		
													<div class="d-flex">
		
														<div align="center">
															<cfloop query="get_tp_trainer">
															<img src="https://lms.wefitgroup.com/assets/user/#get_tp_trainer.planner_id#/photo.jpg" width="41" class="border_thumb mt-1 mb-1">												
															</cfloop>
															<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-1 mb-1"> 
															<br>
															<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
															#temp#	
														</div>
														
														<div align="left" class="ml-2">
															#obj_translater.get_translate("vc_legend_tp_duration")# : <strong>#(tp_duration/60)# H</strong><br>
															#obj_translater.get_translate("tooltip_hours_remain")# : <strong>#tp_remain_go/60# H</strong><br>
															#obj_translater.get_translate("card_deadline")# : <strong><cfif SESSION.PROVIDER_ID eq "2">#obj_dater.get_dateformat(tp_date_end)#<cfelse><cfif order_end neq "" AND not listFindNoCase("1000,1001,1002,1003", SESSION.ACCOUNT_ID)>#obj_dater.get_dateformat(order_end)#<cfelseif tp_date_end neq "">#obj_dater.get_dateformat(tp_date_end)#<cfelse>-</cfif></cfif></strong><br>
														</div>
		
													</div>
		
													<div align="right">
														<a class="btn btn-sm btn-outline-red m-0 mt-2" href="./common_tp_details.cfm?t_id=#tp_id#">#ucase(obj_translater.get_translate("btn_book_short"))#</a>
													</div>
		
												</div>
		
											</cfif>
											</cfoutput>
		
										</div>
										</cfif>


								</div>
							
							</div>
						</div>
						</cfif>
						</cfloop>






						<cfif SESSION.USER_TYPE_ID neq "7">

							<div class="d-flex justify-content-center pt-3" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_285426661_pRJeE3fbzajRaPaET6QwhVh9vWeTOfA3.jpg'); height:110px; background-position:center right; background-size: cover;">
      
							</div>


						<div class="accordion-item">
							<div class="card <cfif SESSION.ACCESS_VIRTUALCLASS eq "1">border<cfelse>bg-light</cfif>">
							
								<div class="p-3 w-100 cursored" data-toggle="collapse" data-target="#div_vc" aria-expanded="false" aria-controls="div_vc">
									<h5 class="d-inline"><i class="fa-thin fa-users-viewfinder <!---<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_virtual')#</cfoutput></h5>
									<hr class="<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
								</div>

								<div id="div_vc" class="collapse" aria-labelledby="div_vc" data-parent="#div_hp">

									<div class="card-body">

										<!------------------ NEXT LESSON WITH SUBSCRIPTION ----------->
										<cfif get_next_lesson_virtual.recordcount neq "0">
											<cfoutput query="get_next_lesson_virtual">
															
											<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
											SELECT COUNT(*) as nb, t.tp_max_participants
											FROM lms_lesson2_attendance la 
											INNER JOIN lms_tp t ON la.tp_id = t.tp_id 
											WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
											AND subscribed = 1
											</cfquery>
								
											<cfif count_participant.nb neq "0">
												<cfset seats_total = count_participant.tp_max_participants>
												<cfset seats_used = count_participant.nb>
												<cfset seats_remaining = seats_total-seats_used>
											<cfelse>
												<cfset seats_total = count_participant.tp_max_participants>
												<cfset seats_used = 0>
												<cfset seats_remaining = seats_total>
											</cfif>
											
											<cfset display_menu_launch = "1">
											<cfset display_tab = tp_name>
											<cfinclude template="./incl/incl_session_container2.cfm">
								
											</cfoutput>
										
										<cfelseif isdefined("get_next_lesson_virtual_not_subscribed") AND get_next_lesson_virtual_not_subscribed.recordcount neq "0">
				
											<cfoutput query="get_next_lesson_virtual_not_subscribed">
															
												<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
												SELECT COUNT(*) as nb, t.tp_max_participants
												FROM lms_lesson2_attendance la 
												INNER JOIN lms_tp t ON la.tp_id = t.tp_id 
												WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
												AND subscribed = 1
												</cfquery>
									
												<cfif count_participant.nb neq "0">
													<cfset seats_total = count_participant.tp_max_participants>
													<cfset seats_used = count_participant.nb>
													<cfset seats_remaining = seats_total-seats_used>
												<cfelse>
													<cfset seats_total = count_participant.tp_max_participants>
													<cfset seats_used = 0>
													<cfset seats_remaining = seats_total>
												</cfif>
												
												<cfset display_menu_launch = "1">
												<cfset display_tab = tp_name>
												<cfinclude template="./incl/incl_session_container2.cfm">
									
											</cfoutput>
				
										<cfelse>
											<!-------------------------- NO NEXT LESSON ------------------->
											<div class="d-flex justify-content-between">
				
												<div class="rounded-top border-top border-left border-right border-red bg-light m-0 pt-2 pb-1 px-3">
													<strong class="text-red">
													<i class="fa-light fa-forward fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('card_learner_nextlesson')#</cfoutput>
													</strong>
												</div>
											</div>
											<div class="shadow-sm rounded-bottom border border-red m-0 w-100 bg-light" style="margin-top:-1px !important">
												<div class="card-body">
													<div align="center">
														<cfoutput>#obj_translater.get_translate('alert_visio_no_nextlesson')#</cfoutput>
													<br><br>
													<a class="btn btn-red m-0" href="./common_tp_details.cfm"><cfoutput>#ucase(obj_translater.get_translate('btn_book_short'))#</cfoutput></a>
													</div>
												</div>
											</div>
				
										</cfif>
				
									</div>
									
									<cfif SESSION.ACCESS_VIRTUALCLASS eq "0">
										<div class="card-footer bg-light border-top" align="right">
											<a class="btn btn-sm btn-outline-red btn_discover_virtualclass m-0 mt-2"><cfoutput>#ucase(obj_translater.get_translate('btn_more_info'))#</cfoutput></a>
										</div>
									<cfelse>
										<div class="card-footer bg-light border-top" align="right">
											<a class="btn btn-sm btn-outline-red m-0" href="./_AD_learner_virtual.cfm"><cfoutput>#ucase(obj_translater.get_translate('vc_btn_manage_tp'))#</cfoutput></a>
										</div>
									</cfif>

								</div>
							</div>
						</div>
						</cfif>








						<cfif SESSION.USER_TYPE_ID neq "7">

							<div class="d-flex justify-content-center pt-3" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_181633090_BYItxn4t4d5hgbQNL5VKZqexfzLWJeRL.jpg'); height:110px; background-position:center right; background-size: cover;">
      
							</div>

						<div class="accordion-item">
							<div class="card <cfif SESSION.ACCESS_EL eq "1">border<cfelse>bg-light</cfif>">
							
								<div class="p-3 w-100 cursored" data-toggle="collapse" data-target="#div_el" aria-expanded="false" aria-controls="div_el">
									<h5 class="d-inline"><i class="fa-thin fa-phone-laptop <!---<cfif SESSION.ACCESS_EL eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_elearning')#</cfoutput></h5>
									<hr class="<cfif SESSION.ACCESS_EL eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
								</div>

								<div id="div_el" class="collapse" aria-labelledby="div_el" data-parent="#div_hp">

									<div class="card-body">

										<cfif SESSION.ACCESS_EL eq "1">
							
											<table class="table table-sm bg-white m-0 mt-4">
														
												<cfoutput>
												<tr>
													<td colspan="2"><i class="fal fa-history"></i> <small><cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput></small></td>
												
													<td>
														<cfif isdefined("SESSION.ACCESS_EL")>
															<cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
															#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#
															<cfelse>
															-
															</cfif>
														<cfelse>
														-
														</cfif>
													</td>
												</tr>
												<tr>
													<td colspan="2"><i class="fal fa-clock"></i> <small><cfoutput>#obj_translater.get_translate('table_th_e_program')#</cfoutput></small></td>
												
													<td>
														<cfif isdefined("SESSION.ACCESS_EL")>
															<cfif listlen(SESSION.USER_EL_LIST) eq ""> 
															-
															<cfelse>
																<cfoutput>
																<cfif listlen(SESSION.USER_EL_LIST) gt "1">
																	#listlen(SESSION.USER_EL_LIST)# #obj_translater.get_translate('el_txt_lessons')#
																<cfelse>
																	#listlen(SESSION.USER_EL_LIST)# #obj_translater.get_translate('el_txt_lesson')#
																</cfif>
																</cfoutput>
															</cfif>
														<cfelse>
														-
														</cfif>
													</td>
												</tr>
												
												<tr>
													<td colspan="2"><i class="fa fa-tasks"></i> <small><cfoutput>#obj_translater.get_translate('table_th_quizzes')#</cfoutput></small></td>
												
													<td>
														<cfif isdefined("SESSION.ACCESS_EL")>
															<cfif get_quizzes.nb eq "0">
															-
															<cfelse>
																<cfif get_quizzes.nb gt "1">
																	#get_quizzes.nb# #obj_translater.get_translate('el_txt_quizzes')#
																<cfelse>
																	#get_quizzes.nb# #obj_translater.get_translate('el_txt_quiz')#
																</cfif>
															</cfif>
														<cfelse>
														-
														</cfif>
													</td>
												</tr>
												
												<tr>
													<td colspan="2"><i class="fal fa-medal" aria-hidden="true"></i> <small><cfoutput>#obj_translater.get_translate('table_th_mock_tests')#</cfoutput></small></td>
												
													<td>
														<cfif isdefined("SESSION.ACCESS_EL")>
															<cfif get_mock_tests.nb eq "0">
															-
															<cfelse>
																<cfif get_mock_tests.nb gt "1">
																	#get_mock_tests.nb# #obj_translater.get_translate('el_txt_tests')#
																<cfelse>
																	#get_mock_tests.nb# #obj_translater.get_translate('el_txt_test')#
																</cfif>
															</cfif>
														<cfelse>
														-
														</cfif>
													</td>
												</tr>
												
												</cfoutput>
											</table>
				
				
										<cfelse>
											<div class="d-flex flex-column w-100 mt-2 pt-3">
												<div>
													<img src="./assets/img/1000_F_448389005_EvnJXIoHnnQIggYFec2kBQdjEGa0Md6H_nb.jpg" class="mr-2 float-left" width="120">
													<cfoutput>#obj_translater.get_translate('alert_hp_no_el')#</cfoutput>									
												</div>
											</div>
										</cfif>

									</div>

									<cfif SESSION.ACCESS_EL eq "1">

									<div class="card-footer bg-light border-top" align="right">
							
										<cfoutput query="get_tp_el">
											<div class="d-flex justify-content-between align-items-end">
				
												<div class="d-flex">
				
													<div align="center">
														<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-1"> 
													</div>
												
													<div class="ml-2" align="left">
														<strong>
														#method_name# #elearning_name#
														<cfif elearning_duration lt 30>
															#elearning_duration# j
														<cfelse>
															#elearning_duration/30# M
														</cfif>		
														</strong>
														<br>
														#obj_translater.get_translate("card_deadline")# : <strong><cfif tp_date_end neq "">#obj_dater.get_dateformat(tp_date_end)#</cfif></strong><br>
													</div>
				
												</div>
				
												<div>
													<a class="btn btn-sm btn-outline-red m-0" href="common_practice.cfm"><cfoutput>#ucase(obj_translater.get_translate("btn_el_access"))#</cfoutput></a>
												</div>
											</div>
										</cfoutput>
										
									</div>	
				
									<cfelse>
				
									<div class="card-footer bg-light border-top" align="right">
										<a class="btn btn-secondary btn_discover_el m-0 mt-2"><cfoutput>#obj_translater.get_translate('btn_more_info')#</cfoutput></a>
									</div>
																				
									</cfif>

								</div>
							</div>
						</div>
						</cfif>



						<cfif SESSION.USER_TYPE_ID neq "7">
						<cfif SESSION.ACCESS_CERTIF eq "1">
						<div class="accordion-item">
							<div class="card <cfif SESSION.ACCESS_CERTIF eq "1">border<cfelse>bg-light</cfif>">
							
								<div class="p-3 w-100 cursored" data-toggle="collapse" data-target="#div_certif" aria-expanded="false" aria-controls="div_certif">
									<h5 class="d-inline"><i class="fa-thin fa-file-certificate <!---<cfif SESSION.ACCESS_CERTIF eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_certif')#</cfoutput></h5>
									<hr class="<cfif SESSION.ACCESS_CERTIF eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
								</div>

								<div id="div_certif" class="collapse" aria-labelledby="div_certif" data-parent="#div_hp">

									<div class="card-body">

										Vous disposez d'un abonnement eLearning ?
										<br>
										N'hésitez pas à vous entraîner pour optimiser votre score
										<br><br>
										<a class="btn btn-sm btn-outline-red m-0" href="common_practice.cfm">ACCÈS E-LEARNING</a>
										
									</div>

									<cfif SESSION.ACCESS_CERTIF eq "1">

										<div class="card-footer bg-light border-top" align="right">
						
											<cfoutput query="get_tp_certif">
												<div class="d-flex justify-content-between align-items-end">
				
													<div class="d-flex">
				
														<div align="center">
															<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-1"> 
														</div>
													
														<div class="ml-2" align="left">
															<strong>#certif_name#</strong>
															<br>
															#obj_translater.get_translate('short_between')#
															#obj_function.get_dateformat('#tp_date_start#')#
															#lcase(obj_translater.get_translate('short_and'))#
															#obj_function.get_dateformat('#tp_date_end#')#
															<!--- <br>
															Fin d'abonnement : <strong> 30/12/2022</strong><br> --->
														</div>
				
													</div>
				
													<div>
														<!--- <a class="btn btn-sm btn-outline-red m-0" href="common_practice.cfm"><cfoutput>#ucase(obj_translater.get_translate("btn_el_access"))#</cfoutput></a> --->
													</div>
												</div>
											</cfoutput>
											
										</div>	
				
									<cfelse>
				
										<div class="card-footer pt-0" align="right">
											<a class="btn btn-secondary btn_discover_certif m-0 mt-2"><cfoutput>#obj_translater.get_translate('btn_more_info')#</cfoutput></a>
										</div>
				
									</cfif>

								</div>

							</div>
						</div>
						</cfif>
						</cfif>





					</div>
				</div>
			</div>

				
		</div>				
			
		
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
   
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<cfinclude template="./incl/incl_scripts_lesson.cfm">
	
<script>

$(document).ready(function() {

	<!---<cfif not isdefined("SESSION.ALERT_WELCOME")>--->

		$(document).ready(function() {
			$('#window_item_lg').modal({keyboard: false,backdrop:'static'});
			$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('title_page_trainer_index')#</cfoutput>");		
			$('#modal_body_lg').load("modal_window_info.cfm?show_info=welcome_vc", function() {});
		});

	<!---</cfif>--->

	$('.btn_view_tp').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];	
        $('#modal_body_xl').empty();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=hp&tp_id="+tp_id, function() {});
	});

	$('.btn_discover_virtualclass').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		// $('#modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");	
		$('#modal_title_lg').text("Activate your Virtual Classroom !");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_virtualclass");
	});

	$('.btn_discover_certif').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		// $('#modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");	
		$('#modal_title_lg').text("En savoir plus sur les certifs");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_certif");
	});

	$('.btn_discover_el').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		// $('#modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");	
		$('#modal_title_lg').text("En savoir plus sur le parcours eLearning");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_el");
	});

	$('.btn_discover_visio').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		// $('#modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");	
		$('#modal_title_lg').text("En savoir plus sur l'abonnement Visio");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_visio");
	});

	
});
</script>
</body>
</html>

