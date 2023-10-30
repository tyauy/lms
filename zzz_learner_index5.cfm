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
	  	
			<!--- <div class="d-flex justify-content-center pt-3 rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_331776223_RfSsrvsBXM1yoTfj6fZmOydtk2pl9NyR.jpg'); height:150px; background-position:center right; background-size: cover;">
                <!--- <h2 class="text-white">Hello world</h2> --->
            </div> --->

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

		<div class="row">

			<!--- <div class="col-lg-4 col-md-6 mb-3">
				<!--- <cfoutput>#SESSION.LAUNCH_NO_TP_AV#</cfoutput> --->
				<div class="card h-100 <cfif SESSION.ACCESS_NEXT eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="w-100">
							<h5 class="d-inline <!---<cfif SESSION.ACCESS_NEXT eq "1">text-red</cfif>--->"><i class="fa-thin fa-rocket-launch <!---<cfif SESSION.ACCESS_NEXT eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_next_activity')#</cfoutput></h5>
							<hr class="<cfif SESSION.ACCESS_NEXT eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
						</div>

						<cfif SESSION.ACCESS_NEXT eq "1">

							<cfloop list="#method_list#" index="cor">
								<cfif isdefined("get_next_lesson_#cor#") AND evaluate("get_next_lesson_#cor#").recordcount neq "0">
									
									<cfoutput query="get_next_lesson_#cor#">
									
									<div class="card border bg-light mt-3">
										<div class="card-body">
											<div class="d-flex">
												<div>
													<img src="./assets/user/#planner_id#/photo.jpg" class="border_thumb" width="80">
												</div>
												<div class="pl-2 w-100">
													#obj_translater.get_translate('short_meet')# <span class="badge badge-pill border border-dark bg-white px-2 py-2">#user_firstname#</span>
													<br>
													#obj_translater.get_translate('short_on')# <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2">#dateformat(lesson_start,'dd/mm/yyyy')#</span> #obj_translater.get_translate('short_at')# <span class="badge badge-pill border border-dark bg-white px-2 py-2">#timeformat(lesson_start,'HH:mm')#</span>
													<br>
													#obj_translater.get_translate('for')# <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2">#method_name#</span>
													
													<cfif method_id eq "10">

														<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#" result="data">
														SELECT COUNT(*) as nb, t.tp_max_participants as max
														FROM lms_lesson2_attendance la 
														LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
														WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
														AND subscribed = 1
														</cfquery>

														<br>
														#obj_translater.get_translate('vc_card_attendance')#
														<!--- title="<cfif count_participant.max eq ''>0<cfelse>#count_participant.nb# inscrit</cfif> / #get_tp_virtual.tp_max_participants# au total" --->
														<span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2" data-toggle="tooltip" data-placement="top" >
														<i class="fa-light fa-users"></i>
														<cfif count_participant.max eq "">0<cfelse>#count_participant.nb#</cfif> / #get_tp_virtual.tp_max_participants#
														</span>

														<div class="d-flex justify-content-end">

															<cfif subscribed eq 1>
																<button class="btn btn-sm btn-outline-red m-0 mt-2 btn_join_class" data-tid="#get_tp_virtual.tp_id#" data-lid="#lesson_id#" id="l_#get_tp_virtual.tp_id#_#lesson_id#">
																	#obj_translater.get_translate('vc_btn_cancel_attendance')#
																</button>
																
																<a class="btn btn-red btn_launch_lesson m-0 mt-2 ml-2" id="l_#lesson_id#" href="##">#obj_translater.get_translate('btn_launch_lesson')#</a>
					
															<cfelse>
																<button class="btn btn-red mb-0 mt-2 btn_join_class" <cfif count_participant.nb gte get_tp_virtual.tp_max_participants>disabled</cfif> data-tid="#get_tp_virtual.tp_id#" data-lid="#lesson_id#" id="l_#get_tp_virtual.tp_id#_#lesson_id#">
																	#obj_translater.get_translate('vc_btn_confirm_attendance')#
																</button>
															</cfif>

														</div>

													<cfelse>

														<div align="right" class="clearfix"><a class="btn btn-red btn_launch_lesson m-0 mt-2" id="l_#lesson_id#" href="##">#obj_translater.get_translate('btn_launch_lesson')#</a></div>
												
													</cfif>	
												
												</div>
											</div>
										</div>
									</div>
									
									</cfoutput>

								</cfif>
							</cfloop>

						<cfelse>

							<div class="d-flex flex-column w-100 mt-2 pt-3">
								<div align="center">
									<cfoutput>#obj_translater.get_translate('alert_no_planned')#</cfoutput>
								</div>
							</div>

						</cfif>
						
					</div>
				
				</div>

			</div> --->


			<cfloop list="visio,f2f,group" index="cor">			
			<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1" OR cor eq "visio">
		
			<cfif cor eq "visio">
				<cfset card_icon = "fa-webcam">
			<cfelseif cor eq "f2f">
				<cfset card_icon = "fa-handshake">
			<cfelseif cor eq "group">
				<cfset card_icon = "fa-screen-users">
			</cfif>

			<div class="col-lg-6 col-md-6 mb-3">
				<div class="d-flex justify-content-center pt-3" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_181633090_BYItxn4t4d5hgbQNL5VKZqexfzLWJeRL.jpg'); height:90px; background-position:center right; background-size: cover;">
      
				</div>

				<div class="card h-100 <cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body pb-0">

						<div class="w-100 mb-3">
							<h5 class="d-inline"><!---<i class="fa-thin <cfoutput>#card_icon#</cfoutput> fa-lg mr-1"></i>---> <cfoutput>#obj_translater.get_translate('card_title_#cor#')#</cfoutput></strong></h5>
							<hr class="<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
						</div>

						<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">
							<!--- <cfdump var="#get_next_lesson_visio#"> --->
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
			</cfif>
			</cfloop>
							<!--- <div class="p-2 mt-3">
							<strong class="text-red">
							<i class="fa-light fa-forward fa-lg mr-1 text-red"></i> Next lesson
							</strong>
							</div> --->

                            <!--- <div class="card border bg-light">
                                
                                <div class="card-body">
                                    <div class="d-flex">
                                        <div>
                                            <img src="./assets/user/#planner_id#/photo.jpg" class="border_thumb" width="80">
                                        </div>
                                        <div class="pl-2 w-100">
                                            #obj_translater.get_translate('short_meet')# <span class="badge badge-pill border border-dark bg-white px-2 py-2">#user_firstname#</span>
                                            <br>
                                            #obj_translater.get_translate('short_on')# <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2">#dateformat(lesson_start,'dd/mm/yyyy')#</span> #obj_translater.get_translate('short_at')# <span class="badge badge-pill border border-dark bg-white px-2 py-2">#timeformat(lesson_start,'HH:mm')#</span>
                                            <br>
                                            #obj_translater.get_translate('for')# <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2">#method_name#</span>
                                            
                                            <!--- <cfif method_id eq "10">
                
                                                <cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#" result="data">
                                                SELECT COUNT(*) as nb, t.tp_max_participants as max
                                                FROM lms_lesson2_attendance la 
                                                LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
                                                WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
                                                AND subscribed = 1
                                                </cfquery>
                
                                                <br>
                                                #obj_translater.get_translate('vc_card_attendance')#
                                                <!--- title="<cfif count_participant.max eq ''>0<cfelse>#count_participant.nb# inscrit</cfif> / #get_tp_virtual.tp_max_participants# au total" --->
                                                <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2" data-toggle="tooltip" data-placement="top" >
                                                <i class="fa-light fa-users"></i>
                                                <cfif count_participant.max eq "">0<cfelse>#count_participant.nb#</cfif> / #get_tp_virtual.tp_max_participants#
                                                </span>
                
                                                <div class="d-flex justify-content-end">
                
                                                    <cfif subscribed eq 1>
                                                        <button class="btn btn-sm btn-outline-red m-0 mt-2 btn_join_class" data-tid="#get_tp_virtual.tp_id#" data-lid="#lesson_id#" id="l_#get_tp_virtual.tp_id#_#lesson_id#">
                                                            #obj_translater.get_translate('vc_btn_cancel_attendance')#
                                                        </button>
                                                        
                                                        <a class="btn btn-red btn_launch_lesson m-0 mt-2 ml-2" id="l_#lesson_id#" href="##">#obj_translater.get_translate('btn_launch_lesson')#</a>
                
                                                    <cfelse>
                                                        <button class="btn btn-red mb-0 mt-2 btn_join_class" <cfif count_participant.nb gte get_tp_virtual.tp_max_participants>disabled</cfif> data-tid="#get_tp_virtual.tp_id#" data-lid="#lesson_id#" id="l_#get_tp_virtual.tp_id#_#lesson_id#">
                                                            #obj_translater.get_translate('vc_btn_confirm_attendance')#
                                                        </button>
                                                    </cfif>
                
                                                </div>
                
                                            <cfelse>
                
                                                <div align="right" class="clearfix"><a class="btn btn-red btn_launch_lesson m-0 mt-2" id="l_#lesson_id#" href="##">#obj_translater.get_translate('btn_launch_lesson')#</a></div>
                                        
                                            </cfif>	 --->
                                        
                                        </div>
                                    </div>
                                </div>
                            </div> --->
                
                            
                            
							
							
							

						
					
					

					


					<!--- <cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "0">
						<div class="card-footer pt-0" align="right">
							<a class="btn btn-secondary btn_discover_visio m-0 mt-2"><cfoutput>#obj_translater.get_translate('btn_more_info')#</cfoutput></a>
						</div>
					</cfif> --->

				

			<cfif SESSION.USER_TYPE_ID neq "7">
			<div class="col-lg-6 col-md-6 mb-3">

				<div class="d-flex justify-content-center pt-3" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_285426661_pRJeE3fbzajRaPaET6QwhVh9vWeTOfA3.jpg'); height:90px; background-position:center right; background-size: cover;">
      
				</div>

				<div class="card h-100 <cfif SESSION.ACCESS_VIRTUALCLASS eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="w-100 mb-3">
							<h5 class="d-inline <!---<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">text-red</cfif>--->"><i class="fa-thin fa-users-viewfinder <!---<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_virtual')#</cfoutput></h5>
							<hr class="<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
						</div>

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
						

						<!--- <cfif SESSION.ACCESS_VIRTUALCLASS eq "1">
							<cfif get_tp_virtual.recordcount lte "3" AND get_tp_virtual.recordcount gt 0>
							<cfloop query="get_tp_virtual">

								<cfset get_tp_trainer = obj_tp_get.oget_tp_trainer(get_tp_virtual.tp_id)>
								<cfset get_next_lesson = obj_tp_get.oget_next_lesson(u_id="#SESSION.USER_ID#",m_id="10",tp_id="#tp_id#")>

								<cfoutput>

								<div class="card border bg-light m-0 mt-3">
									<div class="card-body">
										
										<div class="d-flex">

											<div>
												<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-2"> 
												<img src="./assets/img_level/#tplevel_alias#.svg" width="40" class="mt-2">
												<img src="https://lms.wefitgroup.com/assets/user/#get_tp_trainer.planner_id#/photo.jpg" width="41" class="border_thumb mt-1">												
											</div>

											<div class="ml-2">
												<cfif get_next_lesson.recordcount neq "0">
												<strong> #tp_name#</strong>
												<br>
												<a role="button" class="text-red m-0 mt-2 btn_view_tp" id="tp_#tp_id#">[#obj_translater.get_translate('vc_btn_details_tp')#]</a>

												<br>
												
												<br>#obj_translater.get_translate('vc_card_next_lesson')# : #dateformat(get_next_lesson.lesson_start,'dd/mm/yyyy')# #obj_translater.get_translate('short_at')# #timeformat(get_next_lesson.lesson_start,'HH:mm')#

												<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#" result="data">
												SELECT COUNT(*) as nb, t.tp_max_participants as max
												FROM lms_lesson2_attendance la 
												LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
												WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next_lesson.lesson_id#"> 
												AND subscribed = 1
												</cfquery>
												<br>
												<cfif get_next_lesson.subscribed eq 1>
													<a role="button" class="text-red m-0 mt-2 btn_join_class" data-tid="#get_next_lesson.tp_id#" data-lid="#get_next_lesson.lesson_id#" id="lesson_#get_next_lesson.tp_id#_#get_next_lesson.lesson_id#">
													[#obj_translater.get_translate('vc_btn_cancel_attendance')#]
													</a>
													
												<cfelse>
													<a role="button" class="text-red mb-0 mt-2 btn_join_class" <cfif count_participant.nb eq count_participant.max>disabled</cfif> data-tid="#get_next_lesson.tp_id#" data-lid="#get_next_lesson.lesson_id#" id="lesson_#get_next_lesson.tp_id#_#get_next_lesson.lesson_id#">
														<i class="fa-sharp fa-solid fa-circle-exclamation"></i> [#obj_translater.get_translate('vc_btn_confirm_attendance')#]
													</a>
												</cfif>
												</cfif>
											</div>

										</div>

									</div>
								</div>
								</cfoutput>
							</cfloop>

							<cfelseif get_tp_virtual.recordcount gt "3">

								<div class="card border bg-light m-0 mt-3">
									<div class="card-body">
										
										<div class="d-flex">
											
											<cfoutput>#obj_translater.get_translate('title_page_common_tp_details')# :</cfoutput>
											<cfoutput>#get_tp_virtual.recordcount# </cfoutput>

										</div>

									</div>
								</div>

							<cfelse>
								<cfoutput>#obj_translater.get_translate('vc_no_tpfollow')#</cfoutput>
							</cfif>

						<cfelse>
			
							<div class="d-flex flex-column w-100 mt-2 pt-3">
								<div>
									<img src="./assets/img/method_virtualclass_nb.jpg" class="mr-2 float-left" width="120">
									<cfoutput>#obj_translater.get_translate('vc_no_tpfollow')#</cfoutput>
								</div>
							</div>

						</cfif> --->

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
			</cfif>
				
			
			<cfif SESSION.USER_TYPE_ID neq "7">
			<div class="col-lg-6 col-md-6 mb-3">
				
				<div class="card h-100 <cfif SESSION.ACCESS_EL eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="w-100">
							<h5 class="d-inline"><i class="fa-thin fa-phone-laptop <!---<cfif SESSION.ACCESS_EL eq "1">text-red</cfif>---> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_elearning')#</cfoutput></h5>
							<!--- <hr class="<cfif SESSION.ACCESS_EL eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2"> --->
							<hr class="border-top border-red mb-1 mt-2">
						</div>

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
			</cfif>


			<!--- <div class="col-lg-4 col-md-6 mb-3">
				<div class="card h-100 border">
					<div class="card-body">
						
						<div class="w-100">
							<h5 class="d-inline"><i class="fa-thin fa-address-card fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_account')#</cfoutput></h5>
							<hr class="border-red mb-1 mt-2">
						</div>

						<div class="card border bg-light m-0 mt-3">
							<div class="card-body">
								<div class="d-flex">
									<!---<div>
										<!---<cfoutput>#obj_lms.get_thumb(user_id="#SESSION.USER_ID#",size="40",css="border_thumb")#</cfoutput>--->
										<!--- <img src="./assets/img/unknown_male.png" class="border_thumb mr-3" width="40"> --->
									</div>--->
									<div class="w-100">
												
										<cfoutput>
										<span class="lead"><strong>#SESSION.USER_NAME#</strong></span>
										<br>
										
											<cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput> :
											<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#<cfelse>-</cfif></span>
											<br>
											<!--- <cfoutput>#obj_translater.get_translate('table_th_notifications')#</cfoutput>
											<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1">H-24</span>
											<br> --->
											<cfoutput>#obj_translater.get_translate('profile')#</cfoutput> :
											<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfoutput>#SESSION.USER_PROFILE#</cfoutput></span>
											<br>
											<cfoutput>#obj_translater.get_translate('table_th_creation')# :</cfoutput>
											<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfoutput><cfif SESSION.USER_CREATE neq "">#obj_function.get_dateformat(SESSION.USER_CREATE)#<cfelse>N/A</cfif></cfoutput></span>
											
											<!----------------- REMOVE FOR PARTNER LEARNER -------------------->
											<cfif SESSION.USER_TYPE_ID neq "7">
											<br>
											<cfoutput>#obj_translater.get_translate('card_learner_lst')# :</cfoutput>
											<cfif get_result_lst.recordcount eq "0">
												<a href="quiz_start.cfm?t=lst" class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfoutput>#obj_translater.get_translate('title_page_quiz_lst')#</cfoutput></a>
											<cfelse>
												<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
													<cfoutput><a href="##" target="_blank" class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_lst.quiz_user_id#">#obj_translater.get_translate('title_page_quiz_lst')#</a></cfoutput>
												<cfelseif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end eq "">
													<cfoutput><a href="./quiz.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&f=go" target="_blank" class="btn rounded btn-sm btn-outline-red">#obj_translater.get_translate('title_page_quiz_lst')#</a></cfoutput>
												</cfif> 
											</cfif> 
											</cfif>

											
										<!--- <table class="table table-sm m-0">
											<tr>
												<td><cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput></td>
												<td><span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#<cfelse>-</cfif></span></td>
											</tr>
											<tr>
												<td><cfoutput>#obj_translater.get_translate('table_th_notifications')#</cfoutput></td>
												<td><span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1">H-24</span></td>
											</tr>
											<tr>
												<td><cfoutput>#obj_translater.get_translate('profile')#</cfoutput></td>
												<td><span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-1"><cfoutput>#SESSION.USER_PROFILE#</cfoutput></span></td>
											</tr>
										</table> --->
										</cfoutput>
													
									</div>
								</div>
							</div>
						</div>
									
					</div>
					<div class="card-footer pt-0" align="right">
						<a class="btn btn-outline-red m-0 mt-2" href="./common_learner_account.cfm"><cfoutput>#ucase(obj_translater.get_translate("sidemenu_learner_account"))#</cfoutput></a>
					</div>
				</div>

			</div>	 --->
			
			

			
			<cfif SESSION.USER_TYPE_ID neq "7">
			<cfif SESSION.ACCESS_CERTIF eq "1">
			<div class="col-lg-6 col-md-6 mb-3">
				   

				<div class="card h-100 <cfif SESSION.ACCESS_CERTIF eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="w-100">
							<h5 class="d-inline"><i class="fa-thin fa-file-certificate <cfif SESSION.ACCESS_CERTIF eq "1">text-secondary</cfif> fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_title_certif')#</cfoutput></h5>
							<hr class="<cfif SESSION.ACCESS_CERTIF eq "1">border-red<cfelse>border-top</cfif> mb-1 mt-2">
						</div>

						<div align="center" class="mt-4">
							Vous disposez d'un abonnement eLearning ?
							<br>
							N'hésitez pas à vous entraîner pour optimiser votre score
							<br><br>
							<a class="btn btn-sm btn-outline-red m-0" href="common_practice.cfm">ACCÈS E-LEARNING</a>
						</div>

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

					<!--- <div class="d-flex flex-column w-100 mt-2 pt-3">
						<div>
							<img src="./assets/img/1000_F_499587977_74icudwrqPqxF26K5U7O9weC1AAnq93g_nb.jpg" class="mr-2 float-left" width="120">
							<cfoutput>#obj_translater.get_translate('alert_hp_no_certif')#</cfoutput>
						</div>
					</div> --->


				</div>
				
			</div>
			</cfif>
			</cfif>
									
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

