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
		<cfset get_next_lesson_virtual = obj_tp_get.oget_next_lesson(u_id="#u_id#",m_id="10",subscribed="1")>
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

	<cfset get_tp_certif = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1,2,6,10",m_id="7")>

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
	
	<!--- <cfset SESSION.ACCESS_F2F = 0>
	<cfset SESSION.ACCESS_GROUP = 0> --->

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
      
		<cfset title_page = "*WEFIT LMS*">
		<!--- <cfset help_page = "help_index"> --->
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfinclude template="./incl/incl_nav_hp.cfm">
	  	
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

		<div class="row mt-3">

			<!--------------------- VISIO / F2F / GROUP BOX, VISIO ALWAYS VISIBLE-------------------->
			<cfloop list="visio,f2f,group" index="cor">			
			<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1" OR cor eq "visio">

			<div class="col-lg-6 col-md-6 col-sm-6 mb-3">
				
				<div class="card h-100 <cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body pb-0">

						<div class="d-flex justify-content-between">
							<!---<div>
								<img class="mr-3 img_rounded" src="./assets/img/thumb_long_1.jpg" width="90">
							</div>--->
							<div align="left">
								<h5  class="mb-0">
									<cfoutput>#obj_translater.get_translate("card_title_#cor#")#</cfoutput>
								</h5>
							</div>
							
						</div>

						<hr class="border-top border-red mb-3 mt-2">

						<cfif evaluate("SESSION.ACCESS_#ucase(cor)#") eq "1">

							<div>
							
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
	
								<div class="d-flex justify-content-between align-items-end bg-light border p-2 mb-3">
	
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
										<a class="btn btn-sm btn-outline-red m-0 mt-2" href="./common_tp_details.cfm?t_id=#tp_id#">
											<!--- <i class="fa-solid fa-arrow-right"></i> --->
										#ucase(obj_translater.get_translate("global_details"))#</a>
									</div>
	
								</div>
	
							</cfif>
							</cfoutput>
							</div>
	

								<!-------------------------- NEXT LESSON ------------------->
								<cfif evaluate("get_next_lesson_#cor#").recordcount neq "0">
								
									<cfoutput query="get_next_lesson_#cor#">
										<cfset display_menu_launch = "1">
										<cfset display_tab = "Next activity">
										<cfset display_icon = "fa-forward">
										<!--- #lesson_id# --->
										<cfinclude template="./incl/incl_session_container.cfm">
									</cfoutput>

								<cfelse>

									<!-------------------------- NO NEXT LESSON ------------------->
									<div class="d-flex justify-content-between">

										<div class="rounded-top border-top border-left border-right <!---border-info---> bg-light m-0 pt-2 pb-1 px-3">
											<strong class="text-dark">
											<i class="fa-light fa-forward fa-lg mr-1 text-dark"></i> <cfoutput>#obj_translater.get_translate('card_learner_nextlesson')#</cfoutput>
											</strong>
										</div>
									</div>
									<div class="shadow-sm rounded-bottom border <!---border-info---> m-0 w-100 bg-light" style="margin-top:-1px !important">
										<div class="card-body">
											<div align="center">
												<cfoutput>#obj_translater.get_translate('alert_visio_no_nextlesson')#</cfoutput>
											<br><br>
											<a class="btn btn-red m-0" href="./common_tp_details.cfm"><cfoutput>#ucase(obj_translater.get_translate('btn_book_short'))#</cfoutput></a>
											</div>
										</div>
									</div>

								</cfif>

							<!-------------------------- NO VISIO TP ------------------->
							<cfelse>

								<div align="center">
									<cfoutput>#obj_translater.get_translate('alert_hp_no_visio')#</cfoutput>
									<br>
									<a class="btn btn-sm btn-outline-red m-0 mt-2 btn_contact_wefit"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
								</div>	

							</cfif>
				
					</div>

				</div>
			</div>
			</cfif>
			</cfloop>
							
				

			<!-------------- VIRTUAL CLASSROOM BOX, EXCEPT FOR PARTNERS -------------->
			<cfif SESSION.USER_TYPE_ID neq "7">
			<div class="col-lg-6 col-md-6 col-sm-6 mb-3">

				<div class="card h-100 <cfif SESSION.ACCESS_VIRTUALCLASS eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="d-flex justify-content-between align-items-center">
							<!---<div>
								<img class="mr-3 img_rounded" src="./assets/img/thumb_long_8.jpg" width="90">
							</div>--->
							<div align="left">
								<h5 class="mb-0">
									<cfoutput>#obj_translater.get_translate("card_title_virtual")#</cfoutput>
								</h5>
							</div>
							
						</div>

						<hr class="border-top border-red mb-3 mt-2">

						<cfif SESSION.ACCESS_VIRTUALCLASS eq "1">

							<cfoutput query="get_tp_el">
								<div class="d-flex justify-content-between align-items-end bg-light border p-2 mb-3">
									<div class="d-flex">
										<div align="center">
											<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-1"> 
										</div>
										<div class="ml-2" align="left">
											<strong>
											<!--- #method_name# #elearning_name# --->
											Virtual Class
											<!--- <cfif elearning_duration lt 30>
												#elearning_duration# j
											<cfelse>
												#elearning_duration/30# M
											</cfif>		 --->
											</strong>
											<br>
											#obj_translater.get_translate("card_deadline")# : <strong><cfif tp_date_end neq "">#obj_dater.get_dateformat(tp_date_end)#</cfif></strong><br>
										</div>
									</div>
									<cfif elearning_id eq "1">
									<div align="right">
										<a class="btn btn-sm btn-outline-red m-0 mt-2" href="./learner_virtual.cfm?f_id=#formation_id#">
										#obj_translater.get_translate('vc_btn_manage_tp')#
										</a>
									</div>
									</cfif>
								</div>
							</cfoutput>

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
								<cfinclude template="./incl/incl_session_container.cfm">
					
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
									<cfinclude template="./incl/incl_session_container.cfm">
						
									</cfoutput>



							<cfelse>
								<!-------------------------- NO NEXT LESSON ------------------->
								<div class="d-flex justify-content-between">

									<div class="rounded-top border-top border-left border-right border-top bg-light m-0 pt-2 pb-1 px-3">
										<strong class="text-red">
										<i class="fa-light fa-forward fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('card_learner_nextlesson')#</cfoutput>
										</strong>
									</div>
								</div>
								<div class="shadow-sm rounded-bottom border border-top m-0 w-100 bg-light" style="margin-top:-1px !important">
									<div class="card-body">
										<div align="center">
											<cfoutput>#obj_translater.get_translate('alert_vc_no_nextlesson')#</cfoutput>
										<br><br>
										<a class="btn btn-red m-0" href="./learner_virtual.cfm"><cfoutput>#ucase(obj_translater.get_translate('btn_book_short'))#</cfoutput></a>
										</div>
									</div>
								</div>


							</cfif>


						<cfelse>

							<div align="center">
								<cfoutput>#obj_translater.get_translate('vc_no_tpfollow')#</cfoutput>
								<br>
								<a class="btn btn-sm btn-outline-red btn_discover_virtualclass m-0 mt-2"><cfoutput>#ucase(obj_translater.get_translate('btn_more_info'))#</cfoutput></a>
								<a class="btn btn-sm btn-red m-0 mt-2 btn_contact_wefit"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
							</div>	
							
						</cfif>
						
					</div>
					

				</div>

			</div>
			</cfif>
				
			

			<!-------------- ELEARNING BOX, EXCEPT FOR PARTNERS -------------->
			<cfif SESSION.USER_TYPE_ID neq "7">
			<div class="col-lg-6 col-md-6 col-sm-6 mb-3">
				
				<div class="card h-100 <cfif SESSION.ACCESS_EL eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="d-flex justify-content-between align-items-center">
							<!---<div>
								<img class="mr-3 img_rounded" src="./assets/img/thumb_long_9.jpg" width="90">
							</div>--->
							<div align="left">
								<h5 class="mb-0">
									<cfoutput>#obj_translater.get_translate("card_title_elearning")#</cfoutput>
								</h5>
							</div>
						</div>

						<hr class="border-top border-red mb-3 mt-2">

						<cfif SESSION.ACCESS_EL eq "1">

							<cfoutput query="get_tp_el">
								<div class="d-flex justify-content-between align-items-end bg-light border p-2 mb-3">
									<div class="d-flex">
										<div align="center">
											<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mt-1"> 
										</div>
										<div class="ml-2" align="left">
											<strong>
											#method_name# #elearning_name#
											<!--- <cfif elearning_duration lt 30>
												#elearning_duration# j
											<cfelse>
												#elearning_duration/30# M
											</cfif>		 --->
											</strong>
											<br>
											#obj_translater.get_translate("card_deadline")# : <strong><cfif tp_date_end neq "">#obj_dater.get_dateformat(tp_date_end)#</cfif></strong><br>
										</div>
									</div>
									<cfif elearning_id eq "1">
									<div align="right">
										<a class="btn btn-sm btn-outline-red m-0 mt-2" <cfif #formation_id# eq "2">href="./el_dashboard.cfm"<cfelse>href="./common_practice.cfm"</cfif>>
											#obj_translater.get_translate('btn_el_access')#
										</a>
									</div>
									</cfif>
								</div>
							</cfoutput>


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

							<div align="center">
								<cfoutput>#obj_translater.get_translate('alert_hp_no_el')#</cfoutput>
								<br>
								<a class="btn btn-sm btn-red m-0 mt-2 btn_contact_wefit"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
							</div>	
							
						</cfif>
						
					</div>

				</div>

			</div>
			</cfif>
			

			<!-------------- CERTIF BOX, EXCEPT FOR PARTNERS -------------->
			<cfif SESSION.USER_TYPE_ID neq "7">
			<div class="col-lg-6 col-md-6 col-sm-6 mb-3">
				
				<div class="card h-100 <cfif SESSION.ACCESS_CERTIF eq "1">border<cfelse>bg-light</cfif>">
					<div class="card-body">

						<div class="d-flex justify-content-between align-items-center">
							<!---<div>
								<img class="mr-3 img_rounded" src="./assets/img/thumb_long_6.jpg" width="90">
							</div>--->
							<div align="left">
								<h5 class="mb-0">
									<cfoutput>#obj_translater.get_translate("card_title_certif")#</cfoutput>
								</h5>
							</div>
							<div>
								<cfif SESSION.ACCESS_CERTIF eq "1">
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
												<!--- <a class="btn btn-sm btn-outline-info m-0" href="common_practice.cfm"><cfoutput>#ucase(obj_translater.get_translate("btn_el_access"))#</cfoutput></a> --->
											</div>
										</div>
									</cfoutput>
								</cfif>
							</div>
						</div>

						<hr class="border-top border-red mb-3 mt-2">

						<!---<div align="center" class="mt-4">
							<cfoutput>#obj_translater.get_translate_complex('alert_hp_certif_el')#</cfoutput>
							<br><br>
							<a class="btn btn-sm btn-outline-info m-0" href="el_dashboard.cfm">ACCÈS E-LEARNING</a>
						</div> --->

						<cfif SESSION.ACCESS_CERTIF eq "1">
							<div align="center">
							<!---<cfoutput>#obj_translater.get_translate_complex('alert_hp_certif_el')#</cfoutput>
							<br>--->
							<cfif SESSION.ACCESS_EL eq "1">
							<a class="btn btn-sm btn-outline-red m-0 mt-2" href="el_dashboard.cfm"><cfoutput>#obj_translater.get_translate('btn_el_access')#</cfoutput></a>
							</cfif>
							</div>	
						<cfelse>

							<div align="center">
								<cfoutput>#obj_translater.get_translate('alert_hp_no_certif')#</cfoutput>
								<br><br>
								<cfif SESSION.PROVIDER_ID neq "2">
									<a class="btn btn-sm btn-outline-red m-0 mt-2" target="_blank" href="https://formation.wefitgroup.com">WEFIT SHOP</a>
								</cfif>
								<a class="btn btn-sm btn-red m-0 mt-2 ml-2 btn_contact_wefit"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
							</div>	
								
							
						</cfif>

					</div>

				</div>
				
			</div>
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

	<cfif SESSION.USER_PROFILE eq "TEST" AND isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "1">

		<cfif SESSION.USER_STATUS_ID eq "3">
			
			$('#window_item_lg').modal({keyboard: false,backdrop:'static'});
			$('#modal_title_lg').text("*WEFIT LMS*");		
			$('#modal_body_lg').load("modal_window_info.cfm?show_info=launching_test", function() {});

		</cfif>

	<cfelseif SESSION.USER_PROFILE eq "LEARNER" AND isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "1">

		// <cfif not isdefined("SESSION.ALERT_WELCOME")>

		// 	$('#window_item_lg').modal({keyboard: false,backdrop:'static'});
		// 	$('#modal_title_lg').text("*WEFIT LMS*");		
		// 	$('#modal_body_lg').load("modal_window_info.cfm?show_info=welcome_info", function() {});

		// 	<cfset SESSION.ALERT_WELCOME = "1">

		// </cfif>

	</cfif>


	$('.btn_discover_virtualclass').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		$('#modal_title_lg').text("*WEFIT LMS*");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_virtualclass");
	});

	$('.btn_discover_certif').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		$('#modal_title_lg').text("*WEFIT LMS*");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_certif");
	});

	$('.btn_discover_el').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		$('#modal_title_lg').text("*WEFIT LMS*");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_el");
	});

	$('.btn_discover_visio').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: false});
		$('#modal_title_lg').text("*WEFIT LMS*");	
		$('#modal_body_lg').load("modal_window_info.cfm?show_info=discover_visio");
	});

	
});
</script>
</body>
</html>

