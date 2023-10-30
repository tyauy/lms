<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,4,5,7,8,9">
<cfinclude template="./incl/incl_secure.cfm">	

<cfif isdefined("SESSION.ACCESS_EL") AND listlen(SESSION.LIST_ACCESS_EL) gte "1">
<cfparam name="f_id" default="#listgetat(SESSION.LIST_ACCESS_EL,1)#">
<cfelse>
<cfparam name="f_id" default="2">
</cfif>

<cfparam name="subm" default="toeic">

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<cfset u_id = u_id>
	<cfset p_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
</cfif>

	<!--- <cfif isdefined("SESSION.ACCESS_EL")> --->

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_needs FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>

		<cfquery name="get_bright_listening" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
		</cfquery>
		
		<cfquery name="get_bright_reading" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright reading" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
		</cfquery>
		
		<cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
		</cfquery>
		
		<cfquery name="get_linguaskill" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "linguaskill" AND quiz_active = 1
		</cfquery>
		
		<!--- <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE <cfif listlen(SESSION.LIST_ACCESS_EL) neq "">formation_id IN (#SESSION.LIST_ACCESS_EL#)<cfelse>formation_id <= 5</cfif> --->
		<!--- </cfquery>	 --->
		
		<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
		SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation 
		WHERE formation_id = 1
		OR formation_id = 2
		OR formation_id = 3
		OR formation_id = 4
		OR formation_id = 5
		OR formation_id = 8
		OR formation_id = 9
		OR formation_id = 12
		OR formation_id = 13
		</cfquery>
	
	<!--- </cfif> --->
	
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

<style>
.nav-link {
    color: #999 !important;
}
.nav-pills .nav-link.active, .nav-pills .show>.nav-link
{
color:#FFFFFF !important;
background-color:#51BCDA !important;
}

</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_mock_tests')# : <span style='text-transform : capitalize'>#subm#</span>">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<ul class="nav nav-pills" role="tablist" id="tabs_content">
							
				<li class="nav-item mx-2">
					<a class="nav-link active" href="#tab_HOME" role="tab" id="title_HOME" data-toggle="pill">
						<div align="center"><i class="fal fa-home fa-2x"></i> <br><strong>The test</strong></div>											
					</a>
				</li>
				
				<li class="nav-item mx-2">
					<a class="nav-link" href="#tab_VIDEO" role="tab" id="title_VIDEO" data-toggle="pill">
						<div align="center"><i class="fal fa-camera-movie fa-2x"></i> <br><strong>Video / Tips</strong></div>											
					</a>
				</li>
				
				<li class="nav-item mx-2">
					<a class="nav-link" href="#tab_MOCK" role="tab" id="title_MOCK" data-toggle="pill">
						<div align="center"><i class="fal fa-monkey fa-2x"></i> <br><strong>Mock Test</strong></div>											
					</a>
				</li>
				
				<li class="nav-item mx-2">
					<a class="nav-link" href="#tab_GRAMMAR" role="tab" id="title_GRAMER" data-toggle="pill">
						<div align="center"><i class="fal fa-tasks fa-2x"></i> <br><strong>Specific grammar</strong></div>											
					</a>
				</li>
				
			</ul>
				
				
			<div class="row mt-2">
				<div class="col-md-12">
					<!---
					<cfinclude template="./incl/incl_nav_tc.cfm">
					--->
					<div class="card border-top border-success">
						<div class="card-body">
					
							<div class="tab-content">
							
								<div class="tab-pane show active" id="tab_HOME" role="tabpanel">
								
								
								<cfif subm eq "Toeic">
									<div class="card-title">
									<h5>Toeic Listening & Reading</h5>							
									</div>
									<br>
									<p>
									<img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_toeic.jpg" width="350" align="left">
									<cfoutput>#obj_translater.get_translate_complex('toiec_intro')#</cfoutput>
									</p>
								<cfelseif subm eq "bright">
									<div class="card-title">
									<h5 class="d-inline">Bright Language Test</h5>							
									</div>
									<br>
									<p>
									<img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_bright.jpg" width="350" align="left">
									<cfoutput>#obj_translater.get_translate_complex('bright_intro')#</cfoutput>
									</p>
								<!--- <div class="pull-right">			 --->
								<!--- <select class="form-control" onChange="document.location.href='learner_test.cfm?subm=bright&f_id='+$(this).val()"> --->
								<!--- <cfif SESSION.USER_ID eq "411" OR SESSION.USER_ID eq "533" OR SESSION.USER_ID eq "2030" OR SESSION.USER_ID eq "4348" OR SESSION.USER_ID eq "4841" OR SESSION.USER_ID eq "7767"> --->
									<!--- <cfset list_lang_test = "English,French,German,Spanish,Italian,Portuguese,Russian,Chinese,Dutch"> --->
									<!--- <cfset count_lg = 1> --->
									<!--- <cfloop list="2,1,3,4,5,12,13,8,9" index="cur_lg"> --->
									<!--- <cfoutput> --->
									<!--- <option value="#cur_lg#" <cfif f_id eq cur_lg>selected</cfif>>#listgetat(list_lang_test, count_lg)#</option> --->
									<!--- <cfset count_lg += 1> --->
									<!--- </cfoutput> --->
									<!--- </cfloop> --->
								<!--- <cfelse> --->
									<!--- <cfoutput query="get_formation"> --->
									<!--- <option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option> --->
									<!--- </cfoutput> --->
								<!--- </cfif> --->
								<!--- <select> --->
								<!--- </div> --->
								
								<div class="clearfix mt-3"></div>
								
								<!--- <cfif SESSION.USER_ID eq "411" OR SESSION.USER_ID eq "533" OR SESSION.USER_ID eq "2030" OR SESSION.USER_ID eq "4348" OR SESSION.USER_ID eq "4841" OR SESSION.USER_ID eq "7767"> --->
								
								
										
										
								<cfelseif subm eq "linguaskill">
								<div class="card-title">
								<h5>Linguaskill</h5>							
								</div>
								<br>
								<p>
								<img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_linguaskill.jpg" width="350" align="left">
								<cfoutput>#obj_translater.get_translate_complex('lingua_intro')#</cfoutput>
								</p>
								
								</cfif>
							
						
							</div>
							
							
							
							<div class="tab-pane" id="tab_VIDEO" role="tabpanel">
							
								<cfif subm eq "Toeic">
									<div class="card-title">
									<h5>Toeic Listening & Reading</h5>							
									</div>
									
								<cfelseif subm eq "bright">
									<div class="card-title">
									<h5 class="d-inline">Bright Language Test</h5>							
									</div>
								
								<cfelseif subm eq "linguaskill">
									<div class="card-title">
									<h5>Linguaskill</h5>							
									</div>									
								</cfif>
								
								<div class="row">
								
									<div class="col-md-7">
							
										<video controls width="100%" height="500" poster="./assets/user/140/photo_video.jpg">
										<source src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/user/140/video.mp4" type="video/mp4">
										</video>		
										
									</div>
										
									<div class="col-md-4">
							
										<p>
										Explanation = what is the certificate. Screenshots of what it looks like 
										<br><br>
										Tips = how best to answer questions. General tips when taking exams as well as any specific tips for that certificate. Other websites that might help to understand the exam
										<br><br>
										Levels containing grammar explanations and quizzes linked to the level points.
										<br><br>
										Mock test = link to where the mock tests are or mock test tab so they can take it there and then (I prefer the second option so they are all in one place to do with exam prep)
										</p>
									</div>
								</div>
							
							</div>
							
							<div class="tab-pane" id="tab_MOCK" role="tabpanel">
							
								<cfif subm eq "Toeic">
									
									
									<h5><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Toeic Listening &amp; Reading</h5>
									
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
																<a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																
																<cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq "">
																	<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quiz_#get_result_toeic.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
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
									
									
									<h5><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Bright Language English</h5>
									
									
									<div class="row">
										<div class="col-md-12">		
											<cfoutput query="get_formation">
											<a href="learner_test2.cfm?subm=bright&f_id=#formation_id#" class="btn <cfif isdefined("f_id") AND f_id eq formation_id>btn-outline-info active<cfelse>btn-link</cfif>">
											<img src="./assets/img/training_#lcase(formation_code)#.png" width="40" height="40"><br><cfif len(formation_name) gt 8><small>#formation_name#</small><cfelse>#formation_name#</cfif>
											</a>
											</cfoutput>
										</div>
									</div>
									
									<div class="row">
										
										<div class="col-md-6">
										
										<cfoutput query="get_bright_reading">
											
											<cfquery name="get_result_bright_reading" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id# 
											</cfquery>

												<div class="border bg-light mt-3 p-2">
											
												<div class="media">
													<img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
													<div class="media-body">
														<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
														<small>#quiz_description#</small>
														
														<div class="clearfix"></div>
														<div class="float-right">
														
															<cfif get_result_bright_reading.recordcount eq "0">
															
																<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																
															<cfelse>
																<a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																
																<cfif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end neq "">
																	<a href="##" target="_blank" class="btn btn-sm btn-outline-success btn_view_quiz" id="quiz_#get_result_bright_reading.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																<!---<cfelseif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end eq "">
																	<a href="./quiz.cfm?quiz_user_id=#get_result_bright_reading.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>--->									
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

												<div class="border bg-light mt-3 p-2">
											
												<div class="media">
													<img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
													<div class="media-body">
														<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
														<small>#quiz_description#</small>
														
														<div class="clearfix"></div>
														<div class="float-right">
														
															<cfif get_result_bright_listening.recordcount eq "0">
															
																<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																
															<cfelse>
																<a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																		
																<cfif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end neq "">
																	<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quiz_#get_result_bright_listening.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																<!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
																	<a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
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
							
									<div class="row">
										
										<div class="col-md-6">

											<h5><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill General</h5>
											
											<div class="border-top border-success bg-light mt-3 p-2">
												<div class="media">
													<img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
													<div class="media-body">
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-success"><cfoutput>#obj_translater.get_translate('l_beginner')#</cfoutput></span></h6>
														<em><small>
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														</small></em>
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
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-warning"><cfoutput>#obj_translater.get_translate('l_intermediate')#</cfoutput></span> </h6>
														<em><small>
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														</small></em>
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
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-danger"><cfoutput>#obj_translater.get_translate('l_advanced')#</cfoutput></span></h6>
														<em><small>
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														</small></em>
														<div class="clearfix"></div>
														<div class="float-right">												
															<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
															<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
														</div>
													</div>
												</div>
											</div>
											
											<br>
											
											<h5>DEMO - Linguaskill General</h5>
												
											<div class="border-top bg-light mt-3 p-2">
												<div class="media">
													<img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
													<div class="media-body">
														<h6 class="mt-1">DEMO - <cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput></h6>
														<em><small>
														
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														
														</small></em>
														<div class="clearfix"></div>
														<div class="float-right">												
															<a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LSKLDEMO02" class="btn btn-sm btn-outline-info mb-0">DEMO</a>
														</div>
													</div>
												</div>
											</div>
											
										</div>
												
										<div class="col-md-6">

											<h5><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill Business</h5>	

											<div class="border-top border-success bg-light mt-3 p-2">							
												<div class="media">
													<img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
													<div class="media-body">
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-success"><cfoutput>#obj_translater.get_translate('l_beginner')#</cfoutput></span></h6>
														<em><small>
														
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														
														</small></em>
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
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-warning"><cfoutput>#obj_translater.get_translate('l_intermediate')#</cfoutput></span></h6>
														<em><small>
														
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														
														</small></em>
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
														<h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-danger"><cfoutput>#obj_translater.get_translate('l_advanced')#</cfoutput></span></h6>
														<em><small>
														
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														
														</small></em>
														<div class="clearfix"></div>
														<div class="float-right">												
															<a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/C+level+Test+-+Reading+and+Listening+V2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
														</div>
													</div>
												</div>
											</div>
											
											<br>
											
											<h5>DEMO - Linguaskill Business</h5>	
											
											<div class="border-top bg-light mt-3 p-2">				
												<div class="media">
													<img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
													<div class="media-body">
														<h6 class="mt-1">DEMO - <cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput></h6>
														<em><small>
														
														<cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
														
														</small></em>
														<div class="clearfix"></div>
														<div class="float-right">												
															<a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LinguaskillBusinessDemo" class="btn btn-sm btn-outline-info mb-0">DEMO</a>
														</div>
													</div>
												</div>
											</div>
											
										</div>
										
									</div>
								
								</cfif>
							
							</div>
							
							<div class="tab-pane" id="tab_GRAMMAR" role="tabpanel">
							
								<div id="accordion_grammar_top">
										<div align="center" class="mb-3">
											<div class="btn-group-toggle" data-toggle="buttons">	
												<cfloop list="A1,A2,B1,B2,C1" index="cor">
													<cfif findnocase("A1",cor)>
														<cfset css = "success">
													<cfelseif findnocase("A2",cor)>
														<cfset css = "primary">
													<cfelseif findnocase("B1",cor)>
														<cfset css = "info">
													<cfelseif findnocase("B2",cor)>
														<cfset css = "warning">
													<cfelseif findnocase("C1",cor)>
														<cfset css = "danger">
													</cfif>
													
													<cfoutput><label class="btn btn-lg btn-outline-#css# <cfif cor eq "A1">active</cfif>" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> #cor#</label></cfoutput>
												
												</cfloop>
											</div>
										</div>
										<cfloop list="A1,A2,B1,B2,C1" index="cor">
										<cfoutput>
										<div id="collapse_grammar_sub_#cor#" class="collapse <cfif cor eq "A1">show</cfif> p-2" data-parent="##accordion_grammar_top">	
											
											<cfif cor eq "A1">	
												<cfset list_level = "A1_1,A1_2,A1_3">
											<cfelseif cor eq "A2">	
												<cfset list_level = "A2_1,A2_2,A2_3">
											<cfelseif cor eq "B1">
												<cfset list_level = "B1_1,B1_2,B1_3">
											<cfelseif cor eq "B2">
												<cfset list_level = "B2_1,B2_2,B2_3">
											<cfelseif cor eq "C1">
												<cfset list_level = "C1_1,C1_2,C1_3">
											</cfif>
											
											<table class="table table-sm">
											
											<tr>
												<td></td>
												<td align="center">Revision sheets</td>
												<td align="center">Training Quiz</td>
												<td align="center">Validation Quiz</td>
												<td align="center">Keep training</td>
											</tr>
											
												
											<cfloop list="#list_level#" index="cor2">
											<cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'grammar' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
											</cfquery>
											<cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'vocabulary' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
											</cfquery>
											<!--- <cfdump var="#get_mapping_grammar#"> --->
												<cfif findnocase("A1_",cor2)>
													<cfset css = "success">
												<cfelseif findnocase("A2_",cor2)>
													<cfset css = "primary">
												<cfelseif findnocase("B1_",cor2)>
													<cfset css = "info">
												<cfelseif findnocase("B2_",cor2)>
													<cfset css = "warning">
												<cfelseif findnocase("C1_",cor2)>
													<cfset css = "danger">
												</cfif>			
												<!--- <div class="col-md-4"> --->
													<!--- <div class="card border"> --->
														<!--- <button class="btn btn-outline-#css# bg-white" data-toggle="collapse" data-target="##collapse_grammar_#cor2#">#replace(cor2,"_",".")#</button> --->
													
														<!--- <div class="card-body"> --->
														
														
															<tr class="bg-#css#">
																<td colspan="5"><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
															</tr>
														<cfloop query="get_mapping_grammar">
															<tr>
																<td>
																	<!---<input type="checkbox" name="mapping_id">---> #mapping_name#
																</td>
																<td align="center">
																	<a type="button" class="btn btn-sm btn-#css#" target="_blank" href="./assets/materials/present-perfect-practice_WS.pdf"><i class="fal fa-file-pdf"></i></a>
																</td>
																
																<td align="center">
																<cfset test = randrange(0,3)>
																<!--- test == #test# --->
																<cfif test eq "0">
																<a type="button" class="btn btn-sm btn-#css#"><i class="far fa-edit" text-#cssgo#"></i></a>
																<cfelse>
																	<cfloop from="1" to="#test#" index="cor">
																	<cfif test eq "3">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "2">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "1">
																		<cfset cssgo = "danger">
																	</cfif>
																	<i class="fas fa-star text-#cssgo#"></i>
																	</cfloop>
																</cfif>
																</td>
																<td align="center">
																<cfset test = randrange(0,3)>
																<!--- test == #test# --->
																<cfif test eq "0">
																<a type="button" class="btn btn-sm btn-#css#"><i class="far fa-edit" text-#cssgo#"></i></a>
																<cfelse>
																	<cfloop from="1" to="#test#" index="cor">
																	<cfif test eq "3">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "2">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "1">
																		<cfset cssgo = "danger">
																	</cfif>
																	<i class="fas fa-star text-#cssgo#"></i>
																	</cfloop>
																</cfif>
																
																
																</td>
																<td align="center">
																	<a type="button" class="btn btn-sm btn-#css#" href="learner_practice.cfm?sm_id=636" ><i class="fal fa-play"></i></a>
																		
																</td>
															</tr>
														</cfloop>
														
														
														<!--- <table class="table"> --->
															<!--- <tr class="bg-#css#"> --->
																<!--- <td colspan="2"><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td> --->
															<!--- </tr> --->
														<!--- <cfloop query="get_mapping_vocabulary"> --->
															<!--- <tr class="table-#css#"> --->
																<!--- <td> --->
																	<!--- <input type="checkbox" name="mapping_id"> #mapping_name# --->
																<!--- </td> --->
																<!--- <td width="20%"> --->
																<!--- <div class="progress" style="height: 5px;"> --->
																  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
																<!--- </div> --->
																<!--- </td> --->
															<!--- </tr> --->
														<!--- </cfloop> --->
														<!--- </table> --->
														
														<!--- </div> --->
													<!--- </div>													 --->
												
											</cfloop>
											</table>
											
											
										</div>
										</cfoutput>
										
									</cfloop>
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
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script>
$(document).ready(function() {
	
	$('.btn_restart_quiz').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	
		<cfoutput>
		if(confirm("#encodeForJavaScript(obj_translater.get_translate('js_restart_quiz_confirm'))#")){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		</cfoutput>
	

	})
	
})
</script>

</body>
</html>