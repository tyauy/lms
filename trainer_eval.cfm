<!DOCTYPE html>

<cfsilent>

<cfparam name="f_id" default="2">
<cfparam name="subm" default="wtest">
<cfset menu_type = "eval">

<cfset u_id = SESSION.USER_ID>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>
	

<cfset list_lang = "en,de,fr,es,it,ru,zh,pt,nl">

<cfloop list="#SESSION.LIST_PT#" index="cor">
<cfset "user_qpt_#cor#" = evaluate("get_user.user_qpt_#cor#")>
<cfset "user_qpt_lock_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>
</cfloop>	
	
<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 3
</cfquery>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_needs FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>

<cfquery name="get_bright_listening" datasource="#SESSION.BDDSOURCE#">
SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_type, quiz_description_#SESSION.LANG_CODE# as quiz_description, f.formation_code 
FROM lms_quiz q
INNER JOIN lms_formation f ON f.formation_id = q.quiz_formation_id
WHERE quiz_type = "bright listening" AND quiz_active = 1
</cfquery>

<cfquery name="get_bright_reading" datasource="#SESSION.BDDSOURCE#">
SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_type, quiz_description_#SESSION.LANG_CODE# as quiz_description, f.formation_code 
FROM lms_quiz q
INNER JOIN lms_formation f ON f.formation_id = q.quiz_formation_id
WHERE quiz_type = "bright reading" AND quiz_active = 1
</cfquery>

<cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
</cfquery>

<cfquery name="get_linguaskill" datasource="#SESSION.BDDSOURCE#">
SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "linguaskill" AND quiz_active = 1
</cfquery>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_tests')#">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="row">
				<div class="col-md-12">
					<!---
					<cfinclude template="./incl/incl_nav_tc.cfm">
					--->
					<div class="card border-top border-info">
						<div class="card-body">
					
							<cfif subm eq "wtest">
							<div class="card-title">
							<h5>Wefit Tests</h5>							
							</div>
						
							<cfloop list="#list_lang#" index="lang_select">
								<div class="border mt-3 p-3 bg-light">
									<div class="row">
										<div class="col-md-6">
										
											<div class="media">
												<cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" class="align-self-center mr-3" width="200"></cfoutput>
												<div class="media-body">
												<h6 class="text-left mt-2"><cfoutput>#obj_translater.get_translate('card_learner_pt')# WEFIT - #obj_translater.get_translate('lang_#lang_select#')#</cfoutput></h6>
												<p>
												<ul class="m-0">
												
												<cfoutput>#obj_translater.get_translate_complex('intro_eval_lrn')#</cfoutput>
												
												</ul>							
												</p>
												</div>
											</div>

										</div>
										<div class="col-md-6 d-flex align-items-end justify-content-md-end justify-content-sm-center w-100">
											<cfset get_distinct_pt = obj_query.oget_distinct_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",tp_id="")>		
											<cfoutput>	
												<!--- <cfdump var="#get_distinct_pt#">											 --->
											<cfif get_distinct_pt.recordcount neq "0">
												<div class="row">
													<div class="col-md-12">
														<div class="card border">
															<cfloop query="get_distinct_pt">
																<cfif quiz_user_group_id neq "">
																<div class="d-flex align-items-center">
																	<div class="m-2" align="center">
																		<img src="./assets/img/training_#lang_select#.png" width="50"></span>
																		<br>
																		#obj_dater.get_dateformat(quiz_user_start)#
																	</div>
																	<div class="m-2">
																		<cfif pt_speed eq "fpt">
																			<!--- FULL PLACEMENT TEST --->
																			<span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
																		<cfelseif pt_speed eq "qpt">
																			<!--- QUICK PLACEMENT TEST --->
																			<span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
																		</cfif>
																	</div>
																	<div class="m-2">
																		<cfset get_pt = obj_query.oget_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",quiz_user_group_id="#quiz_user_group_id#")>
																		<cfset quiz_type = get_pt.quiz_type>
																		<cfinclude template="./incl/incl_pt_result.cfm">
																	</div>														
																</div>
																</cfif>
															</cfloop>
														</div>
													</div>
												</div>
											<cfelse>
												<cfif evaluate("user_qpt_#lang_select#") neq "" AND (evaluate("user_qpt_lock_#lang_select#") eq "0" OR evaluate("user_qpt_lock_#lang_select#") eq "")>
													<div class="row">
														<div class="col-md-12">
															<div class="card border">
																<cfoutput>
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
																</cfoutput>		
															</div>
														</div>
													</div>
												<cfelse>
													<div class="card">
														<div class="card-body">
															<h6><i class="fal fa-clock"></i> #obj_translater.get_translate('timing_ten_to_fifty_min')#</h6>
															
															<a href="##" class="btn btn-success p-2 m-2 cursored btn_pass_fpt" id="fcode_#lang_select#">
																<i class="fal fa-arrow-right"></i>	#obj_translater.get_translate('btn_fpt')#
															</a>
														</div>
													</div>
												</cfif>
											</cfif>
											</cfoutput>	
											
										</div>
									</div>
								</div>
							</cfloop>
			
			
							<div class="border mt-3 p-3 bg-light">
								<div class="row">
									<div class="col-md-2">
										<img class="card-img-top" src="./assets/img_material/a265417047adfd29c84ff53a33aedbe0.jpg" width="200">
									</div>
									<div class="col-md-10">
										<div class="mr-2">
										<h6 class="text-left mt-2"><cfoutput>#obj_translater.get_translate('card_learner_lst')#</cfoutput></h6>
										<p>
										<cfoutput>#obj_translater.get_translate_complex('learning_style_test')#</cfoutput>
										
										</p>
										<div class="float-right">
										
											<cfif get_result_lst.recordcount eq "0">
											
												<a href="quiz_start.cfm?t=lst" class="btn btn-sm btn-outline-info"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
												
											<cfelse>
											
												<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
													<cfoutput><a href="./quiz_eval.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&u_id=#SESSION.USER_ID#" target="_blank" class="btn btn-sm btn-success">#obj_translater.get_translate('btn_results_test')#</a></cfoutput>
												</cfif>
										
											</cfif>		
											
										</div>
										</div>
										
									</div>
								</div>
							</div>
							
							
				
							<cfelseif subm eq "Toeic">
							<div class="card-title">
							<h5>Toeic Listening & Reading</h5>							
							</div>
							
							<br><br>
							
							<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Toeic Listening &amp; Reading</h6>
							
							<div class="row">
								
								<cfoutput query="get_toeic">
									
								<cfquery name="get_result_toeic" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
								</cfquery>
							
								<div class="col-md-6">
												
									<div class="border-top border-success bg-light mt-3 p-2">
									
										<div class="media">
											<img src="./assets/img/logo_toeic.jpg" width="120" class="mr-2">
											<div class="media-body">
												<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
												<small>#quiz_description#</small>
												
												<div class="clearfix"></div>
												<div class="float-right">
												
													<cfif get_result_toeic.recordcount eq "0">
													
														<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
														
													<cfelse>
														<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
														
														<cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq "">
															<a href="./quiz_eval.cfm?quiz_user_id=#get_result_toeic.quiz_user_id#" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
														<!---<cfelseif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end eq "">
															<a href="./quiz.cfm?quiz_user_id=#get_result_toeic.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>--->											
														</cfif>
												
													</cfif>		
													
												</div>
											</div>
										</div>

									</div>
								</div>
								
								</cfoutput>
									
							</div>
							
							
							<cfelseif subm eq "bright">
							<div class="card-title">
							<h5>Bright Language Test</h5>							
							</div>

							<br><br>
							
							<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Bright Language</h6>
							
							<div class="row">
								
								<div class="col-md-6">
								
								<cfoutput query="get_bright_reading">
									
									<cfquery name="get_result_bright_reading" datasource="#SESSION.BDDSOURCE#">
									SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id#
									</cfquery>

										<div class="border-top border-success bg-light mt-3 p-2">
									
										<div class="media">
											<img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
											<div class="media-body">
												<img src="./assets/img/training_#lcase(formation_code)#.png" width="40" align="left">
												<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
												<small>#quiz_description#</small>
												
												<div class="clearfix"></div>
												<div class="float-right">
												
													<cfif get_result_bright_reading.recordcount eq "0">
													
														<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
														
													<cfelse>
														<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
														
														<cfif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end neq "">
															<a href="./quiz_eval.cfm?quiz_user_id=#get_result_bright_reading.quiz_user_id#" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
														</cfif>
												
													</cfif>		
													
												</div>
											</div>
										</div>

									</div>
								
								</cfoutput>
								
								</div>
								
								<div class="col-md-6">
								
								<cfoutput query="get_bright_listening">
									
									<cfquery name="get_result_bright_listening" datasource="#SESSION.BDDSOURCE#">
									SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id#
									</cfquery>

										<div class="border-top border-success bg-light mt-3 p-2">
									
										<div class="media">
											<img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
											<div class="media-body">
												<img src="./assets/img/training_#lcase(formation_code)#.png" width="40" align="left">
												<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
												<small>#quiz_description#</small>
												
												<div class="clearfix"></div>
												<div class="float-right">
												
													<cfif get_result_bright_listening.recordcount eq "0">
													
														<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
														
													<cfelse>
														<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																
														<cfif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end neq "">
															<a href="./quiz_eval.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
														</cfif>
												
													</cfif>		
													
												</div>
											</div>
										</div>

									</div>
								
								</cfoutput>
								
								</div>
									
							</div>
							
							
							<cfelseif subm eq "linguaskill">
							<div class="card-title">
							<h5>Linguaskill</h5>							
							</div>

							
							
							<div class="row">
								
								<div class="col-md-6">

									<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill General</h6>
									
									<div class="border-top border-success bg-light mt-3 p-2">
										<div class="media">
											<img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-success">D&eacute;butant</span></h6>
												<em><small><!---COMPLEX--->Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org<!---END_RM---></small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-a1-a2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-a1-a2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
												</div>
											</div>
										</div>
									</div>
									<div class="border-top border-warning bg-light mt-3 p-2">
										<div class="media">
											<img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-warning">Interm&eacute;diaire</span> </h6>
												<em><small>Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-b1-b2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-b1-b2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
												</div>
											</div>
										</div>
									</div>
									<div class="border-top border-danger bg-light mt-3 p-2">
										<div class="media">
											<img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-danger">Avanc&eacute;</span></h6>
												<em><small>Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
												</div>
											</div>
										</div>
									</div>
									
									<br>
									
									<h6 class="text-info">D&eacute;mo - Linguaskill General</h6>
										
									<div class="border-top bg-light mt-3 p-2">
										<div class="media">
											<img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">D&eacute;mo - Compr&eacute;hension &eacute;crite et orale</h6>
												<em><small>Pour acc&eacute;der &agrave; ce test Linguaskill (en conditions r&eacute;elles), vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LSKLDEMO02" class="btn btn-sm btn-outline-info mb-0">D&eacute;mo</a>
												</div>
											</div>
										</div>
									</div>
									
								</div>
										
								<div class="col-md-6">

									<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill Business</h6>	

									<div class="border-top border-success bg-light mt-3 p-2">							
										<div class="media">
											<img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-success">D&eacute;butant</span></h6>
												<em><small>Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/A+level+Test+-+Reading+and+Listening/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
												</div>
											</div>
										</div>
									</div>
									<div class="border-top border-warning bg-light mt-3 p-2">				
										<div class="media">
											<img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-warning">Interm&eacute;diaire</span></h6>
												<em><small>Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/B+level+Test+-+Reading+and+Listening/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
												</div>
											</div>
										</div>
									</div>
									<div class="border-top border-danger bg-light mt-3 p-2">				
										<div class="media">
											<img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Compr&eacute;hension &eacute;crite et orale <span class="badge badge-pill badge-danger">Avanc&eacute;</span></h6>
												<em><small>Pour acc&eacute;der &agrave; cet entra&icirc;nement Linguaskill, vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/C+level+Test+-+Reading+and+Listening+V2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
												</div>
											</div>
										</div>
									</div>
									
									<br>
									
									<h6 class="text-info">D&eacute;mo - Linguaskill Business</h6>	
									
									<div class="border-top bg-light mt-3 p-2">				
										<div class="media">
											<img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
											<div class="media-body">
												<h6 class="mt-1">Test d&eacute;mo - Compr&eacute;hension &eacute;crite et orale</h6>
												<em><small>Pour acc&eacute;der &agrave; ce test Linguaskill (en conditions r&eacute;elles), vous allez &ecirc;tre r&eacute;dirig&eacute;(e) vers le site Cambridgeenglish.org</small></em>
												<div class="clearfix"></div>
												<div class="float-right">												
													<a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LinguaskillBusinessDemo" class="btn btn-sm btn-outline-info mb-0">D&eacute;mo</a>
												</div>
											</div>
										</div>
									</div>
									
								</div>
									
							</div>
							
							
							</cfif>
						
						
						</div>
						
					</div>		
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	

		<cfoutput>
		if(confirm('#obj_translater.get_translate('js_restart_quiz_confirm')#')){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		</cfoutput>
	

	})

	<cfoutput>
	$('.btn_view_qpt').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_group_id = idtemp[1];	
		var quiz_user_id = idtemp[2];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})

	$('.btn_view_quiz').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})

	$('.btn_pass_qpt').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var f_code = idtemp[1];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code="+f_code+"&choice=qpt", function() {});
	})

	$('.btn_pass_fpt').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var f_code = idtemp[1];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code="+f_code+"&choice=fpt", function() {});
	})
	</cfoutput>
	
})
</script>

</body>
</html>