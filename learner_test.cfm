<!DOCTYPE html>

<cfsilent>

<cfset secure = "1,2,3,4,5,7,8,9,11,12,13">
<cfinclude template="./incl/incl_secure.cfm">	

<cfif isdefined("SESSION.ACCESS_EL") AND listlen(SESSION.LIST_ACCESS_EL) gte "1">
<cfparam name="f_id" default="#listgetat(SESSION.LIST_ACCESS_EL,1)#">
<cfelse>
<cfparam name="f_id" default="2">
</cfif>

<cfparam name="subm" default="toeic">

<cfif listFindNoCase("LEARNER,TEST,GUEST,TM", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
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

	<cfif isdefined("SESSION.ACCESS_EL")>

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
	
	</cfif>
	
</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">
			
		<div class="content">

			<cfinclude template="./incl/incl_nav_test.cfm">

			<div class="row mt-3">
				<div class="col-md-12">
					<!---
					<cfinclude template="./incl/incl_nav_tc.cfm">
					--->
					<div class="card border">
						<div class="card-body">
					
							<cfif subm eq "Toeic">
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-file-certificate fa-lg mr-1"></i> <cfoutput>Toeic Listening & Reading</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>
							<cfelseif subm eq "bright">
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-file-certificate fa-lg mr-1"></i> <cfoutput>Bright Language Test</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>
							
							<cfif isdefined("SESSION.ACCESS_EL")>
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
							
							<div class="row">
								<div class="col-md-12">		
									<cfoutput query="get_formation">
									<a href="learner_test.cfm?subm=bright&f_id=#formation_id#" class="btn <cfif isdefined("f_id") AND f_id eq formation_id>btn-outline-info active<cfelse>btn-link</cfif>">
									<img src="./assets/img_formation/#formation_id#.png" width="40" height="40"><br><cfif len(formation_name) gt 8><small>#formation_name#</small><cfelse>#formation_name#</cfif>
									</a>
									</cfoutput>
								</div>
							</div>
									
							</cfif>
									
							<cfelseif subm eq "linguaskill">

								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-file-certificate fa-lg mr-1"></i> <cfoutput>Linguaskill</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>

							</cfif>
						
						
							<cfif not isdefined("SESSION.ACCESS_EL")>
								<cfinclude template="./incl/incl_noaccess.cfm">
							<cfelse>
							
							
								<cfif subm eq "Toeic">
									
									<cfoutput>#obj_translater.get_translate_complex('toiec_intro')#</cfoutput>
									
							
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
																<a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																
																<cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq "">
																	<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_toeic.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
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
									
									<cfoutput>#obj_translater.get_translate_complex('bright_intro')#</cfoutput>
									
									<br><br>
									
									<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Bright Language English</h6>
									
									
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
														<h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
														<small>#quiz_description#</small>
														
														<div class="clearfix"></div>
														<div class="float-right">
														
															<cfif get_result_bright_reading.recordcount eq "0">
															
																<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																
															<cfelse>
																<a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																
																<cfif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end neq "">
																	<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_bright_reading.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
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

												<div class="border-top border-success bg-light mt-3 p-2">
											
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
																	<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_bright_listening.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
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
									
									<cfoutput>#obj_translater.get_translate_complex('lingua_intro')#</cfoutput>
									
							
									<div class="row">
										
										<div class="col-md-6">

											<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill General</h6>
											
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
											
											<h6 class="text-info">DEMO - Linguaskill General</h6>
												
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

											<h6 class="text-info"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Linguaskill Business</h6>	

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
											
											<h6 class="text-info">DEMO - Linguaskill Business</h6>	
											
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

<cfinclude template="./incl/incl_scripts_timer.cfm">


<script>
$(document).ready(function() {
	
	<cfoutput>
	$('.btn_restart_quiz').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	
		
		if(confirm("#encodeForJavaScript(obj_translater.get_translate('js_restart_quiz_confirm'))#")){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		
	

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
	</cfoutput>

	
})
</script>

</body>
</html>