<!DOCTYPE html>
<cfset SESSION.ALERT_WELCOME = "1">
<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">
		
	<!--------------- SET DEFAULT CRITERIAS / INIT CONFIG --->
	<!--- <cfset hide_setup = 1> --->
	<cfset step = "1">
	<cfset u_id = SESSION.USER_ID>
	<cfset a_id = SESSION.ACCOUNT_ID>
	<cfset SESSION.LAUNCH_GROUP = 0>
		
	<cfset get_tp = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1",m_id="1,2,6")>

	<cfif get_tp.recordcount eq "0">

		<cfset get_tp = obj_tp_get.oget_tps(u_id="#u_id#",m_id="11")>

		<cfif get_tp.recordcount eq "0">

			<cfset get_tp = obj_tp_get.oget_tps(u_id="#u_id#",o_id="3")>

			<cfif get_tp.recordcount eq "0">
				<cfset SESSION.LAUNCH_NO_TP_AV = 1>
				<cflocation addtoken="no" url="learner_index.cfm?e=1">
			</cfif>
			
		<cfelse>
			<!--- <cflocation addtoken="no" url="learner_launch_1_group.cfm"> --->
			<cfset SESSION.LAUNCH_GROUP = 1>
		</cfif>

	</cfif>

	<cfset SESSION.TP_ID = get_tp.tp_id>	
	<cfset t_id = SESSION.TP_ID>	
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>
	
	<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_type = "lst"
	</cfquery>

	<cfif get_result_lst.recordCount neq 0>
		<cfset _pos = listFindNoCase(SESSION.STEPS, "3")>
		<cfif _pos neq 0>
			<cfset SESSION.STEPS = listDeleteAt(SESSION.STEPS, _pos)>
		</cfif>
	</cfif>

	<cfquery name="get_tp_quiz" datasource="#SESSION.BDDSOURCE#">
		SELECT lqu.quiz_user_end, t.tp_id, t.tp_date_end, lqut.type, lqut.quiz_user_group_id,
		t.tp_rank, f.formation_code, t.method_id, t.tp_duration, t.elearning_duration, t.tp_name
		FROM  lms_quiz_user lqu
		INNER JOIN lms_quiz_user_tp lqut ON lqut.quiz_user_group_id = lqu.quiz_user_group_id 
		INNER JOIN lms_tp t on t.tp_id = lqut.tp_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		WHERE t.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND lqu.user_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		GROUP BY lqu.quiz_user_group_id, lqut.type
	</cfquery>

	<cfquery name="get_tp_trainer" datasource="#SESSION.BDDSOURCE#">
		SELECT t.tp_id
		FROM lms_tp t 
		inner join lms_tpplanner tpp on tpp.tp_id = t.tp_id AND tpp.active = 1
		WHERE t.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>

	<cfif get_tp_quiz.recordCount neq 0>
		<cfset _pos = listFindNoCase(SESSION.STEPS, "2")>
		<cfif _pos neq 0>
			<cfset SESSION.STEPS = listDeleteAt(SESSION.STEPS, _pos)>
		</cfif>
	</cfif>


	<cfquery name="get_learner_level" datasource="#SESSION.BDDSOURCE#">
		SELECT user_level_id, formation_code, level_id, level_code, level_sub_id, level_sub_code, level_verified
		FROM user_level 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		AND skill_id = 0
		AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
		LIMIT 1
	</cfquery>



	<!--- <cfif SESSION.USER_PROFILE eq "TEST" AND SESSION.USER_TYPE_ID eq 8 AND SESSION.USER_PT_MANDATORY neq 1>
		<cfset temp = obj_lms.updt_step("2")>
	</cfif> --->

</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	

	<script type = "text/javascript" >  
		function preventBack() { window.history.forward(); }  
		setTimeout("preventBack()", 0);  
		window.onunload = function () { null };  
	</script>


</head>


<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
			<!--- <cfset help_page = "help_lstep2"> --->

			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">
				
			
				<cfoutput>
				<!--- <a href="learner_launch_1.cfm?kill_needs=1">[DEV : effacer RECUEIL BESOINS]</a> --->
				<!--- <br><a href="learner_launch_1.cfm?kill_charter=1">[DEV : effacer WELCOME]</a> --->
				<!--- <br><a href="learner_launch_1.cfm?kill_level=1">[DEV : effacer NIVEAU]</a> --->
				<!--- <br>SESSION.USER_CHARTER = #SESSION.USER_CHARTER# --->
				<!--- <br>SESSION.STEPS = #SESSION.STEPS# --->
				<!--- <br>1 = PT --->
				<!--- <br>2 = LST --->
				<!--- <br>3 = NEEDS --->
				</cfoutput>

				<cfif isdefined("k") AND k eq "1">
				<div class="row justify-content-center mt-5">
					<div class="col-lg-10">				
						<div class="alert alert-info" role="alert" align="center">				
							<cfoutput>#obj_translater.get_translate('alert_needs_ok')#</cfoutput>
						</div>
					</div>
				</div>
				<cfelseif isdefined("k") AND k eq "2">
				<div class="row justify-content-center mt-5">
					<div class="col-lg-10">		
						<div class="alert alert-success" role="alert" align="center">				
						<cfoutput>#obj_translater.get_translate('alert_mdp_change_ok')#</cfoutput>
						</div>
					</div>
				</div>
				</cfif>
				
				<cfif SESSION.LAUNCH_GROUP eq 0>
					<cfinclude template="./incl/incl_nav_launching.cfm">
				</cfif>

				<div class="row mt-3">
    
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        
                        <div class="card border">
                    
                            <div class="card-body pb-5">


							<cfif isdefined("SESSION.STEPS") AND not listfind(SESSION.STEPS,2) AND not listfind(SESSION.STEPS,3)>
							<div class="row justify-content-center mt-5">
								<div class="col-lg-10">		
									<div class="card border border-info no-shadow" align="center">
										<div class="card-body" align="center">
											<cfif SESSION.LAUNCH_GROUP eq 0>
												<cfoutput>#obj_translater.get_translate('alert_profil_done')#</cfoutput>
												<br>
												<cfif SESSION.USER_PROFILE eq "TEST" AND SESSION.USER_TYPE_ID neq 8>
													<div align="center" class="mt-2">
														<a href="learner_launch_2_test.cfm" class="btn btn-lg btn-info"><cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i></a>
													</div>
												<cfelseif SESSION.USER_TYPE_ID eq 8>
													<!--- TEST BY TM --->
													<cfif get_tp.tp_duration eq 0>
														<!--- IF QUIZZ ONLY --->
														<div align="center" class="mt-2">
															<!--- <a href="learner_launch_partner_2.cfm" class="btn btn-lg btn-info"><cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i></a> --->
															<cfoutput><input type="submit" id="btn_validate_tp" class="btn btn-info m-0" id="tp_#t_id#" value="#obj_translater.get_translate('btn_continue')#"></cfoutput>
														</div>
													<cfelse>
														<div align="center" class="mt-2">
															<a href="learner_launch_partner_2.cfm" class="btn btn-lg btn-info"><cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i></a>
														</div>
													</cfif>
													
												<cfelse>
													<div align="center" class="mt-2">
														<cfif get_tp.tp_interest_id neq "" OR get_tp.tp_function_id neq "" >
															
															<a href="learner_launch_3.cfm" class="btn btn-lg btn-info">
																<cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i>
															</a>
														<cfelseif  (get_tp.tp_interest_id neq "" OR get_tp.tp_function_id neq "") AND get_tp_trainer.recordcount neq 0>
															<!--- <cfset SESSION.LAUNCHING_STEP_4_MODAL = "1"> --->
															<a href="learner_launch_3.cfm" class="btn btn-lg btn-warning">
																<cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i>
															</a>
														<cfelse>
															<a href="learner_launch_2.cfm" class="btn btn-lg btn-info">
																<cfoutput>#obj_translater.get_translate('btn_go_step_2')#</cfoutput> <i class="fal fa-chevron-double-right"></i>
															</a>
														</cfif>
													</div>
													
												</cfif>
											<cfelse>
												<cfoutput>#obj_translater.get_translate('alert_profil_done_group')#</cfoutput>
												<br>
												<div align="center" class="mt-2">
													<cfoutput>
													<form action="updater_form.cfm" method="post">
														<input type="hidden" name="p_list" value="">
														<input type="hidden" name="u_id" value="#u_id#">
														<input type="hidden" name="t_id" value="#t_id#">
														<input type="hidden" name="form_type" value="affect_trainer">
														<button type="submit" class="btn btn-lg btn-info"> #obj_translater.get_translate('btn_go_send')# <i class="far fa-chevron-double-right"></i></button>
													</form>
													</cfoutput>
													<!--- <a href="learner_index.cfm" class="btn btn-lg btn-success"><i class="fal fa-arrow-right"></i>  <cfoutput>#obj_translater.get_translate('btn_go_send')#</cfoutput></a> --->
												</div>
											</cfif>
										</div>		
									</div>
								</div>
							</div>
							</cfif>	
				
							<div class="row justify-content-center mt-4">
								
								<div class="col-lg-6 col-xl-5">
								<!--- <cfoutput>#SESSION.STEPS#</cfoutput> --->
									<cfif listfind(SESSION.LIST_PT,lcase(f_code))>
									<cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"2")>
									<div class="card border border-info h-100">
									<cfelse>
									<div class="card border h-100" style="background-color:#ECECEC">
									</cfif>
									
										<div class="card-body p-3 d-flex flex-column">

											<cfoutput><img class="card-img-top" src="./assets/img/qpt_#lcase(f_code)#.jpg" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"1")><cfelse>class="card_module"</cfif> width="350" align="center"></cfoutput>
											
											
											<div align="center" class="mt-3">
												<h5 class="d-inline"><cfoutput>#obj_translater.get_translate('js_modal_title_pt')#</cfoutput></h5><br>
											</div>

											<div class="mt-3">
											<cfoutput>#obj_translater.get_translate_complex('pt_intro')#</cfoutput>

												<div align="center">	
													<a class="btn btn-link font-weight-normal text-info" data-toggle="collapse" href="#more_qpt" role="button" aria-expanded="false" aria-controls="more_qpt">
														<cfoutput>[ #obj_translater.get_translate('btn_know_more')# ]</cfoutput>
													</a>
												</div>

												<div class="collapse" id="more_qpt">
													<cfoutput>
													<h6>#obj_translater.get_translate_complex('more_qpt_title')#</h6>
													<ul>
													#obj_translater.get_translate_complex('more_qpt_list')#
													</ul>
													</cfoutput>	
												</div>
											</div>

											<!--- PASSAGE PT --->
											<div class="m-2 p-2 mt-auto" align="center">
												<cfoutput>
												<cfif (get_tp_quiz.recordCount neq 0) AND SESSION.USER_TYPE_ID neq 8 OR isdefined("SESSION.USER_LEVEL_UNVERIFIED")>
													<div>
														<h5 class="text-success bg-white border w-100 p-2">
															<i class="far fa-check fa-lg"></i> 
															#obj_translater.get_translate('global_perform')# : 
															<cfif get_learner_level.level_code neq "">
																#get_learner_level.level_code#
															<cfelseif isdefined("SESSION.USER_LEVEL_UNVERIFIED")>
																#SESSION.USER_LEVEL_UNVERIFIED#
															</cfif>
															
															<cfif get_learner_level.level_verified eq 1>
																(#obj_translater.get_translate('text_verified')#)
															<cfelse>
																(#obj_translater.get_translate('text_not_verified')#)
															</cfif>
														</h5>											
														<!--- <cfset get_pt = obj_query.oget_pt(u_id="#u_id#",quiz_user_group_id="#get_tp.tp_quiz_start_id#",quiz_type="qpt_#f_code#")> --->
														<!--- <cfset get_pt = obj_query.oget_pt(u_id="#u_id#",t_id="#t_id#",quiz_type="qpt_#f_code#",pt_type="start")> --->
														
														<cfif get_learner_level.recordCount neq 0>
															<cfif get_tp_quiz.recordcount neq "0" AND get_learner_level.level_code neq "A0">
															<a href="##" role="button" class="btn btn-link btn_view_qpt font-weight-normal text-info" id="qpt_#get_tp_quiz.quiz_user_group_id#">[ #obj_translater.get_translate('btn_results')# ]</a>
															<cfelseif SESSION.LAUNCH_GROUP eq 0>
															<a href="##" role="button" class="btn btn-link btn_skip_qpt font-weight-normal text-info">[ #obj_translater.get_translate('btn_edit_again')# ]</a>
														</cfif>
														<cfelse>
															<cfif get_tp_quiz.recordcount neq "0">
																<a href="##" class="btn btn-success btn_view_qpt" id="qpt_#get_tp_quiz.quiz_user_group_id#"><i class="fal fa-arrow-right"></i> #obj_translater.get_translate('btn_continue')#</a>
															<cfelseif SESSION.LAUNCH_GROUP eq 0>
																<a href="##" role="button" class="btn btn-link btn_skip_qpt font-weight-normal text-info">[ #obj_translater.get_translate('btn_edit_again')# ]</a>
															</cfif>
																
														</cfif>
														
													</div>
												<cfelse>
													<!--- current level --->
													<!--- <cfif get_learner_level.recordCount neq 0>
														<h5 class="text-success bg-white border w-100 p-2">
															<i class="far fa-check fa-lg"></i> 
															#obj_translater.get_translate('global_perform')# : #get_learner_level.level_code# 
															<cfif get_learner_level.level_verified eq 1>
																(#obj_translater.get_translate('text_verified')#)
															<cfelse>
																(#obj_translater.get_translate('text_not_verified')#)
															</cfif>
														</h5>
													</cfif> --->

													<div class="row justify-content-center">
														<cfif SESSION.LAUNCH_GROUP eq 0 AND SESSION.USER_PT_MANDATORY neq 1>
															<div class="col-md-6">
																<h6><i class="fal fa-clock"></i> #obj_translater.get_translate('timing_zero_minute')#</h6>
																#obj_translater.get_translate('text_pt_later')#<br>
																<a href="##" class="btn btn-outline-info p-2 m-2 cursored btn_skip_qpt" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"2")><cfelse>disabled</cfif>>
																	<i class="fal fa-forward"></i> #obj_translater.get_translate('btn_later')#
																</a>
															</div>
														</cfif>


														<div class="col-md-6">
															<h6><i class="fal fa-clock"></i> #obj_translater.get_translate('timing_ten_to_fifty_min')#</h6>
															#obj_translater.get_translate('text_pt_fpt')#<br>
															<a href="##" class="btn btn-info p-2 m-2 cursored btn_pass_fpt" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"2")><cfelse>disabled</cfif>>
																<i class="fal fa-arrow-right"></i>	#obj_translater.get_translate('btn_fpt')#
															</a>
														</div>

													</div>

												</cfif>
												</cfoutput>
												

												
											</div>

										</div>

									</div>
									</cfif>
									
								</div>

								<div class="col-lg-6 col-xl-5">
								
														
									<cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"3")>
									<div class="card border h-100 border-info">
									<cfelse>
									<div class="card border h-100" style="background-color:#ECECEC">
									</cfif>
			<!--- SESSION.STEPS = <cfoutput>#SESSION.STEPS#</cfoutput> --->
										<div class="card-body p-3 d-flex flex-column">

											<img class="card-img-top" src="./assets/img/lst.jpg" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"3")><cfelse>class="card_module"</cfif> width="350" align="center">
											
											<div align="center" class="mt-3">
												<h5 class="d-inline"><cfoutput>#obj_translater.get_translate('js_modal_title_lst')#</cfoutput></h5><br>
											</div>

											
											<div class="mt-3">
												<cfoutput>#obj_translater.get_translate_complex('lst_intro')#</cfoutput>
												<div align="center">	
													<a class="btn btn-link font-weight-normal text-info" data-toggle="collapse" href="#more_lst" role="button" aria-expanded="false" aria-controls="more_lst">
														<cfoutput>[ #obj_translater.get_translate('btn_know_more')# ]</cfoutput>
													</a>
												</div>

												<div class="collapse" id="more_lst">
													<cfoutput>
													<h6>#obj_translater.get_translate('more_lst_progress')#</h6>
													#obj_translater.get_translate_complex('more_lst_explain')#
													<br><br>
													
													<h6>#obj_translater.get_translate('more_lst_list_profil')#</h6>
													<ul>
														<li class="float-left">#obj_translater.get_translate('profile_independant')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_social')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_dynamic')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_applied')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_conceptual')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_scholastic')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_creative')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_analytic')#</li>
														<li class="float-left ml-4">#obj_translater.get_translate('profile_neutral')#</li>
													</ul>
													</cfoutput>

												</div>

											</div>

											<div class="m-2 p-2 mt-auto" align="center">
											
												<cfif isdefined("SESSION.USER_LST") AND SESSION.USER_LST neq "">
													<div>
													<h5 class="text-success"><i class="far fa-check fa-lg"></i> <cfoutput>#obj_translater.get_translate('global_perform')#</cfoutput></h5>
													
													<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
													<cfoutput>
														<a href="##" role="button" class="btn btn-link btn_view_lst font-weight-normal text-info" id="lst_#get_result_lst.quiz_user_id#">[ <cfoutput>#obj_translater.get_translate('btn_results')#</cfoutput> ]</a>														
													</cfoutput>
													</cfif>
									
													</div>
												<cfelse>

													<div class="row">
														<div class="col-md-6">
															<h6><i class="fal fa-clock"></i> <cfoutput>#obj_translater.get_translate('timing_zero_minute')#</cfoutput></h6>
															<a href="##" class="btn btn-sm btn-outline-info btn_skip_lst p-2 m-2" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"3")><cfelse>disabled</cfif>><i class="fal fa-forward"></i> <cfoutput>#obj_translater.get_translate('btn_later')#</cfoutput></a>
														</div>
														<div class="col-md-6">
															<h6><i class="fal fa-clock"></i> <cfoutput>#obj_translater.get_translate('timing_fifteen_minutes')#</cfoutput></h6>
															<a href="##" class="btn btn-sm btn-info btn_pass_lst p-2 m-2" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"3")><cfelse>disabled</cfif>><i class="fal fa-arrow-right"></i> <cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
												
														</div>
													</div>

												</cfif>

											</div>

										</div>

									</div>

								</div>
								
							</div>

						</div>
					</div>
				</div>

			</div>


			<cfinclude template="./incl/incl_footer.cfm">

		</div>
	</div>

	<cfinclude template="./incl/incl_scripts.cfm">

	<cfinclude template="./incl/incl_scripts_modal.cfm">

	<script>
	$(document).ready(function() {

		<cfif SESSION.USER_PROFILE eq "TEST" AND SESSION.USER_TYPE_ID eq 8>
			$("#btn_validate_tp").click(function(event) {
				event.preventDefault();

				$.ajax({				 
					url: './api/launching/launching_post.cfc?method=switch_user',
					type: "POST",
					data: {t_id:<cfoutput>#SESSION.TP_ID#</cfoutput>},
					datatype : "html",
					success : function(result, statut){
						window.location.href="common_tp_details.cfm";
					}
				})
			});
		</cfif>
		<cfoutput>
		
		<cfif SESSION.USER_PROFILE eq "TEST" AND SESSION.USER_TYPE_ID neq 8>
			<cfif isdefined("trigger_launch")>
				$('##window_item_xl_unclosable').modal({backdrop: 'static',keyboard: false});
				$('##modal_title_xl_unclosable').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_welcome_test'))#");
				$('##modal_body_xl_unclosable').load("modal_window_launch_test.cfm?u_id=#u_id#&t_id=#SESSION.TP_ID#", function() {});
			</cfif>
		<cfelse>
			<cfif isdefined("SESSION.USER_CHARTER") AND (SESSION.USER_CHARTER eq "0" OR SESSION.USER_CHARTER eq "")>
				$('##window_item_xl_unclosable').modal({backdrop: 'static',keyboard: false});
				$('##modal_title_xl_unclosable').text("*WEFIT LMS*");
				$('##modal_body_xl_unclosable').load("modal_window_launch1.cfm?show_info=welcome&u_id=#u_id#&t_id=#SESSION.TP_ID#", function() {});
			</cfif>
		</cfif>	
		
		
		
		$('.btn_skip_qpt').click(function(event) {	
			event.preventDefault();
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_title_lg').text("*WEFIT LMS*");
			$('##modal_body_lg').load("modal_window_launch1.cfm?show_info=qpt_#lcase(f_code)#&f_code=#f_code#&choice=0", function() {});
		});		
		
		$('.btn_pass_qpt').click(function(event) {	
			event.preventDefault();
			$('##modal_title_lg').text("*WEFIT LMS*");
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_body_lg').load("modal_window_qpt_launch.cfm?f_code=#lcase(f_code)#&choice=qpt", function() {});
		})

		$('.btn_pass_fpt').click(function(event) {	
			event.preventDefault();
			$('##modal_title_lg').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_body_lg').load("modal_window_qpt_launch.cfm?f_code=#lcase(f_code)#&choice=fpt&pt_type=start", function() {});
		})
		
		$('.btn_skip_lst').click(function(event) {	
			$('##modal_title_lg').text("*WEFIT LMS*");
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_body_lg').load("modal_window_launch1.cfm?show_info=lst&choice=3", function() {});
		});

		$('.btn_pass_lst').click(function(event) {	
			event.preventDefault();
			$('##modal_title_lg').text("*WEFIT LMS*");
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_body_lg').load("modal_window_launch1.cfm?show_info=lst&choice=4", function() {});
		})
		
		$('.btn_view_qpt').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var quiz_user_group_id = idtemp[1];	
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&u_id=#u_id#", function() {});
		})
							
		<cfif isdefined("get_learner_level") AND get_learner_level.recordCount neq "0" AND isdefined("show_result_qpt")>
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('btn_results_test'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id=#get_tp_quiz.quiz_user_group_id#&u_id=#u_id#&show_result=answer_analysis", function() {});
		</cfif>
		
		$('.btn_view_lst').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var quiz_user_id = idtemp[1];	
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('title_page_learner_eval_lst'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("./incl/incl_lst_container.cfm?quiz_user_id="+quiz_user_id, function() {});
		})
		<cfif get_result_lst.recordcount neq "0" AND isdefined("show_result_lst")>
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('title_page_learner_eval_lst'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("./incl/incl_lst_container.cfm?quiz_user_id=#get_result_lst.quiz_user_id#", function() {});
		</cfif>
		
		
		
		</cfoutput>


	});
	</script>
</body>
</html>